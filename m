Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BF42662D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhJHIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJHIrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3BE661056;
        Fri,  8 Oct 2021 08:45:21 +0000 (UTC)
Date:   Fri, 8 Oct 2021 09:45:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, ping.zhou1@unisoc.com
Subject: Re: [RFC PATCH] arch: ARM64: add isb before enable pan
Message-ID: <YWAFHgUseH2t/FUf@arm.com>
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
 <20211008080113.GA441@willie-the-truck>
 <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 04:34:12PM +0800, Zhaoyang Huang wrote:
> On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > > test, which can be work around by a msleep on the sw context. We assume
> > > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> > >
> > > PS:
> > > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > > alike racing between on chip PAN and SW_PAN.
> >
> > Sorry, but I'm struggling to understand the problem here. Please could you
> > explain it in more detail?
> >
> >   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
> >   - Can you explain the race that you think might be occurring?
> >   - Why does an ISB prevent the race?
> Please find panic logs[1], related codes[2], sample of debug patch[3]
> below. TTBR1_EL1 equals 0x34000000 when panic and can NOT be captured
> by the debug patch during retest (all entrances that msr ttbr1_el1 are
> under watch) which should work. Adding ISB here to prevent race on
> TTBR1 from previous access of sysregs which can affect the msr
> result(the test is still ongoing). Could the race be
> ARM64_HAS_PAN(automated by core) and SW_PAN.

Can you please change the ARM64_HAS_PAN type to
ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE? I wonder whether
system_uses_ttbr0_pan() changes its output when all CPUs had been
brought up and system_uses_hw_pan() returns true.

-- 
Catalin
