Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370034534DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhKPPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:07:06 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11469 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237893AbhKPPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:05:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwtpXN6_1637074936;
Received: from 30.25.250.88(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UwtpXN6_1637074936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 23:02:17 +0800
Message-ID: <2ff387d4-e7e8-9407-802c-e1cfcb2ca511@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 23:02:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-3-yinan@linux.alibaba.com>
 <20211116081020.GW174703@worktop.programming.kicks-ass.net>
 <20211116080749.1ef6337f@gandalf.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211116080749.1ef6337f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/11/16 下午9:07, Steven Rostedt 写道:
> On Tue, 16 Nov 2021 09:10:20 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Tue, Nov 16, 2021 at 10:49:42AM +0800, Yinan Liu wrote:
>>> In some business scenarios, GCC versions are so old that
>>> optimizations in ftrace cannot be completed, such as
>>> -mrecord-mcount and -mnop-mcount. The recordmCount in the
>>> kernel is actually used. In this case, ftrace_init will
>>> consume a period of time, usually around 9~12ms. Do nop
>>> substitution in recordmcount.c to speed up ftrace_init.
>>
>> I really don't buy this.. if you can build a fresh kernel, you can
>> install a fresh gcc too -- and if you care about performance that's a
>> very good idea anyway.
>>
> 
> I'm not sure this is true for all archs, is it? That is, is the nop
> substitution available in all archs that support mcount updates. Some
> (most) archs are special, because they have to deal with link registers and
> such.
> 
> And because of that, I'm not sure the patch works for all those archs.
> 
> -- Steve
> 

At present, I have only verified it under x86. In other cases, I am 
short of arch or scenarios. I am not sure whether the patch is 
applicable to all the architectures, perhaps adding something to x86?
Do you think it makes sense?

In fact, many companies cannot upgrade GCC due to online business 
reasons. This patch will help.




Best regards!
--Yinan liu
