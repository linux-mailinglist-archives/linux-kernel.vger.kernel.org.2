Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E6414FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhIVSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhIVSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:25:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so15644241lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLXLTgVBlIsYGUnptVEmh5wmzNsWwAg5srFOANEsOjk=;
        b=BACF8CJscB+sTIFEZP8umRgC50ndWOAyAGfzm8SVDb+M7yhh1iuf4PiTO9E8ga42yF
         s6UGwMPJSebCCFGL4KFJ0G+2LtXZMqdn3pvHU1ZY+udIJV3CLTpXm43byp2fSF7pFOjM
         17KgNVwZdr3cZLasbHyYPyzpqF9WlW/wi5I4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLXLTgVBlIsYGUnptVEmh5wmzNsWwAg5srFOANEsOjk=;
        b=zVzbgvBrC+EFHhf4iyh9+hr2Nkj01cgLQ0X20k+bht3ccLKA1KY36T77v4crvtdrU1
         KKMOwa2sISA5J5MG5hNHCWH2CWAQuDaUJaCkLuvmmw2TAvxJsLzQXt2F61tdaspFrhLm
         OpnqY3Uohnwh3/62VhBorq9cRyktqE7+6Hwl1WQLGKZgMTxl0aphrnB1QfW5pPb31hTk
         XZoQcJQ1O0TL9m0h10MyRg80tjph5hyO7TxNrAWaDCcx0pyxPsnsPQo5sNySEaF0q1H4
         P07az+VQO2Trw73tWXMDTYnLyRj8x8fDrdovFofqBUH72sTxRTSoTJd5zLsT/OhS3lDX
         /ubw==
X-Gm-Message-State: AOAM5329fDRcRJT6bZOxB6h1HbOYxhcP3aN6BYwlvp4ZfQrHxRyY6p4j
        IJe+0g+kIIJIm6NxBiaGqGold/c4wRuwaGz6Ar0=
X-Google-Smtp-Source: ABdhPJygJBPk4fgkE3GIhRtWxXg2tFM0ifSdzyY6WBC27pEeKDzax3tidlvDa0tM0yJc38pU9sS9LQ==
X-Received: by 2002:a05:6512:c2a:: with SMTP id z42mr374197lfu.664.1632335019393;
        Wed, 22 Sep 2021 11:23:39 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l26sm234596lfh.247.2021.09.22.11.23.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:23:38 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id y28so15435687lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:38 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr705404ljf.191.1632335018277;
 Wed, 22 Sep 2021 11:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com> <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com>
In-Reply-To: <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 11:23:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
Message-ID: <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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

On Wed, Sep 22, 2021 at 10:02 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
>
> Attached is a complete dmesg and also the decoded trace.
> This is done on 4357f03d6611 ("Merge tag 'pm-5.15-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")

drivers/gpu/drm/vc4/vc4_hdmi.c:1214 is

        tmp = (u64)(mode->clock * 1000) * n;

in vc4_hdmi_set_n_cts(), which has apparently been inlined from
vc4_hdmi_audio_prepare() in vc4_hdmi.c:1398.

So it looks like 'mode' is some offset off a NULL pointer.

Which looks not impossible:

  1207          struct drm_connector *connector = &vc4_hdmi->connector;
  1208          struct drm_crtc *crtc = connector->state->crtc;
  1209          const struct drm_display_mode *mode =
&crtc->state->adjusted_mode;

looks like crtc->state perhaps might be NULL.

Although it's entirely possible that it's 'crtc' itself that is NULL
or one of the earlier indirection accesses.

The exact line information from the debug info is very useful and
mostly correct, but at the same time should always be taken with a
small pinch of salt.

Compiler optimizations means that code gets munged and moved around,
and since this is the first access to 'mode', I would not be surprised
if some of the calculations and accesses to get 'mode' might be moved
around to it.

               Linus
