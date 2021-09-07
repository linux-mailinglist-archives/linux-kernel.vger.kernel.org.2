Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFEC402BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345267AbhIGP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345322AbhIGP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:29:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B90AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:28:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c79so13214228oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3CKmrPVfvd5MOHht4Oq/xBuQDC7k4klnrQ2Rw1mlTSQ=;
        b=Jot7dh94Hu1gF5ZKEPw1L8mFcQfznJUJwMLf56j0eMZZ9FlqSJmMRhEwUOYoad3GB3
         MjMJdCUV4a0rZp0JW9HwX0MCm56bymEBGBfdLNdvufzcOJ29tz9hZQyKCT7MC5zxIGMg
         gdpZkiOsc1AwgDBkrkauopCroGuxx/bkM/H8iPeDrvIPIPDE0Mb5OjtJ/2SaZrE6S0D5
         5XIpDUpg68xwGrD0kxCZ57X6bxpnwkJyq9jkLsLI1IO35i7+AKbt/AG5n20MEClyy4yN
         a/HcRkwPd7a2Z6vX4Er+BEBHdj7ugeq7jrieJnz0DEHSMAukhsEPQ6lonK5NRx65hUFE
         SyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CKmrPVfvd5MOHht4Oq/xBuQDC7k4klnrQ2Rw1mlTSQ=;
        b=B0l1EcihHC2f8JNT1am4YRygSWM3wl4Q5HNfdmTagvsGKJwb99qqaPqrxLHaRwAdUP
         kMYBcF2mG/CpBlqDBFoA+3avBTGKOCVy1zhrxVD74Phia7qADrUr8uz32z4WPN9Q4Epr
         8aAhevZAWHObWVTZBb8MxNm4FrQE8AXDZa0OtAw5KlAzJ/BtACROvPPkJXMGjh31Rler
         vDrfAZYkDiE4UXUDEZ0iayjfQtUkin/di5tl4BGqynQXFI8ElKrqgz/1O9cQatjcnVkR
         eXl5NKV6cLqu0ps+QDCz5qFlZUHTxbaQR3rvI4TQZ4PKSjR7HUvGJjmLTw8kb/W0kGVR
         184Q==
X-Gm-Message-State: AOAM5337eGDv8562ymUD2iN9nH/wpAitQW/WY0mjbJ26aBnknJZaa6ki
        qj648p1U23OzIRsyrIMEwYzXOj2yWC0=
X-Google-Smtp-Source: ABdhPJxbLRese2+GBIt1pPmmdvDSb7ywlow4Qpa1F/PwmgOdZmK9LRQ+9MTDwaZ8qCjxd8CLVNGTMA==
X-Received: by 2002:aca:645:: with SMTP id 66mr3363906oig.145.1631028490680;
        Tue, 07 Sep 2021 08:28:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17sm2486235otc.28.2021.09.07.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 08:28:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
 <20210907125354.GE4989@roeck-us.net>
 <38ac012a-c16e-1ba0-b386-156bb8ddecc4@molgen.mpg.de>
 <20210907144737.GF4989@roeck-us.net>
 <6ff370ce-9905-b07e-99cf-4e2861d2872f@molgen.mpg.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: QA: Monitor Linux log messages as port of release (candidate)
 testing
Message-ID: <0c445eca-4f15-f6a1-f098-64fe2c7d3c3a@roeck-us.net>
Date:   Tue, 7 Sep 2021 08:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6ff370ce-9905-b07e-99cf-4e2861d2872f@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 9/7/21 8:18 AM, Paul Menzel wrote:
> Dear Guenter,
> 
> 
> Am 07.09.21 um 16:47 schrieb Guenter Roeck:
> 
>> On Tue, Sep 07, 2021 at 03:50:39PM +0200, Paul Menzel wrote:
> 
>>> Am 07.09.21 um 14:53 schrieb Guenter Roeck:
>>>> On Tue, Sep 07, 2021 at 10:40:31AM +0200, Paul Menzel wrote:
>>>
>>>>> Thank you for testing release candidates and releases [1]. Is your test
>>>>> setup documented somewhere?
>>>>>
>>>> Not really, except its source is available at github:
>>>>     https://github.com/groeck/linux-build-test
>>>
>>> Thank you.
>>>
>>>>> If not happening already, could the Linux messages (at least up to log level
>>>>> warning) also be monitored? For example, in Linux 5.14, a new warning snuck
>>>>> in by cefc7ca462 (ACPI: PRM: implement OperationRegion handler for the
>>>>> PlatformRtMechanism subtype) [2], which could have been caught early on, and
>>>>> fixed before the release.
>>>>>
>>>>> The test summaries would then also notify about possible behavior change.
>>>>
>>>> Logs are available and can be examined at kerneltests.org/builders.
>>>
>>> Sorry for being blind. Under *qemu-tests*, looking at build #1831 [1],
>>> clicking on *stdio* [2] under *Steps and Logfiles*, I do not see any Linux
>>> logs.
>>>
>>>> Reports are generated manually, so it would be way too much effort to add
>>>> build warnings to those. Besides, logs are way too noisy to be useful in a
>>>> summary e-mail.
>>>
>>> Just to avoid misunderstandings, it’s about the Linux run-time logs.
>>
>> Run-time logs are only provided if there are errors or runtime issues
>> (crashes, warning tracebacks, or test failures).
> 
> Could this be changed to always publish them? Or is that too demanding on storage?
> 

It isn't a matter of storage, but of noise. It is mostly me looking at the data,
and I really don't want to see logs if nothing interesting is there. With 450+
builds per release I'd drown in noise otherwise. Sure, a large part of that
is a UI issue, but that is where systems like kernelci come in. If I ever
find the time to do it, I might report build and runtime results/logs to kernelci.
But that is a big IF.

>>>> Also, Geert's build reports already provide build warnings and errors.
>>>> The same applies to reports sent by 0-day. Indeed, I do see at least
>>>> one 0-day report against commit cefc7ca46235.
>>>
>>> How can I find that report?
>>>
>> I just searched for the SHA.
>>
>> https://www.spinics.net/lists/linux-acpi/msg101721.html
> 
> Alright, that is a build time thing. I am looking for runtime things.
> 

If there is nothing in my reports, you'd probably not find what you
are looking for (it would be reported if it results in a backtrace).

Guenter
