Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7F35AE80
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhDJOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:49:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:36795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234587AbhDJOtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:49:15 -0400
IronPort-SDR: txoN0MZeBNvbdzUPHbs85EEhmoMIhhe0u7Lzk0AwvaY4yBtfESebctKDozUTnk1MAv3POGkkVB
 rWRxcEFhSQCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="174023976"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="174023976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 07:49:00 -0700
IronPort-SDR: 4LLPejWhnujnYJd2Rv5aRHA5Bqo3JakHoF2v4TBaDPM6OdktWh91cNGqStVb+jUJaQ1frdpTaD
 uu40+wdc70pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="416687791"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2021 07:48:57 -0700
Date:   Sat, 10 Apr 2021 22:48:56 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always
 checked
Message-ID: <20210410144856.GC22054@shbuild999.sh.intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410094752.GB21691@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410094752.GB21691@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sat, Apr 10, 2021 at 11:47:52AM +0200, Borislav Petkov wrote:
> On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
> > On Tue, Mar 30 2021 at 16:25, Feng Tang wrote:
> > > Normally the tsc_sync will be checked every time system enters idle state,
> > > but there is still caveat that a system won't enter idle, either because
> > > it's too busy or configured purposely to not enter idle. Setup a periodic
> > > timer to make sure the check is always on.
> > 
> > Bah. I really hate the fact that we don't have a knob to disable writes
> > to the TSC/TSC_ADJUST msrs. That would spare this business alltogether.
> 
> We have the MSR filtering and I'd *love* to add those MSRs to a
> permanent ban list of MSRs which will never ever be written to from
> luserspace.

Yep, I just tried changing TSC_ADJUST msr with 'wrmsr' command, and
it did succeed and trigger the warning of tsc_verify_tsc_adjust():

	[ 1135.387866] [Firmware Bug]: TSC ADJUST differs: CPU0 0 --> 4096. Restoring

And the bigger risk is still BIOS's writing to TSC_ADJUST MSR beneath
kernel.

Thanks,
Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
