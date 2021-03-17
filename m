Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB533F14D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCQNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhCQNhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:37:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA56664F30;
        Wed, 17 Mar 2021 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615988255;
        bh=uWLJjwbt6az/G89gyUZnzcahOeBXUQO6+rfQjVIDj6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMqyfriSWDNrf/7PyPyKwWWl/3YPWhVm9DiAyznVOTgjDzow4BkdbFWl2MELdc9WD
         6LJ4OU0u23fUNXVNzCmuV0jILKAaL7vXK1yWhmQqlNJDS7/SF3GlFsQu60Q45kGLOs
         XQ52BZ3y2P58FfSOmMCr4I7/QqlE2/IUL8RYj0yVHajXBZrSLtMkiN7MXe0D0jU7sL
         8lABUzQHSyu8tuH0WFoUUlyltpNUgpjUltj2iK2Y7ApzyVzITwLA+FmddXqoXiyICd
         EONEj/MvwwJbIpLZSjYHlQZPCRHgbjuutGWAkCll1QFlTYvOv49Ek72nBLoQtEga2s
         ftDzLl9NH5L0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80C4C40647; Wed, 17 Mar 2021 10:37:31 -0300 (-03)
Date:   Wed, 17 Mar 2021 10:37:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: unknown NMI on AMD Rome
Message-ID: <YFIGG04xIQRzD+D8@kernel.org>
References: <YFDSSxftYw9tCGC6@krava>
 <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
 <36397980-f897-147f-df55-f37805d869c9@amd.com>
 <20210317084829.GA474581@gmail.com>
 <YFHWNWBAQ4rsyAMG@hirez.programming.kicks-ass.net>
 <alpine.LNX.2.20.13.2103171619320.17743@monopod.intra.ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.13.2103171619320.17743@monopod.intra.ispras.ru>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 17, 2021 at 04:32:17PM +0300, Alexander Monakov escreveu:
> On Wed, 17 Mar 2021, Peter Zijlstra wrote:
> > On Wed, Mar 17, 2021 at 09:48:29AM +0100, Ingo Molnar wrote:
> > > > https://developer.amd.com/wp-content/resources/56323-PUB_0.78.pdf

> > >   1215 IBS (Instruction Based Sampling) Counter Valid Value
> > >   May be Incorrect After Exit From Core C6 (CC6) State

> > >   Description

> > >   If a core's IBS feature is enabled and configured to generate an interrupt, including NMI (Non-Maskable
> > >   Interrupt), and the IBS counter overflows during the entry into the Core C6 (CC6) state, the interrupt may be
> > >   issued, but an invalid value of the valid bit may be restored when the core exits CC6.
> > >   Potential Effect on System

> > >   The operating system may receive interrupts due to an IBS counter event, including NMI, and not observe an
> > >   valid IBS register. Console messages indicating "NMI received for unknown reason" have been observed on
> > >   Linux systems.

> > >   Suggested Workaround: None
> > >   Fix Planned: No fix planned

> > Should be simple enough to disable CC6 while IBS is in use. Kim, can you
> > please make that happen?

> Wouldn't that "magically" significantly speed up workloads running under
> 'perf top', in case they don't saturate the CPUs? Scheduling gets
> much snappier if the target CPU doesn't need to wake up from deep sleep :)

> Alternatively, would you consider adding the errata reference to the
> printk message when IBS is in use, and rate-limit it so it doesn't
> flood dmesg? Then the user will know what's going on, and may
> choose to temporarily disable C-states using the 'cpupower' tool.

Would be interesting as well to make 'perf top' realize that somehow
(looking at some cpu id, etc) and don't use IBS when C-states are being
used and/or warn the user about the situation, i.e. cycles:P can't be
used in this machine if C-states are enabled?

- Arnaldo
