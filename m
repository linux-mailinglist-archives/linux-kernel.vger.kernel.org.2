Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920FC3B4229
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFYLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:08:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:05:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6244367wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rrt46uLQg96YozpZ1ImMzV/fTKwN5YQVvfZbX0ASVOg=;
        b=uDar0AqLTSebWvXgdRMpYSWcSHctMlgJ4A6qpJ8llWcVY6UdRyWobume+LHlhwZTB/
         /VNhUlkf7RrQ/BK1L/4rbr2DAjr30dkzOQs/qonBziS615kgWa0nqSTBA5ftreYBEayD
         7iSTq5jDFdglBBNMZcXEmwFcWAI9OowAJXOyV7LPxIFkvRG0av9jgY++fOBJqA315GHI
         7nsuJQtGXrXKi2/BBG/jOcH0eUp9pZzlzrf58ThiIKu5VFmgmfd4A1mHXMQVgh6jEr77
         JVPBaU4wsMPrxXGHr3AdfQHJ04H6VNZFHUGiDmZfMgg5smHl110NACrQJycm4NPm+0Jn
         p/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rrt46uLQg96YozpZ1ImMzV/fTKwN5YQVvfZbX0ASVOg=;
        b=NXujZKHG+qw3Cy253MPBgoRWj+ACoVvRGXP7vUhuU+yvYVZV99ncNN0WpiPyrU3Z8+
         Ojz1DQ7zx5p7pCNHH4UzQ38TDs8J1Qa+TucO6w1mJ9Qa2yxjdeplqjMfw9AWtFHqPRlk
         V9Fk1KBpRQaX/TtopgEMQoxlKfZpeGKzb1LSOJdWK6BkEQu9+Li8oRQ/hVOWjz8ZUsZO
         jTDbfrQTPmGr0XYUQhdTJgyGTm0QfyexBmNPl45HtEpRDRVa2ED5ENqyNI8B7/OUVyH+
         mj6CLcLo371wjE8FySrtqg7U9BhbI3V189rPpulUkBb7C59/wPoJj4sdGq5KVqtFoYv3
         R/Ww==
X-Gm-Message-State: AOAM530TNNdpPA3kifdRpZcLrJ7cABmWNolL5fNJ1OdIju/0HSgoKt+n
        lZ8NukV66xc6bLlqzH+LvzuH6A==
X-Google-Smtp-Source: ABdhPJy1gUYaNpJ74f5HgIh6lAeEz7TCiWtYFAB5/EeRcXs7Bq/M/iwo+6ClH+kfWjh928TeANgc7A==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr9880619wmc.110.1624619145886;
        Fri, 25 Jun 2021 04:05:45 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:e0a7:1c41:8d67:631b])
        by smtp.gmail.com with ESMTPSA id h10sm6484943wmq.0.2021.06.25.04.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:05:44 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:05:39 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <YNW4g8RxydgADtW5@elver.google.com>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.818783799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624095147.818783799@infradead.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:41AM +0200, Peter Zijlstra wrote:
> Turns out the compilers also generate tail calls to __sanitize_cov*(),
> make sure to also patch those out in noinstr code.
> 
> Fixes: 0f1441b44e82 ("objtool: Fix noinstr vs KCOV")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Marco Elver <elver@google.com>

Thanks! More reason to not even try to do the same for other
architectures, and the compiler needing the attribute...

> ---
>  tools/objtool/arch/x86/decode.c      |   20 ++++
>  tools/objtool/check.c                |  153 ++++++++++++++++++-----------------
>  tools/objtool/include/objtool/arch.h |    1 
>  3 files changed, 100 insertions(+), 74 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -659,6 +659,26 @@ const char *arch_nop_insn(int len)
>  	return nops[len-1];
>  }
>  
> +#define BYTE_RET	0xC3
> +
> +const char *arch_ret_insn(int len)
> +{
> +	static const char ret[5][5] = {
> +		{ BYTE_RET },
> +		{ BYTE_RET, BYTES_NOP1 },
> +		{ BYTE_RET, BYTES_NOP2 },
> +		{ BYTE_RET, BYTES_NOP3 },
> +		{ BYTE_RET, BYTES_NOP4 },
> +	};
> +
> +	if (len < 1 || len > 5) {
> +		WARN("invalid RET size: %d\n", len);
> +		return NULL;
> +	}
> +
> +	return ret[len-1];
> +}
> +
>  /* asm/alternative.h ? */
>  
>  #define ALTINSTR_FLAG_INV	(1 << 15)
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -828,6 +828,74 @@ static struct reloc *insn_reloc(struct o
>  	return insn->reloc;
>  }
>  
> +static void remove_insn_ops(struct instruction *insn)
> +{
> +	struct stack_op *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
> +		list_del(&op->list);
> +		free(op);
> +	}
> +}
> +
> +static void add_call_dest(struct objtool_file *file, struct instruction *insn,
> +			  struct symbol *dest, bool sibling)
> +{
> +	struct reloc *reloc = insn_reloc(file, insn);
> +
> +	insn->call_dest = dest;
> +	if (!dest)
> +		return;
> +
> +	if (insn->call_dest->static_call_tramp) {
> +		list_add_tail(&insn->call_node,
> +			      &file->static_call_list);
> +	}
> +
> +	if (insn->sec->noinstr &&
> +	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> +		if (reloc) {
> +			reloc->type = R_NONE;
> +			elf_write_reloc(file->elf, reloc);
> +		}
> +
> +		elf_write_insn(file->elf, insn->sec,
> +			       insn->offset, insn->len,
> +			       sibling ? arch_ret_insn(insn->len)
> +			               : arch_nop_insn(insn->len));
> +
> +		insn->type = sibling ? INSN_RETURN : INSN_NOP;
> +	}
> +
> +	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> +		if (sibling)
> +			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
> +
> +		if (reloc) {
> +			reloc->type = R_NONE;
> +			elf_write_reloc(file->elf, reloc);
> +		}
> +
> +		elf_write_insn(file->elf, insn->sec,
> +			       insn->offset, insn->len,
> +			       arch_nop_insn(insn->len));
> +
> +		insn->type = INSN_NOP;
> +
> +		list_add_tail(&insn->mcount_loc_node,
> +			      &file->mcount_loc_list);
> +	}
> +
> +	/*
> +	 * Whatever stack impact regular CALLs have, should be undone
> +	 * by the RETURN of the called function.
> +	 *
> +	 * Annotated intra-function calls retain the stack_ops but
> +	 * are converted to JUMP, see read_intra_function_calls().
> +	 */
> +	remove_insn_ops(insn);
> +}
> +
>  /*
>   * Find the destination instructions for all jumps.
>   */
> @@ -866,11 +934,7 @@ static int add_jump_destinations(struct
>  			continue;
>  		} else if (insn->func) {
>  			/* internal or external sibling call (with reloc) */
> -			insn->call_dest = reloc->sym;
> -			if (insn->call_dest->static_call_tramp) {
> -				list_add_tail(&insn->call_node,
> -					      &file->static_call_list);
> -			}
> +			add_call_dest(file, insn, reloc->sym, true);
>  			continue;
>  		} else if (reloc->sym->sec->idx) {
>  			dest_sec = reloc->sym->sec;
> @@ -926,13 +990,8 @@ static int add_jump_destinations(struct
>  
>  			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
>  				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
> -
>  				/* internal sibling call (without reloc) */
> -				insn->call_dest = insn->jump_dest->func;
> -				if (insn->call_dest->static_call_tramp) {
> -					list_add_tail(&insn->call_node,
> -						      &file->static_call_list);
> -				}
> +				add_call_dest(file, insn, insn->jump_dest->func, true);
>  			}
>  		}
>  	}
> @@ -940,16 +999,6 @@ static int add_jump_destinations(struct
>  	return 0;
>  }
>  
> -static void remove_insn_ops(struct instruction *insn)
> -{
> -	struct stack_op *op, *tmp;
> -
> -	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
> -		list_del(&op->list);
> -		free(op);
> -	}
> -}
> -
>  static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
>  {
>  	struct symbol *call_dest;
> @@ -968,6 +1017,7 @@ static int add_call_destinations(struct
>  {
>  	struct instruction *insn;
>  	unsigned long dest_off;
> +	struct symbol *dest;
>  	struct reloc *reloc;
>  
>  	for_each_insn(file, insn) {
> @@ -977,7 +1027,9 @@ static int add_call_destinations(struct
>  		reloc = insn_reloc(file, insn);
>  		if (!reloc) {
>  			dest_off = arch_jump_destination(insn);
> -			insn->call_dest = find_call_destination(insn->sec, dest_off);
> +			dest = find_call_destination(insn->sec, dest_off);
> +
> +			add_call_dest(file, insn, dest, false);
>  
>  			if (insn->ignore)
>  				continue;
> @@ -995,9 +1047,8 @@ static int add_call_destinations(struct
>  
>  		} else if (reloc->sym->type == STT_SECTION) {
>  			dest_off = arch_dest_reloc_offset(reloc->addend);
> -			insn->call_dest = find_call_destination(reloc->sym->sec,
> -								dest_off);
> -			if (!insn->call_dest) {
> +			dest = find_call_destination(reloc->sym->sec, dest_off);
> +			if (!dest) {
>  				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
>  					  insn->sec, insn->offset,
>  					  reloc->sym->sec->name,
> @@ -1005,6 +1056,8 @@ static int add_call_destinations(struct
>  				return -1;
>  			}
>  
> +			add_call_dest(file, insn, dest, false);
> +
>  		} else if (arch_is_retpoline(reloc->sym)) {
>  			/*
>  			 * Retpoline calls are really dynamic calls in
> @@ -1020,55 +1073,7 @@ static int add_call_destinations(struct
>  			continue;
>  
>  		} else
> -			insn->call_dest = reloc->sym;
> -
> -		if (insn->call_dest && insn->call_dest->static_call_tramp) {
> -			list_add_tail(&insn->call_node,
> -				      &file->static_call_list);
> -		}
> -
> -		/*
> -		 * Many compilers cannot disable KCOV with a function attribute
> -		 * so they need a little help, NOP out any KCOV calls from noinstr
> -		 * text.
> -		 */
> -		if (insn->sec->noinstr &&
> -		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> -			if (reloc) {
> -				reloc->type = R_NONE;
> -				elf_write_reloc(file->elf, reloc);
> -			}
> -
> -			elf_write_insn(file->elf, insn->sec,
> -				       insn->offset, insn->len,
> -				       arch_nop_insn(insn->len));
> -			insn->type = INSN_NOP;
> -		}
> -
> -		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> -			if (reloc) {
> -				reloc->type = R_NONE;
> -				elf_write_reloc(file->elf, reloc);
> -			}
> -
> -			elf_write_insn(file->elf, insn->sec,
> -				       insn->offset, insn->len,
> -				       arch_nop_insn(insn->len));
> -
> -			insn->type = INSN_NOP;
> -
> -			list_add_tail(&insn->mcount_loc_node,
> -				      &file->mcount_loc_list);
> -		}
> -
> -		/*
> -		 * Whatever stack impact regular CALLs have, should be undone
> -		 * by the RETURN of the called function.
> -		 *
> -		 * Annotated intra-function calls retain the stack_ops but
> -		 * are converted to JUMP, see read_intra_function_calls().
> -		 */
> -		remove_insn_ops(insn);
> +			add_call_dest(file, insn, reloc->sym, false);
>  	}
>  
>  	return 0;
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -82,6 +82,7 @@ unsigned long arch_jump_destination(stru
>  unsigned long arch_dest_reloc_offset(int addend);
>  
>  const char *arch_nop_insn(int len);
> +const char *arch_ret_insn(int len);
>  
>  int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
>  
> 
> 
