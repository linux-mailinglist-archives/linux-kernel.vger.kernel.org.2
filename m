Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D488436B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJUTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJUTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:23:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EFBC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:20:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i6so2329956lfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMGkfKzFkPndk+aukTeC2hPij1ioiGplmmYNbBLd39U=;
        b=w/2IhqbvnJAooThVClYZntt6hO4FpSbjki/TXe5kQS/pqLu820t3MU1YMfc9qj4cyQ
         ZIvFptym8t2h67l5XIDaTXm1YgxhJjtiCV2oDFhdaQ5ddyDjeoncTGgFimylroR5s6Q7
         0NEbkXziBnKLYk2MWnJp9mDejpH4JNyHd9Ej0MM7uv/ggbHMQ3pCM/ZiyeuoNL+KLZFy
         AbJbMUYbaXp+ttYheo9l364ZY8fKs6ZSUCtmo/d5FgxrSHJ0hABpzOsD2BhNdTNU+FTQ
         WZq2qRYN5PC6B67D7+9HvZ2I1SvnlGXV1E1XLNih+WIfw4DDzVMf5yjRfxHCVxwI6K6/
         qnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMGkfKzFkPndk+aukTeC2hPij1ioiGplmmYNbBLd39U=;
        b=IqiHNle9/5u1P573zFGP0qeWIOdlP5BmRms/O0FzQWgm1dUCOP0sHFx69H0HuhE42X
         wy4+c32dTEQFQjeJ00/r99zM1mjiwABDBnHpRdY3PkcopXkIT2BoZkSyl2Idf5kWvY5K
         PckEJJpdWaxcPZQZiXqsqYXI1tB8d3Bjyk/x7hYhnc704Nxofr0dOI/aQ+l78sqRT9sG
         T+0aucE5dTx4gGqibgMcFRR1sNhi778Nwf6UC3tBFhlcOrLjFdTbEdJlDbp59L/+Q1ij
         1jPfjekXGxSAQUugEOfUIOk3lkKezQuSyAVR/93tOkcqIsGaMsCHlILUcc7ADeK8+Qwj
         hyGQ==
X-Gm-Message-State: AOAM530sokGuE3YMtlEQUbPjZyPAGmylQILS/vunK0r8mSsPLo54mu07
        3PF/Np2EMd0J/R5RlNrDeT8HggZpCKwm/w==
X-Google-Smtp-Source: ABdhPJxo5GjXqDlTGLWXCwJrN0GPBLdVN5DKRXlP3V5kEnbBE/le0TdxKJD1wGsFtyNWAVs8eddv0w==
X-Received: by 2002:a19:6441:: with SMTP id b1mr6800607lfj.73.1634844054240;
        Thu, 21 Oct 2021 12:20:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h16sm626022lji.140.2021.10.21.12.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:20:53 -0700 (PDT)
Subject: Re: [PATCH RESEND v5 0/5] interconnect: qcom: Add MSM8996
 interconnect driver
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <73fbfa8b-8f71-53b2-f5b6-0f17f4941a91@linaro.org>
Date:   Thu, 21 Oct 2021 22:20:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021132329.234942-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 16:24, Yassine Oudjana wrote:
> This series adds a driver for interconnects on MSM8996. This fixes some rare display underflows
> and provides a slight heat reduction.
> 
> Resending because some addresses in CC got mixed up.
> 
> Changes since v4:
>   - Rebase on Dmitry's icc-rpm patches[1].
>   - Combine SDM660 bindings into the RPM interconnect schema.
>   - Clean up qcom_icc_node structs by removing unused properties, moving links to external
>     arrays and using the same arrays for multiple nodes where possible.
>   - Add support for Aggregate 0 NoC (a0noc).
> Changes since v3:
>   - Expand DEFINE_QNODE macros in msm8996.c.
>   - Commonize probe function.
>   - Don't rename qcom_icc_set in icc-rpmh since it's no longer needed.
>   - Code style fixes.
> Changes since v2:
>   - Dual-license qcom,msm8996.h and move it to the dt bindings patch
>   - Remove interconnect paths from CPUs since cpufreq driver doesn't support icc scaling yet.
> Changes since v1:
>   - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-rpmh, and another
>     one for the actual commonization.
>   - Revert unnecessary move of include line in sdm660.c
> 
> [1] https://lore.kernel.org/linux-arm-msm/20210903232421.1384199-1-dmitry.baryshkov@linaro.org/

For the whole series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #db820c

> 
> Yassine Oudjana (5):
>    dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
>    interconnect: icc-rpm: Add support for bus power domain
>    dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
>    interconnect: qcom: Add MSM8996 interconnect provider driver
>    arm64: dts: qcom: msm8996: Add interconnect support
> 
>   .../bindings/interconnect/qcom,rpm.yaml       |  143 +-
>   .../bindings/interconnect/qcom,sdm660.yaml    |  185 --
>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |   93 +
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/icc-rpm.c           |    7 +
>   drivers/interconnect/qcom/icc-rpm.h           |    1 +
>   drivers/interconnect/qcom/msm8996.c           | 2113 +++++++++++++++++
>   drivers/interconnect/qcom/msm8996.h           |  149 ++
>   .../dt-bindings/interconnect/qcom,msm8996.h   |  163 ++
>   10 files changed, 2673 insertions(+), 192 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
>   create mode 100644 drivers/interconnect/qcom/msm8996.c
>   create mode 100644 drivers/interconnect/qcom/msm8996.h
>   create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
> 


-- 
With best wishes
Dmitry
