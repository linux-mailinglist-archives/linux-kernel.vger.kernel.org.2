Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E003251F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBYPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBYPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:07:04 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:06:23 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id e45so5913883ote.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X3d7AH7K+QUX1HOFus++mj3s5Je75s5RJZh6MvT3L4=;
        b=XRk5ulULiJaY05e1RegxtKFNw9malgHXFuO2NiuDECmEKeDQ3JqFDwwxDTtkWXdajW
         T04WkZgJeM26WKR9UzMABmB2rlSI9S/r7JU9ymKttt66yWOTqMCavGWTXbwyG5RaQF2s
         BVao4lPzXalDNZQT+jY8MtJGgqgrb+7in6DU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X3d7AH7K+QUX1HOFus++mj3s5Je75s5RJZh6MvT3L4=;
        b=g5QfVgBw2WuTBC/WyRYYaNUjbdUfwny8dN/WgpOKz97YbnZXq6xRaKuTBpwrwFwBCC
         hD2J/tKSZyDeULsc632AVGoLIlwjQ4AsVpBZh0GQmABtG8A5Lt1vwybHYUH34cuKbU2/
         FsEpsY2jOZS6zi+rhdLV4No5ewXr4sMIlrQaHw66AQISKTWdBR1yq+6I53bj0dSJWGCb
         zvf1TBSSSp3UxPIX5PV/m6rvqLrF74r3LnhEzBF1IToxSL8RorYoIwzED3Bq7WcrNs33
         pGZo3thHhmBHgwfOyTtPEBG6wY9mlG8PBKkvKCj+sp6gvrlG9KymLYm/Za1nngZCTV3O
         4sxA==
X-Gm-Message-State: AOAM533rtXSZ+kL2DnRCzEdG3hdc190e13+BLsbTNM0CDoYP07Bs2+6h
        hAY7YIb14ryEE7FaozMn8n3xnti3J9pnVC6fHrX79A==
X-Google-Smtp-Source: ABdhPJx27Mfpb3Tcx0KPOWahwlh4en7igagQZuJVI/petsFC9Np2XpGcdmkdrXLsANh4L4kuKWypA0FIggT/+IzMzcg=
X-Received: by 2002:a9d:2265:: with SMTP id o92mr2608987ota.188.1614265583119;
 Thu, 25 Feb 2021 07:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20210224105509.yzdimgbu2jwe3auf@adolin> <CAKMK7uFwdHaaGs8BPSAah1Vp5pJWTzxoruLgOWxQu1aDAyCKLQ@mail.gmail.com>
 <20210225102520.uysa4muovemqi66n@sirius.home.kraxel.org> <YDd8qOETBy8z/qDh@phenom.ffwll.local>
 <20210225132722.s2deh35qwhan5kkf@sirius.home.kraxel.org>
In-Reply-To: <20210225132722.s2deh35qwhan5kkf@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 25 Feb 2021 16:06:12 +0100
Message-ID: <CAKMK7uHSFzq6kw9-1Bhw0RdP524umz9Z3jrqBB-PQfyxCvtixQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/vkms: Add support for virtual hardware mode
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 2:27 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 25, 2021 at 11:32:08AM +0100, Daniel Vetter wrote:
> > On Thu, Feb 25, 2021 at 11:25:20AM +0100, Gerd Hoffmann wrote:
> > > On Thu, Feb 25, 2021 at 10:09:42AM +0100, Daniel Vetter wrote:
> > > > On Wed, Feb 24, 2021 at 11:55 AM Sumera Priyadarsini
> > > > <sylphrenadin@gmail.com> wrote:
> > > > >
> > > > > Add a virtual hardware or vblank-less mode as a module to enable
> > > > > VKMS to emulate virtual graphic drivers. This mode can be enabled
> > > > > by setting enable_virtual_hw=1 at the time of loading VKMS.
> > > > >
> > > > > A new function vkms_crtc_composer() has been added to bypass the
> > > > > vblank mode and is called directly in the atomic hook in
> > > > > vkms_atomic_begin(). However, some crc captures still use vblanks
> > > > > which causes the crc-based igt tests to crash. Currently, I am unsure
> > > > > about how to approach one-shot implementation of crc reads so I am
> > > > > still working on that.
> > > >
> > > > Gerd, Zack: For virtual hw like virtio-gpu or vmwgfx that does
> > > > one-shot upload and damage tracking, what do you think is the best way
> > > > to capture crc for validation? Assuming that's even on the plans
> > > > anywhere ...
> > > >
> > > > Ideally it'd be a crc that the host side captures, so that we really
> > > > have end-to-end validation, including the damage uploads and all that.
> > >
> > > Disclaimer:  Not knowing much about the crc thing beside having noticed
> > > it exists and seems to be used for display content checking.
> > >
> > > > For vkms we're going for now with one-shot crc generation after each
> > > > atomic flip (or DIRTYFB ioctl call). Will need a pile of igt changes,
> > > > but seems like the most fitting model.
> > > > Other option would be that we'd wire up something on the kernel side
> > > > that generates a crc on-demand every time igt reads a new crc value
> > > > (maybe with some rate limiting). But that's not really how virtual hw
> > > > works when everything is pushed explicitly to the host side.
> > >
> > > igt runs inside the guest, right?
> >
> > Yup. There's some debugfs files for capture crc on a specific CRTC. So
> > supporting this would mean some virtio-gpu revision so you could ask the
> > host side for a crc when you do a screen update, and the host side would
> > send that back to you on a virtio channel as some kind of message.
>
> Waded through the source code a bit.  So, the vkms crc code merges all
> planes (specifically the cursor plane) before calculating the crc.
> Which is a bit of a problem, we try to avoid that and rarely actually
> merge the planes anywhere in the virtualization stack.  Instead we
> prefer to pass through the cursor plane separately, so we can -- for
> example -- use that to simply set the cursor sprite of the qemu gtk
> window.  It's much more snappy because moving+rendering the pointer
> doesn't need a round-trip to the guest then.
>
> So, it would be quite some effort on the host side, we would have to
> merge planes just for crc calculation.
>
> > > You can ask qemu to write out a screen dump.
>
> Hmm, the (hardware) cursor is not in the screen dump either.
>
> A software cursor (when using for example cirrus which has no cursor
> plane) would be there.
>
> > > Another option to access the screen would be vnc.
>
> vnc clients can get the cursor sprite.  They can't get the position
> though, only set it (it's a one-way ticket in the vnc protocol).
> Typically not a problem because desktops set the position in response
> to the pointer events so guest + host position match nevertheless.
> But for test cases which don't look at input events and set the cursor
> to a fixed place this is a problem ...

Hm yeah that sounds like a bit too much to wire through, and kinda
defeats end-to-end testing if qemu would take a separate path for crc
generation.
-Daniel

> > > On-demand crc via debugfs or ioctl would work too, but yes that wouldn't
> > > verify the host-side.  At least not without virtio protocol extensions.
> > > We could add a new command asking the host to crc the display and return
> > > the result for on-demand crc.  Or add a crc request flag to an existing
> > > command (VIRTIO_GPU_CMD_RESOURCE_FLUSH probably).
> >
> > Yup, I think that's what would be needed. The question here is, what do
> > you think would be the most natural way for virtio host side stack to
> > support this?
>
> virtio has feature flags, so we can easily introduce an extension in a
> backward compatible way.  Each command sends a reply, with optional
> payload, so it would make sense to send the crc with the
> VIRTIO_GPU_CMD_RESOURCE_FLUSH reply.
>
> Alternatively introduce a communication channel independent of the gpu,
> using for example virtio-serial or vsock, let the guest send crc
> requests to qemu that way.  Which would work with all qemu display
> devices, not only virtio-gpu.
>
> take care,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
