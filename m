Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D603C6832
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGMBqC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jul 2021 21:46:02 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53618 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhGMBqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:46:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhaoyan.liao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UfdImcp_1626140589;
Received: from 30.43.68.19(mailfrom:zhaoyan.liao@linux.alibaba.com fp:SMTPD_---0UfdImcp_1626140589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Jul 2021 09:43:10 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] use 64bit timer for hpet
From:   Linux <zhaoyan.liao@linux.alibaba.com>
In-Reply-To: <875yxgngct.ffs@nanos.tec.linutronix.de>
Date:   Tue, 13 Jul 2021 09:43:09 +0800
Cc:     mingo@redhat.com, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com, duanxiongchun@bytedance.com,
        wenan.mao@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <C8CF5E7F-58D9-4FD7-B138-50C66620BE33@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
 <875yxmqw2s.ffs@nanos.tec.linutronix.de>
 <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com>
 <87o8bdoy11.ffs@nanos.tec.linutronix.de>
 <2CC6F5DA-B186-4A06-92B4-B763386F0D0A@linux.alibaba.com>
 <875yxgngct.ffs@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Thank you for your patience. the last question:
> I forgot the details, but when I tried moving HPET to 64bit it did not
> work on one of my machines due to an erratum and other people reported
> similar issues on different CPUs/chipsets.
> 
> TBH, I'm not interested at all to chase down these buggy implementations
> and have yet another pile of quirks.

Can you tell me the erranum or issue link at that time? This is very important
 to us.

Thank you very much.


> 2021年7月12日 下午3:25，Thomas Gleixner <tglx@linutronix.de> 写道：
> 
> Liao,
> 
> On Mon, Jul 12 2021 at 12:52, Linux wrote:
>>> Sorry, keeping the softirq from running for 3 minutes is simply out of
>>> spec. If the sysadmin decides to do so, then he can keep the pieces.
>> 
>> It is because the kernel thread is busy that the clocksource_watchdog 
>> thread is not scheduled, not softirq.
> 
> Which thread?
> 
> The clocksource watchdog runs from a timer_list timer callback in
> softirq context. Even if the softirq is switched to the softirq thread
> then still my argument of starving that for 3 minutes still stands.
> 
> This is _not_ a kernel problem. Overcommitment is a admin problem.
> 
> Thanks,
> 
>        tglx

