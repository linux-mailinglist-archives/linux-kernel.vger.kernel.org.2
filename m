Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EDF3EB71F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbhHMOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbhHMOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:55:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C23C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:54:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g138so7055946wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RNsPi3jDYyBzv2kUjVpJkokk1HayHjqKs+GTvpkRyVg=;
        b=suBO/Sv9jLaFXlKfn+u4jovTDNp7ztHgwGBe3sJ8oa+6JGxOEXHLdnGye0wEEF8jNm
         L4Q4MrjXiVru1C3Zg4NonC0hGk2z2cQSwkyWWxVatutnbJedKhOKYRyIM/MSRfun7var
         7nBelSI6at05aDH6kbZW2WgzXXIjonoXGEf9yAoYqm4/IhgfNqW6zwQ2Qweh+dkz7wSD
         DOJ5a+V2zzcO7/MiF4biYyenjpaqWGM4e0rCTcf7dASvT3CBiJ5/IIRBGytURqa5Dp/S
         b8BadL0eN4E9HDYsxSP9dmigSMqwo2BbIKPh6SJx6yczq3KoRFcqOy+aGM9k5lhY3IHT
         jZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNsPi3jDYyBzv2kUjVpJkokk1HayHjqKs+GTvpkRyVg=;
        b=ng0h/sHYMHOt9/NtV0DRoTVhUAwS23kHheyyXxb0pAY0x5Rz2eyCICW/u6FOSk2gQL
         I/0exPrqENQzam8p7l8iwK8Z48UfueGr3Nvd2LvIt7RW9ikcPfs6rDo+JFVWxVj9relf
         uIBRoUAHbR8sVqnc/ZWxlHVme8hLAfg/vgdIn6Ck84w+T1eM127JtGTKIa/hCeIRlgJg
         nsMkDTw9i6/OGYSTaKXQOtvCOGRoxGe11e2oGW3Kzr2vMjjncMyhEQgljVjfN/5sUmDN
         8Y/z+Bp+flohPhu/dRKmYD5UptROZ45DTM0Z+1sM/GkKM5H50OYq9I5i33Zn/e60mQWP
         JQ1Q==
X-Gm-Message-State: AOAM532NslaHTpt+5FICCW6uJtaWBJov97I1zIVEWpWkv0axfC8MmooG
        I5mExkemE50SWgj/U4mJXG97eqRHdvBukRJA
X-Google-Smtp-Source: ABdhPJyoLasmj8kICLFfOtBuet4rZn2v2GaTohM62GKWy9ojCFy2A6ZonxXaRrz0w2gYuG0bemo1mA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr3138037wmg.130.1628866483900;
        Fri, 13 Aug 2021 07:54:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id r129sm1629693wmr.7.2021.08.13.07.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:54:43 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: dts: rockchip: add thermal fan control to
 rockpro64
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210730151727.729822-1-pgwipeout@gmail.com>
 <ad6d8025-977c-9ff2-81ff-a417df48231c@linaro.org>
 <893701da-ea17-00ab-5e31-c745051ac9b9@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2b1050f2-0311-1871-820a-f876218894bc@linaro.org>
Date:   Fri, 13 Aug 2021 16:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <893701da-ea17-00ab-5e31-c745051ac9b9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,


On 13/08/2021 15:51, Robin Murphy wrote:
> On 2021-08-13 13:59, Daniel Lezcano wrote:
>> On 30/07/2021 17:17, Peter Geis wrote:
>>> The rockpro64 had a fan node since
>>> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
>>> however it was never tied into the thermal driver for automatic control.
>>>
>>> Add the links to the thermal node to permit the kernel to handle this
>>> automatically.
>>> Borrowed from the (rk3399-khadas-edge.dtsi).
>>>
>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

[ ... ]

>>>   +&cpu_thermal {
>>> +    trips {
>>> +        cpu_warm: cpu_warm {
>>> +            temperature = <55000>;
>>> +            hysteresis = <2000>;
>>> +            type = "active";
>>> +        };
>>> +
>>> +        cpu_hot: cpu_hot {
>>> +            temperature = <65000>;
>>> +            hysteresis = <2000>;
>>> +            type = "active";
>>> +        };
>>> +    };
>>> +
>>
>> Why two trip points ?
>>
>> Why not one functioning temperature and no lower / upper limits for the
>> cooling maps ?
> 
> Certainly when I first did this for NanoPC-T4, IIRC it was to avoid the
> fan ramping up too eagerly, since level 1 for my fan is effectively
> silent but still cools enough to let a moderate load eventually settle
> to a steady state below the second trip.

Thanks for your answer.

What would be the governor for this setup ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
