Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0545C8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhKXPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhKXPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:39:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA46C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:36:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so5782298wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9axgss5JK/d4JEsqVSzEUVHdFM9P3LASCpmPJrqXw+4=;
        b=WypPoA5Iumpwhit1UWOxjKhEmdev0XG8irGEOPKfdXs2/OsOrhFUOf5qNjvJ7nTJRE
         WhvhXkY0q52nuWxuCEEWeY0Dt6QCG3xgIQ6nDUKDwrBwBs3ZRAlTXMyvqTmf28td0uoT
         ERRcaAcPQxkzwCZ/MFvXF/cEQ729giTQWe5cZ6Q6O7RYhPiOJ74NEuSlgyf3hdsUPOqp
         mBY41YCfwEqenzPvqrCmL11BH/qUB57dqhp6nZSlna9FhvB7qIRNIRHaxvI3nHu9uQOe
         M/lCYXCzm9bHOOD7q5lfaA9HZnGTpypX4i8yjQuvbTOiB4B8BT/ChvgH2PdBleHG1vaU
         /woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9axgss5JK/d4JEsqVSzEUVHdFM9P3LASCpmPJrqXw+4=;
        b=ID/HHal0qQlJ3fcPDdVVv+2IfjF1m3zLo7cBL54/YXTaxrF9ngDt43WnB8aHK+iQob
         yG/rp5NF+jLG4fxLdesiuYx/XD/Vh76emiRzZW64h3Rcviq5bmOBG7ltG9vyoYocdsqm
         /7D0IzotlQhbFCgmfeQA2Djdg44A3UEaPkl+bJoPoGEALvKVTlSTvju++R0v6W4leGUx
         zzTuqF9CcMVpB59N4+dYiL50qr/xrMWm6SRFHEVUYF09HJO8kqWNbm/DPdqY4zomo59s
         vnJgd1cJ6uI5+loY+STD5+0FLoAwfaiuU2QRLekXLOLOGTTJAv+osQPBWh6VtD0vFTID
         WHAg==
X-Gm-Message-State: AOAM53238W9LDAPZ28Y9+1kok9NioCsZPwY7HmIMVCEm1xslNfw2g1Qg
        a9/RC2crlNc2ejM87G+CHWKjvQ==
X-Google-Smtp-Source: ABdhPJzrjAX/IQMZmWBDLKyMvMXU2IgliP1qCaR4MVKaWRuyssUDeJYnPYeNGh7Mo5dnQM8sMsvP9g==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr16397453wmn.93.1637768168666;
        Wed, 24 Nov 2021 07:36:08 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id h2sm160253wrz.23.2021.11.24.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:36:08 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:36:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, romain.izard.pro@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v2 2/2] mfd: atmel-flexcom: use resume_noirq
Message-ID: <YZ5b5lBdJqHBuzBH@google.com>
References: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
 <20211028135138.3481166-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028135138.3481166-3-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021, Claudiu Beznea wrote:

> Flexcom IP embeds 3 other IPs: usart, i2c, spi and selects the operation
> mode (usart, i2c, spi) via mode register (FLEX_MR). On i2c bus there might
> be connected critical devices (like PMIC) which on suspend/resume should
> be suspended/resumed at the end/beginning. i2c uses
> .suspend_noirq/.resume_noirq for this kind of purposes. Align flexcom
> to use .resume_noirq as it should be resumed before the embedded IPs.
> Otherwise the embedded devices might behave badly.
> 
> Fixes: 7fdec11015c3 ("atmel_flexcom: Support resuming after a chip reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/mfd/atmel-flexcom.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
