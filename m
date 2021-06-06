Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C139CCB8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFFEOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFEN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:13:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A01C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 21:11:59 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so8915371oth.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PeBBPFzXzFLQyV93HqbVbvw6ixlWmMPKlmmW5KX4BdY=;
        b=nK+f1wrx/mVYH3vIBVEAiJd5nccwAkI9qpr4LEweZvywpoBnvHIq3AshG3bQ3bEd3k
         didBUftpsCN4tOM3XYmL6OlXddvPQe8bwn3JhxlfCWOuJI8Djs1RR1y0EayzvyiDOLbg
         ItunPMn4ksyg7QA3w6ufxgJeU2D1Q++4SuyHjTDYPh/YDq6zPvBQPKa3KICKG5nJ9nW9
         Ps9NkyV13O1izOgEGWkTihUIE2dL4C69h+Z7LvbreUSgFVpc05SFeyLx/6cxATwhFMNz
         Ej+VK5MnVehLpNm2/aBU2E5SmZgCpfvhq4Xj96W4ccf6qzyZkdGIP3saimGgrxglTV1P
         2Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PeBBPFzXzFLQyV93HqbVbvw6ixlWmMPKlmmW5KX4BdY=;
        b=s4/Tg4BaV/jOON3JieUTmkke/VNhFAurCKGpXol6LbeacZsaBsfOhn0FAes4v56wcO
         OdTrHRam3ynThKdQmGihzo/WCqHARUYtHQ5cydWycJSF7vUvh2M6ku1G1b+w27Ms17ta
         7sCuY5S0/563iTlbl0NoAHjhofKy850IMXWK61X/Hep7xzJwxdoHnkGmhNZyFYdsyO6V
         PNGZ8Gq/YhPvMFad5br6dhTQBEgBt7p0oD2KRHtNfGpCCLDLdLus1HBtSecDR0WckOHj
         2U7cyB3inEkvEPY9u/vtiokHNKSjNuPGStmD7UzsoJV3cusBuwSebfCG/Wr6dtWeGm8t
         ngJQ==
X-Gm-Message-State: AOAM532zyFqlTc5pqJPGewIl1HRtETRmg9wEwKMS1XHt6tAKW3/A/J8S
        gYzGbpPqEgwOabgMemjDeGGqoA==
X-Google-Smtp-Source: ABdhPJwzMB8YpnFsGxWqU2FCb3PeDcCD1oeRD+TlTDDu8UyZKIEQkeW4eJoDwud454SeT7QiyGRU1w==
X-Received: by 2002:a05:6830:4103:: with SMTP id w3mr9585823ott.27.1622952718437;
        Sat, 05 Jun 2021 21:11:58 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x14sm1481109oic.3.2021.06.05.21.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 21:11:57 -0700 (PDT)
Date:   Sat, 5 Jun 2021 23:11:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: add QCOM SM8350 display clock
 bindings
Message-ID: <YLxLDCOpnbUL7gfL@builder.lan>
References: <20210519001802.1863-1-jonathan@marek.ca>
 <20210519001802.1863-2-jonathan@marek.ca>
 <162266925581.4130789.10178141366818328902@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162266925581.4130789.10178141366818328902@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Jun 16:27 CDT 2021, Stephen Boyd wrote:

> Quoting Jonathan Marek (2021-05-18 17:18:02)
> > Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
> > bindings. Update the documentation with the new compatible.
> > 
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 6 ++++--
> >  include/dt-bindings/clock/qcom,dispcc-sm8350.h              | 1 +
> 
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >  create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
> 
> Why the symlink? Can we have the dt authors use the existing header file
> instead?
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > index 0cdf53f41f84..8f414642445e 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> > @@ -4,24 +4,26 @@
> >  $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250
> > +title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250/SM8350
> 
> Maybe just "Binding for SM8x50 SoCs"
> 

That seems like a certain way to ensure that SM8450 etc will be
different enough to not match this binding :)

Regards,
Bjorn
