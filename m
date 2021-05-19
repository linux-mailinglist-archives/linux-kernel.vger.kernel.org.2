Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F590388CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbhESLZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:25:02 -0400
Received: from foss.arm.com ([217.140.110.172]:60902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350438AbhESLYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:24:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BFB4101E;
        Wed, 19 May 2021 04:23:30 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0133F719;
        Wed, 19 May 2021 04:23:28 -0700 (PDT)
Date:   Wed, 19 May 2021 12:23:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210519112308.umxriuv75onuwvmc@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAL_JsqK6B40D8dRu8KoOsx6eSzRXx6KsSEu5mjDokPEAy+p4oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK6B40D8dRu8KoOsx6eSzRXx6KsSEu5mjDokPEAy+p4oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:17:05PM -0500, Rob Herring wrote:
> On Mon, May 17, 2021 at 10:55 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Viresh,

I noticed I haven't cc-ed linux-pm list, do you need me to post there or
are you happy to pick it up from here when Hector's mediatek cpufreq drivers
using this are ready to be merged ?

--
Regards,
Sudeep
