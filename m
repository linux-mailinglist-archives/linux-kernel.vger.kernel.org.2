Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1430E4F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhBCVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBCVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:31:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CC6664F5F;
        Wed,  3 Feb 2021 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612387830;
        bh=ughN8dAb3jSbnOcn3XKGqXhBiohiE3nh5PIQssjXcxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDg3hGR8shyzGOOWEyCfKwRE2Womzt4D20K1qlKOAuAOWxU9+DwRfvvEnpkpkuIcM
         dH/a22TdRQtWG7yvNtYNoFbav1dqjcJn6DvUGTvpYb4pXr/+Swum3G2XSElfK4KJbf
         hcS8/voqLbp5+1WD+2rBFrzNDMJIJfW52aSodq2orV27zyI55sQ2Wk1tQ0YySajRfe
         jSeHD4gWLRCOVPqN3yJLJt2Q9eNAIKmrYM+Fa6KSKFb6vUUcKAgqVZz+Tn5XI9Vx5v
         lMBDys9JL8pkQX3Ssv24HrbkV2NAzeg+iKzFyQ0jToLH+zW6ocyi4V7x6jtHoiNCg2
         7wKkMqllzaFCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84EEA40513; Wed,  3 Feb 2021 18:30:28 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:30:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
Message-ID: <20210203213028.GY854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
 <20210203200256.GH854763@kernel.org>
 <b56933e7-0454-c2ac-9bac-c9890dcc60d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56933e7-0454-c2ac-9bac-c9890dcc60d4@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 04:20:38PM -0500, Liang, Kan escreveu:
> 
> 
> On 2/3/2021 3:02 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Feb 02, 2021 at 12:09:06PM -0800,kan.liang@linux.intel.com  escreveu:
> > > From: Kan Liang<kan.liang@linux.intel.com>
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index c26ea822..c48f6de 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2689,6 +2689,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> > >   		if (perf_missing_features.aux_output)
> > >   			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> > >   		break;
> > > +	case ENODATA:
> > > +		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> > > +				 "Please add an auxiliary event in front of the load latency event.");
> > Are you sure this is the only case where ENODATA comes out from
> > perf_event_open()? Well, according to your comment in:
> > 
> >    61b985e3e775a3a7 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")
> > 
> > It should be at that point in time, so its safe to merge as-is, but then
> > I think this is fragile, what if someone else, in the future, not
> > knowing that ENODATA is supposed to be used only with that ancient CPU,
> > Sapphire Rapids, uses it?:-)
> > 
> > Please consider adding a check before assuming ENODATA is for this
> > specific case.
> 
> Sure, I will add a check in V2.

Do it as a separate patch, on top of what is now in tmp.perf/core.

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core

- Arnaldo
