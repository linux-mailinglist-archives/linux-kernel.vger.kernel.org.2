Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463E13B9519
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhGARBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhGARBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:01:32 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D427C0613DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:59:01 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id h126so1643119vsc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Immfemhnpfwa8Nxg8YlJJPBmhUahLWtVsprTcnwHwPk=;
        b=fosP1pivS/V7/7q1YVbmKOVzAiaVlm7zVcVZXe75oDTpnLQk/JKjyghVLBOJVFuoV3
         HE3hPij/Y20fQDt6VeHfZvDLHTpLW3jPrwm4wyS7idrW9V4tmk++PdK8IjtEnRKXzvdZ
         ZlagxBpjFbDf5GySfn9hAqblBML6XGQXPxbC+gb4Z8Nrj1ae4rS+814Zk81lR2ppJFSk
         pRVxoVpBm2X4pnBqPLo/l8fEIxVRUJCBwumltoa5T/urpYAgqTCLy6ayZxz8lNEKiKSl
         d9LHZd4OC61Dj9vw3HPRsXC7mlQJi7ZD5aakDa9hqqemjxNnjj3tKs7gVaMPkHOkCkax
         zGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Immfemhnpfwa8Nxg8YlJJPBmhUahLWtVsprTcnwHwPk=;
        b=m/7a+6SUo7+ZacH1/cTBvqRk++LF49kx2cgMwl381U8Z56OVbhOZ8b7xtEIHtzm/pq
         3AL3kQsgVjAzRFG4p4gxdCFgW8t9VD2k7HglFOdLscV5y4vfYOX7aCPTa1y9dESsG/KE
         xeDMIjJq/MZS+eKxg8r+GxlCG1Y2AKjnywX7ZAKIU60pFww/vaBQHs0h6b0/5Z/1KHlY
         Rl2pIp550AWHDIyOfoo/aGlTAjvJ+uvGo+V9z4hWcEnUxyY/aGA6L9fGn/Ve2ZGqo/pD
         F7QjzS4uFOIxZYnLMerF1Lc8q5N1HSQ4We4pwb7FjrobCCZDZIshY1Y0TMkA7Z7yyAEj
         v6iQ==
X-Gm-Message-State: AOAM531zgYdY8lx1bhaHEGxr0IcOdDjb9NIVjOTBtk0Xag383ukfnVWb
        BmVj4a06qil27u3OpQKEW+HqHPK9lsS/lpJNGIGb1w==
X-Google-Smtp-Source: ABdhPJwb80n64AujBuKAB/6m8FZX3ULekcDZrX7rK4uDzligl8QBq8854MayUQyqde2ZRzptR9AszDxPsDj/QYmH4XI=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr1354578vsa.19.1625158740105;
 Thu, 01 Jul 2021 09:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
 <20210630133149.3204290-2-dmitry.baryshkov@linaro.org> <CAPDyKFpXD3rCmp53LFFYky_xQv9ucofvTezG5qWyDZt427chNQ@mail.gmail.com>
 <CAA8EJpob=TpXiJozac-5sKJzE71ddWRFDj7D2-F=W=a2mgKvxA@mail.gmail.com>
In-Reply-To: <CAA8EJpob=TpXiJozac-5sKJzE71ddWRFDj7D2-F=W=a2mgKvxA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Jul 2021 18:58:22 +0200
Message-ID: <CAPDyKFq-vwMchLFb3JvK7B9ZQ9=z-TXzGHUij6CocTR+VmAOqQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx
 power domain
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 18:39, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 1 Jul 2021 at 19:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 30 Jun 2021 at 15:31, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On sm8250 dispcc requires MMCX power domain to be powered up before
> > > clock controller's registers become available. For now sm8250 was using
> > > external regulator driven by the power domain to describe this
> > > relationship. Switch into specifying power-domain and required opp-state
> > > directly.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../bindings/clock/qcom,dispcc-sm8x50.yaml    | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > > index 0cdf53f41f84..48d86fb34fa7 100644
> > > --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > > @@ -55,6 +55,16 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > >
> > > +  power-domains:
> > > +    description:
> > > +      A phandle and PM domain specifier for the MMCX power domain.
> > > +    maxItems: 1
> > > +
> >
> > Should you perhaps state that this is a parent domain? Or it isn't?
> >
> > Related to this and because this is a power domain provider, you
> > should probably reference the common power-domain bindings somewhere
> > here. Along the lines of this:
> >
> > - $ref: power-domain.yaml#
> >
> > As an example, you could have a look at
> > Documentation/devicetree/bindings/power/pd-samsung.yaml.
>
> I'll take a look.
>
> >
> > > +  required-opps:
> > > +    description:
> > > +      Performance state to use for MMCX to enable register access.
> > > +    maxItems: 1
> >
> > According to the previous discussions, I was under the assumption that
> > this property belongs to a consumer node rather than in the provider
> > node, no?
>
> It is both a consumer and a provider. It consumes SM8250_MMCX from
> rpmhpd and provides MMSC_GDSC.

That sounds a bit weird to me.

In my view and per the common power domain bindings (as pointed to
above): If a power domain provider is a consumer of another power
domain, that per definition means that there is a parent domain
specified.

[...]

Kind regards
Uffe
