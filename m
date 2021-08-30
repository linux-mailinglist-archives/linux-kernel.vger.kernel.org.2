Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4F3FB7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhH3OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhH3OTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:19:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27850C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:18:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p17so4015376qvo.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bDYv7A/LtthHV1B7A47v6rcfLVgrIbXO4oXJa+YfPI=;
        b=k0CgpMslNX1rWTUgpPhbj/OqdkaWqxYr0wGz3TaXWYankEGP0Q3UNqymfky1Xy/A+Q
         h2qV2iynbjhNRBp4+5VMojFc8NLf6bLWmC5iCC4hU9iJmqfFt3vEIvEpmtO4bC9JENVS
         BiUJYDzZwfJJyCxYy3ccI1VMtZTiaf2eTMcchnC33Ew6zEn292rQtR/oJd+VTNqdqJaM
         +lXC7g5AzwG4qJFKN8/fmN2SuGpQ/XuyOnLFauVszjQOJ/QUPycaOo0ZNzkAcCQeWyvJ
         b3nU64Ng0kboG6NPpBQljpimAc7gCI8udk+hQmMjKVema62pS4lJie44vfgdbfDw9Q8Q
         EOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bDYv7A/LtthHV1B7A47v6rcfLVgrIbXO4oXJa+YfPI=;
        b=WkKdTK3u9dCLze56CiNXNDgNJ9NyudBj+GfaaASw+CozvLVKosKRLQ0V7gBWvLbWAh
         ZETqHmimAvgSZnfL/Adfn+mj2+Mg0nZWWk36fjbhK+8IFPhR/v5q9+3ZMep4557rzIXm
         AY6GizMvWFZWajwKaO+uGy4JDlh0BLdAnjdEU3JJbfHq4n9lKGujIGwWGoaEOCZRXldx
         aNhOkEe/nWlm2I+547zbkbR+g0Vq+wrTKRhCo7GPGFaR5uu0p/YHyHwfAsSJ3eSuroYt
         W8dUtvV7eWm61kv7/eJ1JWy3+68pM8nR2OWluDshsiSk8SRMWzUv9LzvpUWSTOMMw3Bp
         /PyQ==
X-Gm-Message-State: AOAM533w1Whr1ZsqoxMZTax/FB62chGid450Dq2gzCkAKJ6rdaNzReVy
        RHj1dEa9X0U9nUaKLz+BXhiqyuFV68bzIaAunCVZgQ==
X-Google-Smtp-Source: ABdhPJzHjekGyU39UWiALsxjZxpzf/CttK5mtbE3Qic8fvdcaKyqq5Gpsqicgq48oCXssFXjY5mgE7OOpv1b2mFWx9Q=
X-Received: by 2002:a05:6214:acd:: with SMTP id g13mr23816483qvi.23.1630333128241;
 Mon, 30 Aug 2021 07:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210829203027.276143-1-marijn.suijten@somainline.org>
 <20210829203027.276143-2-marijn.suijten@somainline.org> <CAA8EJprQ03ipZzO+1vgt9W7jFbLXgsYR0n-oJxVB-142x8dgRA@mail.gmail.com>
 <17d19b93-dbe5-cc85-f302-b52cd8eeed56@somainline.org> <CAA8EJpqd7_5510TodALnX13Wo0MufYm2G=r6vw9sy=VURrewyw@mail.gmail.com>
 <YSznouVZ93sUd6xa@Marijn-Arch-PC.localdomain>
In-Reply-To: <YSznouVZ93sUd6xa@Marijn-Arch-PC.localdomain>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Aug 2021 17:18:37 +0300
Message-ID: <CAA8EJpoRo6rPgpUeT9X0K4UPu5d8-YBP=BJ3AAejD+wujhmv+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: dts: qcom: apq8064: Use 27MHz PXO clock as DSI
 PLL reference
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 17:14, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On Mon, Aug 30, 2021 at 04:24:58PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 30 Aug 2021 at 11:28, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On 8/30/21 3:18 AM, Dmitry Baryshkov wrote:
> > > > On Sun, 29 Aug 2021 at 23:30, Marijn Suijten
> > > > <marijn.suijten@somainline.org> wrote:
> > > >>
> > > >> The 28NM DSI PLL driver for msm8960 calculates with a 27MHz reference
> > > >> clock and should hence use PXO, not CXO which runs at 19.2MHz.
> > > >>
> > > >> Note that none of the DSI PHY/PLL drivers currently use this "ref"
> > > >> clock; they all rely on (sometimes inexistant) global clock names and
> > > >> usually function normally without a parent clock.  This discrepancy will
> > > >> be corrected in a future patch, for which this change needs to be in
> > > >> place first.
> > > >>
> > > >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > >
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >
> > > > Checked the downstream driver, it always uses 27 MHz clock in calculations.
> > >
> > >
> > > Given our concerns for msm8974 not updating DT in parallel with the
> > > kernel (hence the need for a global-name fallback because "ref" is
> > > missing from the DT), should we worry about the same for apq8064?  That
> > > is, is there a chance that the kernel but not the firmware is upgraded
> > > leading to the wrong parent clock being used?  The msm8960 variant of
> > > the 28nm PLL driver uses parent_rate in a few places and might read
> > > cxo's 19.2MHz erroneously instead of using pxo's 27MHz.
> >
> > Checked the code. It uses .parent_names =  "pxo", so changing ref
> > clock should not matter. We'd need to fix ref clocks and after that we
> > can switch parent names to fw_name.
>
> Correct, hence why this patch is ordered before the switch to .fw_name.
> These patches can't go in the same series if apq8064 doesn't update its
> firmware in parallel with the kernel just like msm8974.  Do you know if
> this is the case?  If so, how much time do you think should be between
> the DT fix (this patch) and migrating the drivers?

You can have parent_data with .fw_name and .name in it.  .name will be
used as a fallback if .fw_name doesn't match.


-- 
With best wishes
Dmitry
