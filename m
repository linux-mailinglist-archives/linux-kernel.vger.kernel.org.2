Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7545B875
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbhKXKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:39:06 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:40121 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233492AbhKXKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:39:04 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 1324CBB09B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:35:53 +0000 (GMT)
Received: (qmail 16955 invoked from network); 24 Nov 2021 10:35:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 10:35:52 -0000
Date:   Wed, 24 Nov 2021 10:35:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, neilb@suse.de, akpm@linux-foundation.org,
        corbet@lwn.net, riel@surriel.com, hannes@cmpxchg.org,
        david@fromorbit.com, willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM
 conditions
Message-ID: <20211124103550.GE3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211124011954.7cab9bb4@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 01:19:54AM +0900, Alexey Avramov wrote:
> I found stalls in near-OOM conditions with Linux 5.16. This is not the
> hang-up that was reported by Artem S. Tashkinov in 2019 [1]. It's a *new* 
> regression. I will demonstrate this with one simple experiment, which I
> will reproduce with different kernels or settings.
> 
> With older versions of the kernel, running the `tail /dev/zero` command
> usually quickly leads to OOM condition.
> 
> I will run the command `for i in {1...3}; do tail /dev/zero; done` and log
> PSI metrics (using psi2log script from nohang v0.2.0 [2]) and some values
> from `/proc/meminfo` (using mem2log v0.1.0 [3]) while this command is
> running. During the experiment a single tab browser will be kept opened in
> which some video will be playing.
> 

Ok, I can reproduce this. However, it does eventually get killed OOM so
the system makes progress but maybe the throttling should be for very
short intervals if failing to make progress and there have been multiple
reclaim failures recently. Disabling the throttling entirely just results
in cases where 100% CPU is used spinning through lru lists.

Thanks for the report

-- 
Mel Gorman
SUSE Labs
