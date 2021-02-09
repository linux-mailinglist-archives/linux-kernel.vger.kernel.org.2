Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7943151C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBIOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:35:56 -0500
Received: from foss.arm.com ([217.140.110.172]:52578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhBIOe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:34:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7E5101E;
        Tue,  9 Feb 2021 06:33:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B7E3F73D;
        Tue,  9 Feb 2021 06:33:33 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:33:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20210209143328.GA27791@e121166-lin.cambridge.arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
 <20210209115533.GE1435@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209115533.GE1435@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:55:33AM +0000, Catalin Marinas wrote:
> On Mon, Feb 08, 2021 at 04:56:16PM +0000, Vincenzo Frascino wrote:
> > When MTE async mode is enabled TFSR_EL1 contains the accumulative
> > asynchronous tag check faults for EL1 and EL0.
> > 
> > During the suspend/resume operations the firmware might perform some
> > operations that could change the state of the register resulting in
> > a spurious tag check fault report.
> > 
> > Save/restore the state of the TFSR_EL1 register during the
> > suspend/resume operations to prevent this to happen.
> 
> Do we need a similar fix for TFSRE0_EL1? We get away with this if
> suspend is only entered on the idle (kernel) thread but I recall we
> could also enter suspend on behalf of a user process (I may be wrong
> though).

Yes, when we suspend the machine to RAM, we execute suspend on behalf
on a userspace process (but that's only running on 1 cpu, the others
are hotplugged out).

IIUC (and that's an if) TFSRE0_EL1 is checked on kernel entry so I don't
think there is a need to save/restore it (just reset it on suspend
exit).

TFSR_EL1, I don't see a point in saving/restoring it (it is a bit
per-CPU AFAICS) either, IMO we should "check" it on suspend (if it is
possible in that context) and reset it on resume.

I don't think though you can "check" with IRQs disabled so I suspect
that TFSR_EL1 has to be saved/restored (which means that there is a
black out period where we run kernel code without being able to detect
faults but there is no solution to that other than delaying saving the
value to just before calling into PSCI). Likewise on resume from low
power.

Thanks,
Lorenzo

> If that's the case, it would make more sense to store the TFSR* regs in
> the thread_struct alongside sctlr_tcf0. If we did that, we'd not need
> the per-cpu mte_suspend_tfsr_el1 variable.
> 
> -- 
> Catalin
