Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4731356CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbhDGM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:57:48 -0400
Received: from foss.arm.com ([217.140.110.172]:56862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235427AbhDGM5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:57:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BFEF1063;
        Wed,  7 Apr 2021 05:57:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047493F792;
        Wed,  7 Apr 2021 05:57:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 4/9] sched: Move SCHED_DEBUG to debugfs
In-Reply-To: <YG2lBimj3cKMErA7@hirez.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org> <20210326103935.025550243@infradead.org> <87blaqnzho.mognet@arm.com> <YG2lBimj3cKMErA7@hirez.programming.kicks-ass.net>
Date:   Wed, 07 Apr 2021 13:57:22 +0100
Message-ID: <878s5untfx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 14:26, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 11:46:43AM +0100, Valentin Schneider wrote:
>> I can't find the threads in a hurry, but ISTR justifications for keeping
>> this around were:
>> - Most distros have CONFIG_SCHED_DEBUG=y because knobs and ponies
>> - Topology debug prints are "too verbose"
>
> ^^ that mostly.
>
>> - NUMA distance matrix processing gets slower
>>
>> If we make it so distros stop / don't need to select CONFIG_SCHED_DEBUG,
>
> We're not there yet, I think :-(
>

Yeah, I know, a man can dream... At least now I can make use of
CMDLINE_EXTEND on arm64.

>> then I don't think the above really stands anymore (also, sched_init_numa()
>> now has the same complexity regardless of sched_debug), and we could keep
>> everything under CONFIG_SCHED_DEBUG.
>
> But yes, the reason this knob exists is ebcause I too frequently forget
> to add the boot time knob, so I added this one to enable it at runtime
> and then I get topology prints when I hotplug cycle a cpu.
