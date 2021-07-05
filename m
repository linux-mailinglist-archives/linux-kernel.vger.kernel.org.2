Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57A3BBEB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhGEPRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:17:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhGEPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:17:43 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m0QJN-0007Ze-Mf
        for linux-kernel@vger.kernel.org; Mon, 05 Jul 2021 15:15:05 +0000
Received: by mail-ej1-f71.google.com with SMTP id bz12-20020a1709070aacb02904cae86564c7so5102371ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efe6yHR5z71JXmxhf6yurL8AKNbm6pbbpEHAWAEFh64=;
        b=j00CActNw0iJVjL5i6xBGa4ALyj7qxMTHNSaihj5RyzCI+icChK2FtbcoVw4CV04V6
         hxqz1CFiGlSEJdL8hv3WThCuxWOAV3Z2AsrQlEGwJfABmRQ/CgNux9Ic06heQN5PxW0E
         zTyWaiig430BhxLjj7NnzNMTkSTbrFGFY3wMHFW99nrAfq4ign1FV6DStBxTKkQ5/vTm
         qhuH4bPZi+M3BpPfcD4/+CDEGIz0Z963nJ5ijoUJ79xHADQwoUCFWVDmKHUPPBaiwIxr
         2HVd3lareL9BssvLgiV79JoACw0EofA4v2PCZbl9z+p3wSgAccubnYTx+YsIKSKNHI0a
         mYwA==
X-Gm-Message-State: AOAM531M+seDZ5EkcBGxPKpMnQHN/02UyDiZHAtd3uhSSFNZ5rFL3qCj
        SqN0wVyG1S3ojmzcm2cOyZnbL+t2f+K6KR0PE7vsZ1qw4+oXzUCIqks3aBDs7B/gz3sE3sgVl8x
        jMjXHfw+UN7nl8Y38Jgbp+7Qxb6fsoWY5r4o66au1Xw==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr16952984edv.342.1625498104847;
        Mon, 05 Jul 2021 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6xFYGMtAlemF7Mnm1a0Jlb57D0baYZYLw9jE4rXenURGSf2+vOHsHpxvAJ2rJJtvtmzjhuA==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr16952970edv.342.1625498104737;
        Mon, 05 Jul 2021 08:15:04 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gy11sm2166811ejb.105.2021.07.05.08.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 08:15:04 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ralink: of: fix build of rt2880_wdt watchdog module
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>
Cc:     Lee Jones <lee.jones@linaro.org>, kernel test robot <lkp@intel.com>
References: <20210514131750.52867-1-krzysztof.kozlowski@canonical.com>
 <2b427eca-fd6c-d099-337f-39cfbd85cb46@roeck-us.net>
 <a15e7f62-12a0-1ec7-5104-f01f9e3eccc7@canonical.com>
Message-ID: <9d98ec40-757d-28c7-1669-a683b2cd3881@canonical.com>
Date:   Mon, 5 Jul 2021 17:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a15e7f62-12a0-1ec7-5104-f01f9e3eccc7@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 16:04, Krzysztof Kozlowski wrote:
> On 14/05/2021 09:48, Guenter Roeck wrote:
>> On 5/14/21 6:17 AM, Krzysztof Kozlowski wrote:
>>> When rt2880_wdt watchdog driver is built as a module, the
>>> rt_sysc_membase needs to be exported (it is being used via inlined
>>> rt_sysc_r32):
>>>
>>>    ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko] undefined!
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> I don't see a recent change in the code. Has that problem been there
>> all along ?
> 
> I think the problem was there always but 0-day builder did not hit it
> until recently:
> https://lore.kernel.org/lkml/202105082122.yrF7ploN-lkp@intel.com/

Hi Guenter,

It seems that patch was not applied. Anything to fix here?


Best regards,
Krzysztof
