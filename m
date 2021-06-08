Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446B43A0748
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhFHWra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:47:30 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37883 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFHWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:47:29 -0400
Received: by mail-oi1-f180.google.com with SMTP id h9so23217381oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vK1DB3ja5xfgrUtd+VQum3f44icaE1l0DPwqifdZgI0=;
        b=F/QEOIuItw8Ek1r/l6/FFbACr7K6wavqhwXAUcXNdVn22Y1+Tgm6fEm84iVWBNotzE
         V/xFczwrPLmiEK7FWdt2SjDmaa/YL7vtczm2P533PDvmeaxzOcK2iVLnA1dK/NuJEHQ0
         xej7tv+0w93r+c/FZC3cqox7OLdefAM2CE/Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vK1DB3ja5xfgrUtd+VQum3f44icaE1l0DPwqifdZgI0=;
        b=UNjYsqdpbg+NxhY/dcMETJr7D1mlm3vDtFqNOz1bVYyUBPxUu27cMPu/IgNG1Tv0i3
         33nkvLdAzm7Bg4YmO9bhteWaZ3ljaMDPIQS8UmGnLzewqKS+559huTnY+N+OgnJ2nP10
         VpZjPn6289pXeaBoLoZ05FV7zLWA5uUMQ3DZ7GiFUXuTW0ggWcngheKj6DWpGxU0mXdT
         vEQCb3lnKf2iUu7ZZ+XZ/g9LkvdeYaQ7IYCjnzLUNOcDBT+ycrLT9SCrFEtPBhCBWLiX
         1iTNuNVsoJjg75cphVRHPHrBOl7X3qSZgyaPekpq3SOr7h6ubL/Ys987cykPk1FSs3mR
         nlQQ==
X-Gm-Message-State: AOAM532UXme0HrzWFq28j6vudymqb5pFWShXsD7FLWHhLIoaDQao7pbj
        t5I6h417YpmkjQb/4uzVFsx1PzP/BKx5aw5bkv/pSQ==
X-Google-Smtp-Source: ABdhPJzXO4M75BrnIbzQxlkzWZ5A3G/HUmijr4z0C9M2sd3N9NMuUcemw/YoTKbEJqQWCTf2IdeJnKgRiAszb3FoiBQ=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr4591500oiv.166.1623192259105;
 Tue, 08 Jun 2021 15:44:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jun 2021 15:44:18 -0700
MIME-Version: 1.0
In-Reply-To: <YL/wWdRs6e/eECiC@yoga>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga> <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
 <YLxX/YtegtbLmkri@builder.lan> <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
 <YL6sY/1E5wLzMiP/@yoga> <CAE-0n50-X03sMyJdsw7s=Ue0dWXBo=iHOc0HxDQm5yh2J-uS3A@mail.gmail.com>
 <YL/uj+t+BFkII1Fh@yoga> <CAE-0n50WP25kRQkWMVdDZGsZWBXwfbVSTFKyBLF7f8Mp3x2Wfg@mail.gmail.com>
 <YL/wWdRs6e/eECiC@yoga>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 8 Jun 2021 15:44:18 -0700
Message-ID: <CAE-0n51GM65rZVJgXuHy6FerJorHeHKf2W31GijG8sDEhaX_KQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     khsieh@codeaurora.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-06-08 15:34:01)
> On Tue 08 Jun 17:29 CDT 2021, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2021-06-08 15:26:23)
> > > On Tue 08 Jun 17:15 CDT 2021, Stephen Boyd wrote:
> > >
> > > > Quoting Bjorn Andersson (2021-06-07 16:31:47)
> > > > > On Mon 07 Jun 12:48 CDT 2021, khsieh@codeaurora.org wrote:
> > > > >
> > > > > > Sorry about the confusion. What I meant is that even though DP controller is
> > > > > > in the MDSS_GDSC
> > > > > > power domain, DP PHY/PLL sources out of CX. The DP link clocks have a direct
> > > > > > impact
> > > > > > on the CX voltage corners. Therefore, we need to mention the CX power domain
> > > > > > here. And, since
> > > > > > we can associate only one OPP table with one device, we picked the DP link
> > > > > > clock over other
> > > > > > clocks.
> > > > >
> > > > > Thank you, that's a much more useful answer.
> > > > >
> > > > > Naturally I would think it would make more sense for the PHY/PLL driver
> > > > > to ensure that CX is appropriately voted for then, but I think that
> > > > > would result in it being the clock driver performing such vote and I'm
> > > > > unsure how the opp table for that would look.
> > > > >
> > > > > @Stephen, what do you say?
> > > > >
> > > >
> > > > Wouldn't the PHY be the one that sets some vote? So it wouldn't be the
> > > > clk driver, and probably not from the clk ops, but instead come from the
> > > > phy ops via phy_enable() and phy_configure().
> > > >
> > >
> > > If I understand the logic correctly *_configure_dp_phy() will both
> > > configure the vco clock and "request" the clock framework to change the
> > > rate.
> > >
> > > So I presume what you're suggesting is that that would be the place to
> > > cast the CX corner vote?
> >
> > Yes that would be a place to make the CX vote. The problem is then I
> > don't know where to drop the vote. Is that when the phy is disabled?
>
> We do pass qcom_qmp_phy_power_off() and power down the DP part as DP
> output is being disabled. So that sounds like a reasonable place to drop
> the vote for the lowest performance state.
>

So then will the corner vote be in place when the PHY isn't actually
powered up? That will be bad for power. The phy configure code will need
to know if the phy is enabled and then only put in the vote when the phy
is enabled, otherwise wait for enable to make the corner vote.

Honestly I suspect the DP PHY is _not_ in the CX domain as CX is for
digital logic. Probably the PLL is the hardware that has some minimum CX
requirement, and that flows down into the various display clks like the
link clk that actually clock the DP controller hardware. The mdss_gdsc
probably gates CX for the display subsystem (mdss) so if we had proper
corner aggregation logic we could indicate that mdss_gdsc is a child of
the CX domain and then make requests from the DP driver for particular
link frequencies on the mdss_gdsc and then have that bubble up to CX
appropriately. I don't think any of that sort of code is in place
though, right?
