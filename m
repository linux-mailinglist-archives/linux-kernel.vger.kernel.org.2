Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1635EFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350105AbhDNIe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350070AbhDNIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:34:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C363C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:33:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so30087913ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qSiJYf3A2Fi5kx6d1IoI5ylPeQlcrj7WDE0UtDI/T9M=;
        b=NVKgLCEa/kUmT94dLFGWjNYqYTxUpnckJeuoB0RtbjEiyMoij9lcgbD2pmw+XkAlm5
         4WJj6HQQRtQ31QsibMON5MI3LuDnBqt0ROBDX8M8zXfTAsAI3E9DkdSDw97JezTHl4Kk
         frfxa+mH3UpyJGba384YN+2naMDSA5s9BHUACJpEqQv1IqPwFpbjjqo2tAiviEBXg/q6
         jMyPfaWxBEudIOypVPqPokkcpZ83EbJqV0m4bP5IBAMIUPTwy1GhLNYsDWds5zNgQ1Ru
         myR0mXb4MyEN0GvdOjUo0Zeja1CSibSeJyZFzOtmNaSjEzd7teM2s99d8KhaJ+aM11hP
         a0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qSiJYf3A2Fi5kx6d1IoI5ylPeQlcrj7WDE0UtDI/T9M=;
        b=dlKZvY1fefKTOTERXxt74if4bobqE6w8stUF0yS1KIUmeBRzCFArqATC1k/J1saAY6
         QGJk6Uo7syDZ6M3E2XAfa6HySUry2Uloqmj1DAmAAfryib8cxBFOUbNSnYZ41yZD5T5c
         vvdpv1fRVzcsPsNqSz8uNYCXBB7840GQPvJtivZ/XYyhKe3gKwcNYLSZVc+o3L7/kfS1
         RRYLOKP0uCEFHZwjmQu/iTCJ2g52xNhLfSVnL5yil6Iku8aVN7w7yWOGF88OC/0zbrUm
         2XQ/e4Swhok9MzEPSTb92CZcFI/TRSGrix+Ojpm0laNXKdag3vpcQ6XHkoKtbwu2DZai
         0k6Q==
X-Gm-Message-State: AOAM533lpwGOx3Zbk4S38CG7kdqPuUgiZZ3oWE24gYnxuDxRCrNVkGDx
        ePOT7BNuNMPN7g8fGyjYX2Kp8rlre9WECQ==
X-Google-Smtp-Source: ABdhPJwvyKNaGU/rGQvKSNO5QyhKOwXYbkM7S3LR9Ab3EcHUuLOvvmVWdqXKB1BNHim/u0zW8JR5iw==
X-Received: by 2002:a17:907:3f20:: with SMTP id hq32mr29477536ejc.226.1618389229144;
        Wed, 14 Apr 2021 01:33:49 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id mp36sm9138695ejc.48.2021.04.14.01.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:33:48 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:33:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] i2c: designware: Get rid of legacy platform data
Message-ID: <20210414083347.GF4869@dell>
References: <20210331154851.8456-1-andriy.shevchenko@linux.intel.com>
 <20210331154851.8456-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331154851.8456-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021, Andy Shevchenko wrote:

> Platform data is a legacy interface to supply device properties
> to the driver. In this case we don't have anymore in-kernel users
> for it. Just remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c  |  7 +------
>  include/linux/platform_data/i2c-designware.h | 13 -------------
>  2 files changed, 1 insertion(+), 19 deletions(-)
>  delete mode 100644 include/linux/platform_data/i2c-designware.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
