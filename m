Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0280A3EB963
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhHMPqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbhHMPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:46:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE85C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:46:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso9971817wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGqYP/BN1Qfj8+Nm3t3v0K4q1x+QcZ7RN1PrsmUqieY=;
        b=Pvtg9Vmhd42TvM0kpWNs+0odqdTyMN5J7ijyasOeD+aIcPMwBs0qOHAtN2uuHtZw7G
         fCKTXtB0gafDUd2da+Ui9HETXJQnUp1QJ1GhOmfWw0QQq01ssbZmNWqddpilRtNoL3JP
         /GYbY1YCnaCa3HOg+hh1gT1KNsrpV4qX5ytivj8rGNcK0u5FAlNEobB8ooNE6UA7XVyX
         +ACLzUmfuFV6O7rNzoBXWEd0zO5DjqDZg/qBpOj0Ibi/E0Zr1JDoq5TSqyfQlgzr7MSI
         Rjk+m9dJEpfdE2Zq7rOfH66u4dj9LG/Mjjco/VxLSn+4Ze9LPsJrMx30eK5MIhahUzhE
         uXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGqYP/BN1Qfj8+Nm3t3v0K4q1x+QcZ7RN1PrsmUqieY=;
        b=e2HHm51XEhdThy4mqq6Fh0GFnafcuotHQBgZJPJfPKGZCnKMtr3NgV/kZWsFBCndRy
         dohfmM721dZidfCsrGLPS34mxle1fRrqKsH6VOVeI90yfUWiLuAQlZU0ToEK8awx9fcr
         byIbMrBiR7BLQa6ml89yBLZBBsq+x7Zh5znedF4Qm5TQ0B7SjwP5volWBbcWlrno6Gb5
         djhq1t6g48PGdF7gYBy1YEJYuk+g6eEw+scqpdalD3sb5TjpyoXl3G0cUTbfx7L1MBH0
         FH/587kGyD+jdQ55LjAy1s75gEj0de712V1BKAnHWhmkrpDBF+Pn0Quj4jDjmCRAvWcN
         YVTQ==
X-Gm-Message-State: AOAM531SWO8I3RQp1DRCelWGngAX0CdZVYKf/hUkoJdkN9kdeAT9dWiy
        eseqOFjipJNtnepQ/my9Koj7Gr2VjrugfzJM
X-Google-Smtp-Source: ABdhPJyfOCUjMkXHY+NPlZyvCpNVgUdfJ4jJ5vMEbOB2l5W8H8w6JCWMnJ9DhY0TXdEY/B3zvted+Q==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr1152613wmp.146.1628869577924;
        Fri, 13 Aug 2021 08:46:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id y21sm1791206wma.38.2021.08.13.08.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 08:46:17 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: dts: rockchip: add thermal fan control to
 rockpro64
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210730151727.729822-1-pgwipeout@gmail.com>
 <ad6d8025-977c-9ff2-81ff-a417df48231c@linaro.org>
 <893701da-ea17-00ab-5e31-c745051ac9b9@arm.com>
 <2b1050f2-0311-1871-820a-f876218894bc@linaro.org>
 <CAMdYzYptXpahbcdkPm1C9_aH2khNtjdZyBmckndcWLnrh259QQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <141e29aa-d21d-31b8-9a81-015dcd63d24d@linaro.org>
Date:   Fri, 13 Aug 2021 17:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYptXpahbcdkPm1C9_aH2khNtjdZyBmckndcWLnrh259QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2021 17:10, Peter Geis wrote:
> On Fri, Aug 13, 2021 at 10:54 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Robin,
>>
>>
>> On 13/08/2021 15:51, Robin Murphy wrote:
>>> On 2021-08-13 13:59, Daniel Lezcano wrote:
>>>> On 30/07/2021 17:17, Peter Geis wrote:
>>>>> The rockpro64 had a fan node since
>>>>> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
>>>>> however it was never tied into the thermal driver for automatic control.
>>>>>
>>>>> Add the links to the thermal node to permit the kernel to handle this
>>>>> automatically.
>>>>> Borrowed from the (rk3399-khadas-edge.dtsi).
>>>>>
>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>
>> [ ... ]
>>
>>>>>   +&cpu_thermal {
>>>>> +    trips {
>>>>> +        cpu_warm: cpu_warm {
>>>>> +            temperature = <55000>;
>>>>> +            hysteresis = <2000>;
>>>>> +            type = "active";
>>>>> +        };
>>>>> +
>>>>> +        cpu_hot: cpu_hot {
>>>>> +            temperature = <65000>;
>>>>> +            hysteresis = <2000>;
>>>>> +            type = "active";
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>
>>>> Why two trip points ?
>>>>
>>>> Why not one functioning temperature and no lower / upper limits for the
>>>> cooling maps ?
>>>
>>> Certainly when I first did this for NanoPC-T4, IIRC it was to avoid the
>>> fan ramping up too eagerly, since level 1 for my fan is effectively
>>> silent but still cools enough to let a moderate load eventually settle
>>> to a steady state below the second trip.
> 
> That's the same issue I had on the rockpro64.
> 
>>
>> Thanks for your answer.
>>
>> What would be the governor for this setup ?
>>
> 
> The default governor when using arm64_defconfig is step_wise.

Ok, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
