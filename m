Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A543A9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJZB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhJZB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:57:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2FBC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:55:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x123so13724866qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mCnwnbPbhYcrF9QBa5LUo8e7y29tVyuzmG2cawteQCA=;
        b=olTS1hbEonbFLujA4x2P8XYUAvZ7BmbseWok6MxtRkkecckkwKz0CEcHcKTIFXqAD1
         HysBjR0qkBfUHxMdYr2Xq5WICeG/B9+27ROdTcp0AvFcS0g4Panq/rOvWzZ2TmhkTOXG
         lSJNmzpWOQeUmYVpALraWJDQWLuUknFeO6s2pGwmj3D2HA6DehAJ7vias+zNbYSCewk1
         t7w4J7gvXmEP+Bv2hY6sasrL+NEZ/KwUlrLQqJNmU9pfR9B8LF4M7no6jIPjIBosEvfP
         akouqDz9bsBhAcLG0UbstP7ZEIAFG1yuS2OO+gWrMUchRrdLVCvwNZPt4kSFnpe7FKZl
         vh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mCnwnbPbhYcrF9QBa5LUo8e7y29tVyuzmG2cawteQCA=;
        b=OvFQnykpEsPP7WGTm404+YE9uY/Ip21NluY/SMOSTeaY2CCIVPj7ez1KRM3X8WBEEk
         JCVfhnW7c/V1FXuE45M0nbHwBLHTJBuNH1gMN105UXQQTWbshynNF2xMxv6oodqEP1RA
         FyKFms+tEyVxlircvLJ3htLpP6K1L6lzG6rgW3boOH5kVpTskFmBRdNUCEtpYsSgdcJt
         IM2OvtrRl6te98QlNPrr/eOJXx1Pg9rJD1Xvc0MWuJisDm8G0WFRPM206Y9mjU6o3WP5
         VcTlVp4q6cet9DNRiVKfPu7O4s3G14pQMV43PbGtbXAoOH95Qq1qWGiUTaHtxRfitzBr
         Se9w==
X-Gm-Message-State: AOAM533JIUuAaBj5cDbgpCVFPYzZDY8tB1l3Vs7wA0+JVkB+SmHke9/t
        Hv2Kd+ftRKOU+0BO/gPBP14=
X-Google-Smtp-Source: ABdhPJwolSe/hyU6zweo2PfHcxsIbYIwTjHsxR3G5XrXvY2VF2DpbOrilwEvBsvaMiIxs6LTirOehA==
X-Received: by 2002:a05:620a:25ce:: with SMTP id y14mr4685253qko.66.1635213313158;
        Mon, 25 Oct 2021 18:55:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:dfe0:49f0:f0b4:bed7:bbf6:a2b1? ([2600:1700:dfe0:49f0:f0b4:bed7:bbf6:a2b1])
        by smtp.gmail.com with ESMTPSA id b2sm9291563qtg.88.2021.10.25.18.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 18:55:12 -0700 (PDT)
Message-ID: <f0b28cb6-be34-9b78-844c-0913592fe5f9@gmail.com>
Date:   Mon, 25 Oct 2021 18:55:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RESEND 0/5] ARM/arm64: arm_pm_restart removal
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, treding@nvidia.com,
        arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
References: <20210604140357.2602028-1-lee.jones@linaro.org>
 <526fe66f-df08-c873-2a20-f1295e30a855@gmail.com>
 <a4fe088f-0f13-f80f-5011-4eee2d44ef63@gmail.com>
 <321b167f-8744-9ca8-58b0-e09ff39dfa02@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <321b167f-8744-9ca8-58b0-e09ff39dfa02@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2021 6:02 PM, Guenter Roeck wrote:
> On 10/25/21 4:55 PM, Dmitry Osipenko wrote:
>> 26.10.2021 02:29, Florian Fainelli пишет:
>>> On 6/4/21 7:03 AM, Lee Jones wrote:
>>>> This is a rebase/refresh of a set sent out, reviewed,
>>>> then forgotten about.  It's still considered useful.
>>>>
>>>> Here is an excerpt from the previous attempt:
>>>>
>>>>   "Hi Russell, ARM SoC maintainers,
>>>>
>>>>   here's the full set of patches that remove arm_pm_restart as 
>>>> discussed
>>>>   earlier. There's some background on the series in this thread:
>>>>
>>>>     https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/ 
>>>>
>>>>
>>>>   I also have a set of patches that build on top of this and try to add
>>>>   something slightly more formal by adding a power/reset framework that
>>>>   driver can register with. If we can get this series merged, I'll find
>>>>   some time to refresh those patches and send out for review again.
>>>
>>> What happened to this patch series? Is there any chance we will get it
>>> included at some point? It is included in the Android13-5.10 tree AFAICT
>>>
>>
>> It's in mainline since v5.14, AFAICS.
>>
> 
> Yes, indeed.

Great, thanks!
-- 
Florian
