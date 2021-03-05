Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF5432F130
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCER3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCER3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:29:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B20F65020;
        Fri,  5 Mar 2021 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614965386;
        bh=4r34DUYNpOJvEcVPpR+6wZnWvRIaTcgeWMWyB2GA44o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW+QDqfeuEhA66S19otS9K3dumS+X+QQXoylVq+1tB5Hr6UOR3tNkKMaBLbF76OXz
         MJySLIfflBFYFWokdbzwT2jgnwg9jiZmya8gQuNBfXVynLDZq+YTFTlu2yd/UKSgsV
         UoCeqTwAXlJf2/o7dP8RMh0T9QE9WBoSzI1/FPcfQZqOX+jNqXqpes2IrWDsqBy5I6
         ipUNqYgg0hmEA2diUjQG4odPCKiH6kd3eY4nGFdYcuau5JVaTWDcmMx7k+CGCPEH5V
         BXonDpAkbH9JuSKGDvzsJEaJnE6Ky4DGqmZLpWdVRyM80vxuUZrat6lS1yeCULmdj9
         KlaaM0sfG22Hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AC4040647; Fri,  5 Mar 2021 14:29:44 -0300 (-03)
Date:   Fri, 5 Mar 2021 14:29:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] perf cs-etm: Fix bitmap for option
Message-ID: <YEJqiNkIsNWS0E2G@kernel.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-5-leo.yan@linaro.org>
 <20210208204641.GE2077938@xps15>
 <20210209015855.GA54680@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209015855.GA54680@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 09, 2021 at 09:58:55AM +0800, Leo Yan escreveu:
> On Mon, Feb 08, 2021 at 01:46:41PM -0700, Mathieu Poirier wrote:
> > On Sat, Feb 06, 2021 at 11:08:29PM +0800, Leo Yan wrote:
> > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > When set option with macros ETM_OPT_CTXTID and ETM_OPT_TS, it wrongly
> > > takes these two values (14 and 28 prespectively) as bit masks, but
> > > actually both are the offset for bits.  But this doesn't lead to
> > > further failure due to the AND logic operation will be always true for
> > > ETM_OPT_CTXTID / ETM_OPT_TS.
> > > 
> > > This patch defines new independent macros (rather than using the
> > > "config" bits) for requesting the "contextid" and "timestamp" for
> > > cs_etm_set_option().
> > > 
> > > [leoy: Extract the change as a separate patch for easier review]
> > 
> > This should go just above your name - see below.

I fixed this up and added this patch to my perf/urgent branch, for
v5.12, since the kernel bits are upstream and this is a fix.

Looking at the other patches in the series.

- Arnaldo
 
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > 
> >  Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >  [Extract the change as a separate patch for easier review]
> >  Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >  Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > 
> > > ---
> > >  tools/perf/arch/arm/util/cs-etm.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > > index bd446aba64f7..c25c878fd06c 100644
> > > --- a/tools/perf/arch/arm/util/cs-etm.c
> > > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > > @@ -156,6 +156,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> > >  	return err;
> > >  }
> > >  
> > > +#define ETM_SET_OPT_CTXTID	(1 << 0)
> > > +#define ETM_SET_OPT_TS		(1 << 1)
> > > +#define ETM_SET_OPT_MASK	(ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
> > > +
> > 
> > I would much rather see this fixed with the BIT() macro as it is done in the
> > rest of this set than defining new constant.
> > 
> > With the above:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > I have picked up the kernel portion of this set.  I suggest you fix the above
> > and send another revision to Arnaldo with my RBs.
> 
> Will do this.  Thanks for suggestion, Mathieu.
> 
> Leo
> 
> [...]

-- 

- Arnaldo
