Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3883F3F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhHVLcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhHVLcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:32:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE683C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:31:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n12so8535317plf.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uG8L86QsABhqIwwrydn4T4dyHIpTrRxaUr9DrrinnwM=;
        b=l7SzrK0oaNhCcHt3E8VCYzXFX6OdelfMnmQ4dHsFQ8jR1Gr78k59aO7yKKJRxl2Smq
         NnvsA0bNbiMcKTvGJ69azmWt3OA0b273iXiFG8snU2bnbJE1lAlMh0H7CDKOwrDr3v4F
         DTmg9B6q8D3XYY10kROF747L3MfsOySEgi8+30LnWak1TNLUHBAUm2Lvh0ELe/1REo4q
         +VKXo8k/QJItqI8pojbff+ebfpcFzpT99fjNvwxtdJOx5ybBqSuyafl6i8ybClNdYsEt
         ekXhdNS9lHS7ZtXQd3TjwGL/Oc4WUwRHItt0HlPwbbChHED6JTWmu82wZIUd1F5ICkQ8
         7Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uG8L86QsABhqIwwrydn4T4dyHIpTrRxaUr9DrrinnwM=;
        b=O2AEjAYtFUDDGsBQnxGopsKMYaAoSZnbjkk476Ymtgq1J+Uwkb9IAyL3o2i9KQ+UHh
         501KSlijbeSDUXE07m3PXIyc+YVLrrAZ058Sh3Hz2SFJuBla3u5ljUh4D5c0mpqAYflB
         2RMiqXJrtDVGj+FQTN+HPsp8BiIFbtJMo4xOmqXzxeMjGCMjlA2osQdC1SvZJYpbLTeO
         3lOo8gLvbdhYpvIGdhhRCW7SCgLUjkiiQc5HfORQbAhXWQUT0twOv9DkP/69UpxHCE3E
         AEX8ebYRZhcwyA3iPbMxg8jdpOr0suulSpdGhlr7RZJ0W4RKKjjUUUHb6SRBT5puf9VE
         n4iA==
X-Gm-Message-State: AOAM530CR5yc91yCCApeQZq17qUS2tBEThOl5bUqPItwWpZ0mi50JrVr
        gLy9HteP0Nb36aoH4nauVHo=
X-Google-Smtp-Source: ABdhPJw6tKO7hQ6MCmq1ZROVlWfDeX1cTvVIteWiV9X19pBYrc5vUsBuw+myU5VcWIPvSDU/x7/IMQ==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr14469626pjt.164.1629631910175;
        Sun, 22 Aug 2021 04:31:50 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z2sm15074459pgb.33.2021.08.22.04.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 04:31:49 -0700 (PDT)
Subject: Re: [PATCH 0/5] arm64: Survival kit for SCR_EL3.HCE==0 conditions
To:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
 <7ffa35bb-1f2c-19ff-fe4b-33267fba80e8@gmail.com>
 <874kbr12in.wl-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0d3de5dd-f85c-d6d6-2c1b-1248847c0a09@gmail.com>
Date:   Sun, 22 Aug 2021 13:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <874kbr12in.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2021 11:27 AM, Marc Zyngier wrote:
> On Sun, 15 Aug 2021 08:28:47 +0100,
> Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 8/12/2021 9:02 PM, Marc Zyngier wrote:
>>> Anyone vaguely familiar with the ARMv8 architecture would quickly
>>> understand that entering the kernel at EL2 without enabling the HVC
>>> instruction is... living dangerously. But as it turns out [0], there
>>> is a whole range of (*cough*) "high quality" (*cough*) Broadcom
>>> systems out there configured exactly like that.
>>
>> Some Broadcom systems, namely the 4908 and all of those using CFE,
>> they later switched to u-boot and ATF and got it right.
> 
> Do we have a list of the affected systems?

That is going to be hard to come up with given that OEMs such as Asus, 
TP-Link, or Netgear and multiple devices are affected. I would start 
with this list which is far from exhaustive: Netgear R8000P, TP-Link 
Archer C2300, Asus GT AC5300.

> 
>>
>>>
>>> If you are speechless, I'm right with you.
>>>
>>> These machines have stopped being able to boot an upstream kernel
>>> since 5.12, where we changed the way we switch from nVHE to VHE, as
>>> this relies on the HVC instruction being usable... It is also worth
>>> noting that these systems have never been able to use KVM. Or kexec.
>>>
>>> This small series addresses the issue by detecting an UNDEFing HVC in
>>> a fairly controlled environment, and in this case pretend that we have
>>> booted at EL1. It also documents the requirement for SCR_EL3.HCE to be
>>> set to *1* if the kernel is entered at EL2. Turns out that we really
>>> have to state the obvious.
>>>
>>> This has been tested on a FVP model with a hacked-up boot-wrapper.
>>>
>>> Note that I really don't think any of this is -stable material, except
>>> maybe for the documentation. It isn't 5.14 material either. Best case,
>>> this is 5.15, or maybe even later. If ever.
>>
>> While I am very appreciative of the work you have done here to try to
>> get the dysfunctional systems to warn and continue to boot, I would
>> rather we try to load a minimal shim at EL3 capable of fixing up any
>> incorrect EL3 register setting ahead of loading the kernel provided
>> this is possible at all on a commercially available system.
> 
> That would be the best thing to do, and would make the machine fully
> usable. I still think we need to have something in the kernel to at
> least let the user know that their system is misconfigured though.
> 
> If CFE allows a payload to be loaded at EL3 and executed on all CPUs,
> that would be absolutely awesome. It would even allow switching over
> to ATF...

Supposedly there are GPL tarballs containing an u-boot that is suitable 
for the 4908, however I have no idea where to find those. In premise you 
could chainload those to CFE and a get seemingly functional system.
-- 
Florian
