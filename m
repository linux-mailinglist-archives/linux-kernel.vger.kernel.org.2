Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0383A436310
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJUNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:35:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhJUNfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:35:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76259ED1;
        Thu, 21 Oct 2021 06:33:22 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDBF93F73D;
        Thu, 21 Oct 2021 06:33:20 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:33:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20211021133318.74f4tdwpishicefb@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus>
 <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <CAL_Jsq+Xb-MX4dkebARFJ_qHyFUWyPJ1WDZLQkUKA5ALsSHsgg@mail.gmail.com>
 <CAPDyKFosEGWpCEGOEpym_COFNhUr7_Qa=rzst3ObUUqcgdSnqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFosEGWpCEGOEpym_COFNhUr7_Qa=rzst3ObUUqcgdSnqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:13:30PM +0200, Ulf Hansson wrote:
> On Wed, 20 Oct 2021 at 14:11, Rob Herring <robh@kernel.org> wrote:
> >

[...]

> > 'power domains' in DT is supposed to mean physical power islands in
> > the h/w where as genpd can be whatever you want. Are power and
> > performance domains always 1:1?
>
> I wouldn't say that "power domains" *must* correspond to physical
> power islands. At least, that's not the way the bindings are being
> used. For example, if it makes better sense to keep some of the logic
> in FW, rather than describing a complete topology in DT, that should
> be perfectly fine.
>

I agree. The DT must either have h/w view or f/w view of the topology
and not both(that is inviting more trouble in terms of bindings as well
as handling it in the OSPM).

> Additionally, I am not suggesting that "performance domains" and
> "power domains" must map 1:1. A device can be performance managed
> through one domain and power managed by another, that would be
> perfectly fine to me.

I don't understand what you mean by that. Do you expect to create a genpd
with no power domain ops and just performance ops to deal with scenario
I have been presenting(i.e. power domains for a set of devices(CPUs in
particular) aren't exposed to OSPM while performance domains are).

I really don't like to create psuedo/dummy power domains with no useful
info(as f/w hides or abstracts it) just to represent the performance
domains.

Also with CPUs you can imagine all sort of combinations like:
1. cluster level perf domain + cpu level power domains
3. cluster level perf domain + cluster level power domains
2. cpu level perf domain + cpu level power domains
4. cpu level perf domain + cluster level power domains

+ power domains not available to OSPM in all the 4 combo.

So I am really struggling to visualise a way to represent these based
on your suggestion.

--
Regards,
Sudeep
