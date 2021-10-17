Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB804305A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 01:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhJPXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbhJPXrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 19:47:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C2C061768
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 16:45:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d13so1227606ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D0c0sgb79W5e6dJ7vSSEO8I4m/cuKD5ziHmuTHpjwPk=;
        b=gACon7vaUk14p+gdXfz3V/FTLj+wJ8H23Q9GRR3voWv10V/VRq6kmtajjh+F4LLEdM
         9EpTkEfEfWh75rm513hzPHusyJ9MikzZn0OsCw0nt2wR006akapPNRau+DNJbbVbNJX6
         hXk1nO9wvFXW5oqk0lJW2xhQMQOhwSvVTZ4U9YCPJuAUUwoyK4hGamLTSLq/eLa8gDmi
         AiYq1SBwkPHBbWU5iQSCIhvljAX2oWRkL8ymMWlxM5HCbZ12eqZmepVmqJ8MiG3sDBWN
         E3GuQ7t5ZsTWSRC96Pg89Bq4OX2hZ2WbIF8kVPkO9Fs2oNsPcTA2BNN5jqXgdT4Jat2a
         73Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0c0sgb79W5e6dJ7vSSEO8I4m/cuKD5ziHmuTHpjwPk=;
        b=MRjqwOnA08d8jAMbS3QH/O2zaciGyfgskH9N/4psyDhAvRkUsRatkaLU4vjfejqKYa
         KxLiK2Hyg2CgdhXx6e5jHXVi+7CQ5tJmrRks3QKi5B4PJjYKwypU7YdY5reTu1ecEMJU
         t0p8p9vzP7W39ynjIWcv7+feqV9nHIU/aGcx+iSx7nbjVq46tYy1GAiLAanFyq8p+EhH
         ruW2SO1Zkz3M9EzEntK3mE9aMO95ChcFQ1TAUo/N2unriBoC6cWaTkOf1ZKZiqVVNgPJ
         TEj7jWVRdXLOcnP3jGt0xeKSevjk+WrgROPmyTfyPZaSq0v9ZS+w394GmSJUkjFQDCD2
         RIAw==
X-Gm-Message-State: AOAM533ljNDrRo/rix7xMHmYG42bp6W8rwEjM7IKXUbZB6W3YRuMH4Jo
        LFZU3eL7J8qA1YZluhLkbyYL/2NHraHZrQ==
X-Google-Smtp-Source: ABdhPJywd/FL7ps+XWxoNM5azL4XXID96PYjk39vlLDUEv9J+jliv9N+aAwPxEMM4MRJLR46qrVDLA==
X-Received: by 2002:a2e:b611:: with SMTP id r17mr21958949ljn.336.1634427934373;
        Sat, 16 Oct 2021 16:45:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v2sm988001lfo.119.2021.10.16.16.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 16:45:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] phy: qcom: Introduce new eDP PHY driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-phy@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20211015221312.1699043-1-bjorn.andersson@linaro.org>
 <20211015221312.1699043-2-bjorn.andersson@linaro.org>
 <CAA8EJpqGbiy_d1_RUoPiT0Jz0CgC5WaekkuJFXyzU7z7rkZChw@mail.gmail.com>
 <YWtbrAlV9x3rLTsQ@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <4ec86f4c-8c7c-d654-2cfe-9d879fe24950@linaro.org>
Date:   Sun, 17 Oct 2021 02:45:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWtbrAlV9x3rLTsQ@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2021 02:09, Bjorn Andersson wrote:
> On Sat 16 Oct 11:36 CDT 2021, Dmitry Baryshkov wrote:
> 
>> On Sat, 16 Oct 2021 at 01:11, Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
> [..]
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> [..]
>>> +#define QSERDES_COM_SSC_EN_CENTER               0x0010
>>> +#define QSERDES_COM_SSC_ADJ_PER1                0x0014
>>> +#define QSERDES_COM_SSC_PER1                    0x001c
>>> +#define QSERDES_COM_SSC_PER2                    0x0020
>>> +#define QSERDES_COM_SSC_STEP_SIZE1_MODE0        0x0024
>>> +#define QSERDES_COM_SSC_STEP_SIZE2_MODE0        0x0028
>>
>> I think we might want to use register definitions from phy-qcom-qmp.h,
>> so that it would be obvious, which generations are handled by the
>> driver.
>>
> 
> I reviewed the all the registers and concluded that the QSERDES is V4,
> so I included phy-qcom-qmp.h and used the SERDES_V4 defines instead.
> 
> The registers found in the PHY and LANE_TX blocks are specific to this
> PHY, so I'm keeping these here.

Yep. They look like V4 DP_PHY registers, but with one extra register 
inserted in the middle.


-- 
With best wishes
Dmitry
