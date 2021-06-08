Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6A39F3A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhFHKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFHKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:36:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80115C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=baRv1enGH1vjlHZSg8Kx1HoJhoWAo7MKAZf4yMZtCZU=; b=Fm1BFhQWseZIYwXuTrSfXVLsNy
        StzVy0MgUzti833I2saGJK+UfcJnNwDENtv9ELmKtQSleGP4vmdOxnVWLhSEPxkrbH6c7hpyQt1of
        RoMw8vtFlNbUe2sIHgnL+ISBcsqbeSzlnKkuS6CNau8jOyMRhcm7GZDfNb6aXKQF9JonPmRglhRDs
        MemvxHBrf149nyxqqBToDKepCB/5OP5w52eG7A1iAPT/wWXNMhOICVQ8iZoFcURXD7iv7xjr46GeD
        9wW9tIKBye+JFXajXTGpp0AtlitSRkLl1x+gact2M+4oWEEtw78PXxJklRQrhlPWfJnhONwiTPQwM
        w09JDtow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqZ4A-004j3E-Qp; Tue, 08 Jun 2021 10:34:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 047033001E3;
        Tue,  8 Jun 2021 12:34:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA2CD2011672D; Tue,  8 Jun 2021 12:34:44 +0200 (CEST)
Date:   Tue, 8 Jun 2021 12:34:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mark-pk.tsai@mediatek.com,
        ardb@kernel.org
Subject: [PATCH] recordmcount: Correct st_shndx handling
Message-ID: <YL9HxEc/l0yrl5o8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.

This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.

Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 scripts/recordmcount.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym
 	unsigned long offset;
 	int index;
 
-	if (sym->st_shndx != SHN_XINDEX)
+	if (sym->st_shndx > SHN_UNDEF &&
+	    sym->st_shndx < SHN_LORESERVE)
 		return w2(sym->st_shndx);
 
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
+	if (sym->st_shndx == SHN_XINDEX) {
+		offset = (unsigned long)sym - (unsigned long)symtab;
+		index = offset / sizeof(*sym);
 
-	return w(symtab_shndx[index]);
+		return w(symtab_shndx[index]);
+	}
+
+	return 0;
 }
 
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
