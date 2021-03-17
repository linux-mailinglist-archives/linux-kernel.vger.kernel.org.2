Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC833F132
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCQNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:32:37 -0400
Received: from mail.ispras.ru ([83.149.199.84]:50480 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhCQNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:32:22 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id C9695407627D;
        Wed, 17 Mar 2021 13:32:17 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:32:17 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: unknown NMI on AMD Rome
In-Reply-To: <YFHWNWBAQ4rsyAMG@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LNX.2.20.13.2103171619320.17743@monopod.intra.ispras.ru>
References: <YFDSSxftYw9tCGC6@krava> <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net> <36397980-f897-147f-df55-f37805d869c9@amd.com> <20210317084829.GA474581@gmail.com> <YFHWNWBAQ4rsyAMG@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021, Peter Zijlstra wrote:

> On Wed, Mar 17, 2021 at 09:48:29AM +0100, Ingo Molnar wrote:
> > > https://developer.amd.com/wp-content/resources/56323-PUB_0.78.pdf
> > 
> > So:
> > 
> > 
> >   1215 IBS (Instruction Based Sampling) Counter Valid Value
> >   May be Incorrect After Exit From Core C6 (CC6) State
> > 
> >   Description
> > 
> >   If a core's IBS feature is enabled and configured to generate an interrupt, including NMI (Non-Maskable
> >   Interrupt), and the IBS counter overflows during the entry into the Core C6 (CC6) state, the interrupt may be
> >   issued, but an invalid value of the valid bit may be restored when the core exits CC6.
> >   Potential Effect on System
> > 
> >   The operating system may receive interrupts due to an IBS counter event, including NMI, and not observe an
> >   valid IBS register. Console messages indicating "NMI received for unknown reason" have been observed on
> >   Linux systems.
> > 
> >   Suggested Workaround: None
> >   Fix Planned: No fix planned
> 
> Should be simple enough to disable CC6 while IBS is in use. Kim, can you
> please make that happen?

Wouldn't that "magically" significantly speed up workloads running under
'perf top', in case they don't saturate the CPUs? Scheduling gets
much snappier if the target CPU doesn't need to wake up from deep sleep :)

Alternatively, would you consider adding the errata reference to the
printk message when IBS is in use, and rate-limit it so it doesn't
flood dmesg? Then the user will know what's going on, and may
choose to temporarily disable C-states using the 'cpupower' tool.

Alexander
