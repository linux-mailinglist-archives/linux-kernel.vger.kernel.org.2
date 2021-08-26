Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBED33F8AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbhHZPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhHZPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:04:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:04:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 7so2990521pfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JJP+nPxJKAVqphBV0U7M3pCSiiD75owxGS4FYqm3izI=;
        b=l+MJTxG08ZAAwZWn3FOyG34qn8pMD1qp2qC273n9plefcBzQ5AlIH02wRx/yTvktU+
         Qwa3buYuQShXoJWKUnMtYX/MpE6LRuh+fVZeJUITUdc5QVdTQcZLqsqiq1BpXrXtto1Q
         m+jcPkPcaKB47HxEJ4B7ef35PWwMMt2jsAG9lpSF08gz89bKMJwh8E0sD42i3Tqrh7lM
         XfGNKOY8wrtAdbWMR2oYg0hurCNJ+PoAH+xHTAsLGevSOdTy6YsGPh3/y22zN54767Y3
         hdaffOGu0LHrUv0INy27vxIQhlEtWvd6GAZV7IGlLST49dUj0GJ/1Koo+NqJQOI3By5T
         UT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JJP+nPxJKAVqphBV0U7M3pCSiiD75owxGS4FYqm3izI=;
        b=mtdESzGOAVlCZXTFkZZFv8YtXAg50iJJHuNcvs2Cd8h223a67doFvEBvedZA9eHpVz
         YXWwP+849xPBYzYjVRBdUCm1iSl03rxZ9clQCibiz7GYR3Mj0w/JFCPQA840HwqAKCAk
         hiRwfBTgru4lx4/Ilrvokul+T8VvgkPbrP62BmkNz8Y5NURshxMLFSFZavt8ZJMdva+S
         aK9YcnHYjTy25spxAz92LBMTZ1g+NSVGDAD6nGJFc2sIX7hhyT8EHqRzzmwWnpZB1w3o
         WEPcCmTCIdYVADS+EuXtUy5Tjqz+5yFFx6GvO0NWWOBgtv8pIZ6ThtuoY5iGDIuVoymM
         pRRw==
X-Gm-Message-State: AOAM530gZv8ZeNMdQ9uAuwjT4GE+dR4ZAK3gBnFyfhNUhwXg7z3kl8LM
        WckCnK/OByG0A/uuRcmFQEQCGg==
X-Google-Smtp-Source: ABdhPJxxKZ6y5f5P9pt1kCaUiIk5aDU6TW7t3bZVuv4CM0V9Y65ZDvZGSyDAqIaCmNHmBPPmjX+Yng==
X-Received: by 2002:a65:624b:: with SMTP id q11mr3760597pgv.232.1629990250430;
        Thu, 26 Aug 2021 08:04:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 66sm3417160pfu.67.2021.08.26.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:04:09 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:04:09 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Aug 2021 08:04:00 PDT (-0700)
Subject:     Re: [PATCH] riscv: add support for hugepage migration
In-Reply-To: <20210810135105.2827214-1-chenwandun@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        chenwandun@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chenwandun@huawei.com
Message-ID: <mhng-61de2fa3-208d-4d02-8264-a8781b5bdee0@palmerdabbelt-glaptop>
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
