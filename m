Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36A3BF43C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 05:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGHDOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jul 2021 23:14:14 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57561 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230244AbhGHDON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 23:14:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhaoyan.liao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uf4GV0k_1625713889;
Received: from 30.250.200.142(mailfrom:zhaoyan.liao@linux.alibaba.com fp:SMTPD_---0Uf4GV0k_1625713889)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Jul 2021 11:11:30 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] use 64bit timer for hpet
From:   Linux <zhaoyan.liao@linux.alibaba.com>
In-Reply-To: <875yxmqw2s.ffs@nanos.tec.linutronix.de>
Date:   Thu, 8 Jul 2021 11:11:28 +0800
Cc:     mingo@redhat.com, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com, duanxiongchun@bytedance.com,
        wenan.mao@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
 <875yxmqw2s.ffs@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gleixner,

> Seriously? The wrap-around time for 32bit HPET @24MHz is ~3 minutes.

In some cases, our system will be very busy, and the timeout of 3 minutes 
is not an exaggeration. Then, the system considers that the tsc clock is 
inaccurate and switches the tsc clock to the hpet clock, which brings 
greater performance overhead.

> Aside of that the reason why the kernel does not support 64bit HPET is
> that there are HPETs which advertise 64bit support, but the
> implementation is buggy.

Can you tell me what is the buggy with the 64-bit hpet clock? In my opinion, 
it is unreasonable to use a lower-bit width clock to calibrate a higher-bit width
 clock, and the hardware already supports the higher-bit width.


> 2021年7月7日 下午6:04，Thomas Gleixner <tglx@linutronix.de> 写道：
> 
> Liao,
> 
> On Fri, Jul 02 2021 at 16:13, zhaoyan liao wrote:
>> The kernel judges whether the tsc clock is accurate in the
>> clocksource_watchdog background thread function. The hpet clock source
>> is 32-bit, but tsc is 64-bit. Therefore, when the system is busy and the
>> clocksource_watchdog cannot be scheduled in time, the hpet clock may
>> overflow and cause the system to misjudge tsc as unreliable.
> 
> Seriously? The wrap-around time for 32bit HPET @24MHz is ~3 minutes.
> 
>> In this case, we recommend that the kernel adopts the 64-bit hpet clock
>> by default to keep the width of the two clock sources the same to reduce
>> misjudgment. Some CPU models may not support 64-bit hpet, but according
>> to the description of the CPU's register manual, it does not affect our
>> reading action.
> 
> So much for the theory.
> 
>> -#define HPET_MASK			CLOCKSOURCE_MASK(32)
>> +#define HPET_MASK			CLOCKSOURCE_MASK(64)
> 
> How is that valid for a 32bit HPET? This breaks the clocksource.
> 
>> +inline unsigned long hpet_readq(unsigned int a)
>> +{
>> +	return readq(hpet_virt_address + a);
> 
> Breaks 32bit build immediately.
> 
> Aside of that the reason why the kernel does not support 64bit HPET is
> that there are HPETs which advertise 64bit support, but the
> implementation is buggy.
> 
> IOW, while this works for your hardware this breaks quite some parts of
> the universe. Not really a good approach.
> 
> Thanks,
> 
>        tglx

