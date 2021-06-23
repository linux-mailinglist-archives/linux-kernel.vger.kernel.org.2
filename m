Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAB3B11F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFWCzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhFWCzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:55:17 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93866C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 19:52:59 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so378981ooo.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iQPRI9VlPTgzdRBNR9cu3Y1yAK0KjUj8zkwoLnfL0b4=;
        b=lKjieprEHNd7Gb8ed6WjZQQ07ZiX+Sd9cNiqccT7+sEcQDfrm+HHCEBQexAKJTcgA7
         MX72dblVd23f/ukS4JXLpuijOSA7yQYSqe5XTe9TF/i4vJ3mTUwTE70m873fS/ZgmQlJ
         liH1VEjGJ7790IVoi0uTbd06WZBzluEmi9RcMPhuFEV/SctmZmCZkZJ17mMiWA8zre0s
         tklNAYxjXM0QPKEyyZF2vChePNcztFFyuwmKMfhpzxiEAOghVKCwrWzKeqC4/eK9dbMS
         gsDErwpgmyMGUNgPFHq2k2d/+5SmQfUCJuRYBba/T9S83Arq0t4uXMVCVQ7RTyoLxxPI
         RHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQPRI9VlPTgzdRBNR9cu3Y1yAK0KjUj8zkwoLnfL0b4=;
        b=pWmxQowyValRda1VdlxPItK7mA8gziv+HSBTYB8mtuc+vN1T7tkUc5SopUYeFukhuv
         h9dZqO5gjIu+893Ue7AeBmj5o4LUFWqldjxwYmlZue0l1kpUzYsj702ga5rIKX5x3JPJ
         bglh4glPvDNFSezJ39rSE22D9tz75G0apZLg74Bba0NWrsF7sSvrBqDXuahH2yzb1QfU
         m8z0ZqSSqLiU1oi2whbEFUmtOqufaqToc2cc3WlmRorogG+nrUZ5vCFo/Mjz3bProy1W
         g81Ygcb7K9RZPqrwmkxjkGNJmsd9MzuXppAMJo8XbNek6+rol/yH0Se5hcDol1JcWGOv
         4xBA==
X-Gm-Message-State: AOAM531XAzLhwauVbkl1Bj3HrU6C593WmkFFlQQCSB5NlV8uELCvvbsz
        bBS4GC0ZFeUQ0qZtmhMIQy0+qg==
X-Google-Smtp-Source: ABdhPJwPMPpfbBtL3Z9YpwuUqIcllFoSMkx42NLNfW0CK2SsGCgoPgM5m65L/Rj3yow7GnTvEMSzAw==
X-Received: by 2002:a4a:4fc8:: with SMTP id c191mr6038147oob.68.1624416778780;
        Tue, 22 Jun 2021 19:52:58 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b198sm4718927oii.19.2021.06.22.19.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 19:52:58 -0700 (PDT)
Date:   Tue, 22 Jun 2021 21:52:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     khsieh@codeaurora.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
Message-ID: <YNKiB3ZEtOQ+T/MX@yoga>
References: <CAE-0n50-X03sMyJdsw7s=Ue0dWXBo=iHOc0HxDQm5yh2J-uS3A@mail.gmail.com>
 <YL/uj+t+BFkII1Fh@yoga>
 <CAE-0n50WP25kRQkWMVdDZGsZWBXwfbVSTFKyBLF7f8Mp3x2Wfg@mail.gmail.com>
 <YL/wWdRs6e/eECiC@yoga>
 <CAE-0n51GM65rZVJgXuHy6FerJorHeHKf2W31GijG8sDEhaX_KQ@mail.gmail.com>
 <YL/41hWz8xB+jSeO@yoga>
 <21dc5c9fc2efdc1a0ba924354bfd9d75@codeaurora.org>
 <CAE-0n52J_mLsmXLS+skZn2u3k9dhn+GcHeXi0B2BeQyQxEUL9A@mail.gmail.com>
 <YM0THrlJlv7ADW8w@builder.lan>
 <CAE-0n53Zr-w5m-eFhLM2BVmphcYb_M4=s5je3Y7Lg6=onNo=uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53Zr-w5m-eFhLM2BVmphcYb_M4=s5je3Y7Lg6=onNo=uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jun 15:23 CDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-06-18 14:41:50)
> > On Fri 18 Jun 15:49 CDT 2021, Stephen Boyd wrote:
> >
> > > Quoting khsieh@codeaurora.org (2021-06-10 09:54:05)
> > > > On 2021-06-08 16:10, Bjorn Andersson wrote:
> > > > > On Tue 08 Jun 17:44 CDT 2021, Stephen Boyd wrote:
> > > > >
> > > > >> Honestly I suspect the DP PHY is _not_ in the CX domain as CX is for
> > > > >> digital logic. Probably the PLL is the hardware that has some minimum
> > > > >> CX
> > > > >> requirement, and that flows down into the various display clks like
> > > > >> the
> > > > >> link clk that actually clock the DP controller hardware. The mdss_gdsc
> > > > >> probably gates CX for the display subsystem (mdss) so if we had proper
> > > > >> corner aggregation logic we could indicate that mdss_gdsc is a child
> > > > >> of
> > > > >> the CX domain and then make requests from the DP driver for particular
> > > > >> link frequencies on the mdss_gdsc and then have that bubble up to CX
> > > > >> appropriately. I don't think any of that sort of code is in place
> > > > >> though, right?
> > > > >
> > > > > I haven't checked sc7180, but I'm guessing that it's following the
> > > > > other
> > > > > modern platforms, where all the MDSS related pieces (including e.g.
> > > > > dispcc) lives in the MMCX domain, which is separate from CX.
> > > > >
> > > > > So the parent of MDSS_GDSC should be MMCX, while Kuogee's answer (and
> > > > > the dp-opp-table) tells us that the PLL lives in the CX domain.
> > >
> > > Isn't MMCX a "child" of CX? At least my understanding is that MMCX is
> > > basically a GDSC that clamps all of multimedia hardware block power
> > > logic so that the leakage is minimized when multimedia isn't in use,
> > > i.e. the device is suspended. In terms of bumping up the voltage we have
> > > to pin that on CX though as far as I know because that's the only power
> > > domain that can actually change voltage, while MMCX merely gates that
> > > voltage for multimedia.
> > >
> >
> > No, MMCX is a separate rail from CX, which powers the display blocks and
> > is parent of MDSS_GDSC. But I see in rpmhpd that sc7180 is not one of
> > these platforms, so I presume this means that the displayport controller
> > thereby sits in MDSS_GDSC parented by CX.
> >
> > But in line with what you're saying, the naming of the supplies to the
> > QMP indicates that the power for the PLLs is static. As such the only
> > moving things would be the clock rates in the DP controller and as such
> > that's what needs to scale the voltage.
> >
> > So if the resources we're scaling is the clocks in the DP controller
> > then the gist of the patch is correct. The only details I see is that
> > the DP controller actually sits in MDSS_GDSC - while it should control
> > the level of its parent (CX). Not sure if we can describe that in a
> > simple way.
> 
> Right. I'm not sure things could be described any better right now. If
> we need to change this to be MDSS_GDSC power domain and control the
> level of the parent then I suppose we'll have to make some sort of DT
> change and pair that with a driver change. Maybe if that happens we can
> just pick a new compatible and leave the old code in place.
> 

I would prefer that we stay away from making up a new compatible for
that, but let's see when we get there.

> Are you happy enough with this current patch?
> 

Yes, I think this looks good.

> >
> >
> > PS. Why does the node name of the opp-table have to be globally unique?
> 
> Presumably the opp table node name can be 'opp-table' as long as it
> lives under the node that's using it. If the opp table is at / or /soc
> then it will need to be unique. I'd prefer just 'opp-table' if possible.

I asked the same question (if it has to be globally unique) in the patch
adding sdhci nodes for sc7280 and I didn't get a sufficient answer...

So now I do want to know why "opp-table" wouldn't be sufficient name for
these device-internal nodes.

Regards,
Bjorn
