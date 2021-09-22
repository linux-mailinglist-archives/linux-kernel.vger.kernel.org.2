Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0D414A61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhIVNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhIVNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:21:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:19:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i23so6824370wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o2ySB4/yfe5/dtsu7p9s98grv86+I7C5iuCxnggEE20=;
        b=dqXtCocpL9GEbfrI2k9McEb8Ct8+Q1pY3ZdFAB9z+bRgZDnMeSqXbVlCsb9EnDWLfI
         8C0tga5vhwke0oVWTdSXvxOsEamfLBeOuPI1gejyTEM0T6Cg2JgcKGGcFmGSgbqy3J+J
         a0xv+RizB0f7zkpK2eoFXwpAHqXvxeZty35/cS1U7vUU1lpiSommCuIADZ1/PUjeONN5
         Z6zd9MbqqhY3M6ZaIRu2ulJt0KeKZMvstl9guEGJCmZ0HhPiSARssjKVKZhtxmJFUmA9
         UPMllA2bHwLYBLsXz2FbMUyuZgaoe2HpnE+dLEomr63Ra2MVmzB6ShxYRmvYq7EuTctm
         pYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o2ySB4/yfe5/dtsu7p9s98grv86+I7C5iuCxnggEE20=;
        b=Y18guRrjSqIqwz4DeHKEGhKBh4cOFlgdoX1VVczsrJe7QwNn5QDSAUV5w39ExJa6Q8
         xxD77mbuS4v5mciQg16Vd92cBkTzHwJ5oPZ+qwKjZMIrzVrnxh/+dxforAoAMDfioCLy
         YX2mOt3oexjw3FYgo4u3W9lTFd6tKhmP412hfUNm8AnwiUiGslQm2e/IMQ+qYnG1i2Cl
         clIIzlULtyIVj6gMuxGjknjqLUICZttRwmAxlJWfT2HdOR8UdVlCejyyTjAV3hoSMMEk
         DKBHEEEytoWXNDIEAwUtlPZZOdfJQ1LVwOWh5q/PDbp6aL0wxE15dSF5lKmUAi0CVKqe
         uscQ==
X-Gm-Message-State: AOAM5323RzZ1Z/GM2DZkKskl7wXj14+fHqGiGpEsFjRqw2B7wQ0nFYmg
        t4JtBLKBMcFzUiDfIgjh1XG9cdpi3ECWvg==
X-Google-Smtp-Source: ABdhPJxDrDxUYe42jX6oSSBYy2CBtIxYrBfVnZqaoH59KtIdScwFkvsiaLuttQgL7XSpor9uHaCg8w==
X-Received: by 2002:a5d:6212:: with SMTP id y18mr41802546wru.241.1632316784924;
        Wed, 22 Sep 2021 06:19:44 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id z17sm2192595wrr.49.2021.09.22.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:19:44 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:19:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: rk808: Add support for power off on RK817
Message-ID: <YUstbhx37ZEbrRsI@google.com>
References: <20210829025153.1058978-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210829025153.1058978-1-megous@megous.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021, Ondrej Jirman wrote:

> RK817 has a power-off bit in SYS_CFG3. Add support for powering
> off the PMIC.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/mfd/rk808.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
