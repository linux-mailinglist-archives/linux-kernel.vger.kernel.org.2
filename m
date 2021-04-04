Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F413539BF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhDDUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhDDUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:30:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D93C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 13:30:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a6so3257018wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TBl38P7bIAbEuuml42sTVfJSOcbW4y2srl0KhSNAYqU=;
        b=jfAFTELaUJBbuJIrluLkTvCERKzGn5H/3rzDrTuaCmIT32B6enuQPHBQMcHiQNoqZJ
         UdXAJ6L58wCtHvbNohwVxzb0ytXioZke5nYNsyAp+cjfCFXdD+Xh+CLiQCXSJyo9x0fg
         /7eD5Fa8p4JM0jVrneiP3kf0xOjh1f7GOu6ClzaLaDVSRq2Pr1RaIEs0yVMLCUaGr0tN
         OepBstX/sjaojWqOgH5eRGn16WezjT8qTRyo3r0sNqOcx8rqCNOZsfsL+XznveTuFIHu
         bbIwcDqDjBEeR0vivgx7ODoVdfgZhzFxA/cOQdwFh+3mEcxJQP/bcljsMmAjm2Tc4nx+
         0DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBl38P7bIAbEuuml42sTVfJSOcbW4y2srl0KhSNAYqU=;
        b=qoWg2ANKq02KFKSXxJ44FWVUqkDrfxyxM3pdu2fU5YcC+nh/C7C5eqWrF7cCZZ56Iq
         fY/v/2ip20GlYc2a29ta7HFF/8t3SwiXbmK8ino6qS0mD/poCorV2g6NA1c6wvt1r1wJ
         V02OpJBTdV7SaatNOOoC0vRZF4eAMvxvDDHyXaY21I/IbPgMqPWCA4834yPv5jl8jv+d
         Y7JIt8sC+64yLB7+Qp//KavJHtTcY5dGaR3IFwmNLTHHI587SotqPizWXINTXTv/bud9
         XOaNg85KoJ/jteh4tK1VHRr7+ZjTnx8o1uux4Oj1KIUqWXha+1PN+y7zAv/AynJn5hPn
         Yepg==
X-Gm-Message-State: AOAM532gig6QjAlEg3PoqH1GfVeRwRePIuHnm29oQE1x7/gpFwyGSuoP
        LVBaEAQdPuUBblM+1+qOZc+FJg==
X-Google-Smtp-Source: ABdhPJyKijRlhIDUswk2WIOWQKLBJlG+GewGEDazHOp5gCLS7g/gRkgIqzaueLPOVrRN9OcDbgBZ7g==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr25508280wrp.231.1617568207955;
        Sun, 04 Apr 2021 13:30:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id b66sm9830071wmb.48.2021.04.04.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:30:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: qcom-tsens: Add compatible
 for sm8350
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Vinod Koul <vkoul@kernel.org>
References: <20210324124308.1265626-1-robert.foss@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <31232c42-ce58-cac1-63c7-eedd20b6cc76@linaro.org>
Date:   Sun, 4 Apr 2021 22:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210324124308.1265626-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 13:43, Robert Foss wrote:
> Add tsens bindings for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
