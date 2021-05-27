Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D97392877
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhE0HYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:24:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51801 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhE0HYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:24:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UaErcna_1622100187;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UaErcna_1622100187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 May 2021 15:23:08 +0800
To:     will@kernel.org
Cc:     fweisbec@gmail.com, john.stultz@linaro.org,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@google.com, maz@kernel.org,
        mika.penttila@nextfour.com, sboyd@kernel.org, tglx@linutronix.de
References: <20210524221818.15850-3-will@kernel.org>
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
Reply-To: xhao@linux.alibaba.com
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
Date:   Thu, 27 May 2021 15:23:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524221818.15850-3-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  will:

      I  had backport you  tick/broadcast: Prefer per-cpu relatives 
patches,

but i did not get the true result,  the Wakeup Devices are all null, why?

my machine is armv8-a arm64

#cat current_clocksource
arch_sys_counter

my local clock event is

Tick Device: mode:     1
Per CPU device: 95
Clock Event Device: arch_sys_timer
  max_delta_ns:   21474836451
  min_delta_ns:   1000
  mult:           429496730
  shift:          32
  mode:           3
  next_event:     14951080000000 nsecs
  set_next_event: arch_timer_set_next_event_phys
  shutdown: arch_timer_shutdown_phys
  oneshot stopped: arch_timer_shutdown_phys
  event_handler:  hrtimer_interrupt
  retries:        70
Wakeup Device: <NULL>

cat /proc/timer_list  | grep "Wakeup Device:"

Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>
Wakeup Device: <NULL>

Wakeup Device: <NULL>

-- 
Best Regards!
Xin Hao

