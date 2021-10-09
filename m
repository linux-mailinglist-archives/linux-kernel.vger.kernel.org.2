Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63A4276C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhJIC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:58:41 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44953 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhJIC6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:58:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ur3IQOD_1633748201;
Received: from 30.240.97.92(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Ur3IQOD_1633748201)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 10:56:42 +0800
Message-ID: <1d069626-1aed-6244-b932-7853e832eb70@linux.alibaba.com>
Date:   Sat, 9 Oct 2021 10:56:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-2-yinan@linux.alibaba.com>
 <20210911095937.5a298619@rorschach.local.home>
 <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
 <20211008194821.3b6a18a4@oasis.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211008194821.3b6a18a4@oasis.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/9 上午7:48, Steven Rostedt wrote:
> On Sun, 3 Oct 2021 21:42:10 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
> 
>> Sorry for my slow progress . I have encountered some problems with the
>> sorting
>> of the module's mcount in compile time. The .ko file will be relocated
>> after insmod
>> or modprobe, most of the mcount relocation is based on .text section,
>> but there are
>> also a small part of mcount relocation based on .init.text section such
>> as module_init().
>> The loading position of .init.text and .text does not seem to be in a
>> definite order.
> 
> Right, there's no guarantee that the .text portion of a module is
> placed before or after the .init.text portion.
yes.
> 
>>
>> For example, when I insmod ip_tables.ko twice, the front and back
>> positions of init.text
>> and .text are different, so we cannot sort the mcounts in the two
>> sections, which makes
>> the mcount sorting in the module meaningless.
>>
>> What is your opinion on this?
> 
> Probably just keep the sorting algorithm in the kernel and take place
> on module load.
> 
> If you still want to sort at compile time, then do the sort for .init
> functions separate from the .text ones, and have a way to extract this
> information (shouldn't be too hard) in the kernel at module load, and
> then just swap the init and text functions if they were added in the
> reverse order that was expect.
> 
> The functions in .init will either be before all the functions in .text
> or after. They wont be intermingled. Thus, if they are both sorted,
> then they are placed correctly or the two groups of functions need to
> be switched. No other sorting should be necessary.
Thanks so much! I see. And I will have a try.
> 
> -- Steve
> 
Best regards!
-- Yinan liu
