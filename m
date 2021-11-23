Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352F745A3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhKWN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:29:34 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40960 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232333AbhKWN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:29:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UxzwxjE_1637673981;
Received: from 30.32.124.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UxzwxjE_1637673981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 21:26:22 +0800
Message-ID: <31367b55-d3a4-3b2b-8d5d-86b8dfce7383@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 21:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] mm: Promote slow memory in advance to improve
 performance
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <fc80ea7998a98274447cb3be84d5ef705438a3dc.1637571100.git.baolin.wang@linux.alibaba.com>
 <87ilwjbn1j.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87ilwjbn1j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/23 10:53, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Some workloads access a set of data entities will follow the data locality,
>> also known as locality of reference, which means the probability of accessing
>> some data soon after some nearby data has been accessed.
>>
>> On some systems with different memory types, which will rely on the numa
>> balancing to promote slow hot memory to fast memory to improve performance.
>> So we can promote several sequential pages on slow memory at one time
>> according to the data locality for some workloads to improve the performance.
>>
>> Testing with mysql can show about 5% performance improved as below.
>>
>> Machine: 16 CPUs, 64G DRAM, 256G AEP
>>
>> sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua
>> --mysql-user=root --mysql-password=root --oltp-test-mode=complex
>> --oltp-tables-count=65 --oltp-table-size=5000000 --threads=20 --time=600
>> --report-interval=10
>>
>> No proactive promotion:
>> transactions
>> 2259245 (3765.37 per sec.)
>> 2312605 (3854.31 per sec.)
>> 2325907 (3876.47 per sec.)
>>
>> Proactive promotion bytes=16384:
>> transactions
>> 2419023 (4031.66 per sec.)
>> 2451903 (4086.47 per sec.)
>> 2441941 (4068.68 per sec.)
> 
> This is kind of readahead to promote the page before we know it's hot.
> It can definitely benefit the performance if we predict correctly, but
> may hurt if we predict wrongly.

Right.

> 
> Is it possible for us to add some self-adaptive algorithm like that in
> readahead to determine whether to adjust the fault around window
> dynamically?  A system level knob may be not sufficient to fit all
> workloads run in system?

That's a good point, and I also thought about it, but only implemented a 
simple approach now. OK, I will try to implement one flexible approach 
to adjust the fault around window dynamically and measure the 
performance. Thanks for your input.
