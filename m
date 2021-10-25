Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3F439671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhJYMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhJYMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65884C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:37:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y80so7574700ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yGLH8uVWLuSA9dEMz+vdTlondXf9cNFOoA29oShWxuk=;
        b=LLAlEGDyXJ9oBcFgx0FstENWhGJGBw+MU2MvjOOwhNSoyGBn4ejeIinmAAK55k4hq2
         KXk7ljrhCFdHOUww6DfXEGS9kB0Wkqod1QzKlWuicZ7qPMWXkDgPor1Ee6i9eMZ0rtKB
         6CHzw1dZw230g8B5f5Wg6tsFmh/WpvmvhWa68mYuXNWaoIrIdv5qAjsNsC+GFHKGX41a
         AkmRCV/JW8WolA7BbatEZDO2k/IekKGGDhMb/vmFmevlA3IzUU8UoJ7U80ncliawRcXK
         NLj2bXZkAlEvA76p15d5dobM8IeQSp61Tl52Nc1WfwKai15ustGcCpXhP0ZZ9BHGQLNy
         1Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yGLH8uVWLuSA9dEMz+vdTlondXf9cNFOoA29oShWxuk=;
        b=vyuDpkJ8SprBYM5nVjHjUrKDpXLtUR3P8f6XsY8Hc1BOlecIcvq2ralqYY54dPMn+l
         ZqfqGBI/pWn9fpA8i8QXXTo5KLmL89zjUFF6EWN6E+7yz4vDl/hRzmtY3EVsKwD8SBqO
         I1du1TxeuvRjH6Wkx/E5dEEENNvU2mso8I+lcvjAS5a6WdVtddhz/VvQhWfEel5eu0fu
         /XBR1izCyAdQY00fB9vgG7437eI3BFUsPnVz4H4+FatKPC5+EPtbNWr5Lvej1nj1dgUU
         cinx2ApwX08j7TRWmKxH3zkQZo3t4M6RBQyGuyfhZJstSFFkv0G3uw5WraIpmy1FvXTM
         gzgQ==
X-Gm-Message-State: AOAM533450IXpB/TvOLypSSzvATo3JGWkdpyIsKOV/F6uezf/EGU7/S9
        VgctIyh7VrbwtAHGWYO68BIDSgEZC9OWnVuQkSs=
X-Google-Smtp-Source: ABdhPJzrX6/3pdNNpZCHVmN3Cai6+BdMK++mTulUcyrUj+T2Nt3Z/48raEwuV7L/ucU0MipxZGbUo+LXnkZYgYATSJ0=
X-Received: by 2002:a25:bdce:: with SMTP id g14mr17426198ybk.352.1635165440516;
 Mon, 25 Oct 2021 05:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211022144040.3418284-1-javierm@redhat.com> <YXMNOfBS5iFenmx8@intel.com>
 <c1d1f245-7bcf-16e5-c3f4-c13550843e02@redhat.com> <931230b4-1e73-948d-abaf-f1d62ea58239@daenzer.net>
 <f3c9f2e5-73f7-e7c9-dc97-8bfa7b294b0b@redhat.com>
In-Reply-To: <f3c9f2e5-73f7-e7c9-dc97-8bfa7b294b0b@redhat.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 25 Oct 2021 08:36:44 -0400
Message-ID: <CAEg-Je8C03KwXf0F3t+ZABDabQq-rp7ZE68v7=k7OusSBTEvog@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 8:28 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Michel,
>
> On 10/25/21 12:45, Michel D=C3=A4nzer wrote:
> > On 2021-10-24 22:32, Javier Martinez Canillas wrote:
> >> Hello Ville,
> >>
> >> On 10/22/21 21:12, Ville Syrj=C3=A4l=C3=A4 wrote:
> >>> On Fri, Oct 22, 2021 at 04:40:40PM +0200, Javier Martinez Canillas wr=
ote:
> >>>> The simpledrm driver allows to use the frame buffer that was set-up =
by the
> >>>> firmware. This gives early video output before the platform DRM driv=
er is
> >>>> probed and takes over.
> >>>>
> >>>> But it would be useful to have a way to disable this take over by th=
e real
> >>>> DRM drivers. For example, there may be bugs in the DRM drivers that =
could
> >>>> cause the display output to not work correctly.
> >>>>
> >>>> For those cases, it would be good to keep the simpledrm driver inste=
ad and
> >>>> at least get a working display as set-up by the firmware.
> >>>>
> >>>> Let's add a drm.remove_fb boolean kernel command line parameter, tha=
t when
> >>>> set to false will prevent the conflicting framebuffers to being remo=
ved.
> >>>>
> >>>> Since the drivers call drm_aperture_remove_conflicting_framebuffers(=
) very
> >>>> early in their probe callback, this will cause the drivers' probe to=
 fail.
> >>>
> >>> Why is that better than just modprobe.blacklisting those drivers?
> >>
> >> Because would allow to deny list all native (as Thomas called it) DRM =
drivers
> >> and only allow the simpledrm driver to be probed. This is useful for d=
istros,
> >> since could add a "Basic graphics mode" to the boot menu entries, that=
 could
> >> boot the kernel passing a "drm.disable_native_drivers=3D1" cmdline opt=
ion.
> >>
> >> That way, if there's any problem with a given DRM driver, the distro m=
ay be
> >> installed and booted using the simpledrm driver and troubleshoot why a=
 native
> >> DRM driver is not working. Or try updating the kernel package, etc.
> >
> > For troubleshooting, it'll be helpful if this new parameter can be enab=
led for the boot via the kernel command line, then disabled again after boo=
t-up. One simple possibility for this would be allowing the parameter to be=
 changed via /sys/module
>
> That's already the case with the current patch, i.e:
>
> $ grep -o drm.* /proc/cmdline
> drm.disable_native_drivers=3D1
>
> $ cat /proc/fb
> 0 simpledrm
>
> $ modprobe virtio_gpu
>
> $ dmesg
> [  125.731549] [drm] pci: virtio-vga detected at 0000:00:01.0
> [  125.732410] virtio_gpu: probe of virtio0 failed with error -16
>
> $ echo 0 > /sys/module/drm/parameters/disable_native_drivers
>
> $ modprobe virtio_gpu
>
> $ dmesg
> [  187.889136] [drm] pci: virtio-vga detected at 0000:00:01.0
> [  187.894578] Console: switching to colour dummy device 80x25
> [  187.897090] virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
> [  187.899983] [drm] features: -virgl +edid -resource_blob -host_visible
> [  187.907176] [drm] number of scanouts: 1
> [  187.907714] [drm] number of cap sets: 0
> [  187.914108] [drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor =
1
> [  187.930807] Console: switching to colour frame buffer device 128x48
> [  187.938737] virtio_gpu virtio0: [drm] fb0: virtio_gpu frame buffer dev=
ice
>
> $ cat /proc/fb
> 0 virtio_gpu
>
> /drm/parameters/<name>, which I suspect doesn't work with the patch as is=
 (due to the 0600 permissions).
> >
> >
>
> I followed the convention used by other drm module parameters, hence the
> 0600. Do you mean that for this parameter we should be less restrictive ?
>

I would think that the 600 permissions would still permit it, since
the root user can still access and manipulate it.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
