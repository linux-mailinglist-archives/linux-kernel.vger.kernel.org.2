Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899C36D84C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhD1N32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:29:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhD1N31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:29:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234971FB;
        Wed, 28 Apr 2021 06:28:42 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABB43F694;
        Wed, 28 Apr 2021 06:28:40 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:28:32 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <20210428132812.GA71893@e120877-lin.cambridge.arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
 <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
 <YHhZrbLcUD6I83m1@google.com>
 <cc9d7743-7795-a9c9-c1fb-4162cb02bfe2@arm.com>
 <YHhfCr+7KztYpIkD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHhfCr+7KztYpIkD@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:43:06PM +0000, Quentin Perret wrote:
> On Thursday 15 Apr 2021 at 16:32:31 (+0100), Lukasz Luba wrote:
> > Are you sure that the 'policy' can be accessed from compute_energy()?
> > It can be from schedutil freq switch path, but I'm not use about our
> > feec()..
> 
> Right, I was just looking at cpufreq_cpu_get() and we'll have locking
> issue in the wake-up path :/ So maybe making feec() aware of policy caps
> is for later ...
> 
> > For me this cpufreq_driver_resolve_freq sounds a bit out of this patch
> > subject.
> 
> Not sure I agree -- if we're going to index the EM table from schedutil
> it should be integrated nicely if possible.
> 
> Thanks

I'm having a look at this topic right now and I don't think we can skip
cpufreq_driver_resolve_freq() in the end, for two reasons:

1. It is possible to register OPPs (and by extension perf_states) for a
frequency for which, the cpufreq table entry is marked with
CPUFREQ_ENTRY_INVALID. It would probably be an issue that would have to be
fixed in the driver, but it is currently allowed.

2. More importantly, while resolving the frequency, we also cache the index in
cached_resolved_idx. Some drivers, such as qcom-cpufreq-hw rely on this
value for their fastswitch support.

-- 
Vincent
