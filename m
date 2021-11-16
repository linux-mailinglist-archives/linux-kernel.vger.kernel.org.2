Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958F5453492
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhKPOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:49:23 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:18998 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237022AbhKPOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:49:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uwuf-aJ_1637073971;
Received: from 30.25.250.88(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uwuf-aJ_1637073971)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 22:46:11 +0800
Message-ID: <7c7b26fa-81da-4e5a-1c3f-0a3fc44ac34e@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 22:46:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-2-yinan@linux.alibaba.com>
 <20211116080730.GV174703@worktop.programming.kicks-ass.net>
 <edb15f83-ddf9-ae48-6d1e-6ef7802e6f50@linux.alibaba.com>
 <YZOstJy9mbZvHMUi@hirez.programming.kicks-ass.net>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <YZOstJy9mbZvHMUi@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Also, can't sorttable be ran on modules ?
>>
>> The .ko file will be relocated after insmod or modprobe.
>> And the mcount redirection in .ko is based on ".text",
>> ".init.text", ".ref.text", ".sched.text", ".spinlock.text",
>> ".irqentry .text", ".softirqentry.text", ".kprobes.text", ".cpuidle.text",
>> ".text.unlikely". These sections‘ loading
>> position are not in definite order.
>>
>> So sorting this part at compile time doesn't make much sense.
> 
> Bah.. I thought the sections would retain relative position at least,
> but alas. if that isn't done you're quite right that sorting seems
> pointless.
> 

I found the problem when I was sorting mcount in .ko.
Initially I found that some mcount's relocation base on.text
and some base on .init.text.I tried insmod the same .ko several
times. The results show that there is no definite order between
the two sections，and the same situation occurs in several other
mcount base sections.





Best regards!
--Yinan liu

