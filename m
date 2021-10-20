Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4E4348E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:27:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhJTK1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:27:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53B84ED1;
        Wed, 20 Oct 2021 03:25:26 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29F973F70D;
        Wed, 20 Oct 2021 03:25:23 -0700 (PDT)
Date:   Wed, 20 Oct 2021 11:25:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20211020102521.ag2w3fns5bmgb7zd@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus>
 <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 11:17:18AM +0200, Ulf Hansson wrote:
> On Thu, 14 Oct 2021 at 16:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 12:56:46PM +0200, Ulf Hansson wrote:
> > > On Mon, 17 May 2021 at 18:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> > > > implementations where untrusted software had direct access to clock and
> > > > voltage hardware controls. In this attack, the malicious software was able to
> > > > place the platform into unsafe overclocked or undervolted configurations. Such
> > > > configurations then enabled the injection of predictable faults to reveal
> > > > secrets.
> > > >
> > > > Many Arm-based systems used to or still use voltage regulator and clock
> > > > frameworks in the kernel. These frameworks allow callers to independently
> > > > manipulate frequency and voltage settings. Such implementations can render
> > > > systems susceptible to this form of attack.
> > > >
> > > > Attacks such as CLKSCREW are now being mitigated by not having direct and
> > > > independent control of clock and voltage in the kernel and moving that
> > > > control to a trusted entity, such as the SCP firmware or secure world
> > > > firmware/software which are to perform sanity checking on the requested
> > > > performance levels, thereby preventing any attempted malicious programming.
> > > >
> > > > With the advent of such an abstraction, there is a need to replace the
> > > > generic clock and regulator bindings used by such devices with a generic
> > > > performance domains bindings.
> > > >
> > > > [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> > > >
> > > > Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > Hi Sudeep/Viresh/Rob,
> > >
> > > I noticed this binding recently got accepted, so I guess I have missed
> > > the opportunity to provide you with a few comments.
> > >
> >
> > Sorry for not cc-ing you, wasn't aware of the below mentioned intersection,
> > so assumed you are not one of the interested parties.
> >
> > > In any case, I would like to ask a few questions. In particular, am I
> > > trying to understand why the power-domains bindings [1] can't be used
> > > for this?
> > >
> >
> > One reason I can think of is on some platforms, the power domains are
> > completely controlled by the firmware and not exposed to the OSPM.
> > This is mostly applicable for CPU devices(Platform co-ordinated PSCI)
> 
> See below.
> 
> >
> > > The power-domains are capable of dealing with "performance" through
> > > the "operating-points-v2" DT property, which maps to the generic OPP
> > > bindings [2]. I wonder why that isn't sufficient here? Can you please
> > > elaborate?
> > >
> >
> > Even if the power domains are exposed to the OSPM, the OPPs can be
> > firmware enumerated rather than DT. Not sure if it is possible to
> > represent such systems in the above mentioned bindings. IIUC, the genpd
> > uses clock and regulator apis to drive the performance, but these
> > platforms have f/w interface to drive the OPPs(abstracted).
> 
> Genpd doesn't operate on clock rates or voltage levels. Instead
> "performance" is just an integer value for genpd. What a performance
> index means, is genpd provider specific.
>

Understood.

> In other words, it becomes the responsibility for the genpd provider
> to map a performance state index to an OPP, for example. So far,
> providers have used the generic OPP DT bindings to do this, but for
> sure, we don't have to limit ourselves to this. So, if OPP tables can
> be enumerated by FW, rather than specified in DT, that should
> certainly be possible to support.
>
> BTW, these are genpd provider callbacks, that needs to be implemented
> to let it control performance. Perhaps that helps to understand
> things.
>
> int (*set_performance_state)(struct generic_pm_domain *genpd, unsigned
> int state);
> unsigned int (*opp_to_performance_state)(struct generic_pm_domain
> *genpd, struct dev_pm_opp *opp);
>

Looks like this can be used for devices but what about CPUs ?

> >
> > I am happy to know if there are ways to support such systems with the
> > options you have mentioned above.
>
> As far as I understand, the "performance domains" DT bindings that
> $subject patch introduces, allows us to group devices into domains, to
> let them be "performance controlled" together. Right?
>

Or independently. It doesn't matter.

> Unless I am missing something, it looks like power domains DT bindings
> already offer this for us. Yes, certainly, the DT doc [1] needs an
> updated description to better explain this, but other than that we
> should be fine, don't you think?
>

As I mentioned about, the main question is what if firmware doesn't
want to expose power domain details to OSPM like PC co-ordinated PSCI
idle states while it wants to either group CPUs or leave them as
individual in order to get per-CPU DVFS requests and aggregate them
in the firmware. It does something similar for idle states already.

-- 
Regards,
Sudeep
