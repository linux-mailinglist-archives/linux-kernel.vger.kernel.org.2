Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81373B80C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhF3KYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:24:37 -0400
Received: from foss.arm.com ([217.140.110.172]:35038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234112AbhF3KYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703B011D4;
        Wed, 30 Jun 2021 03:22:07 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B6C3F5A1;
        Wed, 30 Jun 2021 03:22:05 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: kprobes: Enable OPTPROBE for arm64
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1622803839-27354-1-git-send-email-liuqi115@huawei.com>
 <2409bcc3-fc5c-1e41-d7be-c81e59042c4d@huawei.com>
 <d19df1a099704089ad671e1d3625655d@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <527265b8-35c3-eeec-5751-cc2920184d4e@arm.com>
Date:   Wed, 30 Jun 2021 11:22:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d19df1a099704089ad671e1d3625655d@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-30 08:05, Song Bao Hua (Barry Song) wrote:
>>
>> On 2021/6/4 18:50, Qi Liu wrote:
>>> This patch introduce optprobe for ARM64. In optprobe, probed
>>> instruction is replaced by a branch instruction to detour
>>> buffer. Detour buffer contains trampoline code and a call to
>>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>>> to execute kprobe handler.
>>>
>>> Limitations:
>>> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
>>> guarantee the offset between probe point and kprobe pre_handler
>>> is not larger than 128MiB.
>>>
>>> Performance of optprobe on Hip08 platform is test using kprobe
>>> example module[1] to analyze the latency of a kernel function,
>>> and here is the result:
> 
> + Jean-Philippe Brucker as well.
> 
> I assume both Jean and Robin expressed interest on having
> an optprobe solution on ARM64 in a previous discussion
> when I tried to add some tracepoints for debugging:
> "[PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist"
> 
> https://lore.kernel.org/linux-arm-kernel/20200828083325.GC3825485@myrica/
> https://lore.kernel.org/linux-arm-kernel/9acf1acf-19fb-26db-e908-eb4d4c666bae@arm.com/

FWIW mine was a more general comment that if the possibility exists, 
making kprobes faster seems more productive than adding tracepoints to 
every bit of code where performance might be of interest to work around 
kprobes being slow. I don't know enough about the details to 
meaningfully review an implementation, sorry.

>>>
>>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
>> mples/kprobes/kretprobe_example.c
>>>
>>> kprobe before optimized:
>>> [280709.846380] do_empty returned 0 and took 1530 ns to execute
>>> [280709.852057] do_empty returned 0 and took 550 ns to execute
>>> [280709.857631] do_empty returned 0 and took 440 ns to execute
>>> [280709.863215] do_empty returned 0 and took 380 ns to execute
>>> [280709.868787] do_empty returned 0 and took 360 ns to execute
>>> [280709.874362] do_empty returned 0 and took 340 ns to execute
>>> [280709.879936] do_empty returned 0 and took 320 ns to execute
>>> [280709.885505] do_empty returned 0 and took 300 ns to execute
>>> [280709.891075] do_empty returned 0 and took 280 ns to execute
>>> [280709.896646] do_empty returned 0 and took 290 ns to execute
>>> [280709.902220] do_empty returned 0 and took 290 ns to execute
>>> [280709.907807] do_empty returned 0 and took 290 ns to execute
> 
> I used to see the same phenomenon when I used kprobe to debug
> arm64 smmu driver. When a kprobe was executed for the first
> time, it was crazily slow. But second time it became much faster
> though it was still slow and affected the performance related
> debugging negatively.
> Not sure if it was due to hot cache or something. I didn't dig
> into it.

 From the shape of the data, my hunch would be that retraining of branch 
predictors is probably a factor (but again I don't know enough about the 
existing kprobes implementation to back that up).

Robin.
