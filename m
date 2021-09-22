Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA5414B83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhIVOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:14:38 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:34933 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233005AbhIVOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:14:35 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 3A659FB462
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:13:03 +0100 (IST)
Received: (qmail 20762 invoked from network); 22 Sep 2021 14:13:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 14:13:03 -0000
Date:   Wed, 22 Sep 2021 15:13:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
Message-ID: <20210922141301.GZ3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210922121620.4716-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210922121620.4716-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:16:20PM +0800, Hillf Danton wrote:
> On Mon, 20 Sep 2021 09:54:32 +0100 Mel Gorman wrote:
> > +static void
> > +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > +							long timeout)
> > +{
> > +	wait_queue_head_t *wqh =3D &pgdat->reclaim_wait;
> > +	unsigned long start =3D jiffies;
> > +	long ret;
> > +	DEFINE_WAIT(wait);
> > +
> > +	atomic_inc(&pgdat->nr_reclaim_throttled);
> > +	WRITE_ONCE(pgdat->nr_reclaim_start,
> > +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> 
> Missing wakeup could happen if the current sleeper overwrites 
> pgdat->nr_reclaim_start set by the existing sleeper.
> 
> 	if (1 == atomic_inc_and_return(&pgdat->nr_reclaim_throttled))
> 		WRITE_ONCE(pgdat->nr_reclaim_start,
> 				node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> 

Good spot, will fix.

-- 
Mel Gorman
SUSE Labs
