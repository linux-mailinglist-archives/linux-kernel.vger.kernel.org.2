Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7D43E909
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1Tlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1Tlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:41:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298DC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:39:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i14so9567082ioa.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/tSSshBuJQz7Lwgul+YjHklhggiEii8fl+Q1ov2qBg=;
        b=JAgmYZ1JK3WXZKDXwnei5tjYJA9/Iz1jHuwZyy65wiB0AJb2MEdsiRbxmZg3h8deOT
         D+4zKwOhUlP0HE0GWJ7bS0nwGEW1JuG3nYfKjVCQTJ3JqTQbG83Iod0YFsE15DClPURf
         DnExxUVM2w1UgARqVS/1+f10OqITCHUK4PiwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/tSSshBuJQz7Lwgul+YjHklhggiEii8fl+Q1ov2qBg=;
        b=oj8YRAVoSwrs2lXxmhQdHAdCzN1i9uecjcTjoWYJt2T+cIjpKBO/li+62rjQdHoGvB
         w/muqca/G99RYB5yITMWIQnQjMhWXjcO1/0tEEDp6vmuOVMaVzLd7PPnmqVxU9vq6cpN
         pk1gnFPa8SuJeBJNJVAGEyxA2SmPXAnSkTyxw/G6JRz2b2TOaQPf9I+ry45mCfMG9Ygc
         jDopivZGPxIlCnwHGAHdKH09nyX69i9tOMO/+9Y9CrRVefsB9SYBzfLBS0s0FNQxrQCl
         0a6rNxA2G/wORfeWnsAt7ztMUcMACpd28m0v6a+1gFZGDIrHjsgSxK3Jbnb9iT8aQ0Dw
         Yk5A==
X-Gm-Message-State: AOAM530D+cmrvmtb9DnLM3y/9aRUGbiqsWbIPVtmF8A7QAYAoaSNEHWO
        fwlMnFCZCWQaJvSCi8ScZZ0gXZyYKdSQNw==
X-Google-Smtp-Source: ABdhPJxWpP9Kam7eowoXqF884yTzWA86BXKZFojsbcIpu2ttA9l9JZo+51N7FD5u2HD+TmMTfRry9A==
X-Received: by 2002:a5d:804a:: with SMTP id b10mr2484991ior.197.1635449962944;
        Thu, 28 Oct 2021 12:39:22 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id l13sm2227010ilh.14.2021.10.28.12.39.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 12:39:22 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id l13so8195638ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:39:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr4341118ilv.142.1635449961589;
 Thu, 28 Oct 2021 12:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211028105754.v5.1.I828f5db745535fb7e36e8ffdd62d546f6d08b6d1@changeid>
 <CA+cxXh=VOkRnkgfxq8DVes=xCvR=691eY-ViQxME2fHMgt1q8Q@mail.gmail.com>
In-Reply-To: <CA+cxXh=VOkRnkgfxq8DVes=xCvR=691eY-ViQxME2fHMgt1q8Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Oct 2021 12:39:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vm1X3xFFkffigKr9z_FuTeA0Z70+_0NVfWcSZy90J-Zw@mail.gmail.com>
Message-ID: <CAD=FV=Vm1X3xFFkffigKr9z_FuTeA0Z70+_0NVfWcSZy90J-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 11:02 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Add "Sam Ravnborg <sam@ravnborg.org>" to cc list for vis.
> Remove "Andrzej Hajda <a.hajda@samsung.com>" from cc list as the
> address can't be found.

Looking at <https://lore.kernel.org/all/b2fb88db-009e-4b38-dc3d-5ce9163257de@samsung.com/>,
it should be Andrzej Hajda <andrzej.hajda@intel.com>. I've added.


> On Thu, Oct 28, 2021 at 10:58 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Fit ps8640 driver into runtime power management framework:
> >
> > First, break _poweron() to 3 parts: (1) turn on power and wait for
> > ps8640's internal MCU to finish init (2) check panel HPD (which is
> > proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> > called before panel is powered, we only add (1) to _resume() and leave
> > (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> > to ensure panel HPD is asserted before we start AUX CH transactions.
> >
> > Second, the original driver has a mysterious delay of 50 ms between (2)
> > and (3). Since Parade's support can't explain what the delay is for,
> > and we don't see removing the delay break any boards at hand, remove
> > the delay to fit into this driver change.
> >
> > In addition, rename "powered" to "pre_enabled" and don't check for it
> > in the pm_runtime calls. The pm_runtime calls are already refcounted
> > so there's no reason to check there. The other user of "powered",
> > _get_edid(), only cares if pre_enable() has already been called.
> >
> > Lastly, change some existing DRM_...() logging to dev_...() along the
> > way, since DRM_...() seem to be deprecated in [1].
> >
> > [1] https://patchwork.freedesktop.org/patch/454760/
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > In v3, I added pm_suspend_ignore_children() in ps8640_probe().
> > Also, I moved the change of "put_sync_suspend" from patch 2/2 to here.
> > But I forgot to mention both changes. So edit v3 change log retroactively.
> >
> > In v4, I moved the change of "ps8640_ensure_hpd" return data type
> > from patch 2/2 to here. But I forgot to mention it. So edit v4 change log
> > retroactively.
> >
> > Changes in v5:
> > - Move the implementation of _runtime_disable() around to resolve merge
> >   conflict when rebasing.
> > - Improve the document for how autosuspend_delay is picked.

The new text looks good to me, thanks!

Since this is from @chromium.org and only reviewed-by @chromium.org
people, I'll plan to give it a 2-week snooze to give others ample time
to comment on these two patches. If 2 weeks pass w/ no comments then
I'll land to drm-misc-next. If someone gives an Ack and/or Reviewed-by
then I'll likely land sooner.

-Doug
