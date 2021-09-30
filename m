Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1441D625
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbhI3JWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349293AbhI3JWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:22:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BDC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:20:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so8913611wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWUu4gfUCIw1qfdMOzh1G0mXcnyINDcvR5YDhGm1cIk=;
        b=DEap/nntYuHPYdehDI3oC9J8mlrnnQUeK0Z+Ax/XhzIk/ffB72lJENarIyab15k7km
         GQGpvvXag209wCFNn8cBjn4SNy+ZjtjRX/ggx3X0GWmnedRAL5mnEJbm/iO98NHJCobA
         Ws1ChpCA8cffA5vbdvab0JmhjSSq1sGSBbUQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cWUu4gfUCIw1qfdMOzh1G0mXcnyINDcvR5YDhGm1cIk=;
        b=pyRx0DtFB+KHwTjYHhiifJLgmfoCml7N+6mxF78VQyfDeM3LF1oTGmPz9PoAxSO4bG
         7wp+7rsioDXbxZ2nQGHoxQ2Ejj1UlYlkr4FXmIzyzl3SRIWu3CW+nbqIm+r7cAbwLDBK
         6KZyXecr/s3MBC+PbsvjZ4dCiSKMDxp98jcpv4g9cKQimqc0PnIeeVtsGNuSmOqyGIMJ
         nnG02+Y7Ka/l5C9YQ8vW1pEf6zfiKdOPFNKcc5U1xSaG2PbAoDkoPCzDXajtj1qWis24
         2qDrMqlN4rxxxhbmHk7xDZHLGlAwCStc4X8XhQTGKw0ZjCGz02un6VJyiD829xxK7CDH
         SAAQ==
X-Gm-Message-State: AOAM532p9AsXjwhoF3uJdsHBccHL9SwSEhwr1hYq2qud/pdl0Gnwk0Pk
        ua/cf5j4iAbyt/Qni10/xNXlnA==
X-Google-Smtp-Source: ABdhPJzq4mhFF0uQJUbJElFrf061CPJgYoqj5BalI56is+e0O68Ykt6BJmA0z74RxjPaX4FXXV+FTw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr4951532wrz.337.1632993618649;
        Thu, 30 Sep 2021 02:20:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o17sm2439103wrj.96.2021.09.30.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 02:20:08 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:19:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression with mainline kernel on rpi4
Message-ID: <YVWBP5ZJInH/wt1P@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210922095725.dk4vk42zb3kh7y6s@gilmour>
 <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
 <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com>
 <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
 <CADVatmPDeSxeY3GTZyC6+G0N76su0E6Y3LF_h6BOcBf5QAtjvg@mail.gmail.com>
 <CAHk-=whASMriPYRdH8kxC_UwObBtwHbPvf7rb58sUEZZyaFxJg@mail.gmail.com>
 <20210924133022.waqgtr5xjjxigong@gilmour>
 <CAKMK7uFxO-ss86k483VJQJiHwcAYxNwD06xSEZStn+fWiRJ6iw@mail.gmail.com>
 <20210928083446.cfji7hmndt6a5nop@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928083446.cfji7hmndt6a5nop@gilmour>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:34:46AM +0200, Maxime Ripard wrote:
> Hi Daniel,
> 
> On Sat, Sep 25, 2021 at 12:50:17AM +0200, Daniel Vetter wrote:
> > On Fri, Sep 24, 2021 at 3:30 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 01:25:21PM -0700, Linus Torvalds wrote:
> > > > On Wed, Sep 22, 2021 at 1:19 PM Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > I added some debugs to print the addresses, and I am getting:
> > > > > [   38.813809] sudip crtc 0000000000000000
> > > > >
> > > > > This is from struct drm_crtc *crtc = connector->state->crtc;
> > > >
> > > > Yeah, that was my personal suspicion, because while the line number
> > > > implied "crtc->state" being NULL, the drm data structure documentation
> > > > and other drivers both imply that "crtc" was the more likely one.
> > > >
> > > > I suspect a simple
> > > >
> > > >         if (!crtc)
> > > >                 return;
> > > >
> > > > in vc4_hdmi_set_n_cts() is at least part of the fix for this all, but
> > > > I didn't check if there is possibly something else that needs to be
> > > > done too.
> > >
> > > Thanks for the decode_stacktrace.sh and the follow-up
> > >
> > > Yeah, it looks like we have several things wrong here:
> > >
> > >   * we only check that connector->state is set, and not
> > >     connector->state->crtc indeed.
> > >
> > >   * We also check only in startup(), so at open() and not later on when
> > >     the sound streaming actually start. This has been there for a while,
> > >     so I guess it's never really been causing a practical issue before.
> > 
> > You also have no locking
> 
> Indeed. Do we just need locking to prevent a concurrent audio setup and
> modeset, or do you have another corner case in mind?
> 
> Also, generally, what locks should we make sure we have locked when
> accessing the connector and CRTC state? drm_mode_config.connection_mutex
> and drm_mode_config.mutex, respectively?
> 
> > plus looking at ->state objects outside of atomic commit machinery
> > makes no sense because you're not actually in sync with the hw state.
> > Relevant bits need to be copied over at commit time, protected by some
> > spinlock (and that spinlock also needs to be held over whatever other
> > stuff you're setting to make sure we don't get a funny out-of-sync
> > state anywhere).
> 
> If we already have a lock protecting against having both an ASoC and KMS
> function running, it's not clear to me what the spinlock would prevent
> here?

Replicating the irc chat here. With

commit 6c5ed5ae353cdf156f9ac4db17e15db56b4de880
Author: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Thu Apr 6 20:55:20 2017 +0200

    drm/atomic: Acquire connection_mutex lock in drm_helper_probe_single_connector_modes, v4.

this is already taken care of for drivers and should be all good from a
locking pov.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
