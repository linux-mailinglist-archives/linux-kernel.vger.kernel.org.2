Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4006333F15C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCQNnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhCQNms (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C789264F50;
        Wed, 17 Mar 2021 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615988568;
        bh=eRGoOFnf0QuLN9Gx89ZLTWTB/pnKrFlRxdhRkz+hKSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDxsu22qEdn0hLmVobk3G5995xtC1TNi73w+riNbuYyXM42+f91LIZRARePd9Sxj8
         fecMzRYOnnJQPxQh5Kat35NL2VAcVLlS0L1eS2CdwJz+sHDRZZPGLKvRuyJPt6+XiM
         TldBe5xgObTQJ8ZTpkD7p28QroFpMj8TGS3CfZ8/Av/2oGKNn9f0o+CXd+OZU3fAxO
         dGOurPfPsLq+SDj9gwcdE78S1tqqurspoYEgtYDNGH0ShBKe4vmnlRxJo+U4o9lWpI
         9VQV+GxUPzwrddVwnJw/Blfyj9Rgqz+611e7psu2QBM9cZS+1YjO1IL/PmutOqIOH6
         k+HvxbBt6j8yw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 942D040647; Wed, 17 Mar 2021 10:42:45 -0300 (-03)
Date:   Wed, 17 Mar 2021 10:42:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YFIHVQPG3TEeiOpP@kernel.org>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 17, 2021 at 08:17:52PM +0800, Jin, Yao escreveu:
> Hi Jiri,
> 
> On 3/17/2021 6:06 PM, Jiri Olsa wrote:
> > On Wed, Mar 17, 2021 at 10:12:03AM +0800, Jin, Yao wrote:
> > > 
> > > 
> > > On 3/16/2021 10:04 PM, Jiri Olsa wrote:
> > > > On Tue, Mar 16, 2021 at 09:49:42AM +0800, Jin, Yao wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > 
> > > > >    Performance counter stats for 'system wide':
> > > > > 
> > > > >          136,655,302      cpu_core/branch-instructions/
> > > > > 
> > > > >          1.003171561 seconds time elapsed
> > > > > 
> > > > > So we need special rules for both cycles and branches.
> > > > > 
> > > > > The worse thing is, we also need to process the hardware cache events.
> > > > > 
> > > > > # ./perf stat -e cpu_core/LLC-loads/
> > > > > event syntax error: 'cpu_core/LLC-loads/'
> > > > >                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> > > > > 
> > > > > valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
> > > > > 
> > > > > Initial error:
> > > > > event syntax error: 'cpu_core/LLC-loads/'
> > > > >                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> > > > > 
> > > > > If we use special rules for establishing all event mapping, that looks too much. :(
> > > > 
> > > > hmmm but wait, currently we do not support events like this:
> > > > 
> > > >     'cpu/cycles/'
> > > >     'cpu/branches/'
> > > > 
> > > > the pmu style accepts only 'events' or 'format' terms within //
> > > > 
> > > > we made hw events like 'cycles','instructions','branches' special
> > > > to be used without the pmu
> > > > 
> > > > so why do we need to support cpu_code/cycles/ ?

> > > Actually we have to support pmu style event for hybrid platform.

> > > User may want to enable the events from specified pmus and also with flexible grouping.

> > > For example,

> > > perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -e '{cpu_atom/cycles/,cpu_atom/instructions/}'

> > > This usage is common and reasonable. So I think we may need to support pmu style events.

> > sure, but we don't support 'cpu/cycles/' but we support 'cpu/cpu-cycles/'
> > why do you insist on supporting cpu_core/cycles/ ?

> 
> I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But
> what would we do for cache event?
> 
> 'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.
> 
> For hybrid platform, user may only want to enable the LLC-loads on core CPUs
> or on atom CPUs. That's reasonable. While if we don't support the pmu style
> event, how to satisfy this requirement?
> 
> If we can support the pmu style event, we can also use the same way for
> cpu_core/cycles/. At least it's not a bad thing, right? :)

While we're discussing, do we really want to use the "core" and "atom"
terms here? I thought cpu/cycles/ would be ok for the main (Big) CPU and
that we should come up with some short name for the "litle" CPUs.

Won't we have the same situation with ARM where we want to know the
number of cycles spent on a BIG core and also on a little one?

Perhaps 'cycles' should mean all cycles, and then we use 'big/cycles/' and
'little/cycles/'?

- Arnaldo
