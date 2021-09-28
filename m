Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FF41AC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhI1Jyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbhI1Jyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3832C061772
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:52:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so1701599wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cjHMFjkvW4u2XFvvUxUcI373OsMN8kf1g+KRGhTi+hg=;
        b=cG/AGXKFOk6YQA8qOp9XdMTnNSPdpKVaNKtm0hkIYsK/ShFQpwxcM5sD3nUpJZ6S2s
         8D1jTi8G3meSVDlMK2JLlU5VGkrIUjIv6s2K8EB1+iNtbxeigbFIhNYbGp0P6k9vRiLO
         VzDKY+dvZC8pkAb69KMcvP7r42ULuF/9wSdg87G3MLxrR2CH34doOdE0azCCbZFQA3ya
         8SJ+eI9gB+frTVi/3yuBraxBqZnorCaraB08Ygfxm5lUYe+ryuuwlSttp4gwzjY0SCdr
         RfHnuqHK6N/f6t8Sb2Tsa0noVy7yi4suXEfzJCa4q3kJ4czH40d/EJrYfsCWFqjWf0cj
         Bxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cjHMFjkvW4u2XFvvUxUcI373OsMN8kf1g+KRGhTi+hg=;
        b=pYnTqG7h4U8yWZotL8595LGqfOmf64QzvcTuSs3B61CgI2jlLu4tHHC4UgvBSpXHLC
         574ySBGZHztkZkX70LHso1oFUrOcACvfJ2TrEsdvH7tocSLfPNAw6/yzFNX2NGgQDyaO
         spdnFIa3jQPheDkm1jJ3K8NNr+1R9ynOE2BR3fuOCPHv2O2OHjgeA7iG5cLdCZn1mQpb
         1vz9FTkrYxz0dS+AF3nERV1U4EqDZuXJ262wAA6opgdCUIrOL8MiJ1yHSTO9tj1I9WRA
         5IYjR7jY2jHB95CI+xVMopU7I1Wg4b29VqIumlKtDnUpW/ISua6iPJdqjCGH9sJ9gBXg
         JC0Q==
X-Gm-Message-State: AOAM530nA84IxvN3k7HcM7KhAR475dS/pILTk+vkGC+w9fktYJ50pF4n
        duKAHBvoiYFIoCLgdmgNopduig==
X-Google-Smtp-Source: ABdhPJxfyPwEaWDY7SVfuxJgITtpdTqA2ORcON8/VBbbldbzaX8avXMA5//eD9Pb7hpWH05EI9eaDw==
X-Received: by 2002:a7b:c938:: with SMTP id h24mr3709349wml.101.1632822770453;
        Tue, 28 Sep 2021 02:52:50 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id l26sm2175589wmi.25.2021.09.28.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:50 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:52:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v2 3/4] mfd: max77693: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <YVLl8PDkeEwCzPBv@google.com>
References: <20210602110445.33536-1-krzysztof.kozlowski@canonical.com>
 <20210602110445.33536-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602110445.33536-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Krzysztof Kozlowski wrote:
65;6402;1c
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 77693 datasheet describes the interrupt line as active low
> with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> The interrupt line is shared between PMIC and RTC driver, so using level
> sensitive interrupt is here especially important to avoid races.  With
> an edge configuration in case if first PMIC signals interrupt followed
> shortly after by the RTC, the interrupt might not be yet cleared/acked
> thus the second one would not be noticed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add ack.
> ---
>  Documentation/devicetree/bindings/mfd/max77693.txt |  2 +-
>  drivers/mfd/max77693.c                             | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
