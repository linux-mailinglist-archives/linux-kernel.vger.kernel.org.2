Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2415B43D75D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJ0XPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJ0XPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:15:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0978C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:13:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v65so5766222ioe.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl0KiyZVmnRa9RIsZlZ/dKBg5oxrwgNJJclLrbASD8g=;
        b=HjFzfoLJ+HriIHgi6MmL9orHjnaLdbN7A06ITgUTPEL1Gnfof/gyL4GBHhc6Fepxwb
         8vZrGwr+DOoKI8CPHpsQpT4Ksl/Adasiqn7vJ52uqBFWis6zN6KqTLNnZLwWoesiX0wa
         Rogrcleh20EWM10gudKnGxlNQELGWDArr4k3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl0KiyZVmnRa9RIsZlZ/dKBg5oxrwgNJJclLrbASD8g=;
        b=VRsxevAhTh1iNlnVRIw23SBspefL3l0gJ3m/7HJtaSRlhYzUk9UyHcE+7FpnqHECl7
         gFeWyZn3LPsWgdy6HyghDcONngEc7bBvOFoX3INOOLtU2bwhsGHxISQr7kPO6M7abB8x
         j5ha2N2n6cU99Zc+o7HTwVIFJKzvfizNt5WdqIvsQotCW196lf7C1Rq9ElCHRB4jfig/
         WUGKmEnIPgSz0fiwrXQ0+lU/LDblgcZHF2abHbpxZFgRec22w3GwkCcYG8aGRKxqL3hH
         BLFCjh7JGmAhHAsOdTj65oA3yqGzuQI6r2PiIRp2U8EDCKjX2DMxRjo0yc/fh3p242Kz
         KalA==
X-Gm-Message-State: AOAM531S+a1J3eUvEayXkY3ik5EtrJqbgEmA6XrFavUndwHYJM88XwzQ
        ylPaFaa5hhZJcwTUEXBy6ZXpVB55qA8LGQ==
X-Google-Smtp-Source: ABdhPJyR29HrpsRxIVgc1t/RRDIyrMtdBpeJFylBJR/Mj7gEwo8wYRNobWflAAD0YBPSEp3aW1rXHw==
X-Received: by 2002:a02:cf1b:: with SMTP id q27mr537227jar.93.1635376402799;
        Wed, 27 Oct 2021 16:13:22 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id c3sm685652ili.33.2021.10.27.16.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 16:13:22 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id n67so5717362iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:13:21 -0700 (PDT)
X-Received: by 2002:a05:6638:13d2:: with SMTP id i18mr549944jaj.3.1635376401029;
 Wed, 27 Oct 2021 16:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210929153553.1.Ib44c2ac967833d7a3f51452d44d15b7b8d23c1f0@changeid>
 <86b0d847ddf06c1b445f3dbac9c771a9@codeaurora.org> <CAD=FV=WnMnEckHdu0DG3U8MnyjwQ42aybFxq35nWSLG=vs=LGA@mail.gmail.com>
 <YXTY6BdmKBa+jPeN@builder.lan>
In-Reply-To: <YXTY6BdmKBa+jPeN@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Oct 2021 16:13:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue-OUOOQTZnvtW1-88+NhzUp5nOo80OKT9Pgx27L0VkA@mail.gmail.com>
Message-ID: <CAD=FV=Ue-OUOOQTZnvtW1-88+NhzUp5nOo80OKT9Pgx27L0VkA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Make RTC disabled by default;
 enable on sc7280-idp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     satya priya <skakit@codeaurora.org>, Vinod Koul <vkoul@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 23, 2021 at 8:54 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 18 Oct 16:45 CDT 2021, Doug Anderson wrote:
>
> > Bjorn,
> >
> > On Wed, Sep 29, 2021 at 9:00 PM <skakit@codeaurora.org> wrote:
> > >
> > > On 2021-09-30 04:08, Douglas Anderson wrote:
> > > > The RTC on the pmk8350 is not useful on all boards. Some boards may
> > > > not provide backup power to the PMIC but might have another RTC on the
> > > > board that does have backup power. In this case it's better to not use
> > > > the RTC on the PMIC.
> > > >
> > > > At the moment, the only boards that includes this PMIC are sc7280-idp
> > > > and sc7280-idp2. On sc7280-idp I'm not aware of any other RTCs, but
> > > > sc7280-idp2 has a Chrome OS EC on it and this is intended to provide
> > > > the RTC for the AP.
> > > >
> > > > Let's do what we normally do for hardware that's not used by all
> > > > boards and set it to a default status of "disabled" and then enable it
> > > > on the boards that need it.
> > > >
> > > > NOTE: for sc7280-idp it's _possible_ we might also want to add
> > > > `allow-set-time;`. That could be the subject of a future patch if it
> > > > is indeed true.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > >
> > > Reviewed-by: Satya Priya <skakit@codeaurora.org>
> >
> > If you're still accepting patches for 5.16, it'd be keen if you'd
> > consider taking this one. Thanks!
> >
>
> I've picked the patch and hope to get it included in v5.16.
>
> I do however not understand why the commit message so clearly defines
> that the only device including pmk8350 is the sc7280 idp when the
> sm8350-mtp.dts contains the following line:
>
> #include "pmk8350.dtsi"
>
>
> Perhaps I'm missing something obvious, but I took the liberty of also
> enabling the RTC in the SM8350 MTP.

Thank you for fixing this up. I must have just glazed over that part
of things. :( Glad you caught and fixed it.

-Doug
