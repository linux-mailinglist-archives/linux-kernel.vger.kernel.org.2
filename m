Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD53DB87F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhG3MW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:22:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhG3MWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:22:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EE1D6E;
        Fri, 30 Jul 2021 05:22:20 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4726E3F70D;
        Fri, 30 Jul 2021 05:22:19 -0700 (PDT)
Subject: Re: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Memory Management <mm-qe@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
 <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com>
 <CA+QYu4rCRR_pNQVxSwGpzcLWJKLUA3F7LAtBiU9hPzz3D0k0Cg@mail.gmail.com>
 <f5b4beb9-4e75-0f4e-da8b-b7ccc12fee68@arm.com>
Message-ID: <1ea2fa5c-ae81-2389-7f02-2227636582e4@arm.com>
Date:   Fri, 30 Jul 2021 14:22:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f5b4beb9-4e75-0f4e-da8b-b7ccc12fee68@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2021 16:38, Dietmar Eggemann wrote:
> On 29/07/2021 14:36, Bruno Goncalves wrote:
>> On Wed, Jul 28, 2021 at 5:55 PM Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 28/07/2021 15:11, Bruno Goncalves wrote:
> 
> [...]
> 
>>> Can't reproduce it on my Juno (arm64) (slow-switching (scpi-cpufreq
>>> driver)).
>>
>> We seem to be able to reproduce this only on Ampere Altra machines,
>> specifically on mtjade and mtsnow cpus.
>>
>> # cpupower frequency-info
>> analyzing CPU 0:
>>   driver: cppc_cpufreq
>>   CPUs which run at the same hardware frequency: 0
>>   CPUs which need to have their frequency coordinated by software: 0
>>   maximum transition latency:  Cannot determine or is not supported.
>>   hardware limits: 1000 MHz - 2.80 GHz
>>   available cpufreq governors: conservative ondemand userspace
>> powersave performance schedutil
>>   current policy: frequency should be within 2.00 GHz and 2.80 GHz.
>>                   The governor "schedutil" may decide which speed to use
>>                   within this range.
>>   current CPU frequency: 1.55 GHz (asserted by call to hardware)
>>
>> # ps -eTo comm,pid,pri,class | grep sugov
>> sugov:0            1082 140 DLN
>> sugov:1            1085 140 DLN
>> ...
>> sugov:78           1319 140 DLN
>> sugov:79           1320 140 DLN
> 
> Thanks! In the meantime I got access to an Ampere Altra so I can try
> 5.14.0-rc1 later today.

The task causing this seem to be the new `cppc_fie` DL task introduced
by commit 1eb5dde674f5 "cpufreq: CPPC: Add support for frequency
invariance" in v5.14-rc1.

With `CONFIG_ACPI_CPPC_CPUFREQ_FIE=y` and schedutil cpufreq governor on
slow-switching system:

DL task curr=`sugov:X` makes p=`cppc_fie` migrate and since it is in
`non_contending` state, migrate_task_rq_dl() calls 

  sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
  rq_clock()->assert_clock_updated()

on p. 

Can you try this snippet? It should fix it.

--8<--

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Fri, 30 Jul 2021 14:03:40 +0200
Subject: [PATCH] sched/deadline: Fix missing clock update in
 migrate_task_rq_dl()

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6cfd42f..4920f498492f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1733,6 +1733,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 */
 	raw_spin_rq_lock(rq);
 	if (p->dl.dl_non_contending) {
+		update_rq_clock(rq);
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
 		/*
-- 
2.25.1
