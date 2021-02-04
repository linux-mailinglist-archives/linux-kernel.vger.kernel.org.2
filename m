Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4030EFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhBDJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:48:13 -0500
Received: from foss.arm.com ([217.140.110.172]:54946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBDJsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:48:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E758211D4;
        Thu,  4 Feb 2021 01:47:25 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA86A3F719;
        Thu,  4 Feb 2021 01:47:22 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
 <09367fac-5184-56d1-3c86-998b5f2af838@arm.com>
 <CAKfTPtCg9pTU6JFpV7+skRXT7gacJzJ5eLJwnOdEFQPuf6vKOw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c97c262d-0098-e59d-a235-c45940115075@arm.com>
Date:   Thu, 4 Feb 2021 10:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCg9pTU6JFpV7+skRXT7gacJzJ5eLJwnOdEFQPuf6vKOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 14:12, Vincent Guittot wrote:
> On Wed, 3 Feb 2021 at 12:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 29/01/2021 18:27, Vincent Guittot wrote:
>>> Le vendredi 29 janv. 2021 ï¿½ 11:33:00 (+0100), Vincent Guittot a ï¿½crit :
>>>> On Thu, 28 Jan 2021 at 16:09, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>>
>>>>> Hi Vincent,
>>>>>
>>>>> On Thu, Jan 28, 2021 at 8:57 AM Vincent Guittot
>>>>> <vincent.guittot@linaro.org> wrote:
>>>>>>> On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
>>>>>>>> On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>>>>>> On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
>>>>>>>>>> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
>>>>>>>>>> <joel@joelfernandes.org> wrote:
>>
>> [...]
>>
>>>> The only point that I agree with, is that running
>>>> update_blocked_averages with preempt and irq off is not a good thing
>>>> because we don't manage the number of csf_rq to update and I'm going
>>>> to provide a patchset for this
>>>
>>> The patch below moves the update of the blocked load of CPUs outside newidle_balance().
>>>
>>> Instead, the update is done with the usual idle load balance update. I'm working on an
>>> additonnal patch that will select this cpu that is about to become idle, instead of a
>>> random idle cpu but this 1st step fixe the problem of lot of update in newly idle.
>>
>> I'm trying to understand the need for this extra patch.
>>
>> The patch below moves away from doing update_blocked_averages() (1) for
>> all CPUs in sched groups of the sched domain:
>>
>> newidle_balance()->load_balance()->
>> find_busiest_group()->update_sd_lb_stats()->update_sg_lb_stats()
>>
>> to:
>>
>> calling (1) for CPUs in nohz.idle_cpus_mask in _nohz_idle_balance() via
>> update_nohz_stats() and for the ilb CPU.
>>
>> newidle_balance() calls (1) for newidle CPU already.
>>
>> What would be the benefit to choose newidle CPU as ilb CPU?
> 
> To prevent waking up another idle cpu to run the update whereas
> newidle cpu is already woken up and about to be idle so the best
> candidate.
> All the aim of the removed code was to prevent waking up an idle cpu
> for doing something that could be done by the newidle cpu before it
> enters idle state

Ah OK, makes sense. So the only diff would be that newidle CPU will call
(1) on nohz.idle_cpus_mask rather on on sd->span.

[...]
