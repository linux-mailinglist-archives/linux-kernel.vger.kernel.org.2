Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3E430D1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBCCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhBCCfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:35:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:34:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b21so16247022pgk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=f8ymPPL3aiMxzD4Xh2QF5FLU9/HSVYl9hpzXbMMvEjA=;
        b=ZR4Yj4Xxr8gBQz8Ajb2J1s91fGhF+zi15XHpqkgQr7ORpIdYCN/JQju9101kSaZWZf
         UrMi7J0Fq8VoxR77unnoD+mc4fGT7Dk+qwoMeNQgXZWqgvWcP9UGsSoxvHPT3BUw36oY
         BfvlC8jXlMv25OCnhAYgkbP2KFPLjA33Qb/6zWFKB+6qu1dsrY8UXcK9P+fwPSJlzDX9
         k8hnIwjucqmg11f5/vIFyuxndsHcGlfeXQbp44xXRqbZNTju6rW6u3KdZRe/7q2gsjPB
         pc4wo07czXy7LVTO2HfrGB/IHIIkFPGGu65X0UB0NOXjoTGKUX0avuZYr8bhuuMl3Q+6
         D23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=f8ymPPL3aiMxzD4Xh2QF5FLU9/HSVYl9hpzXbMMvEjA=;
        b=eYdP334uaVmMrUqxnlATDW4eZxFqgkMt7a12P3fw+z5NM03rIQAvwLyVZtAHweawsl
         OykMS/Qfusec1As50phsYIkohJAmEhq6LnAoyT5WgEeIDwbniN58OM4hcUMBi5WclhSB
         WvDO7nk/OwL2ZwNpA/H/6L8wJNYBEvjI0AWaj8jzP1f3TfRFjfQmE18FbEsAMSFFVVFO
         4CZsIkN5PwvIMGcQ1IA82Kq9f1ocumJgEwIW+s6Owzn6CrRqv4lGCB4T3gnbzU2Mfhrg
         YqibfV74VCjknW3/fY6fy4Q9L3xR0ISh+DTVV+ADGY9ItNhZ/2lE3Dv2u6gTwuox8b4L
         AaTw==
X-Gm-Message-State: AOAM532XrhysohIJQatBJE5fQu9eFsr8xeyDOH2E2m+LxbBECvXNR+lp
        jl19Pfp2W5tMPLoxOI6TA1UPc1Zpo6p2xA==
X-Google-Smtp-Source: ABdhPJzEejY4oEjfO8kKlOke7DqR+csN1+8GClQOe55+ElfMik/fpvkYYS5ocRI0Ciwo0BZPlTm+Aw==
X-Received: by 2002:a65:6458:: with SMTP id s24mr1203365pgv.386.1612319695301;
        Tue, 02 Feb 2021 18:34:55 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a30sm292770pfh.66.2021.02.02.18.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:34:54 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:34:54 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:32:12 PST (-0800)
Subject:     Re: [PATCH 1/3] RISC-V: Fix .init section permission update
In-Reply-To: <20210129190038.1001626-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        geert@linux-m68k.org, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        kirill.shutemov@linux.intel.com, linux-riscv@lists.infradead.org,
        ndesaulniers@gooogle.com, Paul Walmsley <paul.walmsley@sifive.com>,
        svancau@gmail.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-da4345bd-4ed6-48de-be63-606a4eff7017@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 11:00:36 PST (-0800), Atish Patra wrote:
> .init section permission should only updated to non-execute if
> STRICT_KERNEL_RWX is enabled. Otherwise, this will lead to a kernel hang.
>
> Fixes: 19a00869028f ("RISC-V: Protect all kernel sections including init early")
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/setup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 3fa3f26dde85..c7c0655dd45b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -293,6 +293,8 @@ void free_initmem(void)
>  	unsigned long init_begin = (unsigned long)__init_begin;
>  	unsigned long init_end = (unsigned long)__init_end;
>
> -	set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> +	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> +		set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> +
>  	free_initmem_default(POISON_FREE_INITMEM);
>  }

Thanks, this is on fixes.
