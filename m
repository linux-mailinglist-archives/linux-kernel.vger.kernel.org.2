Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FD32BD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452594AbhCCPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:52:23 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36986 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbhCCLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:02:18 -0500
Received: by mail-wr1-f42.google.com with SMTP id v15so23183297wrx.4;
        Wed, 03 Mar 2021 03:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pfwuBLP4HxQKFR1+p3roGMfBodVu9+mUeNmz3GhCsLA=;
        b=nYMpqXEtn3sviUmHdhP1u52QVfKr3ANAQjRmmzncH3TUSLIGbFdWfAxyRW20TPq/Yn
         sKvsERmjR3NzDvl/8ROOv7oYJJabYoSz6AQvXJLuNfkQrt/7sdGzjI0ISC77dBvqtm+8
         bUI4EIM2Im6g75VV4bRMTF/MKOD25YuL5GD82wMTYa6fbL1JkZFIcTYfd0tpskFo0etC
         AyP59nfW0dEKro4HwVSWBdFX4CB2z7GYXbZz7YHk/6uOv5zoQtAdlYJNHb6rfowGCsx6
         Pc7seH0lE+z2oz4+3Z/hYWW3b6lf3NFz+9LkRpOAP72iP2R80JEg9+Wgb4KFjUDou7yt
         YVsw==
X-Gm-Message-State: AOAM532saRAyAoLFvproVzhriLkFuII5L46zTz5OK3NFUXqJrFPh5a5o
        qw6Pu0011nRebGiW5G0BnGaStA7+M1k=
X-Google-Smtp-Source: ABdhPJzwR7PM12VP0KJZ1ODkJkfdBXCSztN/U9kduBif3L8xVXURxbFdR+fAa2qMkDGx46JHdITBzQ==
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr26856577wra.419.1614769279130;
        Wed, 03 Mar 2021 03:01:19 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i4sm5119308wmq.12.2021.03.03.03.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 03:01:18 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
Message-ID: <97c95215-54da-ab44-e0ab-0b0e9cab8c7c@kernel.org>
Date:   Wed, 3 Mar 2021 12:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303103839.it7grj3vtrdmngbd@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 11:38, Krzysztof Kozlowski wrote:
> On Wed, Mar 03, 2021 at 11:30:38AM +0100, Greg Kroah-Hartman wrote:
>>
>> Just let any arch pick any driver if it can be built, you never know
>> what it might be run on.  Removing ARCH_ dependencies in Kconfig files
>> is a good thing, please do not discourage that from happening.

If this is the consensus, then I'll add to my todo list removal of 
ARCH_EXYNOS, ARCH_S3C, ARCH_S5P (and later OMAP, QCOM, NXP and so on) 
from all drivers. Blindly. Because DWC Exynos is the same as watchdog, 
clocksource timer, PWM, GPIO/pinctrl

Are everyone okay with that?

I remember also someone from Suse wanted the opposite - be sure that 
none of SoC related options appear for his choices, when he configures 
his kernel without Exynos support. I can't remember the name though...

Best regards,
Krzysztof
