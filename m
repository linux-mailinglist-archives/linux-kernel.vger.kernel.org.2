Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB33C36F2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhD2XFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:05:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:53418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD2XFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:05:00 -0400
IronPort-SDR: YRtt4Ji4waPgevN+XEdxW0ncTrnQNi5s3ZQ45zk1iShK0Y3rbUMGpdSoIGnPDUK63dkoowJx8a
 F4qt3K8K2a/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="184615119"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="184615119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 16:04:12 -0700
IronPort-SDR: 6+FwaPgiFdigqVtSY3veAlz0a/L6X+7mTvM8vf6oRT4RNwDeO+lAraUZj3kCeuhQYs8D+PBo/e
 GhmaUBR1K+6A==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="466541563"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 16:04:12 -0700
Date:   Thu, 29 Apr 2021 16:04:11 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210429230411.GK4032392@tassilo.jf.intel.com>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
 <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <878s517axu.ffs@nanos.tec.linutronix.de>
 <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
 <87lf91f177.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf91f177.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The idea is to leave the watchdog code in kernel/time/clocksource.c,
> > but to move the fault injection into kernel/time/clocksourcefault.c or
> > some such.  In this new file, new clocksource structures are created that
> > use some existing timebase/clocksource under the covers.  These then
> > inject delays based on module parameters (one senstive to CPU number,
> > the other unconditional).  They register these clocksources using the
> > normal interfaces, and verify that they are eventually marked unstable
> > when the fault-injection parameters warrant it.  This is combined with
> > the usual checking of the console log.
> >
> > Or am I missing your point?
> 
> That's what I meant.

I still think all this stuff should be in the fault injection framework,
like other fault injections, to have a consistent discoverable interface. 

I actually checked now and the standard fault injection supports boot arguments,
so needing it at boot time shouldn't be a barrier.

-Andi
