Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5063DD22B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhHBIme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:42:34 -0400
Received: from foss.arm.com ([217.140.110.172]:60110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhHBImc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:42:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E80106F;
        Mon,  2 Aug 2021 01:42:23 -0700 (PDT)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B843F719;
        Mon,  2 Aug 2021 01:42:21 -0700 (PDT)
Subject: Re: WARNING: CPU: 0 PID: 12 at kernel/sched/fair.c:3306
 update_blocked_averages+0x941/0x9a0
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gmail.com>
References: <b18744a7-d300-59a8-a6d7-55ba88471252@gnuweeb.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7473b5ba-72bf-7836-44a6-42851081a277@arm.com>
Date:   Mon, 2 Aug 2021 10:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b18744a7-d300-59a8-a6d7-55ba88471252@gnuweeb.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On 30/07/2021 17:21, Ammar Faizi wrote:
> Hi everyone,
> 
> I compiled Linux 5.13.0 and use it on my Ubuntu. I got a kernel warning
> at kernel/sched/fair.c:3306.
> 
> Below is the system information
> Kernel: 5.13.0-icetea001-12377-gf55966571d5e

So you're running with:

9e077b52d86a - sched/pelt: Check that *_avg are null when *_sum are
(2021-06-17 Vincent Guittot)

but not with:

ceb6ba45dc80 - sched/fair: Sync load_sum with load_avg after dequeue
(2021-07-02 Vincent Guittot)

The SCHED_WARN_ON you're hitting is harmless and just tells you that the
PELT load_avg and load_sum part of one of your cfs_rq's is not aligned.
Has to be load (and not util or runnable) since load is the only one
still not fixed in f55966571d5e.

This should go away once you applied ceb6ba45dc80.

-- Dietmar

