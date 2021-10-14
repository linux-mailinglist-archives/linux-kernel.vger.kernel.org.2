Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79042DC60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhJNO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:58:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhJNO6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:58:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4F3311D4;
        Thu, 14 Oct 2021 07:55:59 -0700 (PDT)
Received: from bogus (e124108.cambridge.arm.com [10.1.27.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0B813F694;
        Thu, 14 Oct 2021 07:55:57 -0700 (PDT)
Date:   Thu, 14 Oct 2021 15:55:55 +0100
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
Message-ID: <20211014145555.uoi2hyoonrptrd5m@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:56:46PM +0200, Ulf Hansson wrote:
> On Mon, 17 May 2021 at 18:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> > implementations where untrusted software had direct access to clock and
> > voltage hardware controls. In this attack, the malicious software was able to
> > place the platform into unsafe overclocked or undervolted configurations. Such
> > configurations then enabled the injection of predictable faults to reveal
> > secrets.
> >
> > Many Arm-based systems used to or still use voltage regulator and clock
> > frameworks in the kernel. These frameworks allow callers to independently
> > manipulate frequency and voltage settings. Such implementations can render
> > systems susceptible to this form of attack.
> >
> > Attacks such as CLKSCREW are now being mitigated by not having direct and
> > independent control of clock and voltage in the kernel and moving that
> > control to a trusted entity, such as the SCP firmware or secure world
> > firmware/software which are to perform sanity checking on the requested
> > performance levels, thereby preventing any attempted malicious programming.
> >
> > With the advent of such an abstraction, there is a need to replace the
> > generic clock and regulator bindings used by such devices with a generic
> > performance domains bindings.
> >
> > [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> >
> > Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Hi Sudeep/Viresh/Rob,
>
> I noticed this binding recently got accepted, so I guess I have missed
> the opportunity to provide you with a few comments.
>

Sorry for not cc-ing you, wasn't aware of the below mentioned intersection,
so assumed you are not one of the interested parties.

> In any case, I would like to ask a few questions. In particular, am I
> trying to understand why the power-domains bindings [1] can't be used
> for this?
>

One reason I can think of is on some platforms, the power domains are
completely controlled by the firmware and not exposed to the OSPM.
This is mostly applicable for CPU devices(Platform co-ordinated PSCI)

> The power-domains are capable of dealing with "performance" through
> the "operating-points-v2" DT property, which maps to the generic OPP
> bindings [2]. I wonder why that isn't sufficient here? Can you please
> elaborate?
>

Even if the power domains are exposed to the OSPM, the OPPs can be
firmware enumerated rather than DT. Not sure if it is possible to
represent such systems in the above mentioned bindings. IIUC, the genpd
uses clock and regulator apis to drive the performance, but these
platforms have f/w interface to drive the OPPs(abstracted).

I am happy to know if there are ways to support such systems with the
options you have mentioned above.

--
Regards,
Sudeep
