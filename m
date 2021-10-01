Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059F41F44A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355662AbhJASE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355592AbhJASEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:04:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE40C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:03:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 134so12608284iou.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL04/DBPEoOSN56nSu3eaqiiO8NlK2fOuX7kmrPsg2w=;
        b=DRsDMqGo5t/bxn9+5wBzcERkuPc5KHDjQdwCt2EXk2REWJWg+v7NDlDKBEdVOQV8Tr
         rQiDclsnWhqlLo4weSCvtBOjuEtmMTeV0JLQ1zReAAvXljaJID8LuFvXtejnhGd9SZ7o
         pK5cJL6I4QrcjwMawjpp8sJMzu1gxIxRLfMuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL04/DBPEoOSN56nSu3eaqiiO8NlK2fOuX7kmrPsg2w=;
        b=sT0vL2Ne3iZUfeAqoZrulKeEmHTp42/7X0tYHVfdZfq25IrIloT0ySrc4yP8uo1uKI
         mnhuEQo3wsNTLc9IlxLiorOpfzpwQLrfboClnDXnMmFD0VHsfEuU4EJSAXLI+d51c+Yn
         L3kLxYvVzJBm4ggz/CcHHpbi71T7CItJ8wroCuNd+AMXjcpd/RpbCQ/la/Y4e4o1mnAS
         M8l7G3NZxesDfiXE6tOD5X4kprIJObi1yusIfI3YnM6ejlTfFoTf21tEOd/5J59R+Is2
         /TCb9UY4vU9d4K9wnMaa0dMfq8NznYuqb79tEzgVmmT1jIa5L350YH0kdmtEShVR/Tqv
         WAmA==
X-Gm-Message-State: AOAM533P6LaEfcdlI0AEje/byqYecWQ/zpzYWwtyKdD2EWFNKCGKPdJ1
        mJz1yYabsx3JclFwLaDEWeMH/VZWRLNg8Q==
X-Google-Smtp-Source: ABdhPJwzDDDweNSrSs4jtohsCN5Qwgg1dMhInRCwuNmiCUR6L/C+Ld1vG+69nNA/mlPAdumdUJIPZA==
X-Received: by 2002:a6b:3bd1:: with SMTP id i200mr517538ioa.190.1633111389784;
        Fri, 01 Oct 2021 11:03:09 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id a3sm1424866ilr.29.2021.10.01.11.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:03:07 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id j15so11434678ila.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:03:06 -0700 (PDT)
X-Received: by 2002:a05:6e02:20eb:: with SMTP id q11mr10049918ilv.165.1633111385834;
 Fri, 01 Oct 2021 11:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225801.227211-1-robdclark@gmail.com> <20210920225801.227211-4-robdclark@gmail.com>
 <YUvN3j0v+8NMjNte@pendragon.ideasonboard.com> <CAF6AEGviyfX6+c-CB5gMXqRQfHhvb5L8t++-VkZpvS3r9qDNoA@mail.gmail.com>
 <YU03M+CXJ+ALi8De@pendragon.ideasonboard.com>
In-Reply-To: <YU03M+CXJ+ALi8De@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Oct 2021 11:02:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UU1_ZR0K9XEgkTM2M55FgmqoH=ciU5a_oCC+W2NPdZ-A@mail.gmail.com>
Message-ID: <CAD=FV=UU1_ZR0K9XEgkTM2M55FgmqoH=ciU5a_oCC+W2NPdZ-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 7:26 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> > > >  err_conn_init:
> > > >       drm_dp_aux_unregister(&pdata->aux);
> > > >       return ret;
> > > > @@ -792,9 +790,30 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
> > > >       regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
> > > >  }
> > > >
> > > > +/*
> > > > + * Find the connector and fish out the bpc from display_info.  It would
> > > > + * be nice if we could get this instead from drm_bridge_state, but that
> > > > + * doesn't yet appear to be the case.
> > >
> > > You already have a bus format in the bridge state, from which you can
> > > derive the bpp. Could you give it a try ?
> >
> > Possibly the bridge should be converted to ->atomic_enable(), etc..
> > I'll leave that for another time
>
> It should be fairly straightforward, and would avoid the hack below.

Given this point of controversy, my inclination is to wait and not
apply this patch now. I don't think there's anything urgent here,
right? Worst case eventually Laurent might pick it up in his patch
series? At least we know it will work with the MSM driver once patch
#1 lands. :-)


-Doug
