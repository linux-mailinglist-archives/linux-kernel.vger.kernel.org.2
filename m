Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA938D90F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhEWFJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhEWFJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 01:09:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0ABC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 22:07:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 22so17716904pfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GekRZR7m7jX1zkxnCS1d0B7GOHkcR2biU0ysxdIECAM=;
        b=TDGrqxL7pNqI7HEvtYM5FFj81N6E7rg2+l1p2R2uvAZwor4dCfnNAqvf9MWLvkSb14
         ELV7AD8z97DhZJW/oe1M0OIYlZP+eSeakwbsbZ9dvZwxIAQraFDCE0jdy9rDtZOnsMQa
         dY2aby9T2HDb/cZ3Uj5SmWcmSlIKkhhZD0qGMBVfP1f2ykUAADNREBGyYy99Z2MW0VSl
         iTxq7dXQ/DDX3Yxwn3aI377EhZZUgWVhtxLLoAeojwFBZCdkyXcvu3woE50CZpArNydA
         Jyl4XQ02nfi9luGMoIqfAhcWW0xbqrmUJFA33cuygivR4KomVpRat12BJ4VAIIhuBnS3
         wQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GekRZR7m7jX1zkxnCS1d0B7GOHkcR2biU0ysxdIECAM=;
        b=aCB5/nmtGese/AF1BKaIMYOHlkqubq+/Ad3EomiL/o8K2PYQKvY4sSnyr6xKiWaL99
         +Zm4AC3DDAXg3/6Sfq+i+PM0mmczadNN64mRbyCAMnffrLM3s/Ibyz9bYcRoBT3ZGbf9
         JyObMGRm4pRtRbZflLpPLAbe3HaqyE/F6MmBixoxs/QBFo6cVPw8I+w+PhyXZLUi1Lxg
         vvHFioI6/vrP5AAwU7viXQAo9I2sKGiDPwRkQBfbbkAmV9Sg8hFM6TdP5zSvgMTiXLpp
         c5kyOO22kSYJ9gPKIG/95BFDFyjszSRIqrqWuRW0oH0xMwJbZZMgxGEDvev1CDpm/JHW
         5Uqw==
X-Gm-Message-State: AOAM531kj8Oh1iR/WHibr3OyWbnmtbe5cmFAYQHAkBXwJeCKSBVQmPH1
        8t/mkg7+F/J5h9DdU4DhcCU3Fkvb0FgyRw==
X-Google-Smtp-Source: ABdhPJyMjEN4MMriGwo6Bl45NzUgC3mlqy82ICW72TDd+5hymtzM5WbaNcD4MiMPT3keC1kE2GfbCA==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr7066660pgd.205.1621746454491;
        Sat, 22 May 2021 22:07:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u17sm7538997pfm.113.2021.05.22.22.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 22:07:33 -0700 (PDT)
Date:   Sat, 22 May 2021 22:07:33 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 22:06:26 PDT (-0700)
Subject:     Re: [PATCH] riscv: kexec: Fix W=1 build warnings
In-Reply-To: <20210509004443.62c2dd5e@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-01d75198-392b-41c2-9601-5f482daa5e1e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 May 2021 09:44:43 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Fixes the following W=1 build warning(s):
>
> In file included from include/linux/kexec.h:28,
>                  from arch/riscv/kernel/machine_kexec.c:7:
> arch/riscv/include/asm/kexec.h:45:1: warning: ‘extern’ is not at beginning of declaration [-Wold-style-declaration]
>    45 | const extern unsigned char riscv_kexec_relocate[];
>       | ^~~~~
> arch/riscv/include/asm/kexec.h:46:1: warning: ‘extern’ is not at beginning of declaration [-Wold-style-declaration]
>    46 | const extern unsigned int riscv_kexec_relocate_size;
>       | ^~~~~
> arch/riscv/kernel/machine_kexec.c:125:6: warning: no previous prototype for ‘machine_shutdown’ [-Wmissing-prototypes]
>   125 | void machine_shutdown(void)
>       |      ^~~~~~~~~~~~~~~~
> arch/riscv/kernel/machine_kexec.c:147:1: warning: no previous prototype for ‘machine_crash_shutdown’ [-Wmissing-prototypes]
>   147 | machine_crash_shutdown(struct pt_regs *regs)
>       | ^~~~~~~~~~~~~~~~~~~~~~
> arch/riscv/kernel/machine_kexec.c:23: warning: Function parameter or member 'image' not described in 'kexec_image_info'
> arch/riscv/kernel/machine_kexec.c:53: warning: Function parameter or member 'image' not described in 'machine_kexec_prepare'
> arch/riscv/kernel/machine_kexec.c:114: warning: Function parameter or member 'image' not described in 'machine_kexec_cleanup'
> arch/riscv/kernel/machine_kexec.c:148: warning: Function parameter or member 'regs' not described in 'machine_crash_shutdown'
> arch/riscv/kernel/machine_kexec.c:167: warning: Function parameter or member 'image' not described in 'machine_kexec'
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/kexec.h    |  4 ++--
>  arch/riscv/kernel/machine_kexec.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 1e954101906a..e4e291d40759 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -42,8 +42,8 @@ struct kimage_arch {
>  	unsigned long fdt_addr;
>  };
>  
> -const extern unsigned char riscv_kexec_relocate[];
> -const extern unsigned int riscv_kexec_relocate_size;
> +extern const unsigned char riscv_kexec_relocate[];
> +extern const unsigned int riscv_kexec_relocate_size;
>  
>  typedef void (*riscv_kexec_method)(unsigned long first_ind_entry,
>  				   unsigned long jump_addr,
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index cc048143fba5..9e99e1db156b 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -14,8 +14,9 @@
>  #include <asm/set_memory.h>	/* For set_memory_x() */
>  #include <linux/compiler.h>	/* For unreachable() */
>  #include <linux/cpu.h>		/* For cpu_down() */
> +#include <linux/reboot.h>
>  
> -/**
> +/*
>   * kexec_image_info - Print received image details
>   */
>  static void
> @@ -39,7 +40,7 @@ kexec_image_info(const struct kimage *image)
>  	}
>  }
>  
> -/**
> +/*
>   * machine_kexec_prepare - Initialize kexec
>   *
>   * This function is called from do_kexec_load, when the user has
> @@ -100,7 +101,7 @@ machine_kexec_prepare(struct kimage *image)
>  }
>  
>  
> -/**
> +/*
>   * machine_kexec_cleanup - Cleanup any leftovers from
>   *			   machine_kexec_prepare
>   *
> @@ -135,7 +136,7 @@ void machine_shutdown(void)
>  #endif
>  }
>  
> -/**
> +/*
>   * machine_crash_shutdown - Prepare to kexec after a kernel crash
>   *
>   * This function is called by crash_kexec just before machine_kexec
> @@ -151,7 +152,7 @@ machine_crash_shutdown(struct pt_regs *regs)
>  	pr_info("Starting crashdump kernel...\n");
>  }
>  
> -/**
> +/*
>   * machine_kexec - Jump to the loaded kimage
>   *
>   * This function is called by kernel_kexec which is called by the
> -- 
> 2.31.0

This is on fixes.  I got a corrupt patch error from checkpatch, but it 
looks OK to me and git appears to have merged it fine.  LMK if I missed 
something, though.

Thanks!
