Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64401337F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCKUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:31:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:35830 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhCKUbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:31:07 -0500
IronPort-SDR: U1wFizbuAuEsTBvVvzzN4gMWbdSP18HN8cK0tAlZP3jYXLs5qb9actzE8NuZuqoeAMEandNZwg
 1sljghlSIrqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="176328865"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="176328865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:30:55 -0800
IronPort-SDR: 2/de6No7iTnZ24jHnHecKclRguxHMhQPbmS3RGXz5LsZKoZrD36oUdTjdXUXKy5ldm658+HJix
 jids+eOuypDw==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="404191446"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:30:54 -0800
Date:   Thu, 11 Mar 2021 12:30:53 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, namhyung@kernel.org, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210311203053.GK203350@tassilo.jf.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311195832.GK4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 08:58:32PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 11:53:35AM -0500, Liang, Kan wrote:
> 
> > > > The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
> > > > PMEM.
> > > > The "cpu_atom" PMU is similar to Tremont, but with different
> > > > event_constraints, extra_regs and number of counters.
> 
> > > So do these things use the same event lists as SPR and TNT?
> > 
> > No, there will be two new event lists on ADL. One is for Atom core, and the
> > other is for big core. They are different to SPR and TNT.
> 
> *sigh* how different?

Atom and Big core event list have significant differences.

Often event lists of the same core in different SOCs are different too
because some events indicate stuff outside the core (e.g. Offcore Response
and others)

> 
> > > Is there any
> > > way to discover that, because AFAICT /proc/cpuinfo will say every CPU
> > > is 'Alderlake', and the above also doesn't give any clue.
> > > 
> > 
> > Ricardo once submitted a patch to expose the CPU type under
> > /sys/devices/system/cpu, but I don't know the latest status.
> > https://lore.kernel.org/lkml/20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com/
> 
> Yeah, but that was useless, it doesn't list the Cores as
> FAM6_SAPPHIRERAPIDS nor the Atom as FAM6_ATOM_TREMONT.

It's Gracemont, not Tremont.

But what would you do with the information that the core is related
to some other core.

The event lists are tied to the Alderlake model number. You cannot
just use event lists from some other part because there are 
differences to other Golden Cove or Gracemont implementations.

For non event list usages, the model numbers also indicate a lot of things
in the SOC, so even you knew it was a somewhat similar core as Sapphire
Rapids, it wouldn't tell the complete story. Even on the cores there are
differences.

In the end you need to know that Alderlake is Alderlake.

-Andi
