Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39038442D24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:52:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A9C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:49:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p18so12389151plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaIFo45joCtIbALY4+H73q/4ML+vmLQCj6pBcBGjWho=;
        b=TvqE4gWEK2JDCGRw3ZG1OomLZxZsLRjXs7xv+VmLItD3E212NodchziFbXAURQKBw3
         dkeHqKZ+j5sEB1QHUafQnTkl/cYkkX0rUKVaK3q+8IpqtFMWZdrS4lGlWmWdf3vM4Bij
         WgWkDqwn2gMWsUxRbNoXFzSwR4XUju7Hv0kG5wgh4QtcVOfIn9bCfvV/ueffHtaPSW+0
         4nc+pxLVjU35BmgpdbDEZ21mBmSINy1e40WaCT2UFwDQV63twocpOx8zV/emHM/j5cWZ
         yaeb4t6MOU+9rhn0HrR1u/POfGkljVNkrFg78y3ohPhvNH/14A325300EzOfGAj6djPz
         q/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaIFo45joCtIbALY4+H73q/4ML+vmLQCj6pBcBGjWho=;
        b=1Lo+LD7Lm7H+TEJpoT+4js0wLLiWP7FCkMnybyIeV2B1JnYfHWyZsRz1et887S7Gra
         2uOC1On8AkYOaERCP4FHaAL3LbML18wltiOHXRkP9TDKAO0CfY8RIDIWTaDkv2f5lI3s
         qhPk8KY+CZ7x/zErPn42czMy9K+47a2F/bkQ/PK3XG7Ob9caQ/a2gm0CgAz7tMgGtIZ2
         6sYUdvYPvptgrrkYKXQe7tRe1OhIQ15wzBnQbWfsrTfQV0KrXyPN49kwKu0lCF79T9+3
         n0Src+dDcnJnIjEr1CgWjkK1poWtL2+GDRMPzExRPubtHnTL1vKyzDc2lvqzDtokdmZH
         /6uQ==
X-Gm-Message-State: AOAM530jYxc40TtNcUC7UP5FKYk+vDLpC2HsYerIy3V+bvuOOA6eT6Ta
        rut8NIWlRaro/KAbe+8r3UgmnJrR6/n1yhLa90qDJA==
X-Google-Smtp-Source: ABdhPJyh9CGyt6qq9ZsiHAl/WfCjddeiiXcSN+okvKiOqp3IHifyCVQzJSfhbXLiGp5Afl1NXS257Q9cPCyvCazHIGw=
X-Received: by 2002:a17:902:edc7:b0:141:a2d8:ede9 with SMTP id
 q7-20020a170902edc700b00141a2d8ede9mr27782887plk.24.1635853785585; Tue, 02
 Nov 2021 04:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025103322.160913-1-robert.foss@linaro.org>
 <20211025103322.160913-2-robert.foss@linaro.org> <YYBOXQOXM8USks0G@robh.at.kernel.org>
In-Reply-To: <YYBOXQOXM8USks0G@robh.at.kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 2 Nov 2021 12:49:34 +0100
Message-ID: <CAG3jFytkHi06uaP8RFaS9cma68S9oz_AcAtkMxCrPKGXBTtfsA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] media: dt-bindings: media: camss: Document
 clock-lanes property
To:     Rob Herring <robh@kernel.org>
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 at 21:30, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 25, 2021 at 12:33:22PM +0200, Robert Foss wrote:
> > The clock-lanes property corresponds to a hardware register field
> > that is required to be set, in order to enable the CSI clock signal.
> >
> > The physical lane of the clock signal is not programmable, but only
> > togglable On or Off, which what BIT(7) of the
> > CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(5) register controls.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  .../devicetree/bindings/media/qcom,msm8996-camss.yaml        | 5 +++++
> >  .../devicetree/bindings/media/qcom,sdm660-camss.yaml         | 5 +++++
> >  .../devicetree/bindings/media/qcom,sdm845-camss.yaml         | 5 +++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> > index 38be41e932f0..d4da1fad12cf 100644
> > --- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> > +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> > @@ -106,6 +106,11 @@ properties:
> >
> >              properties:
> >                clock-lanes:
> > +                description:
> > +                  The index of the clock-lane is not programmable by
> > +                  the hardware, but is required to define a CSI port.
> > +                  Lane 7 reflects the hardware register field that enables
> > +                  the clock lane.
>
> If it is fixed, then it should not be required. Fix the required part.
>
> >                  items:
> >                    - const: 7
>
> I don't know how we let that in, but this should be the lane number.
> Each binding can't be making up its own interpretation.

If the clock lane number isn't programmable, can clock-lanes be omitted?
