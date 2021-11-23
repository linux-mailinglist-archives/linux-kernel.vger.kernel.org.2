Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6045A396
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhKWNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:23:12 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39465 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237223AbhKWNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:23:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UxzBImG_1637673599;
Received: from 30.32.124.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UxzBImG_1637673599)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 21:20:00 +0800
Message-ID: <399f9ef5-3a77-902a-7b4c-86020e629944@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 21:20:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] mm: Promote slow memory in advance to improve
 performance
To:     Yang Shi <shy828301@gmail.com>, Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, zhongjiang-ali@linux.alibaba.com,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fc80ea7998a98274447cb3be84d5ef705438a3dc.1637571100.git.baolin.wang@linux.alibaba.com>
 <CAHbLzkrj_GmmixNVhchbxqMWM3sCXdwr0eVhrs7BkLKZd1v8bg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAHbLzkrj_GmmixNVhchbxqMWM3sCXdwr0eVhrs7BkLKZd1v8bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/23 3:34, Yang Shi wrote:
> On Mon, Nov 22, 2021 at 2:22 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Some workloads access a set of data entities will follow the data locality,
>> also known as locality of reference, which means the probability of accessing
>> some data soon after some nearby data has been accessed.
>>
>> On some systems with different memory types, which will rely on the numa
>> balancing to promote slow hot memory to fast memory to improve performance.
>> So we can promote several sequential pages on slow memory at one time
>> according to the data locality for some workloads to improve the performance.
> 
> Fault around for NUMA fault definitely could reduce the overhead for
> NUMA balancing by having fewer faults. I think this could be extended
> to regular NUMA balancing too. But I'm not sure whether false
> positives are worth concerning or not.

OK. Like Huang Ying said, maybe we can add some algorithm to adjust the 
window of proactive numa faults dynamically. Thanks for your input.

> 
> I recall Mel proposed fault around too (not in patch, but shared some
> ideas). Added Mel in this thread.
