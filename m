Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FF3AD3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhFRUvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhFRUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:51:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB88C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:49:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1767623otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+oLF+0y8D03kq1ljHTaiFTX3oW0ul23QTjCdRgRqCow=;
        b=CeAachcWpT6uB+4FTIdJRCj9tyRHmQWcuzvtygJGAiFVjW1uv5cFOsgffy7cvhCZyM
         4v3Pn2Zv4lsYe6XG4fjdrDtFDwgQ4MnMlT+6QreBF/Cs4F3M/yiPjPPktq7KcqBX6cdR
         D7dqGEP3/Ved9TXnS0JDwkxtpItWZO+HXK/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+oLF+0y8D03kq1ljHTaiFTX3oW0ul23QTjCdRgRqCow=;
        b=DfNo2JfTiB4J8+owiJWcH20H2rM8k/Cw5DuFldzYbHlW8tyWVz+1NWmLdsFo0P6qiy
         BB6bFWN3EvxxoO1tNMLgQUELBfaxeyHZ7jYK2JLJiiii7Sk0tcjy6+CNbyGJ03avPIuV
         uznPa4UQnEtdsAk4YB/0u11iyTuZTjyAtsTJgkKdLIRh0tqqElQ2P/fOR9HSyL1a2+B1
         wdyaIui4Ka8hTZCFnpgKeG1NNtGZjcJBd622vrfZsJKR0Al4PV38Z2alI+vnOniX18dT
         IILp0L7I/yvCTaJR9A491pbTwbNz1gMotS4nT/dtpZC9ZiHZu2eiVGFXax/A/QC/lV9I
         lDJA==
X-Gm-Message-State: AOAM5331nX1O0+CyRk8CXfhNEcOOarzsM+KcVquwOH+Vmtp/jERUhCZn
        kQA068O//gelTbUpQowRdNBlaRy0DBLXwUlWXmaFNA==
X-Google-Smtp-Source: ABdhPJwtCvyzMkiK+AZo4n1VYcARAx9a6C/WjhtCuramvnKscLd3N8c0IF0P9iekwu92e+H3BDn7CiYlbM4Xev4cSEo=
X-Received: by 2002:a9d:624d:: with SMTP id i13mr2752232otk.34.1624049376379;
 Fri, 18 Jun 2021 13:49:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Jun 2021 13:49:35 -0700
MIME-Version: 1.0
In-Reply-To: <21dc5c9fc2efdc1a0ba924354bfd9d75@codeaurora.org>
References: <YLkI/6ItCz+SbbuJ@yoga> <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
 <YL6sY/1E5wLzMiP/@yoga> <CAE-0n50-X03sMyJdsw7s=Ue0dWXBo=iHOc0HxDQm5yh2J-uS3A@mail.gmail.com>
 <YL/uj+t+BFkII1Fh@yoga> <CAE-0n50WP25kRQkWMVdDZGsZWBXwfbVSTFKyBLF7f8Mp3x2Wfg@mail.gmail.com>
 <YL/wWdRs6e/eECiC@yoga> <CAE-0n51GM65rZVJgXuHy6FerJorHeHKf2W31GijG8sDEhaX_KQ@mail.gmail.com>
 <YL/41hWz8xB+jSeO@yoga> <21dc5c9fc2efdc1a0ba924354bfd9d75@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 18 Jun 2021 13:49:35 -0700
Message-ID: <CAE-0n52J_mLsmXLS+skZn2u3k9dhn+GcHeXi0B2BeQyQxEUL9A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, khsieh@codeaurora.org
Cc:     robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-06-10 09:54:05)
> On 2021-06-08 16:10, Bjorn Andersson wrote:
> > On Tue 08 Jun 17:44 CDT 2021, Stephen Boyd wrote:
> >
> >> Honestly I suspect the DP PHY is _not_ in the CX domain as CX is for
> >> digital logic. Probably the PLL is the hardware that has some minimum
> >> CX
> >> requirement, and that flows down into the various display clks like
> >> the
> >> link clk that actually clock the DP controller hardware. The mdss_gdsc
> >> probably gates CX for the display subsystem (mdss) so if we had proper
> >> corner aggregation logic we could indicate that mdss_gdsc is a child
> >> of
> >> the CX domain and then make requests from the DP driver for particular
> >> link frequencies on the mdss_gdsc and then have that bubble up to CX
> >> appropriately. I don't think any of that sort of code is in place
> >> though, right?
> >
> > I haven't checked sc7180, but I'm guessing that it's following the
> > other
> > modern platforms, where all the MDSS related pieces (including e.g.
> > dispcc) lives in the MMCX domain, which is separate from CX.
> >
> > So the parent of MDSS_GDSC should be MMCX, while Kuogee's answer (and
> > the dp-opp-table) tells us that the PLL lives in the CX domain.

Isn't MMCX a "child" of CX? At least my understanding is that MMCX is
basically a GDSC that clamps all of multimedia hardware block power
logic so that the leakage is minimized when multimedia isn't in use,
i.e. the device is suspended. In terms of bumping up the voltage we have
to pin that on CX though as far as I know because that's the only power
domain that can actually change voltage, while MMCX merely gates that
voltage for multimedia.

> >
> >
> > PS. While this goes for the QMPs the DSI and eDP/DP PHYs (and PLLs)
> > seems to live in MMCX.
> >
> > Regards,
> > Bjorn
>
> Dp link clock rate is sourced from phy/pll (vco). However it is possible
> that different link clock rate
> are sourced from same vco (phy/pll) rate. Therefore I think CX rail
> voltage level is more proper to
> be decided base on link clock rate.
>
