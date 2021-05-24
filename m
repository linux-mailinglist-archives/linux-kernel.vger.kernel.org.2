Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9560E38E524
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhEXLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:15:23 -0400
Received: from foss.arm.com ([217.140.110.172]:41108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232625AbhEXLPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:15:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C05331B;
        Mon, 24 May 2021 04:13:51 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C14E3F719;
        Mon, 24 May 2021 04:13:49 -0700 (PDT)
Date:   Mon, 24 May 2021 12:13:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: don't use CON and BLK mapping if KFENCE is
 enabled
Message-ID: <20210524111346.GE1040@C02TD0UTHF1T.local>
References: <20210524153659.58a707a9@xhacker.debian>
 <20210524103740.GD1040@C02TD0UTHF1T.local>
 <CANpmjNM5tgDDO_baxi2s8p9FQTr564sMHF8LKEYt=TKk2xTgOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM5tgDDO_baxi2s8p9FQTr564sMHF8LKEYt=TKk2xTgOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 12:43:56PM +0200, Marco Elver wrote:
> On Mon, 24 May 2021 at 12:37, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, May 24, 2021 at 03:36:59PM +0800, Jisheng Zhang wrote:
> > > Fix below warning if KFENCE=y but RODATA_FULL=n:
> > >
> > > [    0.000000] ------------[ cut here ]------------
> > > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/memory.c:2462 apply_to_pmd_range+0xec/0x190
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc1+ #10
> > > [    0.000000] Hardware name: linux,dummy-virt (DT)
> > > [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> > > [    0.000000] pc : apply_to_pmd_range+0xec/0x190
> > > [    0.000000] lr : __apply_to_page_range+0x94/0x170
> > > [    0.000000] sp : ffffffc010573e20
> > > [    0.000000] x29: ffffffc010573e20 x28: ffffff801f400000 x27: ffffff801f401000
> > > [    0.000000] x26: 0000000000000001 x25: ffffff801f400fff x24: ffffffc010573f28
> > > [    0.000000] x23: ffffffc01002b710 x22: ffffffc0105fa450 x21: ffffffc010573ee4
> > > [    0.000000] x20: ffffff801fffb7d0 x19: ffffff801f401000 x18: 00000000fffffffe
> > > [    0.000000] x17: 000000000000003f x16: 000000000000000a x15: ffffffc01060b940
> > > [    0.000000] x14: 0000000000000000 x13: 0098968000000000 x12: 0000000098968000
> > > [    0.000000] x11: 0000000000000000 x10: 0000000098968000 x9 : 0000000000000001
> > > [    0.000000] x8 : 0000000000000000 x7 : ffffffc010573ee4 x6 : 0000000000000001
> > > [    0.000000] x5 : ffffffc010573f28 x4 : ffffffc01002b710 x3 : 0000000040000000
> > > [    0.000000] x2 : ffffff801f5fffff x1 : 0000000000000001 x0 : 007800005f400705
> > > [    0.000000] Call trace:
> > > [    0.000000]  apply_to_pmd_range+0xec/0x190
> > > [    0.000000]  __apply_to_page_range+0x94/0x170
> > > [    0.000000]  apply_to_page_range+0x10/0x20
> > > [    0.000000]  __change_memory_common+0x50/0xdc
> > > [    0.000000]  set_memory_valid+0x30/0x40
> > > [    0.000000]  kfence_init_pool+0x9c/0x16c
> > > [    0.000000]  kfence_init+0x20/0x98
> > > [    0.000000]  start_kernel+0x284/0x3f8
> > >
> > > Fixes: 840b23986344 ("arm64, kfence: enable KFENCE for ARM64")
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >
> > It would be good if the commit message could explain the problem more
> > thoroughly, e.g.
> >
> > | When we added KFENCE support for arm64, we intended that it would
> > | force the entire linear map to be mapped at page granularity, but we
> > | only enforced this in arch_add_memory() and not in map_mem(), so
> > | memory mapped at boot time can be mapped at a larger granularity.
> > |
> > | When booting a kernel with KFENCE=y and RODATA_FULL=n, this results in
> > | the following WARNING at boot:
> > |
> > | < warning here >
> >
> > With that:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> We also need "Cc: stable@vger.kernel.org", right?

That would be a good idea, yes. I can't recall whether "Fixes" alone is
intended to be sufficient or not to trigger a backport.

Mark.

> Acked-by: Marco Elver <elver@google.com>
> 
> Thank you both!
> 
> -- Marco
