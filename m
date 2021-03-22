Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3C344549
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhCVNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:15:50 -0400
Received: from foss.arm.com ([217.140.110.172]:59722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhCVNCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:02:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A531042;
        Mon, 22 Mar 2021 06:02:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607AF3F719;
        Mon, 22 Mar 2021 06:02:20 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:01:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen Jun <chenjun102@huawei.com>,
        Marco Elver <elver@google.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: stacktrace: don't trace arch_stack_walk()
Message-ID: <20210322130158.GA78652@C02TD0UTHF1T.local>
References: <20210319184106.5688-1-mark.rutland@arm.com>
 <20210319190205.GI6832@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319190205.GI6832@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 07:02:06PM +0000, Catalin Marinas wrote:
> On Fri, Mar 19, 2021 at 06:41:06PM +0000, Mark Rutland wrote:
> > We recently converted arm64 to use arch_stack_walk() in commit:
> > 
> >   5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > 
> > The core stacktrace code expects that (when tracing the current task)
> > arch_stack_walk() starts a trace at its caller, and does not include
> > itself in the trace. However, arm64's arch_stack_walk() includes itself,
> > and so traces include one more entry than callers expect. The core
> > stacktrace code which calls arch_stack_walk() tries to skip a number of
> > entries to prevent itself appearing in a trace, and the additional entry
> > prevents skipping one of the core stacktrace functions, leaving this in
> > the trace unexpectedly.
> > 
> > We can fix this by having arm64's arch_stack_walk() begin the trace with
> > its caller. The first value returned by the trace will be
> > __builtin_return_address(0), i.e. the caller of arch_stack_walk(). The
> > first frame record to be unwound will be __builtin_frame_address(1),
> > i.e. the caller's frame record. To prevent surprises, arch_stack_walk()
> > is also marked noinline.

[...]

> > Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chen Jun <chenjun102@huawei.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> 
> Thanks Mark. I think we should add a cc stable, just with Fixes doesn't
> always seem to end up in a stable kernel:
> 
> Cc: <stable@vger.kernel.org> # 5.10.x

Makes sense to me, sure.

> With that:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

Will, I assume you're happy to fold in the above when picking this. If
you'd prefer I repost with that folded in, please let me know!

Mark.
