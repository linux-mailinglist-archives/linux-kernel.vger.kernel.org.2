Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65E45326A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhKPMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:54:22 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55936 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236307AbhKPMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:54:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uws948k_1637067079;
Received: from 30.240.105.70(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uws948k_1637067079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 20:51:20 +0800
Message-ID: <a70a70c2-00f9-26ab-eb85-a09f8777be3c@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 20:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-3-yinan@linux.alibaba.com>
 <20211116081020.GW174703@worktop.programming.kicks-ass.net>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211116081020.GW174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/11/16 下午4:10, Peter Zijlstra 写道:
> On Tue, Nov 16, 2021 at 10:49:42AM +0800, Yinan Liu wrote:
>> In some business scenarios, GCC versions are so old that
>> optimizations in ftrace cannot be completed, such as
>> -mrecord-mcount and -mnop-mcount. The recordmCount in the
>> kernel is actually used. In this case, ftrace_init will
>> consume a period of time, usually around 9~12ms. Do nop
>> substitution in recordmcount.c to speed up ftrace_init.
> 
> I really don't buy this.. if you can build a fresh kernel, you can
> install a fresh gcc too -- and if you care about performance that's a
> very good idea anyway.
> 
Thanks! You are right. We should get rid of the burden.
