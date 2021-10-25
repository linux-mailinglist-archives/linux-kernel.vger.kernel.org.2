Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA7439766
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJYNXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:23:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33903 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233482AbhJYNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:23:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UtePCS2_1635168048;
Received: from 30.240.99.57(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UtePCS2_1635168048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Oct 2021 21:20:48 +0800
Message-ID: <d0d5d491-41f5-09a4-ac3d-ebefa37a741b@linux.alibaba.com>
Date:   Mon, 25 Oct 2021 21:20:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-2-yinan@linux.alibaba.com>
 <20210911095937.5a298619@rorschach.local.home>
 <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
 <20211008194821.3b6a18a4@oasis.local.home>
 <1d069626-1aed-6244-b932-7853e832eb70@linux.alibaba.com>
In-Reply-To: <1d069626-1aed-6244-b932-7853e832eb70@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/9 上午10:56, Yinan Liu wrote:

>> Probably just keep the sorting algorithm in the kernel and take place
>> on module load.
>>
>> If you still want to sort at compile time, then do the sort for .init
>> functions separate from the .text ones, and have a way to extract this
>> information (shouldn't be too hard) in the kernel at module load, and
>> then just swap the init and text functions if they were added in the
>> reverse order that was expect.
>>
>> The functions in .init will either be before all the functions in .text
>> or after. They wont be intermingled. Thus, if they are both sorted,
>> then they are placed correctly or the two groups of functions need to
>> be switched. No other sorting should be necessary.
>>

Hi, Steven

I try to apply for memory during the relocation phase to separate and 
adjust the mcount of .init.text and .text. After processing, I found 
that the mcount redirection in .ko is based on ".text", ".init.text", 
".ref.text", ".sched.text", ".spinlock.text", ".irqentry .text", 
".softirqentry.text", ".kprobes.text", ".cpuidle.text", 
".text.unlikely", which makes the sorting process at compile time 
cumbersome and inefficient. And .ko is inserted after the kernel start， 
to a certain extent, the optimization meaning of this part is relatively 
small. Now I think it makes more sense to optimize mcount during the 
startup period, because these mcounts based on different section 
redirects are relatively orderly
just like 11, 13, 15, 17, 19, 1, 3, 5, 7, 9, 21, 23, 25, 27, 29
.

At present, it seems that the processing of compile-time sorting is only 
suitable for vmlinux but not suitable for modules. Please review the 
code of mcount sorting in vmlinux, thank you.

> Best regards!
> -- Yinan liu
