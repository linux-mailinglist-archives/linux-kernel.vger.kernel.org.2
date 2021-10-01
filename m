Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51741EF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354313AbhJAOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354297AbhJAOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:18:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D05C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:17:04 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso11640473otu.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=414YTHzwZHtaZCbcGsZ5S5zmMfFLFjGLUevc4ZzGQiE=;
        b=z0AmurtR1RYw/59CpsQ6B/mLYIOuFFNEvqo5BE4a7+dVfBP7geRqmEOjVvt/DhGJbJ
         Db2V7xjTvoAwymLSZvM+NFOHBJAUd6G+hB+GhiSXQO6MwtpLuraMAav0Nwx2AlwVtVVT
         9nNsq+62dserPMMKics2LTsQ7vN7E+ekW5nYdrqqZXxGEpWSwXV/+DFR8kmEm/q4S+GJ
         MpyG6Sv82Ss+gjTnZ+fEWWZDbRhNup/KFpGzgN7JGgW1sIMnIXnQB/ZZFBWriXZ41uj8
         N1dvtIT89oG30UUarmrAIeZNg8KXnwpq1p0Z/HAGcxr7TAQqkaIa/pqUVmkRqLYDi8x4
         iEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=414YTHzwZHtaZCbcGsZ5S5zmMfFLFjGLUevc4ZzGQiE=;
        b=63tob4GTfucLhfJbu0fLoI3Ex6BNvJLjEFi9xNrK0xw2eUrROpWMV4iSMxuPsiIN2V
         oWX1gvmAGQJPnl6PVRAb495NTV7SD9SZnDGGQUyO2sUrtMy68jPYPs5HWFhUInbYqU/R
         i4h0TDHF0XyCHKOBx/4OtQojEj7FvYVsLJL7Ikf9L9NfFmQ+vKY4qclLqd1k90ATxD3N
         jg9mrw/qI+GL7DigcECDac/ux9PqqXmdrp6lAytdJ8Ye+6MeiNPIX+mkTEanTVnrprT+
         JqxFiknWxBnra1ZRTz8+fwX7kJTJXZEVv0V+/EMP0LWOdbvO/mVClX4jMecotxFTmGrk
         8cpg==
X-Gm-Message-State: AOAM531Au2vfUNrFcbzBFJ4PRaj6fVn/YQ3/SeqaCW7chLOwVWxgkJ2C
        tiTl/btq5ysyiVx6nAFYXwGlpZqZWotdkQ==
X-Google-Smtp-Source: ABdhPJxOgWwlua2HiucLEztgIW23VFNr7a3lDu952nhmksNAlZ60tImMTFc53k2d6MS5uPjstcT9bg==
X-Received: by 2002:a05:6830:1bc6:: with SMTP id v6mr10372984ota.299.1633097823284;
        Fri, 01 Oct 2021 07:17:03 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n4sm1204760otr.59.2021.10.01.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:17:02 -0700 (PDT)
Date:   Fri, 1 Oct 2021 07:18:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] drm/msm/dp: Support up to 3 DP controllers
Message-ID: <YVcYyvtVfOx977an@ripper>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
 <20210825234233.1721068-4-bjorn.andersson@linaro.org>
 <CAE-0n52YaQXQ4-=bR5ffMHOMp7CyFnCS-u9a2pddvaRUQhLrog@mail.gmail.com>
 <CAD=FV=UWu4CBC8S8C9P7r=q+F=JqWMzTVAPyzWb+AT4QHbULZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UWu4CBC8S8C9P7r=q+F=JqWMzTVAPyzWb+AT4QHbULZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Oct 06:58 PDT 2021, Doug Anderson wrote:

> Hi,
> 
> On Thu, Aug 26, 2021 at 10:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Bjorn Andersson (2021-08-25 16:42:31)
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 2c7de43f655a..4a6132c18e57 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -78,6 +78,8 @@ struct dp_display_private {
> > >         char *name;
> > >         int irq;
> > >
> > > +       int id;
> > > +
> > >         /* state variables */
> > >         bool core_initialized;
> > >         bool hpd_irq_on;
> > > @@ -115,8 +117,19 @@ struct dp_display_private {
> > >         struct dp_audio *audio;
> > >  };
> > >
> > > +
> > > +struct msm_dp_config {
> > > +       phys_addr_t io_start[3];
> >
> > Can this be made into another struct, like msm_dp_desc, that also
> > indicates what type of DP connector it is, i.e. eDP vs DP? That would
> > help me understand in modetest and /sys/class/drm what sort of connector
> > is probing. dp_drm_connector_init() would need to pass the type of
> > connector appropriately. Right now, eDP connectors still show up as DP
> > instead of eDP in sysfs.
> 
> I'm not convinced that's the right way to do it. I think the right way
> forward here is to look at whether drm_of_find_panel_or_bridge() finds
> a panel. If it finds a panel then we're eDP. If it doesn't then we're
> DP. That matches roughly what Laurent was planning to do for
> ti-sn65dsi86:
> 
> https://lore.kernel.org/all/20210322030128.2283-11-laurent.pinchart+renesas@ideasonboard.com/
> 

When we spoke about this earlier I got the impression that there was
interest in representing the DP display as a panel at some point in the
future. Did I misunderstand you or would we simply update the scheme
when that day comes?


I updated the patch based on Stephen's input and it looks nice, but I
could certainly respin it again to simply rely on us having an explicit
panel or not.

> I know technically an eDP and DP controller can have different sets of
> features but I think what we really are trying to communicate to
> modetest is whether an internal panel or external display is
> connected, right?
> 

For me Stephen's suggestion resulted in the monitor names in Wayland
suddenly making more sense, i.e. it makes more sense to say that the lid
on my laptop should control eDP-1, rather than DP-3 on this machine...

Regards,
Bjorn
