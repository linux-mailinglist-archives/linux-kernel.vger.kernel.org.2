Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C953CBEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhGPVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhGPVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 17:52:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47840C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:49:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11432499otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GQDiZqD2pdLaFLvt6YO5hNfdrLCG8I79aRHQBk9fUg8=;
        b=A1voHxkPWVXJ574pJpTR3a+8/EmLeYnM6Vnn+05dnKzAXUHI0NNt/AmTnpGtPl9DpI
         y3D+IC2/VJ2Xbp2y2Kp9lms2SVOWSCfXVGx7zDVcTzmdVn8N2dyV1gSZSvRB1XcfthF+
         BVHvXjKEIr/6DUBT73WFwVXNgTkJEx2XlsnNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GQDiZqD2pdLaFLvt6YO5hNfdrLCG8I79aRHQBk9fUg8=;
        b=kSjcsZKJD684sjQlG0WUURWNGFT/yID4mrr55kOFaZb1XiShHIa65bqritAgMm9Jpk
         XL+1nEbm2fBCNptlK64VhZonRG9sUshAmu+nwRnO5JKrIqUHY58dazZKSufp2MGc0YIs
         X6fsgbP1eDpgCYWBbditmlfrUye7c15yRvaxgU337xeaybreqbp+w8mDcrqNaSURJkZL
         Sqm1dGt+JAECJQw9NypwG17073dJiMRE/HQj0p61+/DQ1zTQF1EeVtpnwiYOs+yrqIfi
         oez8Kgv3xFn43QhGn8mo5e/eSiVWxcG9GHH4Us/r98oh88kPVebR0Vcdnv9mijzlAfS7
         rJEg==
X-Gm-Message-State: AOAM530K2KOqAhJAFnl7UkSdVjfFk8Z3r/ZYje96hiea9fqA1EcZubW7
        veNLAa3HWSZ7d/kQYwZwlj7oPXgU9omI5A/30hVbiA==
X-Google-Smtp-Source: ABdhPJwlEwvL0WjNbQUy+fXj6ZREuGVXfD0zE/qGrqA2YbvgWdQaHCOUy4fpVloWIh9CgMJba4/mUUCebsPCHWXxZ+Y=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr9744534otl.233.1626472156558;
 Fri, 16 Jul 2021 14:49:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jul 2021 23:49:16 +0200
MIME-Version: 1.0
In-Reply-To: <YPHxfHPC/faq/y+J@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org> <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com> <YPHxfHPC/faq/y+J@yoga>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 16 Jul 2021 23:49:16 +0200
Message-ID: <CAE-0n50qx80cMFPJ1x9rc+EMR1L+j2CUMyDjWAbnE9mPHjf-TQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-16 13:52:12)
> On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2021-07-16 13:18:56)
> > > On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
> > >
> > > > qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> > > > Though qup-i2c does not support DVFS, it still needs to vote for a
> > > > performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> > > > requirement.
> > > >
> > >
> > > Sounds good, but...
> > >
> > > > Use 'required-opps' to pass this information from
> > > > device tree, and also add the power-domains property to specify
> > > > the CX power-domain.
> > > >
> > >
> > > ..is the required-opps really needed with my rpmhpd patch in place?
> > >
> >
> > Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
> > CX.
>
> On e.g. sm8250 the first available non-zero corner presented in cmd-db
> is low_svs.

Indeed. On sc7180 it's not the first non-zero corner. I suppose
retention for CX isn't actually used when the SoC is awake so your
rpmhpd patch is putting in a vote for something that doesn't do anything
at runtime for CX? I imagine that rpmh only sets the aggregate corner to
retention when the whole SoC is suspended/sleeping, otherwise things
wouldn't go very well. Similarly, min_svs may be VDD minimization? If
so, those first two states are basically states that shouldn't be used
at runtime, almost like sleep states.

>
> And if this (which?) clock requires a higher corner than the lowest
> possible in order to tick at this "lowest" frequency, I'm certainly
> interested in some more details.
>
