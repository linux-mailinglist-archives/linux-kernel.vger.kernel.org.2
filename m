Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AC391932
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhEZNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:51:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233722AbhEZNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D3D168F;
        Wed, 26 May 2021 06:49:28 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEA273F73D;
        Wed, 26 May 2021 06:49:26 -0700 (PDT)
Date:   Wed, 26 May 2021 14:49:22 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526134921.GA414265@e120877-lin.cambridge.arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
 <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:08:07PM +0530, Viresh Kumar wrote:
> On 26-05-21, 10:01, Vincent Donnefort wrote:
> > I originally considered to add the inefficient knowledge into the CPUFreq table.
> 
> I wasn't talking about the cpufreq table here in the beginning, but calling
> dev_pm_opp_disable(), which will eventually reflect in cpufreq table as well.
> 
> > But I then gave up the idea for two reasons:
> > 
> >   * The EM depends on having schedutil enabled. I don't think that any
> >     other governor would then manage to rely on the inefficient OPPs. (also I
> >     believe Peter had a plan to keep schedutil as the one and only governor)
> 
> Right, that EM is only there for schedutil.
> 
> I would encourage if this can be done even without the EM dependency, if
> possible. It would be a good thing to do generally for any driver that wants to
> do that.
> 
> >   * The CPUfreq driver doesn't have to rely on the CPUfreq table, if the
> >     knowledge about inefficient OPPs is into the latter, some drivers might not
> >     be able to rely on the feature (you might say 'their loss' though :)) 
> > 
> > For those reasons, I thought that adding inefficient support into the
> > CPUfreq table would complexify a lot the patchset for no functional gain. 
> 
> What about disabling the OPP in the OPP core itself ? So every user will get the
> same picture.
> 
> > > 
> > > Since the whole thing depends on EM and OPPs, I think we can actually do this.
> > > 
> > > When the cpufreq driver registers with the EM core, lets find all the
> > > Inefficient OPPs and disable them once and for all. Of course, this must be done
> > > on voluntarily basis, a flag from the drivers will do. With this, we won't be
> > > required to update any thing at any of the governors end.
> > 
> > We still need to keep the inefficient OPPs for thermal reason.
> 
> How will that benefit us if that OPP is never going to run anyway ? We won't be
> cooling down the CPU then, isn't it ?

It would give more freedom for the cooling framework to pick a lower frequency
to mitigate the current temperature even if we know this isn't, energy
efficient.

As an example, on the Pixel4's SD855, the first 6 OPPs are inefficients on one
of the cluster. If we hide those from the cooling framework, we'll prevent
cooling for a quite wide range of frequencies.

That'd be however much more intrusive to support into cpufreq than just
preventing the OPPs to be registered.

> 
> > But if we go with
> > the inefficiency support into the CPUfreq table, we could enable or disable
> > them, depending on the thermal pressure. Or add a flag to read the table with or
> > without inefficient OPPs?
> 
> Yeah, I was looking for a cpufreq driver flag or something like that so OPPs
> don't disappear magically for some platforms which don't want it to happen.
> 
> Moreover, a cpufreq driver first creates the OPP table, then registers with EM
> or thermal. If we can play with that sequence a bit and make sure inefficient
> OPPs are disabled before thermal or cpufreq tables are created, we will be good.
> 
> -- 
> viresh
