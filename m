Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B637BB03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhELKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:44:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f9p34mnXe4t5mNvfpROYXG2aTzJ6mgUxTWOmTJUAMYY=; b=eiYeqMjz8mZe0BeBTs7cArM4Jp
        V4+TuJU0LbHqyl/NILzq4KSVNOEow8n/sQEGPHrpBTXIj3lKOKVXHs3q5dycBwmgtFCrct7JI+lyS
        YONVSum7V533EwWLKyJttqR8BDtgTS+LaBmjNooEvXa25EnlVYww2c7qO+epPHNMqabuDNQw57Hc8
        4kPtNgVyLUMKuV2pIXDzX3n/0ikGGnePaX7CkLpUr4cjHqlOp59kCaY0akmT+MQEpXXeiqI3od0NM
        4spsMAHAlCSYTUtgXPsmFDHWkZ+xYE9+VMw2zpeJsFYUILV0PJ+EZ1EAh+KMljc4NgwI2dvDLWAPQ
        XqeyuNjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgmJU-008BsZ-A2; Wed, 12 May 2021 10:42:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9C5830019C;
        Wed, 12 May 2021 12:41:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A34572040BF80; Wed, 12 May 2021 12:41:58 +0200 (CEST)
Date:   Wed, 12 May 2021 12:41:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
Message-ID: <YJuw9lmr0kGX3vlY@hirez.programming.kicks-ass.net>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506194157.452881700@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 09:33:53PM +0200, Peter Zijlstra wrote:
> @@ -343,6 +360,10 @@ static int read_symbols(struct elf *elf)
>  
>  	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
>  
> +	if (!elf_alloc_hash(symbol, symbols_nr) ||
> +	    !elf_alloc_hash(symbol_name, symbols_nr))
> +		return -1;
> +
>  	for (i = 0; i < symbols_nr; i++) {
>  		sym = malloc(sizeof(*sym));
>  		if (!sym) {

Ingo ran into the empty file without .symtab case with as-2.36.1, which
then means we don't even allocate the symbol hashes which then explodes
later.

The below seems to fix things.

---
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6942357cd4a2..60bef847ee85 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -340,25 +340,19 @@ static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
 	struct symbol *sym, *pfunc;
-	int symbols_nr, i;
+	int i, symbols_nr = 0;
 	char *coldstr;
 	Elf_Data *shndx_data = NULL;
 	Elf32_Word shndx;
 
 	symtab = find_section_by_name(elf, ".symtab");
-	if (!symtab) {
-		/*
-		 * A missing symbol table is actually possible if it's an empty
-		 * .o file.  This can happen for thunk_64.o.
-		 */
-		return 0;
-	}
-
-	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
-	if (symtab_shndx)
-		shndx_data = symtab_shndx->data;
+	if (symtab) {
+		symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+		if (symtab_shndx)
+			shndx_data = symtab_shndx->data;
 
-	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
+		symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
+	}
 
 	if (!elf_alloc_hash(symbol, symbols_nr) ||
 	    !elf_alloc_hash(symbol_name, symbols_nr))
