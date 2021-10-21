Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA843672D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJUQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhJUQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:04:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3597C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:02:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so232353lfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoEd/tBzE8K8k0Q63eTfP8ygQVoQShnDO1n9okRZkWE=;
        b=agyyWX7PReVwL1iLD3bEEH4KVzhAJe55KT609vtEt5ahGnRk+qzRs6FAPayp69pg1r
         YZw32Mc6iMLC7tRIzt56LnhaOu3iO88Wo5D1K7ZdlwV9we3k01znAo4V95j1fr/TXHcs
         dfpzwuUX7yX/iHGpEc6BBS/XMAd6OIwZiIBODicEaED5fLAaQeh8GyIrNjK3mDYaMFQP
         r989zpttoIwTre7/osSdmxjUluvsqb/O7mGIzwM4nArk5j4mMRB/6VsMhQWl+L52Hnjq
         A5fSG942hbn+7o2Cwx36gk5XPWk2elpCYD6Lr2yIM9tynRMhLZiPvSPYJVIq7DCJCSvG
         mZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoEd/tBzE8K8k0Q63eTfP8ygQVoQShnDO1n9okRZkWE=;
        b=ZgPLIQcS7ZMebFJuPdoc4hHGjRv5iNzgSRIkI/J/YWZbUpGtODWoniXH5EJJ80LsSa
         thvxZ4Aa/KnPlNGdTRdWFTmpSPEmD4rs9sk41CBq9zfSFThGX1wEyy/0B8uZX9NwERTB
         5loG1Yw/yYIvtp3VENM0Y6JacJQD49YyAD9w4wp4BL0B4cP1l8AmKI2M0SK5nCRZ6sxJ
         vwsfgocHGCxqP2R+9xuJLBr2uQjA4yloBK6ly+wP2kjFf/8284BOY5rXL8votsyjGsbM
         MlD9sgxSEUSqXZ/8Zm4QJ3Vnr55/zZMGdlSac/kNT/8qTz3IVwBSedY54hai7cxcN2z1
         G3wA==
X-Gm-Message-State: AOAM532rVarBJTXTb3vXJIFD7u1Ot+3ecFNdyXZhqrkxLdEweHSfF/xK
        3BHd+OIgrlOmXiuOygnMFDlx6zfaqSSyw/W7d3TF6A==
X-Google-Smtp-Source: ABdhPJz6J1itEiLJ3XJbjfN6YWYuCJknhwrspTZylJffYq4ne5/Ac6N05Fbr9QhNCsFddw3+E32DEE1WQpyP9ZJ+vzQ=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr6297631lfb.71.1634832134320;
 Thu, 21 Oct 2021 09:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus> <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <CAL_Jsq+Xb-MX4dkebARFJ_qHyFUWyPJ1WDZLQkUKA5ALsSHsgg@mail.gmail.com>
 <CAPDyKFosEGWpCEGOEpym_COFNhUr7_Qa=rzst3ObUUqcgdSnqA@mail.gmail.com> <20211021133318.74f4tdwpishicefb@bogus>
In-Reply-To: <20211021133318.74f4tdwpishicefb@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 18:01:37 +0200
Message-ID: <CAPDyKFrf729xb92QXZw34wTYYQwEEtVKayvmSUAXtqWhPOBN4A@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 15:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 21, 2021 at 03:13:30PM +0200, Ulf Hansson wrote:
> > On Wed, 20 Oct 2021 at 14:11, Rob Herring <robh@kernel.org> wrote:
> > >
>
> [...]
>
> > > 'power domains' in DT is supposed to mean physical power islands in
> > > the h/w where as genpd can be whatever you want. Are power and
> > > performance domains always 1:1?
> >
> > I wouldn't say that "power domains" *must* correspond to physical
> > power islands. At least, that's not the way the bindings are being
> > used. For example, if it makes better sense to keep some of the logic
> > in FW, rather than describing a complete topology in DT, that should
> > be perfectly fine.
> >
>
> I agree. The DT must either have h/w view or f/w view of the topology
> and not both(that is inviting more trouble in terms of bindings as well
> as handling it in the OSPM).
>
> > Additionally, I am not suggesting that "performance domains" and
> > "power domains" must map 1:1. A device can be performance managed
> > through one domain and power managed by another, that would be
> > perfectly fine to me.
>
> I don't understand what you mean by that. Do you expect to create a genpd
> with no power domain ops and just performance ops to deal with scenario
> I have been presenting(i.e. power domains for a set of devices(CPUs in
> particular) aren't exposed to OSPM while performance domains are).

Yes, but only if that would make sense, of course.

If it matters, the performance states and idle states in genpd are
supported as two orthogonal states.

>
> I really don't like to create psuedo/dummy power domains with no useful
> info(as f/w hides or abstracts it) just to represent the performance
> domains.

I assume you mean creating dummy *genpds* - and yes that seems very
silly, I agree.

We shouldn't do that, unless we can make use of them in some clever
way to avoid open coding, but that's an entirely different question,
unrelated to DT.

>
> Also with CPUs you can imagine all sort of combinations like:
> 1. cluster level perf domain + cpu level power domains
> 3. cluster level perf domain + cluster level power domains
> 2. cpu level perf domain + cpu level power domains
> 4. cpu level perf domain + cluster level power domains
>
> + power domains not available to OSPM in all the 4 combo.
>
> So I am really struggling to visualise a way to represent these based
> on your suggestion.

For perf domains, we could model this in DT as one power domain for
performance, per CPU, but without a cluster power domain for the
performance, as that seems to be managed in FW. Note that, this
doesn't mean we need to create genpds and hook up devices to them.

I guess this would map 1:1 towards how the "performance-domains"
binding is intended to be used, right?

One thing though, for PSCI we distinguish the power domains, by
specifying "power-domain-names = "psci" in DT. Similar to this, we
would then need to come up with another power-domain-name, to map it
to a "performance domain". Mostly to cover future compatibility
issues.

So, to summarize (thanks for a good discussion!), I will not insist on
deprecating the recently introduced "performance domains" binding. I
leave the call to you! However, to me, it still looks like the
power-domains binding could be used to support "performance" as well.
Especially, as we already have other cpufreq drivers [1] supporting
them.

Kind regards
Uffe

[1]
Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
