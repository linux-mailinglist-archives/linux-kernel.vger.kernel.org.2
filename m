Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A053E29E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245637AbhHFLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245613AbhHFLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:40:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D10C06179B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:39:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h14so10648256wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eigdQs27YUi8ytcJscaoyu+ORvD8eoIuP0aOEqiyV7E=;
        b=Ti+NIcNuF0/R+SpgiNxPVsL48enGb7NANI9RaJE8GlwqfncSxRhJln7Uz1h1WXddDV
         mUZCMhoQ8Ku31NbK6ImPu0BaaySyTssb0T0HULZ3Ryuk8iTCiqrR8RD2Zu/bgPHDu/rg
         plyI0Q0WKvBetSerXsfljg1ijwt7g2JRs3Q3itCg0pWDXz9485K1hF51VM2y1bznS1IL
         06R5aVfJZQhqnopkuWvSIdohe+Frj2VRSNvmZEaSyfWcaq3fkewAJlyiF6/cnD1hjEK9
         +rwpT+LrzmPV5xUIVBhvooLTrG6KnMLiGRG5EB52LmbW8PsB5mL18YG8PvOW0v1lWeq3
         vOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eigdQs27YUi8ytcJscaoyu+ORvD8eoIuP0aOEqiyV7E=;
        b=ZpqbyGMvNO5Vm02yrwxKfKbYjxYtZlEmqvwHQaezJDsVVLAK/tEzpsYD1+PBXxZaAW
         OJhx4y8DyF2cWL2W02QXfvTDr3ImwhkIjbBU8VoaAHcxqqikIEN+ANnpdNbrBu/n9STr
         t83FW5yWjI3PYYftSdru6TqYnJFMGSZqHKXGF8LYx4GJs4sno2nH/WOMnLMgMwsmb8HI
         Ci9u9YFl5sBoSkWg8sbKHaAqsRGP64LaD7F0is7EjBugR93tI+E+4jmWOhUYd5/u4VPc
         LI5giUB/BQFOZr6rnXRGIwcEWQ2PQN2BEh/rCpz4MNS56KRKL3NfyBFTu6Wk1KieK6n+
         ppXg==
X-Gm-Message-State: AOAM533QsyYSOuMTFmEHcA1+dUMHm/HQD0wEHtd+0GeizLbjM2M3yXN0
        oI/ZvH2YiUPCH9CnhX4UXqKfuA==
X-Google-Smtp-Source: ABdhPJzOlZDT6ukjnN6IcN6hMAkU9CqfXgDKdaPgGZXEn6zLgpU4RLopZfAdQ6ZmT2jA3Le7LIwdCw==
X-Received: by 2002:adf:f602:: with SMTP id t2mr10086361wrp.232.1628249998447;
        Fri, 06 Aug 2021 04:39:58 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id p14sm5349404wmi.25.2021.08.06.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:39:58 -0700 (PDT)
Date:   Fri, 6 Aug 2021 12:39:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v9 02/12] mfd: simple-mfd-i2c: Add a Kconfig name
Message-ID: <YQ0fi8pV1DNZd4nP@google.com>
References: <20210806091058.141-1-alistair@alistair23.me>
 <20210806091058.141-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806091058.141-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021, Alistair Francis wrote:

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..09a939f8b7ff 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
>  	  module will be called si476x-core.
>  
>  config MFD_SIMPLE_MFD_I2C
> -	tristate
> +	tristate "Simple MFD device"
>  	depends on I2C
>  	select REGMAP_I2C
>  	help

For what purpose?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
