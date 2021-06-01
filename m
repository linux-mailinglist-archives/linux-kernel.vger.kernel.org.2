Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF2397652
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhFAPRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhFAPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:17:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:15:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so2139922wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NHydh3/ncsVeDXTAdKoz81qBNS+Ux9OeRAZ7MP0jsJw=;
        b=PdTPy6jQNfzwzWFynDMkSAvAzEWVeKtZ47edSlenJqHlyRW7HanJO4/vy5P11qevkW
         crQKWvlquXLWDgK2ag5DFHwo4ciy0gHPt0w47UY+YXDVxxFa0SQPdoESs7a4KkG8muNK
         m2Dc1SbuPgVYUVBoG4uAXzcEre6VZ6CL1QrnpbXPv8hMlHRegb3Kn9akK6AV3IhVl+cl
         gMN9TSFKgOYK3EBJvDRcb3LKFrDlCa138qxxBV15RA+/v4t0GJTHO8dVH4K0ls1DuaH6
         B3Dybhs9WcMCFU1nTZNxRhNoi2gbeUfFYKMXH3R1GDsnF74pT8cgTxX8Jg28HdWwQuzI
         pKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NHydh3/ncsVeDXTAdKoz81qBNS+Ux9OeRAZ7MP0jsJw=;
        b=AQH3lnlOKok5O7M2BCuICfwBagb+n2KiASbvhxZoCgLMQyJyEh7aceFYVCMC3O0l7v
         hy3eEqtHhm8N/5RKPYiz4iD8+yH17Wh67dGxkK5X/tK4b1uW2UsY8GR0o183L68OLJcH
         TPO/mQ8HtV8oYb27+zTjhFvtr4fImH8PKhGSC8AUqxaaHo7QpnbAEKcIVBZ8YsQzVbil
         evjoZFYw7G5n/plUlUFXfdzeMi9TPAlyktA/hOrCYmQfIrVUTLYaWRkh0nyBV9itHoEr
         Wc97Fj2DwYP/yA6FCGHkPzRnjamx9kcirt0Pz/HcL6aDyTJcz8fzSrG+r5STUfBeswdC
         YDvQ==
X-Gm-Message-State: AOAM533Tx2nGXKwUHfsqqe4qWeOvDoKLAIMbO4+NPs24EZ+A6EyGFKo3
        KbtFKE6DRIF7+Fj0pYa1Ht6b5Q==
X-Google-Smtp-Source: ABdhPJxcZQ1D4L2hNpZsGsfckqmotsmM54FGHzV2CcZoiUggH6ogr02f/L/zJkFZL9zu6Iho0qR9zQ==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr406714wmb.11.1622560546968;
        Tue, 01 Jun 2021 08:15:46 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id q3sm3467252wrz.71.2021.06.01.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:15:46 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:15:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 2/3] dt-bindings: mfd: pm8008: Add bindings
Message-ID: <20210601151544.GR543307@dell>
References: <cover.1621965146.git.gurus@codeaurora.org>
 <ee714da21108a5183815ffd1233876dba4c253f5.1621965146.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee714da21108a5183815ffd1233876dba4c253f5.1621965146.git.gurus@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Guru Das Srinagesh wrote:

> Add bindings for the Qualcomm Technologies, Inc. PM8008 MFD driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml

Fixed the *-by tag order and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
