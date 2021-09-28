Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC641AC49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhI1JyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbhI1JyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1888C061765
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:52:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r23so31616986wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yVcQbOuCpqmzA0Unotd8q5BfUkjxaUbJiv1/pjgSmvw=;
        b=IT+UEBuPtAVijXSWbsiNBfN2jv6zi3NY6h6mLsCshHMfL44Q1zDsxubpu2mLKW11fh
         JS/kscx5DjMePLiRz+yItlMxPX/br/edRBPxcx52PmZPe2GmzHlOQGdoVKPGfAIhvNbN
         0UJON/ZWF4FxrhiW8doKw2YrtE1oO37zTNsfYC5FbIsgJWcrdEn80meonMsUYB6iZyv1
         c4eebUvTkFVsRvpfK6LEXz/5uR/YI+NAeZ29mfRV2UlK1Sk7sLZnNLBii0AP7yFspKv7
         sa6+s9JbCTtjLW4yAnHQcu7RMJGjOFwVx2oM54hHEfD4aygh0ZCgM7Z67sWhT8QitPyf
         MUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yVcQbOuCpqmzA0Unotd8q5BfUkjxaUbJiv1/pjgSmvw=;
        b=PTmaAVawrs5TX2csJHZCKJDGwT74+gsg/OrkvFFOGdiV8Xykx24/1mBHolucsQQBBY
         rKT3xzpsD4mvFvz2Y6vLZVAwnWqVo1d6+bAbwvqAycF0B535mmhqg7cA2HcUXxIJZdoD
         m79XsEf7UwE750r9zZwsckPQXqKvq6HkZsVaiVo/4BzusPUNWA4i6Q/R7PpVYj0Ok0g9
         66QifnG3Tf+4+2nMB3dLNbm/gsU3Afy7bpoj1tzY6bIiw4WSnQEfs/wtWmeIVqAVWH2Z
         TC9Wy8WQvOy7PVLDf+wX2oKjW5EGlPOqlo+Tc1iD6Or9QGZDXVGWICbwU39i3CRxHFin
         +Yeg==
X-Gm-Message-State: AOAM530nzesc88IPPeopLPtJ6DuxMZp/BdRMpBxDD3lORJgV/noRcaeJ
        88GQBIOiSxe86VOSyO50XtaC+KD0eK3rIA==
X-Google-Smtp-Source: ABdhPJweAtsLKmkEaMGSf+R8jmjUTDWtQcN5Xf7jIS0jkEcJSO32F6bKYQNNj9DajCWOKJAkdfh3WA==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr5386646wrr.187.1632822744424;
        Tue, 28 Sep 2021 02:52:24 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id n66sm2243910wmn.2.2021.09.28.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:24 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:52:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH v2 1/4] mfd: sec-irq: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <YVLl1tigynO1MtYu@google.com>
References: <20210602110445.33536-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602110445.33536-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Krzysztof Kozlowski wrote:

> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Samsung PMIC drivers are used only on Devicetree boards.
> 
> Additionally, the PMIC datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> Marek Szyprowski reports that together with DTS change (proper level in
> DTS) it fixes RTC alarm failure that he observed from time to time on
> TM2e board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
> 
> Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
> 
> Changes since v1:
> 1. Mention in commit msg that this fixes TM2e RTC alarm.
> 2. Add Marek's tested-by.
> ---
>  drivers/mfd/sec-irq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
