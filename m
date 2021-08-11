Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD133E9485
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhHKP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhHKP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:27:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25149C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:26:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f3so3175586plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fbC74k7Hno3OLPru5q/3yPanTKyU+1bqPbVaC/9INAY=;
        b=pHc2Y0X2lXnJezvRiC7tNcmYOqL3QyL/LPPjFEUdO1ZMdnWHhOjX/tuKRhzOl72umm
         a6oqFzZRBhCvEAR+1LqFe7+7E/blG+JhUHhY3az4TQ+mCR7rYpp1drzxM4i8VFlDJIbA
         Yy7wpI48mn3G0QFnqrclrCQj5Y/MGRc53T/F74hjVg10lW7tWO7IE6FpU961gSXHtKEU
         bWpGxwSofnnoFP2XbMgvS3gP3TO0txS8YlsG6W/9gKnEEtaXuNFXxivNLVKonnIypOiw
         RXnEk5Bu4o493ESzpBbjKiutU+tF3ghGhjVJNhFPVSGd6nBwq7CxwKr6onoV+DZRsNgV
         y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbC74k7Hno3OLPru5q/3yPanTKyU+1bqPbVaC/9INAY=;
        b=Z9B/GlfogQTKoq5Trt2T9BBqdbQCz1ifWJZCYm3RNdzNNDj2GvC6BvFuIobtOhtWg/
         Mz7kAjj03FN/m+18T+1Uto2zBrjJd62eji4n1kkLF6qY6M9Q4/dcXmhSs+gZ9swfdk2d
         9RpApXplEDZm59VmnRzvcjjuzSmkyBW/ymmuKO9jRdDXB9eqs5I7VgK7F96fR+AqNPFO
         80Md24BrGHCs3TYaaumUrJo+piQagIn/qFDqj/7nMUywXERaKMNggADgToStSZltmNPu
         Cjix80zZO223wwOa7Pjx514/mzsmrTm5igISiABBlsoBgPQBnmVS2VEv1oBcM6QTFC0/
         I93g==
X-Gm-Message-State: AOAM533/lm9asHnpb/8eLlNShrc65mmeXNKgqErjeAC6yR6YqF1XA0yQ
        9OpfKqCY9Z4RUFzfYJTbWFQut8SNIiyTsLHs
X-Google-Smtp-Source: ABdhPJwxykalNcisf3Xb07xqdVnpM8u55l18UevBfewbY4iyevf0zZlzT+UGy3Hvh40C19sWH+erJQ==
X-Received: by 2002:a62:d404:0:b029:3a1:8a54:728 with SMTP id a4-20020a62d4040000b02903a18a540728mr28681573pfh.37.1628695610580;
        Wed, 11 Aug 2021 08:26:50 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id f15sm26171942pjt.3.2021.08.11.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:26:47 -0700 (PDT)
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
To:     Thomas Gleixner <tglx@linutronix.de>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
 <877dgsp2vp.ffs@tglx> <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
 <87wnoshyhi.ffs@tglx>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <acbc5aaa-0d19-3144-5299-a66a49b20542@gmail.com>
Date:   Wed, 11 Aug 2021 23:26:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87wnoshyhi.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time.

Thomas Gleixner wrote on 2021/8/11 22:01:
> On Wed, Aug 11 2021 at 21:18, brookxu wrote:
>> Thomas Gleixner wrote on 2021/8/11 8:44 下午:
>>> On Wed, Aug 11 2021 at 17:55, brookxu wrote:
>>>> From: Chunguang Xu <brookxu@tencent.com>
>>>>
>>>> After patch 1f45f1f3 (clocksource: Make clocksource validation work
>>>> for all clocksources), md_nsec may be 0 in some scenarios, such as
>>>> the watchdog is delayed for a long time or the watchdog has a
>>>> time-warp.
>>>
>>> Maybe 0? There is exactly one single possibility for it to be zero:
>>>
>>>   cs->wd_last == wdnow, i.e. delta = 0 -> wd_nsec = 0
>>>
>>> So how does that condition solve any long delay or wrap around of the
>>> watchdog? It's more than unlikely to hit exactly this case where the
>>> readout is identical to the previous readout unless the watchdog stopped
>>> counting.
>>
>> Maybe I missed something. Like this example, when watchdog run ,hpet have
>> wrap around:
>>
>> 'hpet' wd_now: d76e5a69 wd_last: f929eb3c mask: ffffffff
>>
>> We can calculate the number of elapsed cycles:
>> cycles = wd_now - wd_last = 0xde446f2d
>>
>> clocksource_delta() uses the MSB to determine an invalid inteval and returns
>> 0, but for 0xde446f2d, this judgment should be wrong.
> 
> You're right. I forgot about the MSB check which is enabled on x86.
> 
>>>> We found a problem when testing nvme disks with fio, when multiple
>>>> queue interrupts of a disk were mapped to a single CPU. IO interrupt
>>>> processing will cause the watchdog to be delayed for a long time
>>>> (155 seconds), the system reports TSC unstable and switches the clock
>>>
>>> If you hold off the softirq from running for 155 seconds then the TSC
>>> watchdog is the least of your problems.
>>
>> To be precise, we are processing interrupts in handle_edge_irq() for a long
>> time. Since the interrupts of multiple hardware queues are mapped to a single
>> CPU, multiple cores are continuously issuing IO, and then a single core is
>> processing IO. Perhaps the test case can be optimized, but shouldn't this lead
>> to switching clocks in principle?
> 
> The clocksource watchdog failure is only _ONE_ consequence. Processing
> hard interrupts for 155 seconds straight will trigger lockup detectors
> of all sorts if you have them enabled.
> 
> So just papering over the clocksource watchdog does not solve anything,
> really. Next week you have to add similar hacks to the lockup detectors,
> RCU and whatever.

Yeah, we have observed soft lockup and RCU stall, but these behaviors are
expected because the current CPU scheduling is disabled. However, marking
TSC unstable is inconsistent with the actual situation. The worst problem
is that after the clocksource switched to hpet, the abnormal time will be
greatly prolonged due to the degradation of performance. We have not found
that soft lockup and RCU stall will affect the machine for a long time in
this test. Aside from these, as the watchdog is scheduled periodically, when
wd_nsec is 0, it means that something maybe abnormal, do we readlly still
need to continue to verify TSC? and how to ensure the correctness of the
results?

> Thanks,
> 
>         tglx
> 
