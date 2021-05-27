Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86D392CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhE0Lgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:36:41 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39652 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbhE0Lgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:36:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UaGrBy7_1622115303;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UaGrBy7_1622115303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 May 2021 19:35:04 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
To:     Will Deacon <will@kernel.org>
Cc:     fweisbec@gmail.com, john.stultz@linaro.org,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@google.com, maz@kernel.org,
        mika.penttila@nextfour.com, sboyd@kernel.org, tglx@linutronix.de
References: <20210524221818.15850-3-will@kernel.org>
 <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
 <20210527082219.GA21311@willie-the-truck>
Message-ID: <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com>
Date:   Thu, 27 May 2021 19:35:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527082219.GA21311@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/27 下午4:22, Will Deacon 写道:
> On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
>>       I  had backport you  tick/broadcast: Prefer per-cpu relatives patches,
>>
>> but i did not get the true result,  the Wakeup Devices are all null, why?
> Probably because you don't have any suitable per-cpu timers to act as a
> wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_PERCPU

Yes, you are right, but i want to know why the timer do not support  
CLOCK_EVT_FEAT_PERCPU.

> and CLOCK_EVT_FEAT_ONESHOT but not CLOCK_EVT_FEAT_C3STOP?
>
> Will

-- 
Best Regards!
Xin Hao

