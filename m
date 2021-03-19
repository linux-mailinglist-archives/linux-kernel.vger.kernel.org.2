Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5223412D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCSC3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhCSC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616120971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOZfEbLOvB3iicSPUmk8LezmphB3Nt9q612pXUh13u4=;
        b=bPWJG4rG7Wp8F6IsQnmhHTEpcVWS1iiG6C+Q8nU7cVFMiZso8j9CbCpJDmrez7aaKSDGML
        rksfSXEg7aGhG+/gwhGpPlKaI79pTWqeLCGaRm5gL0iWcZVa67fismDA7fdgCBOQg3utjc
        kNOW0ES08DpgZ/exjqiy0/+usdQxf40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-mTgnzKrRM_afMceeSffleA-1; Thu, 18 Mar 2021 22:29:29 -0400
X-MC-Unique: mTgnzKrRM_afMceeSffleA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6DE157083;
        Fri, 19 Mar 2021 02:29:27 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6564910013C1;
        Fri, 19 Mar 2021 02:29:26 +0000 (UTC)
Date:   Thu, 18 Mar 2021 21:29:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] objtool: Add elf_create_undef_symbol()
Message-ID: <20210319022923.weykw3wtg3jysrm2@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.068888092@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171920.068888092@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:14PM +0100, Peter Zijlstra wrote:
> Allow objtool to create undefined symbols; this allows creating
> relocations to symbols not currently in the symbol table.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/elf.c                 |   63 ++++++++++++++++++++++++++++++++++++
>  tools/objtool/include/objtool/elf.h |    1 
>  2 files changed, 64 insertions(+)
> 
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -724,6 +724,69 @@ static int elf_strtab_concat(struct elf
>  	return len;
>  }
>  
> +struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
> +{
> +	struct section *symtab;
> +	struct symbol *sym;
> +	Elf_Data *data;
> +	Elf_Scn *s;
> +
> +	sym = malloc(sizeof(*sym));
> +	if (!sym) {
> +		perror("malloc");
> +		return NULL;
> +	}
> +	memset(sym, 0, sizeof(*sym));
> +
> +	sym->name = strdup(name);
> +
> +	sym->sym.st_name = elf_strtab_concat(elf, sym->name, NULL);
> +	if (sym->sym.st_name == -1)
> +		return NULL;
> +
> +	sym->sym.st_info = 0x10; /* STB_GLOBAL, STT_NOTYPE */

There's a generic macro for this:
	
	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);

And sym->bind and sym->type should probably get set.

-- 
Josh

