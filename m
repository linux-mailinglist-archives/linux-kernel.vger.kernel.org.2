Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27473A3B86
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFKF5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:57:47 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41692 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:57:46 -0400
Received: by mail-lf1-f53.google.com with SMTP id j20so6830849lfe.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWJT1TKTJY/Zgs7uYHfj5AaoA70mjqy3p3kWRMzXAxk=;
        b=u8gClsaTykBGjpue/UpE/vI1OH77Q+uPf76rg7zMpmxiHwyu51RAlukcuO4AxjLoI3
         Cty0lTSdW9Y5xTgrdjej2t/H3E70Vo+XdeSaT/8UYxAGt32R05y1+kcb7BHfKCTFOh8v
         hAsJcej63Y44lRkwFMiZujBdZhPU+MKb5G58qBAhafPWI5G7RqGrBHuqVl1v+EHamul8
         QCLSSR+aZH7EGSg08GuBeCANTIZNepvmU56Rf2SMURWNXlmmSAqLtYKvtKza0NbPmCCZ
         KmucvYemd9/hBxPy1GyOII+fSH/JVVU3y8AtzJMO/BcAOb5zv6nFUAK2H2a9yMd0C7AK
         p06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWJT1TKTJY/Zgs7uYHfj5AaoA70mjqy3p3kWRMzXAxk=;
        b=Z50Qy1OoxYsAbkN5w5Ni4ofIiBoAy5qOUVw6UT3y3Xqs0KIcE1rwRE9XdmEohfGbu2
         244jMPo9LYof7sc8NYmedSZjZuvORn2mr5K+B591MfGdXStNuqfYXYVQhSeAVIoOHWh6
         NG9wHmThIJc+uo2P8WcPqOZugatMxDdA0veEosK/XggrHvAT+oRtU+npEWmUIO7SOxtc
         XlQgtDNkh39oiYnZJqkeJipMYh+3FnpHDztZXARgmHaJqkYTqHOskHJx5lriR3Yd7BK3
         0BhHfj2yuvc8X7Mg6jb4PCDAi7vqQWHWJOGsBKD+FzQuIuL60xC/AvmOrhNUWx64fmSU
         fTnA==
X-Gm-Message-State: AOAM533IldsWKT9dhndHyqh/+dlr62icUuDbBlfwycuEVGmv+lHY207x
        wJDT2tp4fK4WMaJzSW/A30D4yeSfXn32LC46/Vq7+w==
X-Google-Smtp-Source: ABdhPJyBi1jACJJWEC4j8Ji9ooZxSM6vlfwj9FxblgHMo/d9hC0uH3vxw3EwoBcY4sEdvIXgQUk6ztqp4JG6D5+O1AY=
X-Received: by 2002:a19:c181:: with SMTP id r123mr1573442lff.7.1623390887802;
 Thu, 10 Jun 2021 22:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210611050808.2554431-1-vkoul@kernel.org> <CALAqxLW4n8ijkD6hw_xqa2tzkttmXS_LFn_yJo6cP+iYYt-+=A@mail.gmail.com>
 <YML4XfOOSVKiyofD@vkoul-mobl>
In-Reply-To: <YML4XfOOSVKiyofD@vkoul-mobl>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 10 Jun 2021 22:54:35 -0700
Message-ID: <CALAqxLU1gjTY95+phBt=WksyguZuKpNKa6aYaJTe0GeCAg6WrA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8350-mtp: Use mdt files for firmware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:45 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 10-06-21, 22:27, John Stultz wrote:
> > On Thu, Jun 10, 2021 at 10:08 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > As discussed in [1], it makes it easy for everyone to use mdt firmware file
> > > name instead of mbn ones, so changes this for SM8350
> > >
> > > [1]: http://lore.kernel.org/r/CALAqxLXn6wFBAxRkThxWg5RvTuFEX80kHPt8BVja1CpAB-qzGA@mail.gmail.com
> > >
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> > > index 93740444dd1e..d859305f1f75 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> > > @@ -40,7 +40,7 @@ vph_pwr: vph-pwr-regulator {
> > >
> > >  &adsp {
> > >         status = "okay";
> > > -       firmware-name = "qcom/sm8350/adsp.mbn";
> > > +       irmware-name = "qcom/sm8350/adsp.mdt";
> > >  };
> >
> > Uhh, isn't this the opposite of [1]?  My apologies for butting in, and
> > I'd stay out of the discussion, except for my mail being linked as
> > justification :)
>
> I would rather think of your email as background material or trigger :)

My apologies for stirring up trouble. :)

> > In [1] the case was db845c was switched from older mdt files to using
> > the upstream linux-firmware mbn files. This was a bit of a pain, as it
> > broke on our userland with mdt files, and since we use both old and
> > new kernels we had to have both filenames on the disk (via symlink) to
> > keep it working everywhere.
> >
> > My argument in [1] was for new boards, go with the new conventions,
> > but we should avoid breaking those conventions casually on existing
> > devices.  That said, I know it's more complex, and I graciously defer
> > to Bjorn and RobC on the decision.
> >
> > But your patch above seems to be switching from mbn (what I understand
> > to be the new convention) to mdt (what I thought was the old way). And
> > from the git blame, it looks like it was introduced as mbn (new board,
> > new convention - so all good, right?).
> >
> > So is this really the right change? Or maybe just more exposition in
> > the commit message is needed (rather than pointing to my mail, which
> > seems to be arguing the opposite) to explain it?
>
> We have had a discussion after the email thread and thought it is better
> approach to stick to mdt format as used downstream and not have
> confusion and issues resulting from upstream vs downstream
>
> Since SM8350 is a new platform, so switching here onwards made sense,
> hence this patch
>
> I should have added more details for this in changelog as well...

Ok, thanks for the clarification!
-john
