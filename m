Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80114465B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhKEPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhKEPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:32:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704FEC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:29:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i79so10807082ioa.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UkXJV0OUTVeSB3ZWIvuOW6MEyDXb/nfPaZn/YUVDEM=;
        b=I+rltgFifRvQNsNZIVeUD++Ek0yxbA4Jl5XK/KgCoQHB3uXJ8aLeXftGBqi9z/1Kuq
         MrjVCYOIOTp1QVbJQjt9kamQzE5JQsSUgT9ZljMvlaMnRakZuA3oNlpOPB30kGsPPok2
         fCU4eyoVqWvjDFsRlugQxg0PBjBNFQMCQoCjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UkXJV0OUTVeSB3ZWIvuOW6MEyDXb/nfPaZn/YUVDEM=;
        b=x5zWyPumX25EKmyRCEnHpHaFW6i1RW4V+dRawE79U7H0JY904cJsFQZ0My0GGv1Uc2
         jeJu+77IoSoqF1RtsWrOrqaSHBSfohslHC/dY39OneaHfQR/iaNzhMhJM6ssjQrXrsiZ
         FGUfmNS6h790K7SD4kctYG60DxAebgFjWYp7EHIPeeVWub4zxgCVV9RUNIto6KWyvOQM
         YtXmSrEvWOWzwdBBfLIaq3HW0wXwpwLgp9a1heOtBZUPEDNwnw8W1/I5K93QfUa+sGcb
         mpBGMBvh51K+PAvTpzfR7FcguHqwZxZgryxkBGm0sx7by7g4bEGYKcLTucYKyegy2g0I
         KQxg==
X-Gm-Message-State: AOAM531z5Gd1SlxKkneGdRf1oY2Xys/dEm30n0OZGq277YApwgXXwGtx
        FWB+n4bVT68P0miA1e/ENfeucw+sCV81Kw==
X-Google-Smtp-Source: ABdhPJxlO5DbuZti4I2E+7hn4S8/2wPL4PRft/2FBXfYhJSG6Ihlzd5nhiFk7VeMiS7stzVdWIywOw==
X-Received: by 2002:a5d:8487:: with SMTP id t7mr40986339iom.100.1636126176722;
        Fri, 05 Nov 2021 08:29:36 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id s5sm4383851ilq.59.2021.11.05.08.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 08:29:35 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y73so11146563iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:29:35 -0700 (PDT)
X-Received: by 2002:a05:6638:c49:: with SMTP id g9mr9752326jal.54.1636126175216;
 Fri, 05 Nov 2021 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211104222840.781314-1-robdclark@gmail.com> <be2222e2-8fec-84f9-bbcf-bf639a1a63bd@kali.org>
In-Reply-To: <be2222e2-8fec-84f9-bbcf-bf639a1a63bd@kali.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Nov 2021 08:29:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WnTsdU0TzbbFhRzoYtiX6-HG+g=OHiu1LP+tODPGXZKQ@mail.gmail.com>
Message-ID: <CAD=FV=WnTsdU0TzbbFhRzoYtiX6-HG+g=OHiu1LP+tODPGXZKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/devfreq: Fix OPP refcnt leak
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 4, 2021 at 9:32 PM Steev Klimaszewski <steev@kali.org> wrote:
>
>
> On 11/4/21 5:28 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Fixes: 9bc95570175a ("drm/msm: Devfreq tuning")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > index d32b729b4616..9bf8600b6eea 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > @@ -20,8 +20,6 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
> >       struct msm_gpu *gpu = dev_to_gpu(dev);
> >       struct dev_pm_opp *opp;
> >
> > -     opp = devfreq_recommended_opp(dev, freq, flags);
> > -
> >       /*
> >        * If the GPU is idle, devfreq is not aware, so just ignore
> >        * it's requests
> > @@ -31,6 +29,8 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
> >               return 0;
> >       }
> >
> > +     opp = devfreq_recommended_opp(dev, freq, flags);
> > +
> >       if (IS_ERR(opp))
> >               return PTR_ERR(opp);
> >
>
> Testing this here on the Lenovo Yoga C630, and I'm starting to see in my
> dmesg output
>
> [   36.337061] devfreq 5000000.gpu: Couldn't update frequency transition
> information.
> [   36.388122] devfreq 5000000.gpu: Couldn't update frequency transition
> information.

Ah, I think this makes sense. We're now storing a frequency which
might not match an actual "opp" and I suppose that we must return it
in some cases.

I guess a simple fix is to still call devfreq_recommended_opp() in the
idle case but just call dev_pm_opp_put() to fix the leak.

-Doug
