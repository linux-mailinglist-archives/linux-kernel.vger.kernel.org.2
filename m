Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156E83305AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 02:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhCHBnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 20:43:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:2266 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhCHBmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:42:37 -0500
IronPort-SDR: R+gHzbYwf5qREzWyIg3KUH6fLA7YLihAyw2fqm76+iE4MtwIMKc4ac04Xetqam6BJl6QKtPZzs
 bwtVToUWjZfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="185555117"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="185555117"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 17:42:37 -0800
IronPort-SDR: a34LLs3xIBhzsJylWmHkl1RbqCGLNSD6RfmLVCD6r4bx3Pli7R84ytYLHTefsNGw9h/pCmtY7b
 HhcQgfTyWUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="601960067"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2021 17:42:34 -0800
Date:   Mon, 8 Mar 2021 09:42:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] x86/tsc: mark tsc reliable for qualified platforms
Message-ID: <20210308014234.GA84425@shbuild999.sh.intel.com>
References: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
 <878s7470jw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s7470jw.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:51:31PM +0800, Thomas Gleixner wrote:
> On Tue, Mar 02 2021 at 10:52, Feng Tang wrote:
> > There are cases that tsc clocksource are wrongly judged as unstable by
> > clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> > there is hardly a general reliable way to check the validity of a
> > watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
> >
> > "I'm inclined to lift that requirement when the CPU has:
> >
> >     1) X86_FEATURE_CONSTANT_TSC
> >     2) X86_FEATURE_NONSTOP_TSC
> >     3) X86_FEATURE_NONSTOP_TSC_S3
> >     4) X86_FEATURE_TSC_ADJUST
> >     5) At max. 4 sockets
> >
> >  After two decades of horrors we're finally at a point where TSC seems
> >  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
> >  was really key as we can now detect even small modifications reliably
> >  and the important point is that we can cure them as well (not pretty
> >  but better than all other options)."
> >
> > So implement it with slight change as discussed in the thread, and be
> > more defensive to use maxim of 2 sockets.
> 
> Can you please explain the slight change in the changelog?
 
Sorry for the late response. Just found this mail in my "Junk Mail"
folder with 3 copies, interesting mail sever filters!

I will add 
"As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several
generations of Atom processor, and is always coupled with 
X86_FEATURE_CONSTANT_TSC and X86_FEATURE_NONSTOP_TSC, skip checking
it"
to the commit log.

Thanks,
Feng



> Thanks,
> 
>         tglx
