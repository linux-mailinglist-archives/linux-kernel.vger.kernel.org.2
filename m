Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6573CA128
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhGOPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhGOPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:09:18 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:06:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c68so751173qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTXo2CnbSOMrGtpr7d+7B14wJbb3+loP0cPWwbTMyDU=;
        b=ezYOntX/pHD45q0yZXqp24ehBEFMb86vUfaw54iLZ1/BxcdOCC1T62TEyBhzIfTQMo
         rFgZ62blhb8mI+oMeumeYj9bpzjnN6x9iLRpjgz8Q45dwGTKhEWKCjp5oCYuT6r6QiYb
         YjvoaszX5rksO92uq6JnGGcagz3eNhyIYGsW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTXo2CnbSOMrGtpr7d+7B14wJbb3+loP0cPWwbTMyDU=;
        b=p2iYE4U8ft01URMlsAdGLqocMZ0O9cMAw3f6OHRQeDZIuG9pXFyv4mEGnEzSXxpulA
         GbF6mVvakPhPsj6Qrm8UAAzEz9rK/nJXKZzTb2vveP56xzmlwhTetrMcLXFQkIHyzKd5
         xlAxlIvsNTuxcGx+iHqNrICkC7Mj/09rwOUjlMyjpuwBejHh3ykUWJ49Z/yPnC10K877
         1iNXB1XdZ3c5icDK1oSWIYKab3tAHXOniBIC2WGBhviisNDHZqmhSTtNhXthqqt5fnr3
         0wabyEVjn20VLQQjnc5pXp68CwzTCu/4W0/vMm3H5rMgAi936YH2tpC1OTxjfccoP7S4
         iosg==
X-Gm-Message-State: AOAM533HDLfx4lgAsP6fugZleNfSOf+69fnhnUFVjuO7IWv6PvHNLoxd
        TCwyD2JWVWbOl7SHlwe18dkEl3qvUyxNow==
X-Google-Smtp-Source: ABdhPJw+vi8Io7WRg1qkSesH9aRzT7uN9DRPssnpMoJjmfTEPYBYNmSNxg3KYjeAEaHjzrzHpnjtPg==
X-Received: by 2002:a37:84c1:: with SMTP id g184mr4452275qkd.102.1626361582915;
        Thu, 15 Jul 2021 08:06:22 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id b25sm2575940qka.123.2021.07.15.08.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:06:21 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g5so9567798ybu.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:06:21 -0700 (PDT)
X-Received: by 2002:a25:b845:: with SMTP id b5mr1652895ybm.343.1626361580676;
 Thu, 15 Jul 2021 08:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210714101744.1.Ifc22696b27930749915e383f0108b7bcdc015a6e@changeid>
In-Reply-To: <20210714101744.1.Ifc22696b27930749915e383f0108b7bcdc015a6e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jul 2021 08:06:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZWKpQbG+hJkyHCViCEhgC+WmQtyKnNPuDXpi+Yrv6xQ@mail.gmail.com>
Message-ID: <CAD=FV=XZWKpQbG+hJkyHCViCEhgC+WmQtyKnNPuDXpi+Yrv6xQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: For drm_panel_dp_aux_backlight(), init backlight
 as disabled
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        Lyude Paul <lyude@redhat.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 14, 2021 at 10:17 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Even after the DP AUX backlight on my board worked OK after applying
> the patch ("drm/panel-simple: Power the panel when probing DP AUX
> backlight") [1], I still noticed some strange timeouts being reported
> by ti_sn_aux_transfer(). Digging, I realized the problem was this:
> * Even though `enabled` in `struct dp_aux_backlight` was false, the
>   base backlight structure (`base` in that structure) thought that the
>   backlight was powered on.
> * If userspace wrote to sysfs in this state then we'd try to enable
>   the backlight.
> * Unfortunatley, enabling the backlight didn't work because the panel
>   itself wasn't powered.
>
> We can only use the backlight if the panel is on and the panel is not
> officially on when we probe (it's temporarily just on enough for us to
> talk to it).
>
> The important thing we want here is to get `BL_CORE_FBBLANK` set since
> userspace can't mess with that. This will keep us disabled until
> drm_panel enables us, which means that the panel is enabled
> first. Ideally we'd just set this in our `props` before calling
> devm_backlight_device_register() but the comments in the header file
> are pretty explicit that we're not supposed to much with the `state`
> ourselves. Because of this, there may be a small window where the
> backlight device is registered and someone could try to tweak with the
> backlight. This isn't likely to happen and even if it did, I don't
> believe this causes any huge problem.
>
> [1] https://lore.kernel.org/lkml/20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid/
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/drm_dp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)

Pushed with Lyude's review to drm-misc-next:

17a1837d07be drm/dp: For drm_panel_dp_aux_backlight(), init backlight
as disabled
