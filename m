Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88334E653
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhC3Lba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:31:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3LbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:31:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191D11FB;
        Tue, 30 Mar 2021 04:31:02 -0700 (PDT)
Received: from [10.57.57.107] (unknown [10.57.57.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1CE93F694;
        Tue, 30 Mar 2021 04:30:59 -0700 (PDT)
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
From:   Zachary Leaf <zachary.leaf@arm.com>
Message-ID: <9e904f20-7943-ee44-9653-7aa949c3ba88@arm.com>
Date:   Tue, 30 Mar 2021 12:30:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210311000837.3630499-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 00:08, Rob Herring wrote:
> 
> In order to enable 64-bit counters for userspace when available, a new
> config1 bit is added for userspace to indicate it wants userspace counter
> access. This bit allows the kernel to decide if chaining should be
> disabled and chaining and userspace access are incompatible.
> The modes for config1 are as follows:
> 
> config1 = 0 or 2 : user access enabled and always 32-bit
> config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> config1 = 3 : user access enabled and counter size matches underlying counter.
> 

Thanks for this Rob. That makes it extremely easy to request 64 bit
userspace counters without having to worry about the underlying bit
width supported on your system.

The underlying PMUv3 bit width is otherwise not accessible from
userspace as far as I can tell (e.g. the relevant PMUVer bits [11:8] of
ID_AA64DFR0_EL1 are masked off when reading from EL0 [1]), and the
workaround of requesting 64 bit, checking cap_user_rdpmc for userspace
access, and retrying with 32 bit was not that user friendly. I think it
makes a lot of sense for the kernel to handle/expose it here rather than
handled in the application code.

I think it's worth mentioning here if anyone searches, is that the 32
bit counter behaviour when added to the perf_event_mmap_page->offset is
effectively the same as a single 64 bit counter due to the offset being
incremented on overflow. Using a true 64 bit counter can avoid the
overhead of handling an interrupt for each overflow (and obviously has a
lot more headroom before it overflows, if you require very long running
perf stats).

I have tested the new config1 flags on N1-SDP and the behaviour is as
expected.

[1]
https://github.com/torvalds/linux/blob/master/Documentation/arm64/cpu-feature-registers.rst
