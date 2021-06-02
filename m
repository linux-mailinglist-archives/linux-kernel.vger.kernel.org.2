Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D83985A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhFBJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFBJvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B90E6101B;
        Wed,  2 Jun 2021 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622627367;
        bh=CugNKS2a3ZZprq8U1OraauTxEfAA1k4urBEESTDF1Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWYMsfZJrKTYhD/qmo8nNe/Y9jikdpFvBwhFF9SM0SEeENrtErG7494QRXakockZJ
         ppZGL/kBXn4do/UVvE2JagUUVGhFa5USn0qtXd4bLfkmwRks/e0NGWmnlF7z8fzH8d
         LQ1GFAcP19puxWDsJGG6Y7m+2eTdIc3ClW30eBByFUkflUaXqglQXEhp+Dyfy5GOx0
         kWwh+bZM+o0Dxjn0jdB+NXYH8ZbCY823XIzFG4fsVnd1ItHxiMHRFH5HZ6L8/wAxUw
         oFiBxOOLjWYUvtniTkVdOTgDX+gw5QN/zsbZYmfAv4V+luY9aVPPgbK8jpkT5XrPaS
         ESRK5cCoBXNZg==
Date:   Wed, 2 Jun 2021 10:49:22 +0100
From:   Will Deacon <will@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/9] perf: Add EVENT_ATTR_ID to simplify event
 attributes
Message-ID: <20210602094922.GA30503@willie-the-truck>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
 <1621417919-6632-2-git-send-email-liuqi115@huawei.com>
 <20210601131020.GD28025@willie-the-truck>
 <30abdbec-3174-1f8a-47d4-63a4de3b1e47@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30abdbec-3174-1f8a-47d4-63a4de3b1e47@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:45:23PM +0800, liuqi (BA) wrote:
> 
> Hi Will,
> 
> Thanks for reviewing this patch.
> 
> On 2021/6/1 21:10, Will Deacon wrote:
> > On Wed, May 19, 2021 at 05:51:51PM +0800, Qi Liu wrote:
> > > Similar EVENT_ATTR macros are defined in many PMU drivers,
> > > like HiSilicon PMU driver, Arm PMU driver, Arm SMMU PMU
> > > driver. So Add a generic macro to simplify code.
> > > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > ---
> > >   include/linux/perf_event.h | 6 ++++++
> > >   kernel/events/core.c       | 2 ++
> > >   2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index f5a6a2f..d0aa74e 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -1576,6 +1576,12 @@ static struct perf_pmu_events_attr _var = {				    \
> > >   	.event_str	= _str,						    \
> > >   };
> > > +#define PMU_EVENT_ATTR_ID(_name, _id)					     \
> > > +	(&((struct perf_pmu_events_attr[]) {				     \
> > > +		{ .attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),  \
> > > +		  .id = _id, }						     \
> > > +	})[0].attr.attr)
> > > +
> > >   #define PMU_FORMAT_ATTR(_name, _format)					\
> > >   static ssize_t								\
> > >   _name##_show(struct device *dev,					\
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 0ac818b..330d9cc 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -13295,6 +13295,8 @@ ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> > >   	if (pmu_attr->event_str)
> > >   		return sprintf(page, "%s\n", pmu_attr->event_str);
> > > +	else
> > > +		return sprintf(page, "config=%#llx\n", pmu_attr->id);
> > 
> > I think it's a really bad idea to hardcode this here. For example, I think
> > this patch series breaks user ABI for the SMMU PMU which used to print:
> > 
> > 	"event=0x%02llx\n"
> > 
> > and by the looks of it many of the other conversions are unsound too.
> > 
> Got it, so I'll use pmu_attr->event_str here, for example,
> SMMU_EVENT_ATTR(cycles, "event=0x00")

You could, but honestly I don't really see this being any better than the
current code. The advantage of using "event=0x%02llx\n" is that things are
consistent by construction and therefore userspace can parse the information
easily. We lose that if we just hardcode the string and it's error-prone to
extend.

Will
