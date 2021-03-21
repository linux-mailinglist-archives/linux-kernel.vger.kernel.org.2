Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11923430EA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 05:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCUE46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 00:56:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:43543 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCUE4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 00:56:21 -0400
IronPort-SDR: 9mDxNOnKIA7Ae7/T3ZRLrHv8oXCfzkhIyCpF6VElI1qxCu21cqCFyfcvDScZh4aE9BoCoWH9iy
 3Vv6XOjVpgng==
X-IronPort-AV: E=McAfee;i="6000,8403,9929"; a="210155932"
X-IronPort-AV: E=Sophos;i="5.81,265,1610438400"; 
   d="scan'208";a="210155932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 21:56:21 -0700
IronPort-SDR: PiFBcdShvIteaJSvvLmOmrLYU4TYFJ1Yftp1HW3hLTyEiWY6AVejaO2B5MO1DqGTZOWZpDGNRz
 ghtL3kTnPMrQ==
X-IronPort-AV: E=Sophos;i="5.81,265,1610438400"; 
   d="scan'208";a="440663563"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 21:56:20 -0700
Date:   Sat, 20 Mar 2021 21:56:19 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Pontes, Otavio" <otavio.pontes@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] x86/microcode: Check for offline CPUs before
 checking for microcode update
Message-ID: <20210321045619.GB67113@otc-nc-03>
References: <20210319165515.9240-1-otavio.pontes@intel.com>
 <20210319165515.9240-2-otavio.pontes@intel.com>
 <MW3PR11MB45559DAC0B495A4262C9121BF8689@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20210320145546.GC3338@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320145546.GC3338@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 03:55:46PM +0100, Borislav Petkov wrote:
[snip]
> > microcode : 0x30
> > microcode : 0xde
> > microcode : 0x30
> > microcode : 0xde
> 
> Yeah, I'm looking at that check_online_cpus() thing and wondering why we
> even need that:
> 
> 0. So you have CPUs 1 and 3 offline.
> 1. We can update on the subset of cores which are online
> 2. If a core is offline and comes online, we have the hotplug notifier:
> 
>         cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
>                                   mc_cpu_online, mc_cpu_down_prep);
> 
> which takes care of updating the microcode when that CPU comes online.
> 
> So unless your microcode folks don't come back with a real requirement
> why all CPUs must absolutely be online for a late update, then the
> proper fix is to get rid of check_online_cpus() altogether and update
> what's online and the rest will get updated when they come online.

Its true we update them during the online flow, but the core is still
behind compared to other cores. It still participates when it enters SMM,
or when running MCE for instance. Unless its in WAIT_FOR_SIPI state its
best to not leave a core behind when updating microcode.

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
