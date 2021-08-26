Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F63F8B51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbhHZPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhHZPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:48:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:48:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 2so3100802pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JJP+nPxJKAVqphBV0U7M3pCSiiD75owxGS4FYqm3izI=;
        b=B34DZ7GZQQP/RfYnW/796r41LR1R7dUh9UzNNn59z+K2eYT3nNiRTHL9UVBI/5GjjK
         3TfWbQHjHI6ZF1iG6ilkCd3Tnf8CYLTTSVDTJUEoe1CQxI1jWjuJGqVXm6lTN5Ef2pyo
         jgeon94XxOvvTaUC16e7J7meXw4D/txz5Lh9vBxC5ODFBCbGZ50qET4nNP1Uiqfvu2mt
         bEpLA1W5BK/jKZ6DytuHgkwE2H7S8IESmUXCfYKGcFWidLyJXV2aSVlu0hitDWFFfCK0
         5oMMJMJpe8mfHlDqP9O4ot49mUfirHUDOSafWxEpMLvlExgo819A3jbcTY+s3CMqnhaF
         D4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JJP+nPxJKAVqphBV0U7M3pCSiiD75owxGS4FYqm3izI=;
        b=rKNOauuNp4VhjE/bCW9xA9RhiT3vg8ZaOd43LAQBJkybEZJeVUx6SYEii5W6soksgJ
         wu0Nj8/tESllJKms6H2ZD4hBDTSk3CHK5xqX4YPC8Hgx1WrJ+I9qF9TWpct8vIJKcyXv
         cu7mh6HJ/WilF9BH3rHIZSJ0ltu5VFjDrBL2WwKdRRBxgKHAJzgVrZYM6J6pM3RBoWNo
         dTxRDoq6tTCzY7QwG9H/CUJ5x9FFqU92CU+dDBMqCjXrNxHMEeYfpHamg77sPSOB6Hs/
         Ur7jwRKp8uRozSyLta32ggdBLZ8GavQUc8pjEKrLJbb2uITTxGAv30pi785utj0LrTil
         fGYw==
X-Gm-Message-State: AOAM530ddYA+hXd3HOtADjvYINPAqphZ1j63q1JNxz90fTYTeKkrTofJ
        YBS6UhILH3jljZCXu33YcaQA3A==
X-Google-Smtp-Source: ABdhPJxpwYj7R8tyX7ioeatO8I2WCuwy7Nep0VOM904vJ6/PF9EPA/CqBgda+W0PUJMTOMydi8w+BA==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr4425688pfh.17.1629992889586;
        Thu, 26 Aug 2021 08:48:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q18sm3530686pfj.46.2021.08.26.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:48:09 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:48:09 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Aug 2021 08:12:37 PDT (-0700)
Subject:     Re: [PATCH] riscv: add support for hugepage migration
In-Reply-To: <20210810135105.2827214-1-chenwandun@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        chenwandun@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chenwandun@huawei.com
Message-ID: <mhng-d4c69614-7786-4d3a-acbe-4a51d57d7ed4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 06:51:05 PDT (-0700), chenwandun@huawei.com wrote:
> Generic arch_hugetlb_migration_supported can provide appropriate
> support for hugepage migration when enable ARCH_ENABLE_HUGEPAGE_MIGRATION,
> so enable it for hugepage migration in riscv.
>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8ce8382748d5..8bfc89589838 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -13,6 +13,7 @@ config 32BIT
>  config RISCV
>  	def_bool y
>  	select ARCH_CLOCKSOURCE_INIT
> +	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_STACKWALK

Thanks, this is on for-next.
