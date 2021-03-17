Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7333F1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCQNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhCQNwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:52:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFB21ACA8;
        Wed, 17 Mar 2021 13:52:23 +0000 (UTC)
Date:   Wed, 17 Mar 2021 14:52:23 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
In-Reply-To: <20210312171653.710872453@infradead.org>
Message-ID: <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz>
References: <20210312171613.533405394@infradead.org> <20210312171653.710872453@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ also correcting my e-mail address ]

On Fri, 12 Mar 2021, Peter Zijlstra wrote:

Just a remark regarding SHN_XINDEX...

> +static bool elf_symbol_add(struct elf *elf, struct symbol *sym, Elf32_Word shndx)
> +{
> +	struct list_head *entry;
> +	struct rb_node *pnode;
> +
> +	sym->type = GELF_ST_TYPE(sym->sym.st_info);
> +	sym->bind = GELF_ST_BIND(sym->sym.st_info);
> +
> +	if ((sym->sym.st_shndx > SHN_UNDEF &&
> +	     sym->sym.st_shndx < SHN_LORESERVE) ||
> +	    (shndx != SHN_XINDEX && sym->sym.st_shndx == SHN_XINDEX)) {
> +		if (sym->sym.st_shndx != SHN_XINDEX)
> +			shndx = sym->sym.st_shndx;
> +
> +		sym->sec = find_section_by_index(elf, shndx);
> +		if (!sym->sec) {
> +			WARN("couldn't find section for symbol %s",
> +			     sym->name);
> +			return false;
> +		}

...

> @@ -366,47 +414,11 @@ static int read_symbols(struct elf *elf)
>  			goto err;
>  		}
>  
> -		sym->type = GELF_ST_TYPE(sym->sym.st_info);
> -		sym->bind = GELF_ST_BIND(sym->sym.st_info);
> +		if (!shndx_data)
> +			shndx = SHN_XINDEX;
>  
> -		if ((sym->sym.st_shndx > SHN_UNDEF &&
> -		     sym->sym.st_shndx < SHN_LORESERVE) ||
> -		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
> -			if (sym->sym.st_shndx != SHN_XINDEX)
> -				shndx = sym->sym.st_shndx;
> -
> -			sym->sec = find_section_by_index(elf, shndx);
> -			if (!sym->sec) {
> -				WARN("couldn't find section for symbol %s",
> -				     sym->name);
> -				goto err;

...

> +	if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
> +		WARN("elf_symbol_add");
> +		return NULL;
> +	}

SHN_XINDEX means that the extended section index is used. Above you seem 
to use it in the opposite sense too (assigning to shndx when shndx_data is 
NULL). While it makes the code easier to handle, it is a bit confusing 
(and maybe I am just confused now). Could you add a comment about that, 
please? elf_symbol_add() seems like a good place.

Miroslav
