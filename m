Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D361241DE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbhI3QHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348160AbhI3QHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:07:14 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D646C06176E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:05:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q16so7882939oiw.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYKsPBiDJqWgn94z0UrisRrDiPIkl/InaR+MbnDzd8o=;
        b=XhAVOr/0A4R/z99tlCeSSHraD2rZ5vHyFbhTb43A/MXaFjTdRn+YxPnSnr1gS5DDF9
         8uKdNk+GEVCTF6jBsbp7QiwGS2/UWZ0UOBqGCAkVw+TITRFWXcCa1t9MKQX3c1GRGt1F
         jvYccHHP5wBGLZcruY3bA3Yfi2fTnH0pmQHx4S/KXKGyM/DPAen3gCCaglOumcRoiejK
         vsApbVLIdx6ZrUVI6P+zV9rtBwob8R8V/bdBTbtI75T39PmMgTDsZUi1GOQOodK2jkUp
         Azjel8ZfF9N+C2z29j3eN1LjCz/NSn2+rzolTfTiGoU3WUhSwJAPblDHUP/jM6fE32I/
         CGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYKsPBiDJqWgn94z0UrisRrDiPIkl/InaR+MbnDzd8o=;
        b=GX6pxOgvfghpoRWRfQS/Q1eY00G0SeObs5gBVXdYS3Qte6l36NlRNVWpFF7tNhzLm9
         Qb5+LHWOA31xAOuazm39+MgnkEprsSdElXRuFFLGUqhECJ/2j0VR9wMwNwe8O2tqKFAF
         MryjC/FgU+GbDSXekNL/7++ocP7L7bZ0UPDqmx2R8jA8x9FmsbjvS5QR/LPKqGx8glZw
         dXNr7bYHVT22rKoWYADSzOoWlvbspU5luWBg/NWzEkqg1Q/1Vg2j74clD7I0ICsG4AKH
         Ld+7TYp7UlpFfgRuT42jdUCl1ve4+dsZx7HJVfI4xBdyoDY2bok/8YcmeFrAZ9vFJB4k
         vClA==
X-Gm-Message-State: AOAM531Xu5bLQiIf37ESOBc9lLJXof2LmCXzWcgD6rKjKobxbHrPKzVE
        Ge7iXi/O5RuZu7hpD3+Oax5urg==
X-Google-Smtp-Source: ABdhPJzkcIYZeTpr8veDVdd9USNDj/qqDvR5BA6ShZH//YGQawtDR/aJqibAv9FK+9S05XHjuwQutQ==
X-Received: by 2002:a05:6808:144b:: with SMTP id x11mr3467780oiv.111.1633017931479;
        Thu, 30 Sep 2021 09:05:31 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b2sm248127ooi.25.2021.09.30.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:05:31 -0700 (PDT)
Date:   Thu, 30 Sep 2021 09:07:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Subject: Re: [PATCH 1/3] dt-bindings: usb: qcom,dwc3: Add multi-pd bindings
 for dwc3 qcom
Message-ID: <YVXguCSrsdMoCCXH@ripper>
References: <1630346073-7099-1-git-send-email-sanm@codeaurora.org>
 <1630346073-7099-2-git-send-email-sanm@codeaurora.org>
 <YTduDqCO9aUyAsw1@ripper>
 <e947695b-cd50-391b-3de9-3c028dbddab2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e947695b-cd50-391b-3de9-3c028dbddab2@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Sep 02:41 PDT 2021, Sandeep Maheswaram wrote:

> 
> On 9/7/2021 7:20 PM, Bjorn Andersson wrote:
> > On Mon 30 Aug 10:54 PDT 2021, Sandeep Maheswaram wrote:
> > 
> > > Add multi pd bindings to set performance state for cx domain
> > > to maintain minimum corner voltage for USB clocks.
> > > 
> > > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > > ---
> > >   Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 13 ++++++++++++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > index e70afc4..838d9c4 100644
> > > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > @@ -41,7 +41,18 @@ properties:
> > >     power-domains:
> > >       description: specifies a phandle to PM domain provider node
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    items:
> > > +      - description: optional,cx power domain
> > > +      - description: USB gdsc power domain
> > > +
> > > +  power-domain-names:
> > > +     items:
> > > +      - const: cx
> > > +      - const: usb_gdsc
> > But "usb_gdsc" is a subdomain of "cx", why can't we describe this fact
> > in gcc?
> > 
> > Regards,
> > Bjorn
> Thanks for your review.
> Any idea on how can this be described in gcc ? Can you point any reference
> for this .
> 

There's a series from Dmitry that defines such a relationship between
MDSS_GDSC and the MMCX domain on SM8250. This seems like a continuation
of that support, given that we have multiple parent domains (cx, mx
etc).

You can find that discussion here:

https://lore.kernel.org/all/20210727202004.712665-1-dmitry.baryshkov@linaro.org/

Regards,
Bjorn

> Regards
> Sandeep
> > > +
> > > +  required-opps:
> > > +    description: specifies the performance state to cx power domain
> > >     clocks:
> > >       description:
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 
