Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1236DC80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhD1PzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD1PzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:55:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:54:25 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id m13so63477783oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jMQtTg/Qey8vosI3ctdEwkLH1ZsdlWl+A5B8mm+7iRw=;
        b=IupsyiuP045vvmV1BbexYgQQXK2Gpz+06JS8Ja3O5KK8RzP+SK7eMIM9vvizRgd79S
         SdzbPdsq/BAoxHEsgU0Vhwb/f6hgSj0Efi34V3x1xzdFOwF7P14oG+5sBi4+75K+GMWG
         NO+NVQf9fTWZIDlLkUQ5TPTVstnoK/rLD6Q8e7/4d1ANfDqzsXmRKobaE/mAVK05SCK5
         b+CcPcdnuu7FCkTL5wW5YkqznwOjrQ1kjzctNlDldqNowhrWEPQUnvlPIzIx0JNveoL4
         9y0qkhHjfDnbowwBKeq67n5ZSvlBD7bPCLtBjzLy6q9emMtlA80baoNlnckjV/hjfnLL
         DxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jMQtTg/Qey8vosI3ctdEwkLH1ZsdlWl+A5B8mm+7iRw=;
        b=PdfhW77WlGXMERIdPYdThZhAdQj4HbkQ3bdTvAYIIQfXXoJRiJgV5EvZ2XBLYnBjCz
         CpchhZ5BU9wxp1sABVJqtdScKKm8TceSd8ZfkJHYqSLGDhDgbquPmBSnxM4YhGiaPBvF
         Y3l2IObdyD9NZJ1R6KSzDNFoy04zOulhynjIdG236kllWo4Rkgj1uuvXJ0c7HGWfd5Xb
         uNR8d5J8szzxl42MTM8dtJnAT29952BRHQ7zLG7RN536kO2oV3gPQZWWmPgwOn3XCJXy
         hvTknL+brooxcrf8jBofqhhBbMnuY0uCQ3j9biNhbZfk8CHHarP04TF7hVDbe4lmMqpu
         RW7A==
X-Gm-Message-State: AOAM532+txlpV2Lq8bLT6MxOB/sOvlo85y/ZShyXwgzMvfp6cVESaE8y
        t5GLBW4IJQNJB8yhT85eR1CM+g==
X-Google-Smtp-Source: ABdhPJwGoy7UDtxPJsjVy9R8T2dHpVasKNLNGorcsJta6vLvWYicqdr/Y9z3z93Ark9Gy1pHWnYdGA==
X-Received: by 2002:aca:5b04:: with SMTP id p4mr20973171oib.109.1619625264638;
        Wed, 28 Apr 2021 08:54:24 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j7sm65507otk.65.2021.04.28.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:54:24 -0700 (PDT)
Date:   Wed, 28 Apr 2021 10:54:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fenglin Wu <fenglinw@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 0/2] Add QCOM PMIC PWM driver
Message-ID: <20210428155422.GL1908499@yoga>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427102247.822-1-fenglinw@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Apr 05:22 CDT 2021, Fenglin Wu wrote:

> Add PWM driver to support PWM modules inside QCOM PMIC chips which are accessed
> through SPMI bus. Normally, there would be multiple PWM modules with adjacent
> address spaces present in one PMIC chip, and each PWM module has 0x100 size of
> address space. With this driver, a pwm_chip with multiple pwm_device individuals
> is created, and each pwm_device individual is corresponding to one PWM module.
> 

Exposing this as individual pwm_chips will prevent us from enabling the
LED related use cases (patterns and multicolor) that most versions of
the hardware support.

I proposed [1] a while ago and think this is a better approach. I'll
take some time to respin this and send out the next version.

[1] https://lore.kernel.org/linux-arm-msm/20201021201224.3430546-1-bjorn.andersson@linaro.org/

Regards,
Bjorn

> Fenglin Wu (2):
>   dt-bindings: pwm: add bindings for PWM modules inside QCOM PMICs
>   pwm: pwm-qcom: add driver for PWM modules in QCOM PMICs
> 
>  .../devicetree/bindings/pwm/pwm-qcom.yaml          |  51 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-qcom.c                             | 585 +++++++++++++++++++++
>  4 files changed, 646 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
>  create mode 100644 drivers/pwm/pwm-qcom.c
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
