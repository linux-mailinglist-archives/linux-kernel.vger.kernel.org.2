Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8A45F04D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353907AbhKZPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353998AbhKZPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:07:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A92C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 06:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C4762299
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 14:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D751C93056;
        Fri, 26 Nov 2021 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637937693;
        bh=UFkWL1t4sncycpVxqqdL4yjI2wz5vOWpmHtnhkS5ft4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=o7PtzE6Bf/Eoa7qNkl4R4yUBUAefevQSCSuG98p/KOq/jgn82/yJjobaadiiCw+gI
         od6DmwBfwzEGEsr4Rrew0NwAf84/F6Ft/+JZXsa1ylwRsmXTVO51D6/VB0GiaqaQmB
         g5K1otDW5qB3q0yg1hOPo42J+j8cJXTItR3ZLOJrAJvS++7OSX2pkjZ6RKTkjAV9Vz
         D8XFqtPLvTRNyphXeFiL6caO7KjHpotqJx6opYcgTBS378WKuT0ZGyrjLGMcLptTg0
         0zAtunIdkJuxS3gnS+2ypjsn6gGiKgVOxTqNdvzgakpkE4Jk3LihebR7v7UFrRfOxJ
         1w9Fx0ug52guQ==
From:   SeongJae Park <sj@kernel.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     akpm@linux-foundation.org, SeongJae Park <sj@kernel.org>,
        john.stultz@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: Fix fake /proc/loadavg reports
Date:   Fri, 26 Nov 2021 14:41:30 +0000
Message-Id: <20211126144130.15460-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <23071693.Kees4NU7H7@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 15:37:12 +0100 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hello.
> 
> On čtvrtek 25. listopadu 2021 17:08:28 CET SeongJae Park wrote:
> > This patchset fixes DAMON's fake load report issue.  The first patch
> > makes yet another variant of usleep_range() for this fix, and the second
> > patch fixes the issue of DAMON by making it using the newly introduced
> > function.
> > 
> > I think these need to be applied on v5.15.y, but the second patch cannot
> > cleanly applied there as is.  I will back-port this on v5.15.y and post
> > later once this is merged in the mainline.  If you think this is not
> > appropriate for stable tree, please let me know.
> > 
> > Changelog
> > ---------
> > 
> > >From v1
> > 
> > (https://lore.kernel.org/linux-mm/20211124145219.32866-1-sj@kernel.org/)
> > - Avoid copy-and-pasting usleep_delay() in DAMON code (Andrew Morton)
> > 
> > SeongJae Park (2):
> >   timers: Implement usleep_idle_range()
> >   mm/damon/core: Fix fake load reports due to uninterruptible sleeps
> > 
> >  include/linux/delay.h | 14 +++++++++++++-
> >  kernel/time/timer.c   | 16 +++++++++-------
> >  mm/damon/core.c       |  6 +++---
> >  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> I'd appreciate if you Cc me as a reporter since I'm going to test this.

Oops, sorry for forgetting that.  I also forgot adding 'Suggested-by:' for
Andrew Morton on the first patch.  I will do that and resend, Cc-ing you.

> 
> Thanks.
> 
> -- 
> Oleksandr Natalenko (post-factum)
> 
