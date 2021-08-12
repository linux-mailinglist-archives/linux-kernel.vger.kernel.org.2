Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583463E9F59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhHLHTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhHLHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:19:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59015C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso9308730pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mdOlsfXKdlKl6MyZvBvYASQyu4ZbLHqpUz6jLPzFa8I=;
        b=1pmWvojHGXKtF3Y31/agvPnvgb3Mo8uRp8GVUnuA9iT/DM8T+wOSFcbOhYRq7fg9ko
         rAu5mWvfUJccuG6Xqwty7QVAZa5lMC7G82mjaaCPDCtcJVHU8weO+mWglXB95GCRbO89
         es4x3kR24Ll9QhABrVGfu4H/qrGfPpIrQ7n6CNx3Aduqq3t2vZawfsIhUNHzRVytRyzJ
         Qg/k/LvSGrYhgGPA0EpU8uevogx6ExW9yBTwpTy4dvXA4wFxSEBY0uyUfekW1Avyjjjw
         /4M/bNvysLmVBMSxBD9oHEBZKh+ujRD999wdQU2gX8n9pMMRBoltlkTFLjhTxd1GoJ1P
         zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mdOlsfXKdlKl6MyZvBvYASQyu4ZbLHqpUz6jLPzFa8I=;
        b=ekEiSJIR4akPf9e1XGDf4cSN1OH1SeFLrMA4VaWN0KtX9qpECOt9kXdbPbvfIhh+qL
         WJEoXTyA5AdV/PkHdAWXvmfN0RgHzM+Id7cnbhURssTl1PeJLczqMU1QDFpHiri3T2ef
         +KRGyXCqoIcJN6g4Q0WWwFM6colztnikg546sZKgkSNKlEDEopyMNxf25jMNk+UEwBY9
         rk4Dwdz6r7I2J4uvQYlKrOyO94HuPlorJE10lqb9kA7arFGagjYCDL7+zNPqw0/LEMKD
         y9H1gHMuXS/vO0ltwHNVA5UAdGCvRwAaIL1TT+RiBdhdXtRRkB8gIuk2iWyQVM5xR5x/
         sP7Q==
X-Gm-Message-State: AOAM533eS93D+FMB6WFaSd6bDJQwaGz+gf/wYrIsQB0frC0FLPFN4oFW
        8FKpTVTBP+C2Q5I1euBdbAOmkA==
X-Google-Smtp-Source: ABdhPJypp8y/PT/pmeaZn789t3g2lcZzjWVyMVqF/3wBs2ifjAqYaUi4z9s3z6GwhLVGQ86eBUfHyg==
X-Received: by 2002:a63:5153:: with SMTP id r19mr2712356pgl.56.1628752714869;
        Thu, 12 Aug 2021 00:18:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b20sm1966925pfl.9.2021.08.12.00.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:18:34 -0700 (PDT)
Date:   Thu, 12 Aug 2021 00:18:34 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Aug 2021 23:50:20 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_VALUE
In-Reply-To: <20210726054254.21801-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-450bca42-382b-4821-8310-a2d43108c7cd@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021 22:42:54 PDT (-0700), alex@ghiti.fr wrote:
> The current comment states that we check if the 64-bit kernel mapping
> overlaps with the last 4K of the address space that is reserved to
> error values in create_kernel_page_table, which is not the case since it
> is done in setup_vm. But anyway, remove the reference to any function
> and simply note that in 64-bit kernel, the check should be done as soon
> as the kernel mapping base address is known.
>
> Fixes: db6b84a368b4 ("riscv: Make sure the kernel mapping does not
> overlap with IS_ERR_VALUE")
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a14bf3910eec..79a2e02924e4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -191,7 +191,7 @@ static void __init setup_bootmem(void)
>  	 * if end of dram is equal to maximum addressable memory.  For 64-bit
>  	 * kernel, this problem can't happen here as the end of the virtual
>  	 * address space is occupied by the kernel mapping then this check must
> -	 * be done in create_kernel_page_table.
> +	 * be done as soon as the kernel mapping base address is determined.
>  	 */
>  	max_mapped_addr = __pa(~(ulong)0);
>  	if (max_mapped_addr == (dram_end - 1))

Thanks, this is on fixes.
