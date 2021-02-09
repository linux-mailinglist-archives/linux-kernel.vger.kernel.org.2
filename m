Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76C31551C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhBIR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:29:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233142AbhBIR3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:29:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72D964E9C;
        Tue,  9 Feb 2021 17:28:24 +0000 (UTC)
Date:   Tue, 9 Feb 2021 17:28:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
Message-ID: <20210209172821.GI1435@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
 <20210209115533.GE1435@arm.com>
 <20210209143328.GA27791@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209143328.GA27791@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:33:28PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Feb 09, 2021 at 11:55:33AM +0000, Catalin Marinas wrote:
> > On Mon, Feb 08, 2021 at 04:56:16PM +0000, Vincenzo Frascino wrote:
> > > When MTE async mode is enabled TFSR_EL1 contains the accumulative
> > > asynchronous tag check faults for EL1 and EL0.
> > > 
> > > During the suspend/resume operations the firmware might perform some
> > > operations that could change the state of the register resulting in
> > > a spurious tag check fault report.
> > > 
> > > Save/restore the state of the TFSR_EL1 register during the
> > > suspend/resume operations to prevent this to happen.
> > 
> > Do we need a similar fix for TFSRE0_EL1? We get away with this if
> > suspend is only entered on the idle (kernel) thread but I recall we
> > could also enter suspend on behalf of a user process (I may be wrong
> > though).
> 
> Yes, when we suspend the machine to RAM, we execute suspend on behalf
> on a userspace process (but that's only running on 1 cpu, the others
> are hotplugged out).
> 
> IIUC (and that's an if) TFSRE0_EL1 is checked on kernel entry so I don't
> think there is a need to save/restore it (just reset it on suspend
> exit).

You are right, we don't check TFSRE0_EL1 on return to user, only
clear it, so no need to do anything on suspend/resume.

> TFSR_EL1, I don't see a point in saving/restoring it (it is a bit
> per-CPU AFAICS) either, IMO we should "check" it on suspend (if it is
> possible in that context) and reset it on resume.

I think this should work.

> I don't think though you can "check" with IRQs disabled so I suspect
> that TFSR_EL1 has to be saved/restored (which means that there is a
> black out period where we run kernel code without being able to detect
> faults but there is no solution to that other than delaying saving the
> value to just before calling into PSCI). Likewise on resume from low
> power.

It depends on whether kasan_report can be called with IRQs disabled. I
don't see why not, so if this works I'd rather just call mte_check_async
(or whatever it's called) on the suspend path and zero the register on
resume (mte_suspend_exit). We avoid any saving of the state.

-- 
Catalin
