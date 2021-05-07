Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1254A376660
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhEGNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:48:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234951AbhEGNsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:48:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFFFF106F;
        Fri,  7 May 2021 06:47:05 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8413F73B;
        Fri,  7 May 2021 06:47:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <CAKfTPtA+w1Euepw+MP0o1EGYhoohpQm3jJP+WFQrmZ6Zet+F3g@mail.gmail.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book> <87blaakxji.mognet@arm.com> <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com> <878s5bvrij.mognet@arm.com> <CAKfTPtA+w1Euepw+MP0o1EGYhoohpQm3jJP+WFQrmZ6Zet+F3g@mail.gmail.com>
Date:   Fri, 07 May 2021 14:46:59 +0100
Message-ID: <87y2cqirl8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent, apologies for the belated reply

On 30/04/21 08:58, Vincent Guittot wrote:
> On Wed, 21 Apr 2021 at 12:52, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 20/04/21 16:33, Vincent Guittot wrote:
>> > Is it something that happens often or just a sporadic/transient state
>> > ? I mean does it really worth the extra complexity and do you see
>> > performance improvement ?
>> >
>>
>> "Unfortunately" yes, this is a relatively common scenario when running "1
>> big task per CPU" types of workloads. The expected behaviour for big.LITTLE
>> systems is to upmigrate tasks stuck on the LITTLE CPUs as soon as a big CPU
>> becomes free, usually via newidle balance (which, since they process work
>> faster than the LITTLEs, is bound to happen), and an extra task being
>> enqueued at "the wrong time" can prevent this from happening.
>>
>> This usually means a misfit task can take a few dozen extra ms than it
>
> A few dozens is quite long. With a big core being idle, it should try
> every 8ms on a quad x quad system and I suspect the next try will be
> during the next tick. Would be good to understand why it has to wait
> so much
>

True, IIRC this was mostly due to a compound effect of the different issues
I've described in that thread (and the previous one). Now that

  9bcb959d05ee ("sched/fair: Ignore percpu threads for imbalance pulls")

is in, I'll re-run some tests against upstream and see how we fare.
