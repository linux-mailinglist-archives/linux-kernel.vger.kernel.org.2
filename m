Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4243796B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhJVO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhJVO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:59:11 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:56:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 67so7574908yba.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xJta1LgbGikUaHeLMB8kAoU0t7xQlrmtTQ9nyeUNTBQ=;
        b=pSvSBNfOJuEMbAhhFhVbSuj2ODm9tTRno/unAAt1EDe971a40kvDf5akrEHB3AatmF
         MXCSYedNalukwZoghqjacHYTzadBTdcUq2EiIjwRaua/RBMz4KCnYzI3FFj106IQ+ATq
         UKkZVhQO+z2SQOUrW4SJgas/9zcVpdQE8bA2vyAAtTpdl2kWn8fbgxDhiANE+d5dhfo3
         KE+4WfzV6L6SlDfmahgxygwV/a1HKnKz9HjPT3yMlUqnG+DMl53JRunr4J3BkazZPTgO
         3U1DJLFcaIg0Xv16Om2brTyC0TgF7veIAtKz5xDfWaFa142KaJQVh61HxGp6VVcNpd14
         eJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJta1LgbGikUaHeLMB8kAoU0t7xQlrmtTQ9nyeUNTBQ=;
        b=j7tSZsnwSw5MYr4pTcJ1GNc1JlaB2QtO6eEvPFJiHRK6+1+A5VTzLHKc4SHBy96eUE
         N093noRwu9XQC7zsmv/mUhMYy8mmOHBR5I7+r7RCN2tTX4qywxu8DoYpIySr0IQ7+7uo
         d3OQx/LL06oFuyBS6+3DvYanPD/vtTMHwfBL1L3SaeZmWgS7V8pylwRlcsNhNCj1sSK8
         Of/HscjKdZIuLC5eDavBnDMoQJ5azj5UyJQxty7+sINCIp8SNGOYyvBtQn9iHGx+cDdf
         q7wi2JPVbfJoSSrxJ801j1blLZC2nXhrSElGyXUtlUG2RFWlRQrCp4aFed7FPd5gtn+V
         VVlQ==
X-Gm-Message-State: AOAM530UNw2YQjE8cer5p/wRZlLHRnvUjiMrGWRYKJShKeSSjiiS2DXA
        NwQEJH3eieWhYjO2SWsBRZ02Qa8VkB2tLeJXVcw=
X-Google-Smtp-Source: ABdhPJwQ8YKApfhcSCGdyFijKioRrFOwGLLjqapBaunO/xsdVEnOUhcTteiHxyfCwknFhBGe0ozH32t0W/oEzAZksk0=
X-Received: by 2002:a05:6902:701:: with SMTP id k1mr280979ybt.298.1634914612428;
 Fri, 22 Oct 2021 07:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211022144040.3418284-1-javierm@redhat.com>
In-Reply-To: <20211022144040.3418284-1-javierm@redhat.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 22 Oct 2021 10:56:16 -0400
Message-ID: <CAEg-Je_v0zvOs1dOZ3P0qsPDO7LC8xk0zxQBLH6gr65V82dnPA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Oct 22, 2021 at 10:40 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The simpledrm driver allows to use the frame buffer that was set-up by th=
e
> firmware. This gives early video output before the platform DRM driver is
> probed and takes over.
>
> But it would be useful to have a way to disable this take over by the rea=
l
> DRM drivers. For example, there may be bugs in the DRM drivers that could
> cause the display output to not work correctly.
>
> For those cases, it would be good to keep the simpledrm driver instead an=
d
> at least get a working display as set-up by the firmware.
>
> Let's add a drm.remove_fb boolean kernel command line parameter, that whe=
n
> set to false will prevent the conflicting framebuffers to being removed.
>
> Since the drivers call drm_aperture_remove_conflicting_framebuffers() ver=
y
> early in their probe callback, this will cause the drivers' probe to fail=
.
>
> Thanks to Neal Gompa for the suggestion and Thomas Zimmermann for the ide=
a
> on how this could be implemented.
>
> Suggested-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Hello,
>
> I'm sending this as an RFC because I wasn't sure about the correct name f=
or
> this module parameter, and also if 'remove_fb=3D0' is intitutive or inste=
ad a
> parameter that's enabled is preferred (i.e: 'disable_fb_removal=3D1').
>

In general, I think the patch is fine, but it might make sense to name
the parameter after the *effect* rather than the *action*. That is,
the effect of this option is that we don't probe and hand over to a
more appropriate hardware DRM driver.

Since the effect (in DRM terms) is that we don't use platform DRM
modules, perhaps we could name the option one of these:

* drm.noplatformdrv
* drm.simpledrv
* drm.force_simple

I'm inclined to say we should use the drm.* namespace for the cmdline
option because that makes it clear what subsystem it affects. The
legacy "nomodeset" option kind of sucked because it didn't really tell
you what that meant, and I'd rather not repeat that mistake.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
