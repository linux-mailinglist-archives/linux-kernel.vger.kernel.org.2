Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8A38F069
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhEXQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhEXP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:56:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA50C061143
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:08:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v22so27342942oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qd2GGNOqjcoVwR9/InTy3gHaTefuQ8PzIzZm4PfwF+Q=;
        b=pHUsCN/IDaId/ipsKoG3ZrMYVpOUrGYrLef0xTZtQqyz5XEMvN+lSpLTWg7jqjs6Jg
         8wJ0pQL7+XaAsnBMSaWQCy7vQ/ZJnhOkVL0wp8RSeBJ7P47eTtE07yeR4+A6SNbbViAa
         iet9G/GM1FfaXkBxAschybOUCLj4dh8QNh+vYyRua3BmM2eulhIfr9X1rl0wIRCwsWd+
         pISDWphupk3cSrSJvfwLRLkVetuRq3bdIaT1ju8SB684mx/GMUIuCsIkN5+XbviAupjL
         9P0mdNOzaKLEQ+SZt9yQ2d8SL3naZn+5M6s/xOz5hGkwU900zBI4ruNo/Nh5jzk7aRTk
         Bqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qd2GGNOqjcoVwR9/InTy3gHaTefuQ8PzIzZm4PfwF+Q=;
        b=J1uQsxSKmB2ZZmCF7gEbJXeRHnM/zcOqbYR/EFQ4W5cIFeFVgnTaxv9Rue4ky8D4/1
         mH/KGUDGTgqzhCtRqbxZHa9ZyPgRYBCUMCtX8gdkf+ck4o1uIsQ6u2Nstzv4OsT24n38
         GK6Lp3ugRf0PhbSl456b2eqON1zo7aEJAajLRKwk8UsvXItNxolJsqQdY3XUtDyhgSjO
         obI5EXin15tbZPlNtiCgAQX07Q1uFeFtmeivdwb3zNq15lyvwAEMJd27IcJmrxXdYfVn
         7utierwQR4FbGPDpT/0wnikXfHaeZHEvMHTaY6ULzFK9gj3pOhtXA9ywgyZMIKGiWb6k
         fDHQ==
X-Gm-Message-State: AOAM530PgqURvVeTrgzicOXyiH780Gn9xH/aoSgYGZMzIEdFGGS6fXtk
        kUYTGNYgSAHG2LBe2o7ByLDFHw==
X-Google-Smtp-Source: ABdhPJzQwEXxT63vulS4Mr1iXuUiQVfsntslWby9WpFJQ1i6LL+g6rwKWyZorlvtptAuR0hvccJ5Xg==
X-Received: by 2002:aca:230e:: with SMTP id e14mr11102837oie.58.1621868898078;
        Mon, 24 May 2021 08:08:18 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n11sm2564001oom.1.2021.05.24.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 08:08:17 -0700 (PDT)
Date:   Mon, 24 May 2021 10:08:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] dt-bindings: msm/dsi: Document Display Stream
 Compression (DSC) parameters
Message-ID: <20210524150815.GH2484@yoga>
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-3-vkoul@kernel.org>
 <20210521144237.GZ2484@yoga>
 <YKtWM+BYeIA+P+55@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKtWM+BYeIA+P+55@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 May 02:30 CDT 2021, Vinod Koul wrote:

> On 21-05-21, 09:42, Bjorn Andersson wrote:
> > On Fri 21 May 07:49 CDT 2021, Vinod Koul wrote:
> > 
> > > DSC enables streams to be compressed before we send to panel. This
> > > requires DSC enabled encoder and a panel to be present. So we add this
> > > information in board DTS and find if DSC can be enabled and the
> > > parameters required to configure DSC are added to binding document along
> > > with example
> > > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  .../devicetree/bindings/display/msm/dsi.txt       | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > > index b9a64d3ff184..83d2fb92267e 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > > @@ -48,6 +48,13 @@ Optional properties:
> > >  - pinctrl-n: the "sleep" pinctrl state
> > >  - ports: contains DSI controller input and output ports as children, each
> > >    containing one endpoint subnode.
> > > +- qcom,mdss-dsc-enabled: Display Stream Compression (DSC) is enabled
> > > +- qcom,mdss-slice-height: DSC slice height in pixels
> > > +- qcom,mdss-slice-width: DSC slice width in pixels
> > > +- qcom,mdss-slice-per-pkt: DSC slices per packet
> > > +- qcom,mdss-bit-per-component: DSC bits per component
> > > +- qcom,mdss-bit-per-pixel: DSC bits per pixel
> > > +- qcom,mdss-block-prediction-enable: Block prediction mode of DSC enabled
> > >  
> > >    DSI Endpoint properties:
> > >    - remote-endpoint: For port@0, set to phandle of the connected panel/bridge's
> > > @@ -188,6 +195,14 @@ Example:
> > >  		qcom,master-dsi;
> > >  		qcom,sync-dual-dsi;
> > >  
> > > +		qcom,mdss-dsc-enabled;
> > 
> > To me the activation of DSC seems to be a property of the panel.
> 
> I think there are three parts to the problem
> 1. Panel needs to support it

In the case of DP there's bits to be read in the panel to figure this
out, for DSI panels this seems like a property that the panel (driver)
should know about.

> 2. Host needs to support it

Right, so this needs to be known by the driver. My suggestion is that we
derive it from the compatible or from the HW version.

> 3. Someone needs to decide to use when both the above conditions are
> met.
> 
> There are cases where above 1, 2 will be satisfied, but we might be okay
> without DSC too.. so how to decide when to do DSC :)
> 

Can we describe those cases? E.g. is it because enabling DSC would not
cause a reduction in clock speed that's worth the effort? Or do we only
use DSC for DSI when it allows us to squeeze everything into a single
link?

Regards,
Bjorn

> I feel it is more of a system property. And I also think that these
> parameters here are host configuration and not really for panel...
> 
> > 
> > > +		qcom,mdss-slice-height = <16>;
> > > +		qcom,mdss-slice-width = <540>;
> > > +		qcom,mdss-slice-per-pkt = <1>;
> > > +		qcom,mdss-bit-per-component = <8>;
> > > +		qcom,mdss-bit-per-pixel = <8>;
> > > +		qcom,mdss-block-prediction-enable;
> > 
> > Which of these properties relates to the DSC encoder and what needs to
> > be agreed with the sink? Can't we derive e.g. bpp from the information
> > we have from the attached panel already?
> 
> Let me go back and check on this a bit more
> 
> Thanks
> -- 
> ~Vinod
