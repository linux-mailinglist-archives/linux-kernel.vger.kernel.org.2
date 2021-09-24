Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C218417DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhIXWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhIXWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:52:03 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FCC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:50:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x124so16535751oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFDW7lncbxlfdS6O3az8pUVpsIvToFPs2S/93aYbsYE=;
        b=DCHhPp3O1tvVWh5nQ86u4yOWXvOhsgEuz0xHF/9ViKXs553UsDP90Ve/x006NTFn1S
         HD4C3h9oDySg896+tpvl3c3i9tnCoG3h5N/PMUJK7HpwroAMguPmrA9Y2+tYq3qJgip9
         thb4YclQrm1Cdq+NVM8Zr2lX+oCfYKj9W7Srs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFDW7lncbxlfdS6O3az8pUVpsIvToFPs2S/93aYbsYE=;
        b=gzCHQt6GL2AJFRa0ZW4CKzRSgUNDm5gxdaURUQMYRFRF1RnQF/k/VCy2pyefOVejoi
         6matbnaaDUIn7Kozn+GrcBdOifz0gZmbK45yHNOBGFTW4kCm5dFY7n2mWsApcjmIfm/e
         5WMmthnQhTaXElJCh5rjAllo+gMkptTDcqBkJiLA+vSrXsPeIF1cMt1x34pZ5kMYVsi4
         Lb2C3zc2pfTC5mqj/gOHWXc4JX+2rlQVDB8hxtBrA0ZEMPWxXA+l/hoPTLLz13g4Xipt
         uiiqGqyXU51ZRZ5NH0bKvrcXPXIlhmOGs8pTHvgmLxtyM/5xieRyJcw7CYuNFv1XGlA6
         umAg==
X-Gm-Message-State: AOAM5317irPsNga90WcyUJOk9xbQ+bR8qPwIKY8nJsYzIHOmShnx6qUJ
        h3g96uNOdbfQqujktjNssm/ILhpCt4rt7jyZMMW+IQ==
X-Google-Smtp-Source: ABdhPJwhNF96FPqLktf2AeTdHBfKB4aoz398F+kZSpY/G9t8bSrit9cTUBqsQk6btKhlTkjxJumwvEhMKpCgNF3WI5Y=
X-Received: by 2002:aca:ebd5:: with SMTP id j204mr3429389oih.14.1632523829045;
 Fri, 24 Sep 2021 15:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
 <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com>
 <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
 <CADVatmPDeSxeY3GTZyC6+G0N76su0E6Y3LF_h6BOcBf5QAtjvg@mail.gmail.com>
 <CAHk-=whASMriPYRdH8kxC_UwObBtwHbPvf7rb58sUEZZyaFxJg@mail.gmail.com> <20210924133022.waqgtr5xjjxigong@gilmour>
In-Reply-To: <20210924133022.waqgtr5xjjxigong@gilmour>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 25 Sep 2021 00:50:17 +0200
Message-ID: <CAKMK7uFxO-ss86k483VJQJiHwcAYxNwD06xSEZStn+fWiRJ6iw@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 3:30 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Sep 22, 2021 at 01:25:21PM -0700, Linus Torvalds wrote:
> > On Wed, Sep 22, 2021 at 1:19 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > I added some debugs to print the addresses, and I am getting:
> > > [   38.813809] sudip crtc 0000000000000000
> > >
> > > This is from struct drm_crtc *crtc = connector->state->crtc;
> >
> > Yeah, that was my personal suspicion, because while the line number
> > implied "crtc->state" being NULL, the drm data structure documentation
> > and other drivers both imply that "crtc" was the more likely one.
> >
> > I suspect a simple
> >
> >         if (!crtc)
> >                 return;
> >
> > in vc4_hdmi_set_n_cts() is at least part of the fix for this all, but
> > I didn't check if there is possibly something else that needs to be
> > done too.
>
> Thanks for the decode_stacktrace.sh and the follow-up
>
> Yeah, it looks like we have several things wrong here:
>
>   * we only check that connector->state is set, and not
>     connector->state->crtc indeed.
>
>   * We also check only in startup(), so at open() and not later on when
>     the sound streaming actually start. This has been there for a while,
>     so I guess it's never really been causing a practical issue before.

You also have no locking, plus looking at ->state objects outside of
atomic commit machinery makes no sense because you're not actually in
sync with the hw state. Relevant bits need to be copied over at commit
time, protected by some spinlock (and that spinlock also needs to be
held over whatever other stuff you're setting to make sure we don't
get a funny out-of-sync state anywhere).

Liberally sprinkling a few NULL checks here doesn't fix much at all,
it only papers over design bugs in the code.
-Daniel


> I'm still not entirely sure how we can end up in that situation though.
> The only case I could think of is that:
>
>   * The firmware enables the HDMI controller, then boots Linux
>
>   * The driver starts, registers its audio card. connector->state is
>     NULL then, and if the HDMI monitor is actually an HDMI monitor (vs a
>     DVI monitor), the VC4_HDMI_RAM_PACKET_ENABLE bit that we test in
>     startup will be set.
>
>   * The driver will create the connector->state (through a call to
>     drm_mode_config_reset in vc4_kms_load), connector->state isn't NULL
>     anymore, VC4_HDMI_RAM_PACKET_ENABLE is still set.
>
>   * The driver then disables the HDMI controller (in
>     vc4_crtc_disable_at_boot) but never clears the
>     VC4_HDMI_RAM_PACKET_ENABLE bit.
>
>   * Pulseaudio opens the audio device, startup succeeds because both
>     conditions we test succeed.
>
>   * However, since we either never enabled the HDMI connector (or if it
>     was disabled at some point), connector->state->crtc is NULL and we
>     get our NULL pointer dereference.
>
>     The Ubuntu configuration has the framebuffer emulation and the
>     framebuffer console enabled, so it's likely to be enabled and
>     something (X.org?) comes along and disables the connector right when
>     pulseaudio calls prepare().
>
> Maxime



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
