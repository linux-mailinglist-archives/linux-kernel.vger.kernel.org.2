Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CE41B566
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbhI1Rus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbhI1Rur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:50:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55884C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:49:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso3465097otu.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ee67sOAid6wHL8yrDSwQ2wW8ZqBQe7W4ic7SnZyjfy8=;
        b=XkGwrkSb1R6uAaHn7U04oOGdQRt47kH/S27GgW65TXmlE2fbFeeveSEdrLCk/4MOUO
         /UTt5ME2isOVlwZaH5OYnnx5uoCTuNYj2nC/tSN4SOk1NWhTh6eZ/GZrTFaIqDpRPdzO
         lh8UaOwqd9ldEX1quDBn4WgxDwjWY+quVKSRdhmOoI7p1j2mQZ5qZCSmBpFqyO6WlneW
         uxi9yt+oXIlsFXRw2bGVeNC958u+tqz2r7Sa447ChWP7mMjwV3wQ0752wig/oKUVO3Eh
         dXpiYW5tTaGKlkp6KDA7eumj6IqqImgef08A2BUG+5vdyAL7/TR/8Gz867Ge239byU3X
         vNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ee67sOAid6wHL8yrDSwQ2wW8ZqBQe7W4ic7SnZyjfy8=;
        b=fe+1Ylle26h3AxZiSaPrp+8xLFxSb7tKzbX4WjnMbpTN/8bBQQTqzaBD0hTF2vShIH
         hVIRoS1yR2H2cxkDMqW2I/CB2Vwe86dnpn+YpTDAUKuJMKYIfpmAF++LYmzc9WR4/C0W
         4U3HIzLL99Pn9qG1mQ7KKI8INz3+PdbcVg6n9SZSlsFFGzVvAe00qVR6GDj1O/1qXWLQ
         bqGAW+FO1vRL/Y6MGuy9b2gD9/SeyKFRjrondwvc603ycvGWApG5nEpq1NWP83mJbENX
         o2U8zR2bx2p+PeAx3ZZjt6gOJdWV59R270pQnM0ud6yeeKhToc/0xhb/ggEWwzd5Cdv+
         gqIg==
X-Gm-Message-State: AOAM532ADQc6TOyDg4tsemVNVbnG8qNVy53X5o276nsKUV/d3YkVSP0A
        zUUj13tDIvLWH530lg5+5Dc+FA==
X-Google-Smtp-Source: ABdhPJyfTt/EzawBdjDkqYLPD5aqWqzUHFwedZ70wOMrQFJJcvuAQrUVr0u3d53SZEuqTVmefmT9tg==
X-Received: by 2002:a9d:7093:: with SMTP id l19mr6345851otj.15.1632851346478;
        Tue, 28 Sep 2021 10:49:06 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u2sm3080220otg.51.2021.09.28.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:49:06 -0700 (PDT)
Date:   Tue, 28 Sep 2021 12:49:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: soc: smem: Make indirection optional
Message-ID: <YVNVj68WjBBXef3h@yoga>
References: <20210928044546.4111223-1-bjorn.andersson@linaro.org>
 <YVLszZ7U7D91oIH2@gerhold.net>
 <CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Sep 12:34 CDT 2021, Rob Herring wrote:

> On Tue, Sep 28, 2021 at 5:22 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Mon, Sep 27, 2021 at 09:45:44PM -0700, Bjorn Andersson wrote:
> > > In the olden days the Qualcomm shared memory (SMEM) region consisted of
> > > multiple chunks of memory, so SMEM was described as a standalone node
> > > with references to its various memory regions.
> > >
> > > But practically all modern Qualcomm platforms has a single reserved memory
> > > region used for SMEM. So rather than having to use two nodes to describe
> > > the one SMEM region, update the binding to allow the reserved-memory
> > > region alone to describe SMEM.
> > >
> > > The olden format is preserved as valid, as this is widely used already.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../bindings/soc/qcom/qcom,smem.yaml          | 34 ++++++++++++++++---
> > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
> > > index f7e17713b3d8..4149cf2b66be 100644
> > > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
> > > [...]
> > > @@ -43,6 +55,20 @@ examples:
> > >          #size-cells = <1>;
> > >          ranges;
> > >
> > > +        smem@fa00000 {
> >
> > I think this is a good opportunity to make a decision which node name
> > should be used here. :)
> 
> reserved-memory node names are kind of a mess, so I haven't tried for
> any standard... It needs to be solved globally.
> 

I'd be happy to paint the shed any color you decide :)

That said, the binding itself doesn't mandate any node name, so it's
just the example here that would be "wrong" - and just as wrong as it
currently is.

> >
> > You use smem@ here but mentioned before that you think using the generic
> > memory@ would be better [1]. And you use memory@ in PATCH 3/3:
> >
> > -               smem_mem: memory@86000000 {
> > +               memory@86000000 {
> > +                       compatible = "qcom,smem";
> >                         reg = <0x0 0x86000000 0 0x200000>;
> >                         no-map;
> > +                       hwlocks = <&tcsr_mutex 3>;
> >                 };
> >
> > However, if you would use memory@ as example in this DT schema,
> > Rob's bot would complain with the same error that I mentioned earlier [2]:
> >
> > soc/qcom/qcom,smem.example.dt.yaml: memory@fa00000: 'device_type' is a required property
> >         From schema: dtschema/schemas/memory.yaml
> >
> > We should either fix the error when using memory@ or start using some
> > different node name (Stephen Boyd suggested shared-memory@ for example).
> > Otherwise we'll just keep introducing more and more dtbs_check errors
> > for the Qualcomm device trees.
> 
> A different node name. A node name should only have 1 meaning and
> 'memory' is already defined.
> 
> The main issue here is what to name nodes with only a size and no address.
> 

This particular node has both address and size (as does all of the other
reserved-memory regions we use upstream today)...

Regards,
Bjorn
