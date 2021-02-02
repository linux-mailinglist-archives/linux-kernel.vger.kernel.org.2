Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2B30CB82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhBBT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:27:00 -0500
Received: from foss.arm.com ([217.140.110.172]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239708AbhBBTY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:24:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3A8ED1;
        Tue,  2 Feb 2021 11:23:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AA23F73B;
        Tue,  2 Feb 2021 11:23:34 -0800 (PST)
Date:   Tue, 2 Feb 2021 19:23:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     sonicadvance1@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Matteo Croce <mcroce@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] arm64: Exposes support for 32bit syscalls
Message-ID: <20210202192331.GF67187@C02TD0UTHF1T.local>
References: <20210202165437.334515-1-Sonicadvance1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202165437.334515-1-Sonicadvance1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 02, 2021 at 08:54:23AM -0800, sonicadvance1@gmail.com wrote:
> From: Ryan Houdek <Sonicadvance1@gmail.com>
> 
> This is a continuation of https://lkml.org/lkml/2021/1/6/47
> This patch is currently based against a 5.10 kernel but rebasing against
> latest HEAD is trivial
> 
> Specifically Amanieu pointed out a couple of problem spaces that would
> show up around memory management and various other bits.
> 
> This convinced me that the previous path of only having an ioctl32
> syscall is only a bandage on a much larger problem.
> 
> This takes a patch from the Tango support tree and modifies it a bit to
> not rely on a Tango specific quirk.
> 
> Original patch:
> https://github.com/Amanieu/linux/commit/b4783002afb027ae702da8f56e43e45c7332d226

Please reconsider the presentation of this commit message, because as it
stands it's practically unreviewable, and for the vast majority of
people CC'd this is noise.

You need to write this such that someone can read this from start to
finish and understand each step without jumping back-and-forth, without
the reader having to read external links. Introduce the big picture
first (what problem are you trying to solve? Who does this matter to?),
then context (There's a constraint ..., someone previously tried this
but there was a specific problem ...), then give an overview and
justification for the code, with any caveats that reviewers may need to
take into account.

As-is, this commit message doesn't follow that flow, and that places a
burden on reviewers to expend significant effort to reverse-engineer and
extract the information they need.

You'll find it's much easier to make progress if you optimize for the
reviewers. Please look at the general way commits in the Linux source
tree are written, and try to follow that approach.

> This patch changes the KSTK_EIP and KSTK_ESP helpers to only fall to
> Tango specific behaviour once a "Tango" syscall has been invoked.

At this point the reader has no idea what a "Tango" syscall is, nor why
this should affect KSTK_EIP or KSTK_ESP.

What is a "Tango" syscall?

Who is this useful for?

Why does this matter to the upstream kernel?

> I'm working on a backwards compatibility project that is unrelated to
> Tango, but it would be nice to have a solution that works for both of
> us. Since we are both working on projects that run 32bit applications
> inside of a 64bit process for compatibility purposes.

Only here do reviewers discover this something to do with running 32-bit
applications somehow, when really that should be in the first couple of
sentences.

Generally, I have significant misgivings about exposing a new syscall
interface (or exposing an existing interface to different callers). It's
a maintainability nightmare, and since it's liable to violate implicit
assumptions made in syscall implementations there's huge scope for error
including bugs and exploitable behaviour.

So without significant justification, my view is to NAK this sort of
change.

Thanks,
Mark.
