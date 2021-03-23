Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA32D345B15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCWJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:40:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:40:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm8so22684917edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VM6J50cuO11tHNrSpVMEPhTlVh0nXJYB1QWh6jX41x8=;
        b=ljIX33yEr+y8O/Km4ORjc6mpfKAzTKw7E0cIYwNv9D4+CTk92/dWTK8pNVyby0TD92
         r/WgLLXu2D/bfmC+KhRAZAGh9C/rGvicFTh6UwBCdlMnsO2rcHMxZ9S6N+lXOjh18o4J
         3uqKQ0ovd60NWl5nQ01pHI/PQMEMvBBmS6LT19KDWAabdB9J3Gs4TEue6ob5HiAUrQ/R
         QNrc/NfLdBo3cFk2gKJQTVpLW6QevvR3UFJWOCRwB5Bbe1rG1amFtjn2+Ws2aJkjCrku
         AC62Rh3GXbClZekjs+wTrd8c3oGZt8jSw4VuJmySUHRloEcPrz/fFcQK5gImMkR2ZtuD
         B27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VM6J50cuO11tHNrSpVMEPhTlVh0nXJYB1QWh6jX41x8=;
        b=G/AoMSl8tZr3hz22MBcbakDpI+9exwr5FfCxtoMhNNRi9323rvMZJR3piEoIikn9gl
         5jeXQIpaqaFEEwB1TyQu29f3kugBUa3NEJRkI0GEAzGD/y5cwkxtsF8aHCZ4+s9Nura5
         u1SiXQkIod9fZ2XWhSkpiOAIyoPFFI1JYhY4EPi/5tBvQctIsK2J1pSeneETAQIF26Q2
         R2JZdRz8kssRcPsLmCNH3Y0HzOCfRN6ruJM+3gJwwX6O/qsX0i1mFx0QeG0Oodol3fsS
         D8wcWywd1E8c1QmQWwogauy6q65JU7AkmuZcXTFL1BKZyOa0kkug9DgnTXSXoSDxK1/W
         I7Ww==
X-Gm-Message-State: AOAM530ICeOw/9go1VmM7UffYz4dZ331gnIsDinRDwHyuDkt30mjg9Ob
        7ztpDBbfk6vyUpZYqA/YZfKqRV8rRAmTYw==
X-Google-Smtp-Source: ABdhPJxdvGM+6tcJUBAoHYZn+tISoI8Z3WDYAZL4H8IT3tFDossgdWDbo06ey4bSGaw1krADL34Q8g==
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr3723646edb.243.1616492399245;
        Tue, 23 Mar 2021 02:39:59 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id lx6sm10905544ejb.64.2021.03.23.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:39:58 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:39:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     vilhelm.gray@gmail.com, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, olivier.moysan@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] mfd: stm32-timers: avoid clearing auto reload register
Message-ID: <20210323093956.GS2916463@dell>
References: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021, Fabrice Gasnier wrote:

> The ARR register is cleared unconditionally upon probing, after the maximum
> value has been read. This initial condition is rather not intuitive, when
> considering the counter child driver. It rather expects the maximum value
> by default:
> - The counter interface shows a zero value by default for 'ceiling'
>   attribute.
> - Enabling the counter without any prior configuration makes it doesn't
>   count.
> 
> The reset value of ARR register is the maximum. So Choice here
> is to backup it, and restore it then, instead of clearing its value.
> It also fixes the initial condition seen by the counter driver.
> 
> Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/mfd/stm32-timers.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
