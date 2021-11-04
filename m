Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414A244502E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKDI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhKDI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:27:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2222FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 01:24:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d27so7326603wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=edti6PQbrA3HO/fwP6tU3hw7xf9JRnqSTxxIgTQdj3k=;
        b=fYVZLmUslh+eLwgHPV5xTut4Jv2Uhr8Wwdmhv5cbvnLd1RWxwwmsqYtUomcMXYXbir
         wij32+YvSu5QpnaZCPYonNOX1C3ULZhZEc7KdFA7mYpSvHcxsa8IlqDWDoyDBPonAI8D
         AIkbAgDNVftal/ysAg1v5XCT0EYkhVyZV/urQqjqKa1kkxTG2+xVzLHAt+yREner/4+t
         FOpjM+Qy5zLHmD17qQhqBGb/5+sxHBhVXrxx/tC2kALowYzPLDZi3OYLqDipPmhpedA3
         Cv6q62SbWnLIEELsczWP8zu8zvs73MCZtry5mg3rX/j0vi14n4Goc0hx22N5Syduyr46
         JiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=edti6PQbrA3HO/fwP6tU3hw7xf9JRnqSTxxIgTQdj3k=;
        b=pYmeoYFEZjJnRYM4fysWToXIfrx8ytW808qhnkY+R6Pv91Mw4kvnUZLQx/gPZmAoO8
         pU+EMkeKz+ydshgDbzWh+SZuBktiK/57tbZTvHHFzABZe8eTu4HekfyQ2/cr1Vk/Cq1U
         D24WCerXnTXivs0oDt8lVjexnh8DpD/q4wtzcGByU8Og9rzbEZlo9Dup+vF76LXR7tJe
         Kn9PzXS6e+rhXdfCF6fdKrCLvoJYLCpW4mlYTqAQ6ll6h3CHCawAd+nVJ0wKWyPu3Q4j
         Gz2HYMwh/J8dLC2Fd03StPjIxcBIZ+LS8JrORrAh2Zv0dWg7imFreBZZomC7r/aL1sw4
         WYrA==
X-Gm-Message-State: AOAM53318QMCxBcWQrAK7joFU1ADG6ymU/LTj0BS5PmQRMDIuCG9qR+X
        Z8WcLmUMjrmIwskFYo88Wu7sQjQfDyHFWA==
X-Google-Smtp-Source: ABdhPJx2iW1GS3Vwxz7RWt61oCZh21RABeyYiWwujWfFk4vfKwqHnNW/hwFqoJigjTmWKI1IMeKxuQ==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr12757706wri.141.1636014270689;
        Thu, 04 Nov 2021 01:24:30 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id n32sm4105502wms.42.2021.11.04.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 01:24:30 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:24:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new
 mfd-core dependency
Message-ID: <YYOYvDnX7yA932re@google.com>
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021, Tyler Hicks wrote:

> Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> linker error:
> 
>  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
>  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
>  make: *** [Makefile:1187: vmlinux] Error 1
> 
> Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Looks like the same change that has already been applied.

Could you rebase on top of the MFD tree please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
