Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC53A3544
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFJVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJVBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD09D613B3;
        Thu, 10 Jun 2021 20:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623358769;
        bh=DKDbdzJErGy6T0/5CYDDzlalGvMMsJdIK0b/MVLHi1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFIPb1n62xzGCdnnNnKZN/mfW3tKtRnxpLrN+Fr4uN4v2RIW/xAxnAJg4rJ3MhrlW
         9eQkPWtlrQocDgngRIczQ7iIP+CLSoIU/gCAC0tRnfyuOAJ/LgkknNqTO85SBrSrVm
         k7+ZoOP06R7sAbD3A3MFfQxRkk+seINVv3uMXowQJU26BtdHr+wjisbcb4AHo32ER0
         7emavZziek7CpCGSkB4SJaH9lD+aOYr9ESK2fPLt+XDlXO7vx3CI7B/BCV9dFG4RIH
         iIV8l2UL90nYZQ+LFTepInD57IKVMnXLpZ9kCGShcj1PR99yGRGIYzZJDmaK9aQICy
         gQbhT/D5/E/CA==
Date:   Thu, 10 Jun 2021 13:59:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
Message-ID: <YMJ9MGyXHi9Xa0ne@DESKTOP-1V8MEUQ.localdomain>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
 <CABCJKudzC-Nss_LGrpYwRqwdDxeWOf1o6Bvp3J2fBQthEB=WGg@mail.gmail.com>
 <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 09:33:44PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 11:50:36AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 10, 2021 at 11:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > Adding Sami because I am not sure why this patch would have much of an impact
> > > in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
> > > question.
> > 
> > It's because LLVM enables -ffunction-sections with LTO, so using .text
> > section size to estimate the reloc hash table size isn't going to be
> > accurate, as confirmed by objtool output with --stats:
> > 
> >   OBJTOOL vmlinux.o
> > nr_sections: 141481
> > section_bits: 17
> > nr_symbols: 215262
> > symbol_bits: 17
> > max_reloc: 24850
> > tot_reloc: 590890
> > reloc_bits: 10
> 
> Bah. Would something like the *completely* untested below help with that?

LGTM, thanks for the quick fix!

Benchmark #1: allmodconfig
  Time (mean ± σ):     624.555 s ±  2.089 s    [User: 35109.967 s, System: 2146.215 s]
  Range (min … max):   623.078 s … 626.032 s    2 runs

Benchmark #2: allmodconfig with ThinLTO
  Time (mean ± σ):     769.959 s ±  1.819 s    [User: 39692.409 s, System: 2308.010 s]
  Range (min … max):   768.673 s … 771.245 s    2 runs

Summary
  'allmodconfig' ran
    1.23 ± 0.01 times faster than 'allmodconfig with ThinLTO'

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 25f6d293bc86..8676c7598728 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -288,6 +288,9 @@ static int read_sections(struct elf *elf)
>  		}
>  		sec->len = sec->sh.sh_size;
>  
> +		if (sec->sh.sh_flags & SHF_EXECINSTR)
> +			elf->text_size += sec->len;
> +
>  		list_add_tail(&sec->list, &elf->sections);
>  		elf_hash_add(section, &sec->hash, sec->idx);
>  		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
> @@ -581,13 +584,7 @@ static int read_relocs(struct elf *elf)
>  	unsigned int symndx;
>  	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
>  
> -	sec = find_section_by_name(elf, ".text");
> -	if (!sec) {
> -		WARN("no .text");
> -		return -1;
> -	}
> -
> -	if (!elf_alloc_hash(reloc, sec->len / 16))
> +	if (!elf_alloc_hash(reloc, elf->text_size / 16))
>  		return -1;
>  
>  	list_for_each_entry(sec, &elf->sections, list) {
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index 90082751f851..e34395047530 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -83,6 +83,7 @@ struct elf {
>  	int fd;
>  	bool changed;
>  	char *name;
> +	unsigned int text_size;
>  	struct list_head sections;
>  
>  	int symbol_bits;
