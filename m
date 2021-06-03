Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27042399F42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFCKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:52:30 -0400
Received: from foss.arm.com ([217.140.110.172]:37990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhFCKw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C0431063;
        Thu,  3 Jun 2021 03:50:44 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8FC3F774;
        Thu,  3 Jun 2021 03:50:41 -0700 (PDT)
Subject: Re: [sched/pelt] e906550aca:
 WARNING:at_kernel/sched/fair.c:#update_blocked_averages
To:     kernel test robot <oliver.sang@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ltp@lists.linux.it, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        odin@uged.al, aubrey.li@linux.intel.com, yu.c.chen@intel.com
References: <20210602064526.GB9872@xsang-OptiPlex-9020>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <56316b95-3ec5-74e6-a4f7-d91aea022abe@arm.com>
Date:   Thu, 3 Jun 2021 12:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602064526.GB9872@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2021 08:45, kernel test robot wrote:

[...]

> kern :warn : [   40.989618] WARNING: CPU: 2 PID: 253 at kernel/sched/fair.c:8029 update_blocked_averages (kbuild/src/consumer/kernel/sched/fair.c:8029 kbuild/src/consumer/kernel/sched/fair.c:8065 kbuild/src/consumer/kernel/sched/fair.c:8152) 

Hit something like this on my Ubuntu i7-7567U as well.

With more debugging:

[    7.388006] WARNING: CPU: 1 PID: 926 at kernel/sched/fair.c:8029 update_blocked_averages+0x30d/0x7e0
...
[    7.388167] path=/autogroup-2 load_avg=1 util_avg=0 runnable_avg=1

IMHO, this is because this patch needs:

(1) sched/pelt: ensure that *_sum is always synced with *_avg (2021-06-03 Vincent Guittot)

https://lkml.kernel.org/r/20210601085832.12626-1-vincent.guittot@linaro.org

(2) sched/fair: Keep load_avg and load_sum synced (2021-06-03 Vincent Guittot)

tip/sched/urgent 7c7ad626d9a0

Using both patches underneath makes this warning go away.

