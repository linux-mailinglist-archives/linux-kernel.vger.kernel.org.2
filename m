Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD435EFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbhDNIdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348471AbhDNIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:33:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B0C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:33:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x12so9339222ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xtZyGhp+r8KyQsgdY6dvRyvGM+PA3hhprK2XIk+e5iI=;
        b=Zj9BoZa5Uwmd4GL7iOxvoxDCYIDkBLMsPKxvvHMbB1HNmv7WTmCQn98J+/uaMsrcRq
         ZkPgT5N6ZWiEAm/ALL2zIJbRgOCD3jUZSCo0w77xt3EC23R6OxD3yVjXnb+G/tw2+42i
         qFplRAZA5uspzQg+9yeCYCVXTjXM5ktK/JbEPt7Lqvu6MLC1UjSyHAxqo6UkdHabLFGz
         JOkI6DJfOha1nxKrD7Ej2L2jw/w+iOJJjgsxXz43d6iqWkO5l6Z5Re83zyy204g4hQCM
         fTlELbrJbjxTtFUzWjNIQvP4CshhLLgT2Jtffti0KJfMGP36JZuenngJ4bQqW7GgqbTn
         /qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xtZyGhp+r8KyQsgdY6dvRyvGM+PA3hhprK2XIk+e5iI=;
        b=XlAUze6Xoe2RGmRm44wX8Zo9yb/4TfqUHnaz2b1VqLYufDjSxuMOtfPNWdwQQuNPKR
         D88yewEFUafUtC6BeFPr/i/rHn6bxdMgCGfkPxF6cnyF20iiYj+XkvVud4JWAM+MttoK
         onSZ5OVRvgOaY7SlyRQxVv3LxLpUWB4tlH48O8xGnqCeZs9/ITdi8X2OPtAlsD26gHG5
         1RYMJ9/hjZaFoILQ2278QXAwQVaXwwVDTWCzMeja0Xvde1F13SZ6ieicx8BTEEEryEM+
         tmJtm+AKL159fH0OCLbV9BmFAs2k982DJQg1NuyTanlxHOVZQ+CTjE1bv+8b2bk0zMV/
         noRg==
X-Gm-Message-State: AOAM532rfw1Ifyv1LUPj6yqSbDrcUXBJKLNjH1qLv8Dv8skCbv9ctnYT
        N3dqqMZULUnF9skDPG427xuVZg==
X-Google-Smtp-Source: ABdhPJyyf637F4yQJ1Y0LSg5vfXoU2bVseY3Mb+2LCpWkgQmQAK501PeDMSQhDbEtOeAXEcGERd00Q==
X-Received: by 2002:a17:906:86c2:: with SMTP id j2mr25434581ejy.257.1618389206394;
        Wed, 14 Apr 2021 01:33:26 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id ga27sm1577044ejc.87.2021.04.14.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:33:25 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:33:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/2] mfd: =?iso-8859-1?Q?int?=
 =?iso-8859-1?Q?el=5Fquark=5Fi2c=5Fgpio=3A_Convert_I=B2?= =?iso-8859-1?Q?C?=
 to use software nodes
Message-ID: <20210414083324.GE4869@dell>
References: <20210331154851.8456-1-andriy.shevchenko@linux.intel.com>
 <20210331154851.8456-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331154851.8456-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021, Andy Shevchenko wrote:

> The driver can provide a software node group instead of
> passing legacy platform data. This will allow to drop
> the legacy platform data structures along with unifying
> a child device driver to use same interface for all
> property providers, i.e. Device Tree, ACPI, and board files.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 41 +++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
