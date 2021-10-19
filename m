Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21374337E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhJSOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:01:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:59:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g36so7735179lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILzjBv7jb2erSvTebu5+BOJoPbprz/SsH8tpTWu6DKY=;
        b=O2Re71PfoAqOL7WOfHfHJNkIL7iakzqAszzJk8SjFyqWyNb6UHyVMqs6C3OoSWFI9F
         Xd64Q3XG7+XiEpugc1LBKkCsbt0vFqwjKEg2h5n9zge5VqjQGwXmHsR7/hIdY5oZ9d/g
         5DfJKBfi4rxaMhprLEdyPJvfPKfXnn2MFq9VxKNW9P9Y14ABget75hoP0JN+Sd2k3Oz+
         NZ3KUgMnI1fTEb+pN3spt4l7LG71Y5Y03w+0lC2USSDgWWWO0H+PGdDB1fo5BV2kHhcj
         +aX1sr2LryW3yuBIDCwy1jjpcNQSCsz9JM7sylSi9ochWS5bEJdW/sz0oq0atmMOQCsP
         NEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILzjBv7jb2erSvTebu5+BOJoPbprz/SsH8tpTWu6DKY=;
        b=iTesw79mJ9/MVaq7Rwq5w5/T9z1OXBuPdOWtqeIZF3wYnONjDkjXUyanjmRKaPzw02
         yzND+etq8eb58RjpOKEzhKEkrKlA9IL6SYfmmoAowDGncEkEErpDOoV1nN9LD7BWCo4e
         xyc3W4Ymg4Q/UU2zUHldHT4R01RG6IEdrumD6QunoYhkSBiiqFWrQAl8afdramx3GjYN
         +XryH49X1trUa57M+fG7nEMYLTcnFcYuNKKpMwzmQcq7Dfg6NXmXkfb0n3X+N9tf8WZy
         mLGAT6dPOS8yJoHCA2kOOQGe9AB1u6kvUlSTrtvJRLDyJcWgPcR7N5q/jKDZGwD9G5Gh
         GP5Q==
X-Gm-Message-State: AOAM531McCvBnvedy/W+eimIQr+S616JzgE6UFsMu2wWl1UDowCEDcF/
        PTLK6s+50oCsdgN/DuBV2JNgDXGRbU3sXL/bclGvnw==
X-Google-Smtp-Source: ABdhPJwEZ/12s6FhUn9BwHsNM2h0kgJ1t7fNc7uC9H9v39KVXFWF2Gp6L127iVGYAWoxT0/CCwL8R8bkoNkCTrlDLyE=
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr5900952lfd.167.1634651951419;
 Tue, 19 Oct 2021 06:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus> <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <20211019072425.dvq3ummjdkjmucgm@vireshk-i7>
In-Reply-To: <20211019072425.dvq3ummjdkjmucgm@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 15:58:35 +0200
Message-ID: <CAPDyKFqk_-YQjEECLm_gM6UpMahRok4vNnxCv3i614OEvPuD2Q@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 09:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-10-21, 11:17, Ulf Hansson wrote:
> > As far as I understand, the "performance domains" DT bindings that
> > $subject patch introduces, allows us to group devices into domains, to
> > let them be "performance controlled" together. Right?
>
> This and it also provides a reg space where we can get/set the
> performance state.

Right. So that can be done for power-domains too.

>
> > Unless I am missing something, it looks like power domains DT bindings
> > already offer this for us. Yes, certainly, the DT doc [1] needs an
> > updated description to better explain this, but other than that we
> > should be fine, don't you think?
>
> I think yes we can make it work through that as well, but I am not
> sure if we will be able to use required-opp n stuff here as the DT
> doesn't have the OPP table for the CPUs.
>
> The CPU's freq table is generated at runtime, see
> drivers/cpufreq/mediatek-cpufreq-hw.c for example.

To me, this looks doable from a genpd provider too. Of course, we may
need to extend the genpd interface a bit to make it fit well for this
new use case, of course. And I am happy to help, if that is needed.

One thing though; how is the aggregation of the OPP votes expected to
be done? Is that entirely managed by FW - or is it expected that the
cpufreq driver, in this case, keeps track of the aggregated votes too?

Don't get me wrong, I am not pushing for these DT bindings to be
deprecated (at least not yet :-)), but I would certainly like to
understand more about them. In the end, we haven't walked this far, by
extending genpd and inventing new DT bindings to enable it to support
"performance management" - then just to just forget about them again.
:-)

Kind regards
Uffe
