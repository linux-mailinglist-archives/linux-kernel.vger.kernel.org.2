Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93AF319FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBLN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhBLN24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:28:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB7D64E35;
        Fri, 12 Feb 2021 13:28:10 +0000 (UTC)
Date:   Fri, 12 Feb 2021 13:28:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steven Price <steven.price@arm.com>, sonicadvance1@gmail.com,
        amanieu@gmail.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Message-ID: <20210212132807.GC7718@arm.com>
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
 <20210212123515.GC6057@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212123515.GC6057@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:35:15PM +0000, Mark Brown wrote:
> On Fri, Feb 12, 2021 at 11:30:41AM +0000, Steven Price wrote:
> > On 11/02/2021 20:21, sonicadvance1@gmail.com wrote:
> > > Why do we need compatibility layers?
> > > There are ARMv8 CPUs that only support AArch64 but still need to run
> > > AArch32 applications.
> > > Cortex-A34/R82 and other cores are prime examples of this.
> > > Additionally if a user is needing to run legacy 32-bit x86 software, it
> > > needs the same compatibility layer.
> 
> > Unless I'm much mistaken QEMU's user mode already does this - admittedly I
> > don't tend to run "legacy 32-bit x86 software".
> 
> Yes, this has been deployed on Debian for a long time - you can install
> any combination of Debian architectures on a single system and it will
> use qemu to run binaries that can't be supported natively by the
> hardware.

The only downside I think is that for some syscalls it's not that
efficient. Those using struct iovec come to mind, qemu probably
duplicates the user structures, having to copy them in both directions
(well, the kernel compat layer does something similar).

Anyway, I'm not in favour of this patch. Those binary translation tools
need to explore the user-only options first and come up with some perf
numbers to justify the proposal.

-- 
Catalin
