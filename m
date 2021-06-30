Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21D3B8260
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhF3Ms2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:48:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35926 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhF3Ms0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:48:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6EB2822590;
        Wed, 30 Jun 2021 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625057157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UA0p0qBvxm4Dv5V5rsM7/oDmlQV7roqktSNBqulRsTI=;
        b=sqjkmDyNypunmjm4Ar0kqzkcpeWQgRpdzUCwwYXTlg+NdadnpPQn2UgK1q/y9YGD4Wj7Sp
        d7jTM7xUpa4KcL/vvgtWtXFHtSOFnHNTvP0R8WR0awhJjNryFSErd8Ln7iIsnEBIz1gBsR
        3fELLCW+AkXxZjfA2seQxe4jJVixh3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625057157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UA0p0qBvxm4Dv5V5rsM7/oDmlQV7roqktSNBqulRsTI=;
        b=Jr6MO5F58XE3e4mxfts9c3uP37jk7BbtvRUhiWFAzVHBn57axbJpC08wKXy54RFjwGMJqe
        5PdBttI93IkK0dCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42E7CA3B8C;
        Wed, 30 Jun 2021 12:45:57 +0000 (UTC)
Date:   Wed, 30 Jun 2021 14:45:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
In-Reply-To: <20210624095147.756759107@infradead.org>
Message-ID: <alpine.LSU.2.21.2106301431120.32505@pobox.suse.cz>
References: <20210624094059.886075998@infradead.org> <20210624095147.756759107@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2725,15 +2820,24 @@ static int validate_branch(struct objtoo
>  
>  			if (insn->visited & visited)
>  				return 0;
> -		}
> +		} else
> +			nr_visited++;

just a coding style

	} else {
		nr_visited++;
	}

> @@ -3192,6 +3304,13 @@ int check(struct objtool_file *file)
>  		warnings += ret;
>  	}
>  
> +	if (stats) {
> +		printf("nr_visited: %ld\n", nr_visited);

Could we make this nr_insns_visited?

> +		printf("nr_cfi: %ld\n", nr_cfi);
> +		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
> +		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
> +	}
> +
> +++ b/tools/objtool/orc_gen.c
> @@ -13,13 +13,19 @@
>  #include <objtool/warn.h>
>  #include <objtool/endianness.h>
>  
> -static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
> +static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
> +			  struct instruction *insn)
>  {
> -	struct instruction *insn = container_of(cfi, struct instruction, cfi);
>  	struct cfi_reg *bp = &cfi->regs[CFI_BP];
>  
>  	memset(orc, 0, sizeof(*orc));
>  
> +	if (!cfi) {
> +		orc->end = 0;
> +		orc->sp_reg = ORC_REG_UNDEFINED;
> +		return 0;
> +	}
> +

This looks strange. You access cfi a couple of lines earlier (bp cfi_reg 
initialization).

Is it even possible to have cfi == NULL here? The second call site below 
has a check and the first one should not happen (insn->cfip should be 
always set if I am not missing something).

>  	orc->end = cfi->end;
>  
>  	if (cfi->cfa.base == CFI_UNDEFINED) {
> @@ -162,7 +168,7 @@ int orc_create(struct objtool_file *file
>  			int i;
>  
>  			if (!alt_group) {
> -				if (init_orc_entry(&orc, &insn->cfi))
> +				if (init_orc_entry(&orc, insn->cfip, insn))
>  					return -1;
>  				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
>  					continue;
> @@ -186,7 +192,8 @@ int orc_create(struct objtool_file *file
>  				struct cfi_state *cfi = alt_group->cfi[i];
>  				if (!cfi)
>  					continue;
> -				if (init_orc_entry(&orc, cfi))
> +				/* errors are reported on the original insn */
> +				if (init_orc_entry(&orc, cfi, insn))
>  					return -1;
>  				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
>  					continue;

Anyway, this is a nice improvement.

Miroslav
