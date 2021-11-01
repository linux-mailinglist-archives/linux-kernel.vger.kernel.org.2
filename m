Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285294415B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhKAI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:59:13 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:58977 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231663AbhKAI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:59:10 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 1A1D027ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:56:35 +0000 (GMT)
Received: (qmail 19541 invoked from network); 1 Nov 2021 08:56:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Nov 2021 08:56:34 -0000
Date:   Mon, 1 Nov 2021 08:56:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <20211101085633.GW3959@techsingularity.net>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
 <20211028094834.1312-2-mgorman@techsingularity.net>
 <CAKfTPtB-fJ7Pd6eYPDrHB8Ts0o7SCbN7nniAD9PSoF4Pf+xB3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtB-fJ7Pd6eYPDrHB8Ts0o7SCbN7nniAD9PSoF4Pf+xB3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:17:38PM +0200, Vincent Guittot wrote:
> > index ff69f245b939..d00af3b97d8f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct *p)
> >         }
> >
> >         if (current->last_wakee != p) {
> > +               int min = __this_cpu_read(sd_llc_size) << 1;
> > +               /*
> > +                * Couple the wakee flips to the waker for the case where it
> > +                * doesn't accrue flips, taking care to not push the wakee
> > +                * high enough that the wake_wide() heuristic fails.
> > +                */
> > +               if (current->wakee_flips > p->wakee_flips * min)
> > +                       p->wakee_flips++;
> 
> I have a hard time understanding the rationale behind these changes
> and the one below. Could you provide more details about why to
> increase p->wakee_flips here ? Also would be good to add such
> explanation in the commit message


The changelog covers it in the first two paragraphs but would the
following be better as a comment?

/*
 * Couple the wakee flips to the waker for the case where the
 * wakee doesn't accrue any flips during a short interval where
 * there are many wakeups without cpu load average being updated.
 * Otherwise, it is possible for wake_wide to not trigger followed
 * by an affine wake stacking multiple tasks on the same CPU due
 * to a stale cpu_load() value checked in wake_affine_weight.
 * This heuristic reduces excessive stacking of tasks while taking
 * care to not push the wakee high enough that the wake_wide
 * heuristic fails differently.
 */

Is that any better? I know this is a heuristic that is a bit on the
fuzzy side as it's trying to clamp the worst of a corner case. Ideally
"wake_wide" would be replaced with a more straight-forward heuristic but
I'm not aware of any alternatives being proposed (and I don't have one
of my own).

-- 
Mel Gorman
SUSE Labs
