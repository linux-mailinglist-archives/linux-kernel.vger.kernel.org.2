Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D743D644
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJ0WKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhJ0WK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:10:28 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:08:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i14so5509956ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiP44UGVXbpC7k9IJewANkS+3gSAjhlyJBDwVsycucE=;
        b=Lu1kEcSgJ5CM4fb00TgWWDv0L3AjYU1il2R/D5xmDWuRnaaTHN04sJlmuCzfJUuhot
         h1Nm5jv0jK0T5bcewjFklOJFRyZhWSz3hKCfjw0eZ+FpyTXU+dbvkaG6RYHafg+12IHj
         gLJYqou40KMde0S7p+/JaI+zSz52QftF7ojCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiP44UGVXbpC7k9IJewANkS+3gSAjhlyJBDwVsycucE=;
        b=KY2G8oF6R4oGy2yzkBLCJY6H4owJ1XJQlFld04Kp6FmAyOFfVpeGr5+Dvq5hEr6YNc
         vOZ69o5GgkRg/GK13uhrnUMHa9vazHkJ+VuLb954+2UbWTQMaR/DyG7ogjPodo2Urcgj
         hmWcaYA1XLGOakJyp5JsLRqoCStSEw3VBhW8rUBKvzlgVTIDnlB3oEfMksgYyDdsw+Ib
         oLwIoGZfar1CuTupVGnhBXiacd36OHDOb2U1rv43scrf8nroEB7vbBlzWavfxh6nPOBo
         Fy/09m3FnVGWqfzf2hKu8Nm4w5D4eEAEnbL1Ejkq2Ih7HCT1eKwPVvNzklHnESQ/82XC
         FDHw==
X-Gm-Message-State: AOAM532yB7WX9LycyAD+DyjvQs5rDYhh6z9kVkRJNpFuzJ9cOamR86vN
        dEVCTXecSpnqcYIOlNI29rQbyiiB0/sG8A==
X-Google-Smtp-Source: ABdhPJxpOwaRG72tDGwftdQyFplX33qsrU4sU/L3wUnE0EJjeJSpDja/nUOaRKF42srDTsHkdt3xcQ==
X-Received: by 2002:a5d:9d9c:: with SMTP id ay28mr166953iob.206.1635372481105;
        Wed, 27 Oct 2021 15:08:01 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id z26sm565854ioe.9.2021.10.27.15.08.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 15:08:00 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id b188so5566162iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:08:00 -0700 (PDT)
X-Received: by 2002:a05:6602:342a:: with SMTP id n42mr161897ioz.136.1635372479999;
 Wed, 27 Oct 2021 15:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211026145622.v4.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
In-Reply-To: <20211026145622.v4.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Oct 2021 15:07:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTQG_zdQVDFPe7u8_350Nwr9tSeWjtQO7FD-3N-JMjuQ@mail.gmail.com>
Message-ID: <CAD=FV=WTQG_zdQVDFPe7u8_350Nwr9tSeWjtQO7FD-3N-JMjuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 2:56 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Fit ps8640 driver into runtime power management framework:
>
> First, break _poweron() to 3 parts: (1) turn on power and wait for
> ps8640's internal MCU to finish init (2) check panel HPD (which is
> proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> called before panel is powered, we only add (1) to _resume() and leave
> (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> to ensure panel HPD is asserted before we start AUX CH transactions.
>
> Second, the original driver has a mysterious delay of 50 ms between (2)
> and (3). Since Parade's support can't explain what the delay is for,
> and we don't see removing the delay break any boards at hand, remove
> the delay to fit into this driver change.
>
> In addition, rename "powered" to "pre_enabled" and don't check for it
> in the pm_runtime calls. The pm_runtime calls are already refcounted
> so there's no reason to check there. The other user of "powered",
> _get_edid(), only cares if pre_enable() has already been called.
>
> Lastly, change some existing DRM_...() logging to dev_...() along the
> way, since DRM_...() seem to be deprecated in [1].
>
> [1] https://patchwork.freedesktop.org/patch/454760/
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> In v3, I also added pm_suspend_ignore_children() in the ps8640_probe()
> but forgot to mention that in the v3 change log.
>
> Changes in v4:
> - Make ps8640_ensure_hpd() return int (This change was mis-added to
>   another patch [2] in this patch series:
>   [2] https://patchwork.kernel.org/project/dri-devel/patch/20211026121058.v3.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid/)
>
> Changes in v3:
> - Fix typo/wording in the commit message.
> - Add ps8640_aux_transfer_msg() for AUX operation. In
>   ps8640_aux_transfer(), wrap around ps8640_aux_transfer_msg()
>   with PM operations and HPD check.
> - Document why autosuspend_delay is set to 500ms.
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 186 +++++++++++++++----------
>  1 file changed, 115 insertions(+), 71 deletions(-)

Unfortunately, your patch no longer applies to drm-misc/drm-misc-next.
Commit 7abbc26fd667 ("drm/bridge: ps8640: Register and attach our DSI
device at probe") landed and that causes a merge conflict. Can you
rebase and resend?

This will also cause a conflict when Sam's change lands [1] so I guess
we can see whose lands first. Let me review that now and maybe you add
a Tested-by? If it lands that'll make it easier and you can just
rebase on both of them?


> +       pm_runtime_enable(dev);
> +       /*
> +        * In practice, ps8640_aux_transfer_msg() takes ~300ms to complete in
> +        * the worst case. Set autosuspend_delay to 500ms.
> +        */
> +       pm_runtime_set_autosuspend_delay(dev, 500);

To be a little nitpicky, this makes it sound as if the 500 ms needs to
be greater than the 300 ms for correctness. That's not _really_ the
case. During the whole ps8640_aux_transfer_msg() we're holding a PM
Runtime reference (so it won't autosuspend no matter what) and at the
end of it we mark that we were busy so the timer won't start ticking
until then.

Really the 500 ms is because we're quite slow to power up (~300 ms)
and so we want to avoid powering down and powering up constantly. We
definitely need to avoid a power down / power up when reading the EDID
and an EDID read involves _several_ calls in a row to the AUX transfer
function. We also expect that after userspace reads the EDID it will
call us again "soon" to turn the power on and it's nice to not have to
wait the 300 ms again. The 500 ms here is really just a number that's
not too short but not too long. I suppose it's roughly related to the
300 ms because that's the delay we're trying to avoid, but otherwise
they are unrelated. NOTE: the code will still be _correct_ if we miss
the 500 ms window, it'll just be a lot slower.

[1] https://lore.kernel.org/r/20211020181901.2114645-2-sam@ravnborg.org

-Doug
