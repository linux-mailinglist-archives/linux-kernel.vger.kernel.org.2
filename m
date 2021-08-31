Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6873FC759
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhHaMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhHaMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:36:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62246C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:35:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1979016wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqjkTcNYKfzyFpIHY9GPDPWjeBNV/2F2AOaBAYK2ovs=;
        b=NHO+KfQvg8jk/8oprujJHPrqbZQi2DVVV2l36P6CGO7IqAhsx1XKQp/rikjN6LR9zO
         abjBMJHxVj6llGB/1dhtxIYnYlGOGWiwYY+x79TOBcPY3DvEA7+W1Jt17fy5pLnu2exq
         59Mf5HhwmzybVgHLP+HpgXFpjD/hNRDUvoZFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jqjkTcNYKfzyFpIHY9GPDPWjeBNV/2F2AOaBAYK2ovs=;
        b=ccKR1fIKq2RMrHCXZw+qodXbEkKClg92S4Tl4Nb46ts8pdLjguR/49BDrofPaAloeA
         wZFAnWLKJQxoHThXXbEiLWYE3UnP3IhRSoJaDFTYBqGND0CkwVN1XR9Blwwjv2jzk8rg
         OHQCIzxaInfZwbNsnXemtSEUXVglT4OkDDepnSiz8oqSCBb4AWZdU95SmaXfcai5ML2H
         3cG5YKT4iBhOWIUs1nkvBVVV1jE5kXCazLG6glCeH9hOQqAbt/UQR8W70BML/+aq0muc
         CQnl5DgA6RWfMwzEKMKjsOh9huM3NnTLmj3xpGrKPS4aB+cW01KaeQv0Z/Xf6tO3btt/
         Z+fg==
X-Gm-Message-State: AOAM532aP3xKbVlVVWNrDWsXqH74Vhx9ojJPaNFkXLuqXpoYb3C2Ok1c
        qpE6rOqiJbBha2XF6hGgh/rThA==
X-Google-Smtp-Source: ABdhPJxM7t43JspDgcszisGhtu9sLfqW1NsFQW87rYKFpoFS/aLP5arH0VQSiiqo9MJIfzJOcRNyUA==
X-Received: by 2002:a1c:ac05:: with SMTP id v5mr3869097wme.13.1630413347941;
        Tue, 31 Aug 2021 05:35:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v5sm19103677wru.37.2021.08.31.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 05:35:47 -0700 (PDT)
Date:   Tue, 31 Aug 2021 14:35:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
Message-ID: <YS4iIR689bAZ4QT9@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
 <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 12:02:21AM +0200, Javier Martinez Canillas wrote:
> Hello Daniel and Thomas,
> 
> On 8/27/21 10:20 PM, Daniel Vetter wrote:
> > On Fri, Aug 27, 2021 at 07:50:23PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 27.08.21 um 12:00 schrieb Javier Martinez Canillas:
> >>> This patch series splits the fbdev core support in two different Kconfig
> >>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> >>> be disabled, while still using fbcon with the DRM fbdev emulation layer.
> >>
> >> I'm skeptical. DRM's fbdev emulation is not just the console emulation, it's
> >> a full fbdev device. You can see the related device file as /dev/fb*.
> >> Providing the file while having CONFIG_FB disabled doesn't make much sense
> >> to me. I know it's not pretty, but it's consistent at least.
> >>
> >> If you want to remove fbdev, you could try to untangle fbdev and the console
> >> emulation such that DRM can set up a console by itself. Old fbdev drives
> >> would also set up the console individually.
> > 
> > Yeah given the horrendous security track record of all that code, and the
> > maze of handover we have (stuff like flicker free boot and all that) I'm
> > wondering whether typing a new drmcon wouldn't be faster and a lot more
> > maintainable.
> > 
> 
> We talked about a drmcon with Peter Robinson as well but then decided that a
> way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
> intermediary step, hence these RFC patches.
> 
> But yes, I agree that a drmcon would be the proper approach for this, to not
> need any fbdev support at all. We will just keep the explicit disable for the
> fbdev drivers then in the meantime.

I think the only intermediate step would be to disable the fbdev uapi
(char node and anything in sysfs), while still registering against the
fbcon layer so you have a console.

But looking at the things syzbot finds the really problematic code is all
in the fbcon and console layer in general, and /dev/fb0 seems pretty
solid.

I think for a substantial improvement here in robustness what you really
want is
- kmscon in userspace
- disable FB layer
- ideally also disable console/vt layer in the kernel
- have a minimal emergency/boot-up log thing in drm, patches for that
  floated around a few times

Otherwise it feels a bit like we're just doing Kconfig bikeshedding and
no real improvement on the attack surface :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
