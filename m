Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D43167F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhBJNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:23:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhBJNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:22:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612963326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJ/FLvZfbmUWb+LKB9yPiOaObzH1yEtwvoqn84DYlnI=;
        b=eO3AAJocFz7hUWdWkbQstm4HNlOwO/MjkW99G5zLU2b3IIfvsQhzApBML0ToHFuS6xgNL/
        uZPG9HZCCiD+q8r5IdyP9+X3+dWknvVaunBpLXeNMC3u3JmGp8KkSCdqFy4NiIQkmsfbcb
        2XTX5GvVTA8USYkqEGRDExmBMPodhhQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C932EAEAB;
        Wed, 10 Feb 2021 13:22:06 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:22:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Sonny Rao <sonnyrao@google.com>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        page-reclaim@google.com
Subject: Re: [page-reclaim] Augmented Page Reclaim
Message-ID: <YCPd/dJiHO8z6e4A@dhcp22.suse.cz>
References: <YBkT6175GmMWBvw3@google.com>
 <CAJmaN=miDwb4CvVDmLS4aBKsNOVp9XiDKB1Dp3s6cfrq4yXiQQ@mail.gmail.com>
 <YCOHZhJKr6DzFQGi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCOHZhJKr6DzFQGi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-02-21 00:12:38, Yu Zhao wrote:
> On Tue, Feb 09, 2021 at 01:32:58PM -0800, Jesse Barnes wrote:
> > > ======================
> > > Augmented Page Reclaim
> > > ======================
> > > We would like to share a work with you and see if there is enough
> > > interest to warrant a run for the mainline. This work is a part of
> > > result from a decade of research and experimentation in memory
> > > overcommit at Google: an augmented page reclaim that, in our
> > > experience, is performant, versatile and, more importantly, simple.
> > 
> > Per discussion on IRC, maybe some additional background would help.
> 
> And I'll add more details to the doc included in the tree once I've
> finished collecting feedback.

Please be as specific as possible early.

> > In looking at browser workloads on Chrome OS, we found that reclaim was:
> > 1) too expensive in terms of CPU usage
> 
> We have two general metrics for this item: CPU time spent on page
> reclaim and (direct) page reclaim latency. CPU usage is important to
> everybody but latency is also quite important for phones, laptops,
> etc.

While this is true in general, more details would be more than welcome.
What is the source of the additional overhead and how does your work
address that?

This applies to most of other areas you are covering here and in the
original cover letter. Especially when you do not plan to build on an
existing code and rather plan to do things considerably differently.

I confess I haven't checked your repository but it would have been much
better to post a patch series
-- 
Michal Hocko
SUSE Labs
