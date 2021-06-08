Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0E3A06AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFHWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:18:35 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37742 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:18:34 -0400
Received: by mail-ot1-f49.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so21898274otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=1t7u9q3nwz2autO/xtf8MJUk6lpDM4DYMrf1MH8aW4Q=;
        b=nnJv9OsQARR+ciGzlrE04XLGFV0Ux9hu6Ve/m90ADK/OJWfgUtFa5VXf9rre6PLWaN
         LNJBnrT6y2ZueCu3zQ8Z3XEDG3zpgr+hsSnNo9wVaGY1PLXVOLR2eSRrW9umN/6gV4Me
         NOnl93Y3lguNQy2J2fb3oDj4vwuOs3DRJawuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=1t7u9q3nwz2autO/xtf8MJUk6lpDM4DYMrf1MH8aW4Q=;
        b=K9a/yVjEma6yyttkcMOxYqkAJvARCiLBCMEQl+3G+bg82zgeEp64mK7Ef/HD6q+4aP
         I0utmVmDnVCJMQ+q3P9oLhqPd1m3AlEeKo36rHHkAquhWr9pzE2LcrjcAaBM7FZ4BO9A
         HOQjD1U190vXrRrvSYS1njzEdpSGN70S8yq55oTXgmtzXUjBVWc9g30rhA/IO9uAIlJt
         kPPv3IVjhCDF0fKBa/LKsbBcO58dyFoteJahNpbDoOYKdUFT2eJ5Tlo3K+8UznVZH7wq
         KpeaPzXOdy+AYbFgu4gPX4hQkm2QWkJcHKrRDatH4Hrv6SRZALw1Y5L0Nbe2Ad+TpYyT
         ZKtA==
X-Gm-Message-State: AOAM532OkbSIHMpQukrQ/wUHr+IHbGZDvhBpH7eHhkIiuDbf51zwBIvj
        Z6UCoIjpaGY1W1+2rkx2apz/evrwrhnVQElLsMhSMg==
X-Google-Smtp-Source: ABdhPJyhL13bl002GGKwoydit/q9hRO2Cy7ITNXY5T1OOJafiJ0zxdlM0bxacz6SkRb5QZJX9/NiCtc2lHaGS2mp8d8=
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr7251410ota.34.1623190529833;
 Tue, 08 Jun 2021 15:15:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jun 2021 15:15:29 -0700
MIME-Version: 1.0
In-Reply-To: <YL6sY/1E5wLzMiP/@yoga>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga> <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
 <YLxX/YtegtbLmkri@builder.lan> <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
 <YL6sY/1E5wLzMiP/@yoga>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 8 Jun 2021 15:15:29 -0700
Message-ID: <CAE-0n50-X03sMyJdsw7s=Ue0dWXBo=iHOc0HxDQm5yh2J-uS3A@mail.gmail.com>
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

Quoting Bjorn Andersson (2021-06-07 16:31:47)
> On Mon 07 Jun 12:48 CDT 2021, khsieh@codeaurora.org wrote:
>
> > On 2021-06-05 22:07, Bjorn Andersson wrote:
> > > On Thu 03 Jun 16:56 CDT 2021, khsieh@codeaurora.org wrote:
> > >
> > > > On 2021-06-03 09:53, Bjorn Andersson wrote:
> > > > > On Thu 03 Jun 11:09 CDT 2021, Kuogee Hsieh wrote:
> > > [..]
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > > [..]
> > > > > > +                             power-domains = <&rpmhpd SC7180_CX>;
> > > > >
> > > > > Just curious, but isn't the DP block in the MDSS_GDCS? Or do we need to
> > > > > mention CX here in order for the opp framework to apply required-opps
> > > > > of CX?
> > > >
> > > > yes,
> > >
> > > If you want me, or other maintainers, to spend any time reviewing or
> > > applying your patches going forward then you need to actually bother
> > > replying properly to the questions asked.
> > >
> > > Thanks,
> > > Bjorn
> >
> > Sorry about the confusion. What I meant is that even though DP controller is
> > in the MDSS_GDSC
> > power domain, DP PHY/PLL sources out of CX. The DP link clocks have a direct
> > impact
> > on the CX voltage corners. Therefore, we need to mention the CX power domain
> > here. And, since
> > we can associate only one OPP table with one device, we picked the DP link
> > clock over other
> > clocks.
>
> Thank you, that's a much more useful answer.
>
> Naturally I would think it would make more sense for the PHY/PLL driver
> to ensure that CX is appropriately voted for then, but I think that
> would result in it being the clock driver performing such vote and I'm
> unsure how the opp table for that would look.
>
> @Stephen, what do you say?
>

Wouldn't the PHY be the one that sets some vote? So it wouldn't be the
clk driver, and probably not from the clk ops, but instead come from the
phy ops via phy_enable() and phy_configure().

By the way, there's nothing wrong with a clk device doing power domain
"stuff", except for that we haven't plumbed it into the clk framework
properly and I'm fairly certain our usage of runtime PM in the clk
framework today underneath the prepare_lock is getting us into trouble
or will get us there soon.
