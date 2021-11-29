Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDBF460E04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhK2EY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 23:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhK2EW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 23:22:28 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68978C061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 20:17:37 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t19so32261739oij.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 20:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kDBI1pM1biUwuZ6se1pyMqBzMjKaqExQXeOtMAXhmkg=;
        b=UCLbt5oDRaIIDH7wmJS38QZELynqrRpo+Y+UK3/EUjjPoebFRJj2csTwMlBKKDEHe9
         JBfokNLWK47btnAccmT6qI7vx8pOK2IeKZwPMezT6iRSKtBCuL10TuproL4mFuucbJAf
         XWytofkF0vu1ZFLon6sxucyxbdQ1l0+WaY/9/Z10sTzGW+qm/DqewHZAQeA13WIlJ6up
         lc2aWIuYtK6qWEmBg+G4i4d8e7GzwpMtFxGNmZtDlLVitUnbBI7JE5ORWXlcxjfYCluT
         c4cDZz9TQ7tKwUncO7fGGnaE3Jz17Hpgn90XX0pDqtqj/9RTv7acoAOTSCMA/jJEM9iS
         02bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDBI1pM1biUwuZ6se1pyMqBzMjKaqExQXeOtMAXhmkg=;
        b=gfnNKeBhX43gJfsdSnz+8YpQi6s7QXG9vJiv83QUisEePoUke7XdUpM59M104MxQdU
         sNiyrdls861hbWmER6W3t1SfJ5GHVygDmfeMZJ54ZDSb20B/yJEG/tvfNf5goWvTgEs1
         /86M3NkNZ4ohdqhCoQGbIZjRtrDGXvuLO9FRQm77cApF//GeKXolXPz7Dnf5VTK6voq5
         E1++YOWgYFeFK0jpS6hDKRw5cBlWGNJbY3oATWQS+c+d/RjIZkDE3lZ8c4TMophCmcvQ
         tx6GcAfqZPI7GXEV/RAXYyldob6w4Rqre6fKCXgC48hMnnSZucSYpPvtqOQyI1LNFG22
         fGiQ==
X-Gm-Message-State: AOAM5309aK0rA+mmwSWXYAI8nWH+dMWAK4ZrybZRuxJyPrW4ozwBe53T
        almDJmURZpMaDWg4MBl1FSU=
X-Google-Smtp-Source: ABdhPJyUFjHh2piqDAjXgRuYqCmQrHas4k66VR2i8f9903a+klhDNpl5xKqK6bp+D8I0MJqMV9erSg==
X-Received: by 2002:a05:6808:23d1:: with SMTP id bq17mr38992958oib.71.1638159456782;
        Sun, 28 Nov 2021 20:17:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a16sm2458084otj.79.2021.11.28.20.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 20:17:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net>
 <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.16-rc3
Message-ID: <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
Date:   Sun, 28 Nov 2021 20:17:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/21 7:07 PM, Randy Dunlap wrote:
> 
> 
> On 11/28/21 17:59, Guenter Roeck wrote:
>> On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
>>> So rc3 is usually a bit larger than rc2 just because people had some
>>> time to start finding things.
>>>
>>> So too this time, although it's not like this is a particularly big
>>> rc3. Possibly partly due to the past week having been Thanksgiving
>>> week here in the US. But the size is well within the normal range, so
>>> if that's a factor, it's not been a big one.
>>>
>>> The diff for rc3 is mostly drivers, although part of that is just
>>> because of the removal of a left-over MIPS Netlogic driver which makes
>>> the stats look a bit wonky, and is over a third of the whole diff just
>>> in itself.
>>>
>>> If you ignore that part, the statistics look a bit more normal, but
>>> drivers still dominate (network drivers, sound and gpu are the big
>>> ones, but there is noise all over). Other than that there's once again
>>> a fair amount of selftest (mostly networking), along with core
>>> networking, some arch updates - the bulk of it from a single arm64
>>> uaccess patch, although that's mostly because it's all pretty small -
>>> and random other changes.
>>>
>>> Full shortlog below.
>>>
>>> Please test,
>>>
>>
>> Build results:
>>     total: 153 pass: 152 fail: 1
>> Failed builds:
>>     mips:allmodconfig
>> Qemu test results:
>>     total: 482 pass: 482 fail: 0
>>
>> Building mips:allmodconfig ... failed
>> --------------
>> Error log:
>> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>
>> There is still no fix for the mips:allmodconfig build problem as far
>> as I can see. It is a bit odd, because the fix would be as simple as
>>
>>   config PCIE_MT7621
>> -    tristate "MediaTek MT7621 PCIe Controller"
>> -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
>> +    bool "MediaTek MT7621 PCIe Controller"
>> +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
>>       select PHY_MT7621_PCI
>>       default SOC_MT7621
>>       help
>>
>> Context: tristate doesn't make sense here because both RALINK and
>> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
>> already depends on it. The compile failure is due to missing exported
>> symbols, and it is only seen if PCIE_MT7621=m - which is only possible
>> if COMPILE_TEST=y. In other words, the dependencies above are set such
>> that test builds, and only test builds, fail.
>>
>> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
>> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
>> those responsible to see if we can expect a solution sometime soon.
> 
> 
> I sent a patch for this a couple of weeks ago and Sergio replied to it
> here:
> 
> https://lore.kernel.org/linux-pci/CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com/
> 
> saying that is a different patch out there but that it had not
> been reviewed yet.
> 

All proposals I have seen assume that PCIE_MT7621=m. As I said, I think
that it is pointless to do that because the driver can only be built
as module if COMPILE_TEST=y. We should not [have to] export symbols
because of that.

Guenter
