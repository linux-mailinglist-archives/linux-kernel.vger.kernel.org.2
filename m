Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B141514D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhIVUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhIVUVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:21:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5947C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:19:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i132so14397862qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWG04tH8ZQ7gPjKUtd+hX/duqooCcZZ2VSN1tOuuz5k=;
        b=dtauWIWomSt7xfZQ6C6Lm/WKaRcTXvI5dEgP+WHYIn52J6eCV6dXwTKNjUSmjOtrru
         mavucHfKbDcoYu+xKDdpGwn4MDP3rd5C8CdKD2sYEpNec2UwkuGWGIuR2OmS1KuC8p8f
         9KirbCX43ov5ZV4EECH7SNF++ejT/GLbLGPLsjFZF2PJfzAAJ0QQmqroKhi9ojgUMCQk
         ft4+D5KcBElXJ39czp+1z5FF3f7k6zUo3iNrFM+qqe1JpVYwJc/5BpWbLFXJL85167pW
         ccIiyGVBlm6wzD9ThqS2SilBHVIziYLRfxIYML1HOm1Uzkio1ahwitXAPP3S3PFSXVl9
         GCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWG04tH8ZQ7gPjKUtd+hX/duqooCcZZ2VSN1tOuuz5k=;
        b=I/pb3j9tk0jq6UTUedyidzEKPTVSv4vNHMneJCU2Uz/2EZJIS6qTTiBCA8i3RdC49r
         IM6GnT2QUVth/QMKo+sZveDCWgpYHEGvayfQ/DDsUVM9Uq1Dmxy0FApJ6rw66z5RhLlF
         dIzlZDg7gkg+ANXQBuQmMR35C5c5ZgdQ99vASpxVbPaMJERjk+8uXeRv43hbUeAW+2EM
         TPkrmobPQgaribH/HjjgIhSsGnGYbaOXkdUmQ84Q8Tgwqp5zqQnwrmX+9Yl/81B43L2e
         2rAMxNeE3Vr6WoBGIZ/46zpKqP+hyGz7WQZqbCO2AvPVFWhoQhLHS04IWnvGJPRwQTi3
         cQLA==
X-Gm-Message-State: AOAM5334vmGpi+wpD8khoAgeo8ASwaV8gaE3MLIyqUtm360mck5q6Sqm
        m7ng8RXy+nZRgCaasfgR6pvDp6kdTtTPrN92AfI=
X-Google-Smtp-Source: ABdhPJyDEsC/NHuUbFQwSMD4X/S9ZHm7zqsPZ5bIpJKEvIB03KJx81JCqj86QQj+BRLowiekNZ1W2eVYuP67JZ6q800=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr1157340ybk.403.1632341981997;
 Wed, 22 Sep 2021 13:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
 <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com> <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 22 Sep 2021 21:19:06 +0100
Message-ID: <CADVatmPDeSxeY3GTZyC6+G0N76su0E6Y3LF_h6BOcBf5QAtjvg@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 7:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 22, 2021 at 10:02 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> >
> > Attached is a complete dmesg and also the decoded trace.
> > This is done on 4357f03d6611 ("Merge tag 'pm-5.15-rc2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")
>
> drivers/gpu/drm/vc4/vc4_hdmi.c:1214 is
>
>         tmp = (u64)(mode->clock * 1000) * n;
>
> in vc4_hdmi_set_n_cts(), which has apparently been inlined from
> vc4_hdmi_audio_prepare() in vc4_hdmi.c:1398.
>
> So it looks like 'mode' is some offset off a NULL pointer.
>
> Which looks not impossible:
>
>   1207          struct drm_connector *connector = &vc4_hdmi->connector;
>   1208          struct drm_crtc *crtc = connector->state->crtc;
>   1209          const struct drm_display_mode *mode =
> &crtc->state->adjusted_mode;
>
> looks like crtc->state perhaps might be NULL.

I added some debugs to print the addresses, and I am getting:
[   38.813809] sudip crtc 0000000000000000

This is from struct drm_crtc *crtc = connector->state->crtc;

connector and connector->state had valid addresses.
[   38.805302] sudip connector ffff000040bac578
[   38.809779] sudip state ffff000057eb5400

This is the diff of the debug I added:
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 4a1115043114..2a8f06948094 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1205,11 +1205,20 @@ static void
vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi,
 static void vc4_hdmi_set_n_cts(struct vc4_hdmi *vc4_hdmi, unsigned
int samplerate)
 {
        struct drm_connector *connector = &vc4_hdmi->connector;
-       struct drm_crtc *crtc = connector->state->crtc;
-       const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+       struct drm_crtc *crtc;
+       struct drm_display_mode *mode;
        u32 n, cts;
        u64 tmp;

+
+       pr_err("sudip connector %px\n", connector);
+       pr_err("sudip state %px\n", connector->state);
+       crtc = connector->state->crtc;
+
+       pr_err("sudip crtc %px\n", crtc);
+       pr_err("sudip state %px\n", crtc->state);
+       pr_err("state mode %px\n", &crtc->state->adjusted_mode);
+       mode = &crtc->state->adjusted_mode;
        n = 128 * samplerate / 1000;
        tmp = (u64)(mode->clock * 1000) * n;
        do_div(tmp, 128 * samplerate);


-- 
Regards
Sudip
