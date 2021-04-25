Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA836A3DC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhDYBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 21:10:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:48704 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhDYBKa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:10:30 -0400
IronPort-SDR: X82cNlA3EPUudMJPGLTCa03EJQrmm/sYdJzyNdX37sB+NMCGC45jfdCvFIubhK1PQjy5ED84rR
 inCa9pE/NNqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="193018427"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="193018427"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 18:09:51 -0700
IronPort-SDR: 5kKneAmJBud43H5KummpJ77rwSkykSs1NBYOYtDRFiELhjduxaw7sdw0hXL70mal0l6P6aQPq/
 UdBYRbISkSQQ==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428895136"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 18:09:51 -0700
Date:   Sat, 24 Apr 2021 18:09:50 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf vendor events: Add missing model numbers
Message-ID: <20210425010950.GQ1401198@tassilo.jf.intel.com>
References: <20210329070903.8894-1-yao.jin@linux.intel.com>
 <67f05194-0eb4-becd-c8bb-7dc944ac6ca8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f05194-0eb4-becd-c8bb-7dc944ac6ca8@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 10:58:02AM +0800, Jin, Yao wrote:
> Hi Andi, Arnaldo, Jiri,
> 
> Can this patch be accepted?

Looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


> 
> Thanks
> Jin Yao
> 
> On 3/29/2021 3:09 PM, Jin Yao wrote:
> > Kernel has supported COMETLAKE/COMETLAKE_L to use the SKYLAKE
> > events and supported TIGERLAKE_L/TIGERLAKE/ROCKETLAKE to use
> > the ICELAKE events. But pmu-events mapfile.csv is missing
> > these model numbers.
> > 
> > Now add the missing model numbers to mapfile.csv.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/pmu-events/arch/x86/mapfile.csv | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > index 2f2a209e87e1..6455f06f35d3 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -24,6 +24,7 @@ GenuineIntel-6-1F,v2,nehalemep,core
> >   GenuineIntel-6-1A,v2,nehalemep,core
> >   GenuineIntel-6-2E,v2,nehalemex,core
> >   GenuineIntel-6-[4589]E,v24,skylake,core
> > +GenuineIntel-6-A[56],v24,skylake,core
> >   GenuineIntel-6-37,v13,silvermont,core
> >   GenuineIntel-6-4D,v13,silvermont,core
> >   GenuineIntel-6-4C,v13,silvermont,core
> > @@ -35,6 +36,8 @@ GenuineIntel-6-55-[01234],v1,skylakex,core
> >   GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
> >   GenuineIntel-6-7D,v1,icelake,core
> >   GenuineIntel-6-7E,v1,icelake,core
> > +GenuineIntel-6-8[CD],v1,icelake,core
> > +GenuineIntel-6-A7,v1,icelake,core
> >   GenuineIntel-6-86,v1,tremontx,core
> >   AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
> >   AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> > 
