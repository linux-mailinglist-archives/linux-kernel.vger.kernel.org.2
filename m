Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FA3DFF59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhHDKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:21:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235522AbhHDKU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:20:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A0113A1;
        Wed,  4 Aug 2021 03:20:46 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24ECA3F66F;
        Wed,  4 Aug 2021 03:20:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for non-online nodes
In-Reply-To: <20210804100155.GE4072958@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com> <20210701041552.112072-2-srikar@linux.vnet.ibm.com> <875yxu85wi.mognet@arm.com> <20210712124856.GA3836887@linux.vnet.ibm.com> <87zguqmay9.mognet@arm.com> <20210723143914.GI3836887@linux.vnet.ibm.com> <20210804100155.GE4072958@linux.vnet.ibm.com>
Date:   Wed, 04 Aug 2021 11:20:41 +0100
Message-ID: <87r1f9a4ue.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/21 15:31, Srikar Dronamraju wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2021-07-23 20:09:14]:
>
>> * Valentin Schneider <valentin.schneider@arm.com> [2021-07-13 17:32:14]:
>>
>> > On 12/07/21 18:18, Srikar Dronamraju wrote:
>> > > Hi Valentin,
>> > >
>> > >> On 01/07/21 09:45, Srikar Dronamraju wrote:
>> > >> > @@ -1891,12 +1894,30 @@ void sched_init_numa(void)
>> > >> >  void sched_domains_numa_masks_set(unsigned int cpu)
>> > >> >  {
>> > >
>
> Hey Valentin / Peter
>
> Did you get a chance to look at this?
>

Barely, I wanted to set some time aside to stare at this and have been
failing miserably. Let me bump it up my todolist, I'll get to it before the
end of the week.

> --
> Thanks and Regards
> Srikar Dronamraju
