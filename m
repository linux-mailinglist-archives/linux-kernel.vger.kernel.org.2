Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95C63C4358
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 06:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhGLEz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jul 2021 00:55:27 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56122 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhGLEz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:55:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhaoyan.liao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UfRdTTt_1626065556;
Received: from 30.43.41.248(mailfrom:zhaoyan.liao@linux.alibaba.com fp:SMTPD_---0UfRdTTt_1626065556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Jul 2021 12:52:37 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] use 64bit timer for hpet
From:   Linux <zhaoyan.liao@linux.alibaba.com>
In-Reply-To: <87o8bdoy11.ffs@nanos.tec.linutronix.de>
Date:   Mon, 12 Jul 2021 12:52:36 +0800
Cc:     mingo@redhat.com, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com, duanxiongchun@bytedance.com,
        wenan.mao@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2CC6F5DA-B186-4A06-92B4-B763386F0D0A@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
 <875yxmqw2s.ffs@nanos.tec.linutronix.de>
 <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com>
 <87o8bdoy11.ffs@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gleixner,

> Sorry, keeping the softirq from running for 3 minutes is simply out of
> spec. If the sysadmin decides to do so, then he can keep the pieces.

It is because the kernel thread is busy that the clocksource_watchdog 
thread is not scheduled, not softirq.

>   4) For any system which actually has to use HPET the 64bit HPET is
>      overhead. HPET access is slow enough already.
I agree with your opinion. If it is unreasonable to use a 64-bit HPET timer, 
is there any other more reasonable method to avoid misjudgment of the 
tsc clock?
I will also try to switch to other methods.
Thanks
           Zhaoyan Liao



> 2021年7月8日 下午7:17，Thomas Gleixner <tglx@linutronix.de> 写道：
> 
> Liao!
> 
> On Thu, Jul 08 2021 at 11:11, Linux wrote:
>>> 2021年7月7日 下午6:04，Thomas Gleixner <tglx@linutronix.de> 写道：
>>> Seriously? The wrap-around time for 32bit HPET @24MHz is ~3 minutes.
>> 
>> In some cases, our system will be very busy, and the timeout of 3 minutes 
>> is not an exaggeration. Then, the system considers that the tsc clock is 
>> inaccurate and switches the tsc clock to the hpet clock, which brings 
>> greater performance overhead.
> 
> Sorry, keeping the softirq from running for 3 minutes is simply out of
> spec. If the sysadmin decides to do so, then he can keep the pieces.
> 
>>> Aside of that the reason why the kernel does not support 64bit HPET is
>>> that there are HPETs which advertise 64bit support, but the
>>> implementation is buggy.
>> 
>> Can you tell me what is the buggy with the 64-bit hpet clock?
> 
> I forgot the details, but when I tried moving HPET to 64bit it did not
> work on one of my machines due to an erratum and other people reported
> similar issues on different CPUs/chipsets.
> 
> TBH, I'm not interested at all to chase down these buggy implementations
> and have yet another pile of quirks.
> 
>> In my opinion, it is unreasonable to use a lower-bit width clock to
>> calibrate a higher-bit width clock, and the hardware already supports
>> the higher-bit width.
> 
> There is nothing unreasonable with that, really:
> 
>   1) This is not about calibration. It's a sanity check to catch
>      broken TSC implementations.
> 
>      Aside of that it _IS_ very reasonable for calibration. We even
>      calibrate TSC via the PIT if we can't get the frequency from
>      the firmware.
> 
>   2) Expecting that the softirq runs within 3 minutes is very
>      reasonable.
> 
>   3) On modern machines this is usually not longer necessary. If you
>      are confident that the TSC on your system is stable then you
>      can disable the watchdog via the kernel command line.
> 
>      There is also effort underway to come up with reasonable
>      conditions to avoid the watchdog on those CPUs in the first place.
> 
>   4) For any system which actually has to use HPET the 64bit HPET is
>      overhead. HPET access is slow enough already.
> 
>   5) 32bit HPET has to be supported as well and just claiming that a
>      64bit access on 32bit HPET does not matter is just wishful
>      thinking. Aside of breaking 32bit kernels along the way which
>      is just a NONO.
> 
> #4 and #5 were the main reason why I gave up on it - aside of the
> discovery that there are broken implementations out there.
> 
> So no, there is really no compelling reason to support 64bit HPETs.
> 
> Thanks,
> 
>        tglx
> ---
> P.S: Please trim your replies.

