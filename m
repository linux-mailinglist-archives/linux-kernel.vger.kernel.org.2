Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5891F337FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCKVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:43:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ac2GshzHDBbYFZYWpQvmFOuN7K45Tqd3TxtnIlDvA1g=; b=L2IlJ1fsg+OdawMAj/25KcTwi9
        ASjxBq3+ctOm1ZknMCi/B6gL2zMBPJBWcn4Xax9Z8uZhBeyeAzjssUjP9XN79FC+o0SYRv/meiuIK
        WB9i+y4yu697xl+c44w/HrNYz3V7cJJBxGMH6o4EypfXgOeZmUXMRunRBYkrFvoXYS/EihSJb1M84
        ybzK58NeEZ43JG1wbv1USkuWlO+ZLX/M1VpQbquANpolt+JSrMlRpMX9qov9uQIZvgeHwExB8sMad
        Yawe+ZtgPdE9N/HR2kiuYlAFOGjKrSYxsyz9Vba5P8bHMY7re3YQ/89dP/LgDOjqG0fT0RGOeDQBV
        SlsEM/mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKT5Q-008gI0-Gw; Thu, 11 Mar 2021 21:43:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65D7D9864D0; Thu, 11 Mar 2021 22:43:15 +0100 (CET)
Date:   Thu, 11 Mar 2021 22:43:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210311214315.GN4746@worktop.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
 <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
 <20210311204742.GM4746@worktop.programming.kicks-ass.net>
 <a606211b5b454ef5b658858e0cb361f0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a606211b5b454ef5b658858e0cb361f0@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:09:57PM +0000, Luck, Tony wrote:
> >> I think the "sapphire_rapids" is the code name for the server platform.
> >
> > If that's really the case, then:
> >
> > #define INTEL_FAM6_SAPPHIRERAPIDS_X     0x8F
> >
> > is wrong, those things should be uarch name, not platform name. Tony?
> 
> 0x8F is the model number of the CPU that is named Sapphire Rapids that
> goes into the Eagle Stream platform
> 
> If you want a uarch name, that might be the name of the core
> (.... something-cove ... I can't keep track of the names of all the
> coves).

uarch names used to be different from that. But looking at wikipedia,
things have gone completely apeshit after skylake :-/

We used to have one microarch and then a laptop,desktop and server sku,
but now each of those has a separately named microarch, so where we had
one new name each year, we now have at least 3. No wonder I've no
sodding clue anymore.

/me stmps off to get a beer to forget all I've seen ...
