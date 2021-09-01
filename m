Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA063FE52D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhIAWDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbhIAWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:02:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C6C061764
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:02:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so1617481ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnPQdzZMs4DyH5oLKknlerujheq7E0iK+rdK9Bg2xfk=;
        b=cgNmqIkTHsf1QnCRrUS/zZO11duHElqzfFhG7zlCMqbLJcms0JEvWTGlb8V+zHvoM5
         iSdwddpYr4dEHkNrUztXq6Dj9wALUczIRB/F8xGLXrAeUTqmp77yHunL5wAl0/vsTvcL
         9KQqxHpwKMBX6Ajnq8beVbkNEEXx2BpMsYkIvXajUQKuwWvyVQVZ8Qtv1m1nu1OhHOYr
         xFpqUP+NGlyySmqf6ZdzdoxOX+xotBKEbcwrbQ71GPWfbmlocxnFAuU48DYmI3MiURv7
         oLCPxNDhV8PXYUPx1ZxrDDio8KIJyiZOhvHG4ptXvjVdUjyQbip0dp2v/zHwb21ekKH4
         KxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnPQdzZMs4DyH5oLKknlerujheq7E0iK+rdK9Bg2xfk=;
        b=pKJ2J5367ZTxtup7gSDKPUD4QFR9zKvthXdeIFj+QvruZXiBgx2BF99f2ZVo8cws4E
         wbcfjmrwB4T6hfxIehsimiZoltPwVWj8q9zmLOEclL/vZdr5w3mF0XHrZNKQ9y7J9upd
         sUvwTWH+aljaJQWeeYeQmoXb8oOAlQrVf19yRKYWDYO/iyMR5PTQGN7P08zXSDQIF/h2
         PH86WXvcZKgIeOztR9btEl2L1CyP3453jpO8llvxBhIldo6IVw6XHn3w8KkkEhe/WI3i
         3oO7MS3eecpE2wGobE7w8qfAquKuHe9JH/qfDudGLzudS/MQkRAUiJWfK3bhppcLdFW0
         Y7zA==
X-Gm-Message-State: AOAM533y5Ufx7XFgVUwU/EnHgStnK1QM+2SQaCAI+wicEEGu6p+vlAOj
        ahHkmnRg5upuseqqO4zDcMdFxA==
X-Google-Smtp-Source: ABdhPJyaXhC41uRSeOf+R0AotjM8nRToFIF6cqB5moPon/c3QALTANIK4zHrWwQ9vYCcen9WP3JHdA==
X-Received: by 2002:a2e:8511:: with SMTP id j17mr1410329lji.407.1630533720327;
        Wed, 01 Sep 2021 15:02:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d21sm4432ljo.70.2021.09.01.15.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 15:01:59 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20210901121518.152481-1-y.oudjana@protonmail.com>
 <20210901121518.152481-2-y.oudjana@protonmail.com>
 <9af0f031-101e-53b4-514e-9ead44320f4e@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <efafd058-ad68-eb0a-af42-40d879ef63d9@linaro.org>
Date:   Thu, 2 Sep 2021 01:01:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9af0f031-101e-53b4-514e-9ead44320f4e@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 21:48, AngeloGioacchino Del Regno wrote:
> Il 01/09/21 14:15, Yassine Oudjana ha scritto:
>> SoCs such as MSM8996 also control bus QoS in a similar fashion to SDM660,
>> with some paths being controlled by RPM and others directly by the AP.
>> Move relevant functions and defines to a new object so that they can 
>> be used
>> in multiple drivers.
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Hey guys!
> 
> I'm waiting for the interconnect RPM-QoS commonization to be merged as I 
> have fresh
> interconnect drivers for MSM8998 and MSM8976, ready to send, that are 
> also using
> the very same QoS mechanism as SDM660.

We were also looking onto this. I'd propose to merge sdm660 code into 
main icc-rpm.c instead of splitting it into separate file. We have 
enabled QoS for apq8096 (msm8916) and msm8939. See 
https://lore.kernel.org/linux-arm-msm/20210818015732.1717810-1-dmitry.baryshkov@linaro.org/ 
for the reference. I'm waiting for Shawn to publish v2 of his fix, then 
I can post v2 of my patchset.

> 
> Yassine, please check Shawn's recent patches for SDM660 interconnect, 
> which are
> fixing some bits for the QoS implementation and adding some required 
> clocks to the
> SDM660 interconnect driver.
> 
> Adding Shawn to the Ccs as to make him aware of this patch;
> also adding Marijn and Konrad from SoMainline as probably interested 
> parties.
> 
> Cheers!
> - Angelo


-- 
With best wishes
Dmitry
