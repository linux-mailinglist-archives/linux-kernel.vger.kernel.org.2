Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF73B44D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFYNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:53:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C93C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:51:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so5473473pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOFfzzfB3icWGJyf7fd7qOAkUBx8OfOCfNvo7lnaGYw=;
        b=YM80se/wfZcmjIUdSKV47UrLjX0M4qEqOF+kSIH9NkEhkj0yQiBb7w4qYWVko38Po0
         +UcQV6+bQAwiG0LlFHrtwIR6WQ8ib+jtJw3sE2sCTWGz5LI71qoT1WOs1UoblBmHoSvd
         nEtaUVmFlrU9gZGzrJIt6+TPwwXmub1PBArekQu22fZbwy+/GLqObMyYgtdx9t7n4ElA
         UMIw+NQu/OK6eZWTIbF7HQsBks+i7bl4iLg7NWfGjahETY4p8bNUFa2ZIKGy+UUFKPNu
         3fzQHaMHzYAnYEkhhUxWvrLbtZNnQbPWSRUiBzWbeEZK4YhcuDY6XGoYVaRjd6KcJ1ks
         c7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOFfzzfB3icWGJyf7fd7qOAkUBx8OfOCfNvo7lnaGYw=;
        b=KaPQ8yCpIZ4VrkBJ3JUUBFsGOd0J0jm//z3S+O2P8t8b3NHuyBda5R3ltSbHARyAnp
         zSmx8VxkkFOJxS85M14ss/EV5hmlMVxPcp0c1XcXicVsZGDqf39qz9agqq6nmkFgTXDd
         1cWp3R69floVe3IyJRJd4/8pKBUUgy6IXjxM0nCbjtavfvnNHWqtUeYG+W7mzdYUGrKs
         ry7M53etSqZjQGHTS7mYcwBQ4ZVmSbzAcTiM9KoD2CW8ua+7NXo9r7N+vDwoLH5jsPE2
         iD+dT1xdjCDJqlVgZXsnRFOLY2h9YyUMbyXWulaBG0f1lh6eSOso04y8QY+SmUPXAMmK
         3p8A==
X-Gm-Message-State: AOAM533M5M1gaoUMS1OYMV6nyTfeVdmeOuWNUmk7dcCjLUaBTTmlvdAi
        vLC0V1biw/w9pfkLjkaISAUfRc2qsrJ98mFvAui+mg==
X-Google-Smtp-Source: ABdhPJxQYINbrnkbID4F3k8iJOHCoCXHacOfFXlPSJpossaqYKp4Q8nwrksZOualbPoua2Grp4gvm+09tDaR1QbMJAU=
X-Received: by 2002:a17:90a:c394:: with SMTP id h20mr20745388pjt.222.1624629096164;
 Fri, 25 Jun 2021 06:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210616141107.291430-1-robert.foss@linaro.org>
 <20210616141107.291430-6-robert.foss@linaro.org> <20210624211844.GA1997615@robh.at.kernel.org>
In-Reply-To: <20210624211844.GA1997615@robh.at.kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 25 Jun 2021 15:51:24 +0200
Message-ID: <CAG3jFyv3aMt-P+vCExhncBR4n1xYKARhAoO_m+9xsqhp2nwarg@mail.gmail.com>
Subject: Re: [RFC v1 05/11] dt-bindings: clock: Add QCOM SM8350 display clock bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Taniya Das <tdas@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 at 23:18, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 16, 2021 at 04:11:01PM +0200, Robert Foss wrote:
> > Add device tree bindings for display clock controller for
> > Qualcomm Technology Inc's SM8350 SoC.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  .../bindings/clock/qcom,dispcc-sm8x50.yaml    |  6 +-
> >  .../dt-bindings/clock/qcom,dispcc-sm8350.h    | 77 +++++++++++++++++++
> >  2 files changed, 81 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8350.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > index 0cdf53f41f84..c10eefd024f6 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > @@ -4,24 +4,26 @@
> >  $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250
> > +title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250/SM8350
> >
> >  maintainers:
> >    - Jonathan Marek <jonathan@marek.ca>
> >
> >  description: |
> >    Qualcomm display clock control module which supports the clocks, resets and
> > -  power domains on SM8150 and SM8250.
> > +  power domains on SM8150, SM8250 and SM8350.
> >
> >    See also:
> >      dt-bindings/clock/qcom,dispcc-sm8150.h
> >      dt-bindings/clock/qcom,dispcc-sm8250.h
> > +    dt-bindings/clock/qcom,dispcc-sm8350.h
> >
> >  properties:
> >    compatible:
> >      enum:
> >        - qcom,sm8150-dispcc
> >        - qcom,sm8250-dispcc
> > +      - qcom,sm8350-dispcc
> >
> >    clocks:
> >      items:
> > diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8350.h b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
> > new file mode 100644
> > index 000000000000..361ef27de585
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
> > @@ -0,0 +1,77 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> I'm tired of saying this for QCom bindings given it's been QCom I've
> gotten complaints on DT licensing, but dual license please. Spread the
> word.
>
> I'm sure if someone audited licenses of headers and dts files they'd
> find a mess.

Thanks for pointing this out. I'll keep an eye out and change it to
(GPL-2.0-only OR BSD-2-Clause).
