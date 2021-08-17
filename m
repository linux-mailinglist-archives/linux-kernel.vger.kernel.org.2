Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC533EE0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHQAC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:02:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232470AbhHQAC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016031FB;
        Mon, 16 Aug 2021 17:01:54 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE6D3F66F;
        Mon, 16 Aug 2021 17:01:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
In-Reply-To: <20210816103347.GC21942@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com> <20210701041552.112072-2-srikar@linux.vnet.ibm.com> <875yxu85wi.mognet@arm.com> <20210712124856.GA3836887@linux.vnet.ibm.com> <87zguqmay9.mognet@arm.com> <20210723143914.GI3836887@linux.vnet.ibm.com> <87h7g09bgg.mognet@arm.com> <20210809065235.GH4072958@linux.vnet.ibm.com> <875yweaig9.mognet@arm.com> <20210810114727.GB21942@linux.vnet.ibm.com> <20210816103347.GC21942@linux.vnet.ibm.com>
Date:   Tue, 17 Aug 2021 01:01:46 +0100
Message-ID: <87mtph6is5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/21 16:03, Srikar Dronamraju wrote:
>>
>> Your version is much much better than mine.
>> And I have verified that it works as expected.
>>
>>
>
> Hey Peter/Valentin
>
> Are we waiting for any more feedback/testing for this?
>

I'm not overly fond of that last one, but AFAICT the only alternative is
doing a full-fledged NUMA topology rebuild on new-node onlining (i.e. make
calling sched_init_numa() more than once work). It's a lot more work for a
very particular usecase.

>
> --
> Thanks and Regards
> Srikar Dronamraju
