Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBCE433469
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJSLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED1D61355;
        Tue, 19 Oct 2021 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634641758;
        bh=mn7WNbuKWsMjpIEdlUS0qd7qI41WfZ+Micdfq5umJQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ej2ULvfO2ILqca28DRYu8cQ/dKKsfI+QdEGLiNZ4Jw27jUDRVD3wsDCMmVdWz6XWP
         0wOGgLpKJvnQvQAFD7IgpNEmyrwksGVBeXBK+LDKL3NJqguurreT/hJto0OHPmsRo+
         Bo2G/FRotZ4natJFZmQ3vT/5HiG//rqAgfYszJE63pnBsebiCyyXFNkuMZUfdyjnsJ
         JvwJNojwYqO6vbCgDTWLihXKyKL71wib1mlI9cAVycQvW6QmrviwAEUACPEhzBgFN8
         Gd7K0hnfGMHWQtCr8ZjmFZzepSc0ayLUpk7jXKT6p5S9vqVrUCc4QQVpg44aa5lDP/
         BrQmHY0QRgDOg==
Date:   Tue, 19 Oct 2021 12:09:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
Message-ID: <20211019110912.GF13251@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211011110243.GB4068@willie-the-truck>
 <87mtnfptni.wl-maz@kernel.org>
 <2cf7b564-63c2-ac6c-a083-f7ac2caab6fc@linaro.org>
 <877decotwi.wl-maz@kernel.org>
 <d0c55386-2f7f-a940-45bb-d80ae5e0f378@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c55386-2f7f-a940-45bb-d80ae5e0f378@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:51:19AM +0200, Daniel Lezcano wrote:
> On 17/10/2021 11:57, Marc Zyngier wrote:
> > Hi Daniel,
> > 
> > On Sat, 16 Oct 2021 22:59:33 +0100,
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Marc,
> >>
> >>
> >> On 11/10/2021 15:39, Marc Zyngier wrote:
> >>
> >> [ ... ]
> >>
> >>> Thanks for that. All addressed now. I'll repost the series once we've
> >>> addressed the question below.
> >>>
> >>>> How do you want to merge this series? It would be nice to have the arch
> >>>> bits in the arm64 tree, if possible, as we'll be tripping over the cpucaps
> >>>> stuff otherwise.
> >>>
> >>> I think we should keep the series together, as asm/arch_timer.h gets a
> >>> beating all over the place, and there is no chance the arm64 bits at
> >>> the end can apply (let alone work) on their own.
> >>>
> >>> So either Daniel would ack the series for it to go via arm64, or
> >>> create a stable branch with the first 13 patches that would go in both
> >>> the clocksource and arm64 trees.
> >>>
> >>> Daniel, any preference?
> >>
> >> yes, I prefer a stable branch for this series.
> >>
> >> https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/armv8.6_arch_timer
> >>
> > 
> > OK, this branch is now slightly outdated, since I have reworked it at
> > Will's request. -rc5 is also too recent a base for arm64, which is
> > usually based on -rc3.
> > 
> > I'll repost a new series today or tomorrow and provide tags for both
> > you and Will to pull from.
> 
> Ok, thanks. I've updated the branch accordingly.
> 
> Let me know if everything is fine, so I can prepare a PR for the 'tip' tree.

Thanks, I've pulled that branch into the arm64 tree so please don't rebase
it now.

Will
