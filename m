Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9725238D836
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhEWCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhEWCFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:05:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE63C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:04:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso8568146pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mUbO565hf5uxk6ROeLW4fGwEI0mXowXZYPE3OuwhyXo=;
        b=MvnsjT4rH2/VYW1fh1/Ar/6sWPUsRuEP4ur5isAnaGZhGwLUehtZFQINKPMQkTjWXw
         RD+yMwWktzzR/6XriPLOqtbFbQQa5KumuMgDptBD2kdtudohOWBW/x/vjZGIhbhjXzxq
         UKWxzcrvXMKVWNsXUt6hmtow0ZQJYeZpPRH12N3jWqW/Yw11/RP7xDKLEd/mxKK4BXt0
         c2xNZlHt+n80mWRB/wGPzqOC/N1TgACTLYtqItGICNsr90fDYWkFy79TQ8qErwL0gfB8
         dpW66ZmKOAHuFPaujDYZNbhpA4w9DUPkWuwEYVPLYqbCmMywoA5TmVE2f1QRonrf3NQb
         HfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mUbO565hf5uxk6ROeLW4fGwEI0mXowXZYPE3OuwhyXo=;
        b=ObkdFVdmLQ/INomB3NPDvgYrWS2t8FFqnGQxWx8+N4XxNLbYGBusxQrn6D/IS+qjo7
         1oxX9wkDvVEXYNvzlJKStI353ZEYRHIgWtqk8AwOqlYzTmXBEGt8nGODHVl7R2stSyTJ
         lBdCXbQ7YwBKhsCci1kg3Qzd30IMOVkCXxUvKJBnvdy/9TMJFXPwuKns7sjvnK/FDu5Y
         sd7AronDbfY/M6acYFdYeYyXsEfuZtWeSm32USnXQvatMHVzEfbroJ0mZTc7TlFywQJg
         6BAKy4cIO+F0KFYLP3dQHIv+Vqf7oIoLL4Fm1zRYWju9l5v4LDqPcsiuLzVWOXh2lIsD
         p4Aw==
X-Gm-Message-State: AOAM530Uga6mifUgW5EyvDwcSTaFsBX3zxOIvtrVati2yLb0AR3rThiC
        YaGzBcoOhbpOi8/eL08g+O8smA==
X-Google-Smtp-Source: ABdhPJzhWCQ480vMXxtMykQQVFX1GkdT3DsG2KEaFC7hlHjoYCXWm0x5/N57FORybBy3ElUYCG0oMw==
X-Received: by 2002:a17:902:8bc3:b029:e9:9639:be21 with SMTP id r3-20020a1709028bc3b02900e99639be21mr18894966plo.59.1621735447899;
        Sat, 22 May 2021 19:04:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w123sm7322419pfw.151.2021.05.22.19.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 19:04:07 -0700 (PDT)
Date:   Sat, 22 May 2021 19:04:07 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 19:03:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: Remove setup_zero_page()
In-Reply-To: <20210507221959.2db29936@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-7bd87d93-ae3b-4c4e-bd75-388d583a0c0e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021 07:19:59 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> The empty_zero_page sits at .bss..page_aligned section, so will be
> cleared to zero during clearing bss, we don't need to clear it again.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>
> Hi Palmer,
>
> This patch was one of v3 series of "riscv: improve self-protection"
> and acked by Anup. I checked Linus tree this tonight, it seems the v2 or
> v1 was merged, this patch is missing, so I rebased and sent out this patch.
> If it's late for linux-5.13, then I can rebase again once linux-5.13-rc1
> is released.
>
> Thanks in advance
>
>  arch/riscv/mm/init.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index dfb5e4f7a670..4a68b029e3d2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -67,11 +67,6 @@ static void __init zone_sizes_init(void)
>  	free_area_init(max_zone_pfns);
>  }
>
> -static void __init setup_zero_page(void)
> -{
> -	memset((void *)empty_zero_page, 0, PAGE_SIZE);
> -}
> -
>  #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
>  static inline void print_mlk(char *name, unsigned long b, unsigned long t)
>  {
> @@ -862,7 +857,6 @@ RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
>  void __init paging_init(void)
>  {
>  	setup_vm_final();
> -	setup_zero_page();
>  }
>
>  void __init misc_mem_init(void)

Sorry, I missed this one.  It's on for-next now.
