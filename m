Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41203AD487
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhFRVoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhFRVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:44:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:41:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t40so12077382oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HEAuigaKYRmeY+WM5XLEktX0+rBVmYO66uMcr8Tpv8k=;
        b=qKuYzrv6j4NzmU3yjTgh08cBfgpCmtwmdOO7VGZ7x0Wpyin21OENhZDu7wYnqoPHs0
         HSf75CkxWeZDgoBEaPxChHYUt5+6a/LZp+UQfFNLL72O/1pm3JfnKtHcimfPf1wvGFsK
         poM9I5TIeRpi+AimpmuU9P+DEjUlJCP5DvFRLmNJ3ohBlA38DBiGpq/qbXooI+RTeqE2
         QEZBQesKMQb1KSBaVQP/GcKcH5JDJNePOIK0Tjz2UnVD/BrvTieA7bjgoJJ7mSpQILtx
         pegolu/d0kmopoCrWrq8d+aWTjSm/xsplTaxmVBEc1adWHwRzLxv8kFO639cXh2f2XTX
         R9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HEAuigaKYRmeY+WM5XLEktX0+rBVmYO66uMcr8Tpv8k=;
        b=EqEPqVI0T/KmcLZ3xdTtGT1kFk+JAFzl5rghvuSZ3Vd/Y9O8hmTTi7tndEvLT6kj9R
         WYXgpjalMAHQlGZeOyh4JmBWKUkeyjQME8JqVUKDNVRljMXQ2g4tMx1mgNVFLM9Xr64j
         FEdu7j2KUjjyoGvn0lXhlHbbbwyWc/y4oLFUBBtoCh7k1UyI+MJf3o+MKedNcPMHM+OH
         4WyysNwk5+/QEVFoBRFzLqKJjP6CifrYgptE36hn+Yg1Cw8K/k/2ah/OWRtrqAT3o8Ru
         XrwoTGGfsAOA9KXnsLu0Z42hypgqPvlDSQOiukq+iHMrgLuoZ36XvRqJHwF67rMi9rkn
         G/Uw==
X-Gm-Message-State: AOAM5326HLMKsgEDwqkexc958VqxN8bBAKggv3MjHckyL24pQdRiy/sh
        X7pP0Fmgp4IYXbFgHHn9ePYWXQ==
X-Google-Smtp-Source: ABdhPJw+EvH62tnCFbU9WxcWHYUQU643zznk/FLKiDJaeLJ8T0g0z4cu85QEzzdO6spdx+DKHd9AHQ==
X-Received: by 2002:aca:de07:: with SMTP id v7mr15863677oig.8.1624052512628;
        Fri, 18 Jun 2021 14:41:52 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 94sm2251023otj.33.2021.06.18.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:41:51 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:41:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     khsieh@codeaurora.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
Message-ID: <YM0THrlJlv7ADW8w@builder.lan>
References: <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
 <YL6sY/1E5wLzMiP/@yoga>
 <CAE-0n50-X03sMyJdsw7s=Ue0dWXBo=iHOc0HxDQm5yh2J-uS3A@mail.gmail.com>
 <YL/uj+t+BFkII1Fh@yoga>
 <CAE-0n50WP25kRQkWMVdDZGsZWBXwfbVSTFKyBLF7f8Mp3x2Wfg@mail.gmail.com>
 <YL/wWdRs6e/eECiC@yoga>
 <CAE-0n51GM65rZVJgXuHy6FerJorHeHKf2W31GijG8sDEhaX_KQ@mail.gmail.com>
 <YL/41hWz8xB+jSeO@yoga>
 <21dc5c9fc2efdc1a0ba924354bfd9d75@codeaurora.org>
 <CAE-0n52J_mLsmXLS+skZn2u3k9dhn+GcHeXi0B2BeQyQxEUL9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52J_mLsmXLS+skZn2u3k9dhn+GcHeXi0B2BeQyQxEUL9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Jun 15:49 CDT 2021, Stephen Boyd wrote:

> Quoting khsieh@codeaurora.org (2021-06-10 09:54:05)
> > On 2021-06-08 16:10, Bjorn Andersson wrote:
> > > On Tue 08 Jun 17:44 CDT 2021, Stephen Boyd wrote:
> > >
> > >> Honestly I suspect the DP PHY is _not_ in the CX domain as CX is for
> > >> digital logic. Probably the PLL is the hardware that has some minimum
> > >> CX
> > >> requirement, and that flows down into the various display clks like
> > >> the
> > >> link clk that actually clock the DP controller hardware. The mdss_gdsc
> > >> probably gates CX for the display subsystem (mdss) so if we had proper
> > >> corner aggregation logic we could indicate that mdss_gdsc is a child
> > >> of
> > >> the CX domain and then make requests from the DP driver for particular
> > >> link frequencies on the mdss_gdsc and then have that bubble up to CX
> > >> appropriately. I don't think any of that sort of code is in place
> > >> though, right?
> > >
> > > I haven't checked sc7180, but I'm guessing that it's following the
> > > other
> > > modern platforms, where all the MDSS related pieces (including e.g.
> > > dispcc) lives in the MMCX domain, which is separate from CX.
> > >
> > > So the parent of MDSS_GDSC should be MMCX, while Kuogee's answer (and
> > > the dp-opp-table) tells us that the PLL lives in the CX domain.
> 
> Isn't MMCX a "child" of CX? At least my understanding is that MMCX is
> basically a GDSC that clamps all of multimedia hardware block power
> logic so that the leakage is minimized when multimedia isn't in use,
> i.e. the device is suspended. In terms of bumping up the voltage we have
> to pin that on CX though as far as I know because that's the only power
> domain that can actually change voltage, while MMCX merely gates that
> voltage for multimedia.
> 

No, MMCX is a separate rail from CX, which powers the display blocks and
is parent of MDSS_GDSC. But I see in rpmhpd that sc7180 is not one of
these platforms, so I presume this means that the displayport controller
thereby sits in MDSS_GDSC parented by CX.

But in line with what you're saying, the naming of the supplies to the
QMP indicates that the power for the PLLs is static. As such the only
moving things would be the clock rates in the DP controller and as such
that's what needs to scale the voltage.

So if the resources we're scaling is the clocks in the DP controller
then the gist of the patch is correct. The only details I see is that
the DP controller actually sits in MDSS_GDSC - while it should control
the level of its parent (CX). Not sure if we can describe that in a
simple way.


PS. Why does the node name of the opp-table have to be globally unique?

Regards,
Bjorn

> > >
> > >
> > > PS. While this goes for the QMPs the DSI and eDP/DP PHYs (and PLLs)
> > > seems to live in MMCX.
> > >
> > > Regards,
> > > Bjorn
> >
> > Dp link clock rate is sourced from phy/pll (vco). However it is possible
> > that different link clock rate
> > are sourced from same vco (phy/pll) rate. Therefore I think CX rail
> > voltage level is more proper to
> > be decided base on link clock rate.
> >
