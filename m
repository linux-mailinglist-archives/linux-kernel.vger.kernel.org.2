Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1B41E26F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbhI3Tvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbhI3Tvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 15:51:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0AFC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:49:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d18so9036960iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB277iFt75fl+4aHOINXc6MZFx1y8U+fiFPNDywa6l0=;
        b=sVwEennI3YOv/UrOQmnsqVqIhhmjAqxaNwYAVxmqBTd4rixuqJ97suJdLoBCvAYXsq
         vqUyUs6E/zFeeVvYYctFUEAvSIJUjkLfscDw1/XGt8HMdQH02ZPsajyKFSOGMMQnQBE7
         OMZNJzxZZVH/zuzFfgFLZ7OO5ZUexLEoQULY0HRt9la5ssJXraGbEWXERcIxAXj/Y4iL
         GbovCIs9o8pOzBpoOA6W3+iSevcBLzocfy3UW8lbRum4hnIXQ32Q6Z4QMmXqv3ToB55w
         +b0xMP9oWaRrnUXapNlG4vPu4Xu9sUJA3SxgVX6Z9uQmLuh97KpN3INV6q1zl525Tu7h
         +LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB277iFt75fl+4aHOINXc6MZFx1y8U+fiFPNDywa6l0=;
        b=zmaFZURIlJybGVyeWQ2gqD8DBXQXIbJ/84HG2/N8RrnJ4w/gfsK9yoJFvBwGMn51aA
         ikA5eeXZfRwMPs95fHlDYM/xR8ijPg85U04vLGvSv7SOpXrzAvZFX3IBDoPqW4578AvI
         ge3ZRRDwDPZfpDry1c104SFKMZAl5wrJ9IFWvnEJiH+EXdBsfiw/ovlKhXt+9l07anoj
         b/yMoHbimjlsPDFZ5Mdv6uJO3W/p36OHkvzRMKfp93D8E02/ZNsx4xMPenwph+SlN8eb
         kV4oANkD7c1LbMRXFznSxUm2V78t445Lf/5w2TcYM1uEvZXyXwqViPN4WW2QHqjyypct
         ZD2w==
X-Gm-Message-State: AOAM532TiUQK1WpRy5pVRgFKuMPyvZuJ5/BL7CBESSIfqG2ZR6lCISsK
        Vw8L8OLhh+fr8QZuT2vieqofIsWlNNd0LUK0w5miRQ==
X-Google-Smtp-Source: ABdhPJwJrWmWi/hsIsUS4oPU9/SBSkqOkq20r51rFH2xJ/wOLttpZT4oZowTFy/G1fwZD09J6piBpcqyb2OELajF8rg=
X-Received: by 2002:a05:6638:2650:: with SMTP id n16mr6428740jat.30.1633031387130;
 Thu, 30 Sep 2021 12:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210910101218.1632297-1-maxime@cerno.tech> <CALAqxLUqdkxXogmPhPgHv4Bgx-4b3mxe12LzzvWb07pLSnb2kA@mail.gmail.com>
 <CALAqxLUYb=ge4AZZzmk71Qr-92vnnE6sJxwCNUdEz4=VDKr1kg@mail.gmail.com>
 <CALAqxLX7oK6DeoCPZhMTpHKCihSYq7KZDrt5UKb46=ZBbJd9fA@mail.gmail.com> <CAF6AEGuJgrYrg7FXpVj8P_qf73CXb4=0KysSYQaobJuheDeUSA@mail.gmail.com>
In-Reply-To: <CAF6AEGuJgrYrg7FXpVj8P_qf73CXb4=0KysSYQaobJuheDeUSA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 1 Oct 2021 01:19:11 +0530
Message-ID: <CAMi1Hd0sUUFvNzYwt29af9d99o1-x+LiXBPCrQ8=9H0tHvxVHg@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] drm/bridge: Make panel and bridge probe order consistent
To:     Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Inki Dae <inki.dae@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sept 2021 at 04:50, Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 2:51 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Wed, Sep 29, 2021 at 2:32 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Wed, Sep 29, 2021 at 2:27 PM John Stultz <john.stultz@linaro.org> wrote:
> > > > On Fri, Sep 10, 2021 at 3:12 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > The best practice to avoid those issues is to register its functions only after
> > > > > all its dependencies are live. We also shouldn't wait any longer than we should
> > > > > to play nice with the other components that are waiting for us, so in our case
> > > > > that would mean moving the DSI device registration to the bridge probe.
> > > > >
> > > > > I also had a look at all the DSI hosts, and it seems that exynos, kirin and msm
> > > > > would be affected by this and wouldn't probe anymore after those changes.
> > > > > Exynos and kirin seems to be simple enough for a mechanical change (that still
> > > > > requires to be tested), but the changes in msm seemed to be far more important
> > > > > and I wasn't confortable doing them.
> > > >
> > > >
> > > > Hey Maxime,
> > > >   Sorry for taking so long to get to this, but now that plumbers is
> > > > over I've had a chance to check it out on kirin
> > > >
> > > > Rob Clark pointed me to his branch with some fixups here:
> > > >    https://gitlab.freedesktop.org/robclark/msm/-/commits/for-mripard/bridge-rework
> > > >
> > > > But trying to boot hikey with that, I see the following loop indefinitely:
> > > > [    4.632132] adv7511 2-0039: supply avdd not found, using dummy regulator
> > > > [    4.638961] adv7511 2-0039: supply dvdd not found, using dummy regulator
> > > > [    4.645741] adv7511 2-0039: supply pvdd not found, using dummy regulator
> > > > [    4.652483] adv7511 2-0039: supply a2vdd not found, using dummy regulator
> > > > [    4.659342] adv7511 2-0039: supply v3p3 not found, using dummy regulator
> > > > [    4.666086] adv7511 2-0039: supply v1p2 not found, using dummy regulator
> > > > [    4.681898] adv7511 2-0039: failed to find dsi host
> > >
> > > I just realized Rob's tree is missing the kirin patch. My apologies!
> > > I'll retest and let you know.
> >
> > Ok, just retested including the kirin patch and unfortunately I'm
> > still seeing the same thing.  :(
> >
> > Will dig a bit and let you know when I find more.
>
> Did you have a chance to test it on anything using drm/msm with DSI
> panels?  That would at least confirm that I didn't miss anything in
> the drm/msm patch to swap the dsi-host vs bridge ordering..

Hi, smoke tested
https://gitlab.freedesktop.org/robclark/msm/-/commits/for-mripard/bridge-rework
on Pocophone F1 (sdm845 / A630) with v5.15-rc3. I see no obvious
regressions in my limited testing so far including video (youtube)
playback.

>
> BR,
> -R
