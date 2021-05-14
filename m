Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E19380B02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhENOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:05:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhENOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:05:47 -0400
Received: from mail-vk1-f199.google.com ([209.85.221.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lhYQc-00034J-TO
        for linux-kernel@vger.kernel.org; Fri, 14 May 2021 14:04:34 +0000
Received: by mail-vk1-f199.google.com with SMTP id s131-20020a1f2c890000b02901eb30527a89so3976519vks.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QU/Hksxi2+pFDWpDvWUPYqDD7PqBm7YcgQmJYrRUtOY=;
        b=R55oEZE4+w/8fpibsvGvVRscac1F19UXz1SRaJQACAT60Gv7GeVqWQrmwDRpI/e1cB
         SY5hAurbcFfYJPO6IgSZX4sgiDNk70w603sfQPxg3dXlAt5+o9LOImL9XZzxE6BVZk8y
         LwlvjAf1KbYnBYHydmKS8BnHoxouxUuwF6NgrbJ9Ng5mHZYaxq1RdwmoMDGxeCPH5cGK
         moQE+/2TEM3KjN+4+X9axq6/f2FcDaHyEEi4KNXTXHOqlxmehYcv65LYKSpKv6f1oVZy
         L7ttSFtL7lzdyJTOYIvHmQ1UAp5Y3Pf6HI405EalFI7AvQESHffWtWAQeGMF1D3a1NUY
         3u5A==
X-Gm-Message-State: AOAM531zCUBoj6brFXCM53nX3Alx464DB/rtaXKUBvAGhF682BU4CQHG
        dVNUWV85Jjq4dm526thfKI1IIEMWQAPbjVeGfvmk0P0iJrnOF0/pooxrlbUTcL6JLh8GcWIJzDH
        zb3wZFL05U1ordcQybWH6f5eN2/iBEnYrZdWXWeOmxw==
X-Received: by 2002:a1f:160c:: with SMTP id 12mr37650303vkw.25.1621001073612;
        Fri, 14 May 2021 07:04:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwylx1xY4Sf3udb6i6sdh04vHdujnzpZFF+f+9W/4TRbEFNhRCcUwNy8maLRsZ7g612dyKCKA==
X-Received: by 2002:a1f:160c:: with SMTP id 12mr37650275vkw.25.1621001073395;
        Fri, 14 May 2021 07:04:33 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id b2sm851232uaq.16.2021.05.14.07.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:04:32 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ralink: of: fix build of rt2880_wdt watchdog module
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>
Cc:     Lee Jones <lee.jones@linaro.org>, kernel test robot <lkp@intel.com>
References: <20210514131750.52867-1-krzysztof.kozlowski@canonical.com>
 <2b427eca-fd6c-d099-337f-39cfbd85cb46@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a15e7f62-12a0-1ec7-5104-f01f9e3eccc7@canonical.com>
Date:   Fri, 14 May 2021 10:04:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2b427eca-fd6c-d099-337f-39cfbd85cb46@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 09:48, Guenter Roeck wrote:
> On 5/14/21 6:17 AM, Krzysztof Kozlowski wrote:
>> When rt2880_wdt watchdog driver is built as a module, the
>> rt_sysc_membase needs to be exported (it is being used via inlined
>> rt_sysc_r32):
>>
>>    ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko] undefined!
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I don't see a recent change in the code. Has that problem been there
> all along ?

I think the problem was there always but 0-day builder did not hit it
until recently:
https://lore.kernel.org/lkml/202105082122.yrF7ploN-lkp@intel.com/


Best regards,
Krzysztof
