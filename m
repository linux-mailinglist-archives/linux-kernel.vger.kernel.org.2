Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E8436661
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJUPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:38:04 -0400
Received: from foss.arm.com ([217.140.110.172]:44384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:38:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEDDD6E;
        Thu, 21 Oct 2021 08:35:46 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56E773F694;
        Thu, 21 Oct 2021 08:35:45 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:35:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20211021153542.qdklpwqiz4ujx6zy@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus>
 <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <20211020102521.ag2w3fns5bmgb7zd@bogus>
 <CAPDyKFrunb7sjhZnWVDPRYD_p0Dqr+NZyzX-OUrE00nCa2PmNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrunb7sjhZnWVDPRYD_p0Dqr+NZyzX-OUrE00nCa2PmNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:34:17PM +0200, Ulf Hansson wrote:
> On Wed, 20 Oct 2021 at 12:25, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> >
> > Looks like this can be used for devices but what about CPUs ?
>
> Yes, that should work. dev_pm_genpd_set_performance_state() takes a
> struct device* as an in-parameter.
>
> The struct device to use would typically be the one that you receive
> from dev_pm_domain_attach_by_name(). We already do this for some other
> cpufreq drivers, so this works fine.
>

I totally understand this is possible but the question is: is it really
necessary ?

> >
> > > >
> > > > I am happy to know if there are ways to support such systems with the
> > > > options you have mentioned above.
> > >
> > > As far as I understand, the "performance domains" DT bindings that
> > > $subject patch introduces, allows us to group devices into domains, to
> > > let them be "performance controlled" together. Right?
> > >
> >
> > Or independently. It doesn't matter.
> >
> > > Unless I am missing something, it looks like power domains DT bindings
> > > already offer this for us. Yes, certainly, the DT doc [1] needs an
> > > updated description to better explain this, but other than that we
> > > should be fine, don't you think?
> > >
> >
> > As I mentioned about, the main question is what if firmware doesn't
> > want to expose power domain details to OSPM like PC co-ordinated PSCI
> > idle states while it wants to either group CPUs or leave them as
> > individual in order to get per-CPU DVFS requests and aggregate them
> > in the firmware. It does something similar for idle states already.
> 
> Yes, that can be modeled too.
> 
> Just let each CPU node point to its own separate power-domain and also
> *don't* model the parent power-domain, instead leave this to be
> managed by the FW.
>

Why ? IMO it is unnecessary indirection and useless as we don't need the
genpd created for these for no useful reasons. All we need is to get the
domain id for the device and request the firmware passing that id to set
the performance. Creating a psuedo power domain with no power domain
info except the performance domain id and then creating genpd domains
for the same just because we can is something I am failing to understand
here. I agree if the CPU domains were real(as in what f/w or h/w represents),
then may be, again I really don't like them disconnected from real CPU
power domains just because perf and power are not 1:1. Creating one set
of genpd for power and another for performance is also not okay IMO for
reasons stated above.

-- 
Regards,
Sudeep
