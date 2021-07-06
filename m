Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4A3BC7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGFI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhGFI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:26:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78711C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:24:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so1065298wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VsBR1kPAqwaus4wsl3eEy2clPsB8g8F67D4/h57x3zg=;
        b=VXCDKOvpY81S1qjLmasFSh3RxuTWbWxgzyVPBPxUrknaDN9viJmuLPjO4gorF/kH1c
         0SXlnrpiGiUA06z1hAtso5FwQ1/lK/oW1WsSULD54XSv761Ta4PZtFfVTctLwZXtoIIG
         esHaMInPPeJ6xo+/YU7GZdzBvTz0UzTrSGBDn1kfsuY2eWvTGLzagXF/gNZi98PPzHnJ
         qb8rRsIIHlfBa6zuMUULMGwOTqz15J8Z+TNEwL4Dvii5LsOUGqZxBnO1mLVheDdQDur8
         tDHSKfNr6lCK8ogdK4gB9F0fcqwheFKKbe+wf99Xc6IFGBqafj91Kh5e6F06FXqyS2um
         esxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VsBR1kPAqwaus4wsl3eEy2clPsB8g8F67D4/h57x3zg=;
        b=t1pySWzzy4eRr0NoAODeW7Xlf0QwcldTJ0KbbZQb/DZZmLKpoGBeWC9LGm6kX0h0m9
         kYKb256Umhrz8Lq09zGSRZqxngKYPnXjAlrLGfkEx7JktVbNpwXt6DL4eYL0Ns+MP6Hx
         fYXqHTK0Cjd9VEdnNeOLekegRvWw/eAozwfFBRBqrAMg4YW3OEQkPhGhaBYtNrdH7NfN
         4vjBnWvJXiqhNiuwj87JPhgbvAJSoi83j0nfuU9CcI/8jXI4Y9PyWmGudQzMVND+Y/68
         4t5MrVE7UaLAXM5eUb/+3FVVBR5D2NqumJo6pI8uPrH2O6oUq8pq8JVjObo3CPl2MGAW
         /c2Q==
X-Gm-Message-State: AOAM530v0muoadvmDehiA9cwN+6C629sySzN/BWe3UoELX4yjTpAcJ0k
        q/fLIVmwQVcWpK8UAc+YEPQuIA==
X-Google-Smtp-Source: ABdhPJz5lArn57Cztz9ZpGcnXAU1wOJbT3fcbyZm+nijyI1OCAMBgVRZ75DjTMizZi9vXX1wbNOqPQ==
X-Received: by 2002:a05:600c:3b0b:: with SMTP id m11mr3408106wms.25.1625559855954;
        Tue, 06 Jul 2021 01:24:15 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id d3sm7670088wrx.77.2021.07.06.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:24:15 -0700 (PDT)
Date:   Tue, 6 Jul 2021 09:24:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, axel.lin@ingics.com, cy_huang@richtek.com
Subject: Re: [PATCH v2] regulator: rt5033: Use linear ranges to map all
 voltage selection
Message-ID: <YOQTLWsXpTOK58dr@dell>
References: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2021, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Instead of linear mapping, Use linear range to map all voltage selection.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2
> - recover the volt number back in rt5033-private.h
> - Add the n_voltages from v1 back.
> 
> Even though commit 6549c46af855 ("regulator: rt5033: Fix n_voltages settings for BUCK and LDO")
> can fix the linear mapping to the correct min/max voltage
> But there're still non-step ranges for the reserved value.
> 
> To use the linear range can fix it for mapping all voltage selection.
> ---
>  drivers/regulator/rt5033-regulator.c | 21 +++++++++++++++------

>  include/linux/mfd/rt5033-private.h   |  4 ++--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 17 insertions(+), 8 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
