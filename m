Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B1336875
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCKAN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCKANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:13:21 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:13:21 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f8so13241794otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erXJ8iD4PdZZOPdskeJrDvYPVu+tfBX21Jw1u5qAgH8=;
        b=Wc0f7wU3TUc2iJPP9/xxnyPXH/7SCWn7oxmpPj8uDJwzLk14cI5bIyd31ldsct6ANX
         9wf+rXPgsyc80Mqi67Qts7NZVwOyNjXLrmEd3vgKKlwwMx6JqXoietLmEXW5lzGb+ORZ
         eU3asOu425N0rTD7jkTXAe//M5nPs1Zo1nQOGgHSlhETGkuvMIV4nWeYzfi7pMLg6pRN
         fLDUAiOg1jiK1BvRlmfyydJKmviK3FdH0ZyjXCdF0gAud1gvVHE35xo7oIwDTnZ3I5xN
         JXdcveVRhr1jPWVIPsPApvgDZY3HPcdC9xvA+Z6zoo8mUqp08ssvPj9tXMEUDuyLF8H3
         ACyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erXJ8iD4PdZZOPdskeJrDvYPVu+tfBX21Jw1u5qAgH8=;
        b=Rm3tQNO6gvoF+0zJ86gs2+CcjUAy5JM2Baz/NAVC2AUh3Bsl/6PWgBylkkMeXjZE7S
         KYg53QhVKplfmhyQwOu0KsjPVbrfdQQFus49Ucf6BX2JaG4BRbHuZ23Sygt4eTEbKb6m
         CBapoXk+k+5TCjGynJJRVLULdBkJvFmS54/l+JuILnYwfIGpjnZMvU7En0UmvnMZbbt8
         QYFfCmAHf57fNnOjNHTHN0bawSv8xJerWBdXpNhPc68bwzKRpuUgiPEmXrw+rZuP7zEd
         ERs9bOzFqWUELepp2Rf3HWj187dRl6gWswvXwpj4dQBD53P99TQ86lGc2nMXf+7fGv3u
         JWhw==
X-Gm-Message-State: AOAM532oLJR4lP5eUReDix66peTDjKRC+2q1CLDjEnhWAM/iI+EmL8+l
        9LYSPjt41TCOJ66buhoBg7T2Yg==
X-Google-Smtp-Source: ABdhPJxH0oevfBS8lHRDO2gQ1d7kzTcsUZamL2RWxdoLbQFa28w6Y6qr9CEiUaTicZKMhSdAjjjjoA==
X-Received: by 2002:a9d:4816:: with SMTP id c22mr4555658otf.144.1615421600442;
        Wed, 10 Mar 2021 16:13:20 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p3sm289437otk.9.2021.03.10.16.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:13:19 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:13:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Add binding updates and DT files for SC7280 SoC
Message-ID: <YElgnuH6ZEoMOgdj@builder.lan>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12 Feb 01:28 CST 2021, Rajendra Nayak wrote:

> This series includes a few minor binding updates and base device tree
> files (to boot to shell) for SC7280 SoC and the IDP board using this SoC.
> 
> The series is dependent on a few driver patches to merge first, for
> gcc, rpmhcc and pinctrl
> https://lore.kernel.org/patchwork/project/lkml/list/?series=484517
> https://lore.kernel.org/patchwork/project/lkml/list/?series=484489
> https://lore.kernel.org/patchwork/patch/1379831/
> 

I'm not able to find v2 of this series, but plenty of patches that
depends on its content. Do I somehow miss it, or is it coming?

Regards,
Bjorn

> Maulik Shah (3):
>   arm64: dts: qcom: sc7280: Add RSC and PDC devices
>   arm64: dts: qcom: Add reserved memory for fw
>   arm64: dts: qcom: sc7280: Add cpuidle states
> 
> Rajendra Nayak (5):
>   dt-bindings: arm: qcom: Document SC7280 SoC and board
>   dt-bindings: firmware: scm: Add SC7280 support
>   arm64: dts: sc7280: Add basic dts/dtsi files for SC7280 soc
>   dt-bindings: qcom,pdc: Add compatible for sc7280
>   arm64: dts: qcom: SC7280: Add rpmhcc clock controller node
> 
> Sai Prakash Ranjan (4):
>   dt-bindings: arm-smmu: Add compatible for SC7280 SoC
>   arm64: dts: qcom: sc7280: Add device node for APPS SMMU
>   dt-bindings: watchdog: Add compatible for SC7280 SoC
>   arm64: dts: qcom: sc7280: Add APSS watchdog node
> 
> satya priya (1):
>   arm64: dts: qcom: sc7280: Add SPMI PMIC arbiter device for SC7280
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
>  .../devicetree/bindings/firmware/qcom,scm.txt      |   1 +
>  .../bindings/interrupt-controller/qcom,pdc.txt     |   1 +
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
>  .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  47 ++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 596 +++++++++++++++++++++
>  8 files changed, 654 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280.dtsi
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
