Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6318A44333B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhKBQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhKBQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:42:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F6C079785
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:16:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso2493275wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk7gtJZIf8x3vKhtXKZKHOEj4aweMrUNlA9C44Zf6nU=;
        b=cqWMTY5MJJwXi/lOFXC3vCIcbszW5fflGtz43DsvZLPKsdSxiqApa0wwvoK2yKSz/F
         DPRrWb9YZesKfdQf2/Oyp85SNhzZ69Zi5I+LTrFuVolojhuwmLKazUyFbavizDyrt0TL
         rlMXQgBiu1uHFBnyyuD9IKomgFj0gJvT0NuSf8pSJW4ZYPDW/0l4freXzseSVgiWVIEg
         riqGJ7kWwyy/ZRo1S56rfZ8fulGudesmBjcoamz204qznCs1TVnezaagmlqO1oPJ1XaT
         1ggUgUSkHgGxfyyvGuSxLu7z/HsNXlh8KLhbP3d9qKCI9pAYdXS3X419gt/dkAoINcvB
         D5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk7gtJZIf8x3vKhtXKZKHOEj4aweMrUNlA9C44Zf6nU=;
        b=qvx8NkERdTc7JrTG46dePvD7EJ1apjJllybdFUWaLJgEJQa2TsfCyquF4u8srHXI/i
         OqCPD1ZMbIhSnOcQE8sS6ktTGOtPYdpt/tE7Ztjkvc90gYT796GGKWEaUMQ2i9BSXAai
         z0RYMWZK7DMhMTC3KkzGPec8uuDSI4GMC7wi6vnf03+NTJxhdwv+mwIf5a0ewjRnXlBB
         thZT5Glp5LaDSMd4cNjvPxKEpWcgXspVYkRoVOe6zY60R030hvcNdRrEbsoVJEpcSGBo
         q2xq5mD23E3Rbn+3blQLjqufx9DqB/7GpUS/ak9v2dN54uM0ytbAcJ2Z9btUhNWhJCvr
         XIig==
X-Gm-Message-State: AOAM531rgLtoQLFpWjdzLYJ+qDcwyIlmM8/dnCNw0VPI/p5N4bhBF8Sh
        NvjXI5qyGmT48ks5crO3021ro7JyEJyY0YYF+b4r3A==
X-Google-Smtp-Source: ABdhPJzlVpPbIvRPDvaNvaOkdQtTw92mc0xd1dJ21JwMbqrtyuKlYZ2WkPFRAg5+D39I+fM8WCaZOjbjxyvoYzoHEWU=
X-Received: by 2002:a1c:2507:: with SMTP id l7mr8374133wml.144.1635869775698;
 Tue, 02 Nov 2021 09:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-3-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-3-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:15:59 +0000
Message-ID: <CAPY8ntCu=wzXtNeDrnYNC8NH8WwjUY-qC=UsgqS_VQO1voR8SA@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] drm/vc4: hdmi: Fix HPD GPIO detection
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-rpi-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:29, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Prior to commit 6800234ceee0 ("drm/vc4: hdmi: Convert to gpiod"), in the
> detect hook, if we had an HPD GPIO we would only rely on it and return
> whatever state it was in.
>
> However, that commit changed that by mistake to only consider the case
> where we have a GPIO and it returns a logical high, and would fall back
> to the other methods otherwise.
>
> Since we can read the EDIDs when the HPD signal is low on some displays,
> we changed the detection status from disconnected to connected, and we
> would ignore an HPD pulse.
>
> Fixes: 6800234ceee0 ("drm/vc4: hdmi: Convert to gpiod")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 338968275724..dde67b991ae7 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -190,9 +190,9 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>
>         WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
>
> -       if (vc4_hdmi->hpd_gpio &&
> -           gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio)) {
> -               connected = true;
> +       if (vc4_hdmi->hpd_gpio) {
> +               if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
> +                       connected = true;
>         } else {
>                 unsigned long flags;
>                 u32 hotplug;
> --
> 2.31.1
>
