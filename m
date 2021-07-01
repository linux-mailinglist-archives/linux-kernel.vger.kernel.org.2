Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2A3B94C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGAQmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhGAQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:42:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A3C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:39:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c13so4514072qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1omKszLA96uDrGntnvvvB8tgKEGENuOVwCJ29kc0wQ=;
        b=X3rDAfHuhzkoWnwo5uurv5Exfv3mg3SGhQw6Ouw7diqQw1SJpU0uljBxmTl7XH02ij
         FZ48rAir+oVsJxyTJmUcOnMIPBL5+Jv7io2cjOkr2BQoRngsMbXvVUK8ZYY5Yl5KM0QE
         SujHUOV4olMx5BpJFkQJDpB7WVkRsakwwfBjT8OIcGV7lHybyVflPsJzUTe0B9J7gBYO
         Ts/RanidSkddmPkLs3/wkf8g5RdSHi6aytU2uJ+Xqj8HzahGq6YhVht7Kek5QF+E0fLl
         jvFRD5FpoYd9n1kPJUaQmjwzz8ict8ICq8q7ft3k6SpBD8JDFtCmEF9reoBnOnwZ8Prj
         Xglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1omKszLA96uDrGntnvvvB8tgKEGENuOVwCJ29kc0wQ=;
        b=SG/UuH6Bo0mb8uGyjztyddPS8RuxD7hDdGLK//Ac5nPFxAGnsZjdXDCH5ycgg/9T5v
         WXaIL3K7THdUB0dvS7KRU7ZycIshtlLtLO3zFwPkYgkrBVrK2uADqWRE6GNMGxdGF4V+
         QUlfj1EdVdUCdGK4NBd9ZAN1hHsry1pZ+9rLzIdkJPgl7VlV+8qxDtFfMD7I5BeQDPNh
         TRO71eoAT7SMx2V/6HoBkv3hcGSWUGDxGbDsBJvQRKH0vakQTF5Q7oSSrILt1TuFfPgT
         1pO656cwjCbLQY3rtvJrRm/i+/aaU0KQVIHIWDx4gf/Mr0EgIZ0OVHWJgKiAuHeWxE8t
         MwTA==
X-Gm-Message-State: AOAM532wlaXe+u1n8Y9PVE0AIh4L0DO4HE7qYrf+Yv3DkZCTBmQ7XaTl
        L4090Ab76HsarLvUi2ae1Pak/bKtzvT2u9YH/HPTiQ==
X-Google-Smtp-Source: ABdhPJwi3BsgWop/FymmZElECT1X2KqUjB7rfX7hjzyL3qQMDHaQuzKORjxJqwkf0XhL3JEvQDhLDk8MGXWhEfUtf9M=
X-Received: by 2002:ac8:5b0d:: with SMTP id m13mr806896qtw.364.1625157580768;
 Thu, 01 Jul 2021 09:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
 <20210630133149.3204290-2-dmitry.baryshkov@linaro.org> <CAPDyKFpXD3rCmp53LFFYky_xQv9ucofvTezG5qWyDZt427chNQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpXD3rCmp53LFFYky_xQv9ucofvTezG5qWyDZt427chNQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 1 Jul 2021 19:39:29 +0300
Message-ID: <CAA8EJpob=TpXiJozac-5sKJzE71ddWRFDj7D2-F=W=a2mgKvxA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx
 power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, 1 Jul 2021 at 19:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 30 Jun 2021 at 15:31, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On sm8250 dispcc requires MMCX power domain to be powered up before
> > clock controller's registers become available. For now sm8250 was using
> > external regulator driven by the power domain to describe this
> > relationship. Switch into specifying power-domain and required opp-state
> > directly.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/clock/qcom,dispcc-sm8x50.yaml    | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > index 0cdf53f41f84..48d86fb34fa7 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > @@ -55,6 +55,16 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > +  power-domains:
> > +    description:
> > +      A phandle and PM domain specifier for the MMCX power domain.
> > +    maxItems: 1
> > +
>
> Should you perhaps state that this is a parent domain? Or it isn't?
>
> Related to this and because this is a power domain provider, you
> should probably reference the common power-domain bindings somewhere
> here. Along the lines of this:
>
> - $ref: power-domain.yaml#
>
> As an example, you could have a look at
> Documentation/devicetree/bindings/power/pd-samsung.yaml.

I'll take a look.

>
> > +  required-opps:
> > +    description:
> > +      Performance state to use for MMCX to enable register access.
> > +    maxItems: 1
>
> According to the previous discussions, I was under the assumption that
> this property belongs to a consumer node rather than in the provider
> node, no?

It is both a consumer and a provider. It consumes SM8250_MMCX from
rpmhpd and provides MMSC_GDSC.

>
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -64,6 +74,15 @@ required:
> >    - '#reset-cells'
> >    - '#power-domain-cells'
> >
> > +# Either both properties are present or both are absent
> > +dependencies:
> > +  power-domains:
> > +    required:
> > +      - required-opps
> > +  required-opps:
> > +    required:
> > +      - power-domains
> > +
> >  additionalProperties: false
> >
> >  examples:
> > --
> > 2.30.2
> >
>
> Kind regards
> Uffe



-- 
With best wishes
Dmitry
