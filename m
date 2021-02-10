Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385D431653C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBJLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhBJLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:23:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BpOvzmMGVYD8dl7fG6gpFSbb4HEvbQKLbeXQJY+2Ovs=; b=T3bbhSHkcN63BTsbbV+GfZZJl0
        ldGeybH8MarFeKUtn/cpJjC8nky4HObilQRcdtUFvntnX6ZNiTYHYtKmx3HtUycHXjQ/Dsl+vI6uj
        SaU5tgNESbAyA/Kuvzzg31p0NhkQMhFKK4mrPaSEC8R1oakNWhTF5Ei8ymzd4gFA8sMtWf+Sy2o0R
        dAjE1y5zqxVc5h+Tzu+RFBm+hUSiJUVtkmCL2MApywlaO9aDdIEDZalQwvtSafVRashJooHoSeJh/
        BfeFvlK5KEMXZqHiq3weT8vbYAaKbBSr+ct/UmQG/rJe7ttgXD2a5VRau9bzrWEfa2hMh15gnY66y
        Gy3MOltA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9nZ6-008lfT-2X; Wed, 10 Feb 2021 11:21:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5C42301324;
        Wed, 10 Feb 2021 12:21:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B670203EBF29; Wed, 10 Feb 2021 12:21:44 +0100 (CET)
Date:   Wed, 10 Feb 2021 12:21:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Message-ID: <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
 <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
 <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:58:15PM +0000, Song Bao Hua (Barry Song) wrote:

> > I've finally had a moment to think about this, would it make sense to
> > also break up group: node0+1, such that we then end up with 3 groups of
> > equal size?
> 

> Since the sched_domain[n-1] of a part of node[m]'s siblings are able
> to cover the whole span of sched_domain[n] of node[m], there is no
> necessity to scan over all siblings of node[m], once sched_domain[n]
> of node[m] has been covered, we can stop making more sched_groups. So
> the number of sched_groups is small.
> 
> So historically, the code has never tried to make sched_groups result
> in equal size. And it permits the overlapping of local group and remote
> groups.

Histrorically groups have (typically) always been the same size though.

The reason I did ask is because when you get one large and a bunch of
smaller groups, the load-balancing 'pull' is relatively smaller to the
large groups.

That is, IIRC should_we_balance() ensures only 1 CPU out of the group
continues the load-balancing pass. So if, for example, we have one group
of 4 CPUs and one group of 2 CPUs, then the group of 2 CPUs will pull
1/2 times, while the group of 4 CPUs will pull 1/4 times.

By making sure all groups are of the same level, and thus of equal size,
this doesn't happen.

