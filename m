Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F304235D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhJFCdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:33:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BAC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:31:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so670510plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6daisZMMl5LDcuFIJtmvVlRgTb+iyI4U81mxJ9yyQBE=;
        b=GG4UepWZWDqDE51hudG+9ut2mK/3wjl/Gr389Ylmj3ScbOI6MMFOcHB87xOFcH4dje
         MMlYcviHJGq0IxXr+UaJQCgQ2DQISA7pTt1Mj2gWG1xQeNcxaDUJ16ZflpCOnVmPwj8x
         AbUWcHMp0vo5+ocyATEFtIYMYNe1X4wjD1TDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6daisZMMl5LDcuFIJtmvVlRgTb+iyI4U81mxJ9yyQBE=;
        b=kCfVedSaRKvIrz7+22+8wsfZHS8Twyh1b1MWdyb0cDNTxIUvhXprG/+cGqjeszUgvT
         JUgsGr9ETa+uY9gFlRMvUNqYRCTiBq2RTkq0JjuODLlxz1TybRQXBMvcmVPtBKpMerHu
         8bVY3pnMHaGbxvmGIx/rOc+DLD5WsTT7b0npRmEb22xu98pYCz8zGWx+8sAEkl8qNeTw
         pH7ZFODtdb4Hz0u6v00Ix17szGvotp2DTS9THgwAaYxUAT7jGbLRuRO3+/a4NkscyPYk
         JLo9BM+3ownEnRtFiwYttOEZlxZG29OLotOwdXm8NyWItJChmOC9sg9gp8rGh3QrEVzw
         wAvw==
X-Gm-Message-State: AOAM533S32kh2FIxnVJcvvLwVrV+6WDAMF/uugEJ3PJe1hk5edqxCprX
        4aBlvoNgRe0CrgdCvQpPXLw0ug==
X-Google-Smtp-Source: ABdhPJwr4N0demd2IQcSUg5POBP0HTUmNYaj1NnwWHF71aR8I+K9UlSdlfed6CbkEMfCi0XVHFlUlw==
X-Received: by 2002:a17:902:ed4d:b0:13e:daf1:6a37 with SMTP id y13-20020a170902ed4d00b0013edaf16a37mr8533810plb.18.1633487470417;
        Tue, 05 Oct 2021 19:31:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s19sm1936208pfh.18.2021.10.05.19.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:31:10 -0700 (PDT)
Date:   Tue, 5 Oct 2021 19:31:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <202110051929.37279B6B4A@keescook>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVmd7D0M6G/DcP4O@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 03:11:24PM +0300, Alexey Dobriyan wrote:
> Kernel assumes that ELF program headers are ordered by mapping address,
> but doesn't enforce it. It is possible to make mapping size extremely huge
> by simply shuffling first and last PT_LOAD segments.
> 
> As long as PT_LOAD segments do not overlap, it is silly to require
> sorting by v_addr anyway because mmap() doesn't care.
> 
> Don't assume PT_LOAD segments are sorted and calculate min and max
> addresses correctly.

Nice! Yes, this all make sense.

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/binfmt_elf.c |   23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -93,7 +93,7 @@ static int elf_core_dump(struct coredump_params *cprm);
>  #define ELF_CORE_EFLAGS	0
>  #endif
>  
> -#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
> +#define ELF_PAGESTART(_v) ((_v) & ~(int)(ELF_MIN_ALIGN-1))

Errr, this I don't like. I assume this is because of the min() use
below?

>  #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
>  #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
>  
> @@ -399,22 +399,21 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  	return(map_addr);
>  }
>  
> -static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> +static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
>  {
> -	int i, first_idx = -1, last_idx = -1;
> +	elf_addr_t min_addr = -1;
> +	elf_addr_t max_addr = 0;
> +	bool pt_load = false;
> +	int i;
>  
>  	for (i = 0; i < nr; i++) {
> -		if (cmds[i].p_type == PT_LOAD) {
> -			last_idx = i;
> -			if (first_idx == -1)
> -				first_idx = i;
> +		if (phdr[i].p_type == PT_LOAD) {
> +			min_addr = min(min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
> +			max_addr = max(max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);

How about:
		min_addr = min_t(elf_addr_t, min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
		max_addr = max_t(elf_addr_t, max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);

> +			pt_load = true;
>  		}
>  	}
> -	if (first_idx == -1)
> -		return 0;
> -
> -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> +	return pt_load ? (max_addr - min_addr) : 0;
>  }
>  
>  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)

-Kees

-- 
Kees Cook
