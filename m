Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE144340E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhKBQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhKBQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:56:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A223C0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:52:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso2480766wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0Gv/QN2qKt1UUPbNJBs29OCuwlLk5Iawd0kmAyppIA=;
        b=h8aMBSgC270p3YyYgpwd9zWqS4OtdEsHQZvdJaLWV40vD/w3SBChTEGVptLs4VFMcV
         F+m0yWAxAiUwVV61X7q/i5Unb16+/SPQ06goMnbo0rqkGD+hNXgrCr40eqc0eyCriHWQ
         vVcCZrnStQNxzF0Vk8mGFtQ5go+gzkRcRs9mbuG1d9X6dTQTvvMLv1WlRaKMnOXQyn8s
         +lCoJMOgq1G2+PNrnXXiToV8q+ew4tPM6QgDTNohpD2dn4A/Z3Ze8FR7X5yRuAM5qkHo
         arzRyFiTo2RFka7YS6ianmQPTC7B19SphNKM4HC3fK6Tlykb1zjzHE5J9pgr3HSDpMRL
         o7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0Gv/QN2qKt1UUPbNJBs29OCuwlLk5Iawd0kmAyppIA=;
        b=aN37+2UsgnwBjdDpi+MWuLDBixy+Dr409LIu8xtvT4TJut2yCOIXlIub9Pxpg0I+aq
         YhKvF7CK2gUhMEoO3sP0r76pUC1SHKEoMvc9aIAVLGfjUFZ04TDhyBMy+LoJFIkViTLz
         6Seay+sJyiumtIWbegqcsK+VRBPV0EC9gxmIcl851I6o3EkrFwE3ssthahDDqTcfFPk6
         ZugeMDI4NjRNhnvj4Wvzy5YlSpwDfsTXq7CQdzygYeLvDk2FT5H1gA5uHBBehCv3b/o2
         YeXZOIk+qtIpzoqUtzU28RJ8FlLPb9aH3dBz21HTVDw7Q3LQcQMyIUOEVgQyhERcUVZ3
         k++g==
X-Gm-Message-State: AOAM533E8e8Nmq18yhHFI1a29E83W2k3scZhyXQiFtn4tg/MiaPWuy92
        J/cxm4u37if+hoPjz0RJLTixkkunPrYvsEhjV9Qpwg==
X-Google-Smtp-Source: ABdhPJxwhjzaNXSqOK31BY9i52m7fgj9oObZ/pz+E28nZFxKsfZi10g6CAzJlWv/8mfKRLWsrXwneMezrmknElEZ96o=
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr8145187wmh.15.1635871926869;
 Tue, 02 Nov 2021 09:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-10-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-10-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:51:50 +0000
Message-ID: <CAPY8ntCiQ_42mXMYz_TF33TwAArH=o_C9MazuPmKwSosP2qrnQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] drm/vc4: hdmi: Enable the scrambler on reconnection
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
> If we have a state already and disconnect/reconnect the display, the
> SCDC messages won't be sent again since we didn't go through a disable /
> enable cycle.
>
> In order to fix this, let's call the vc4_hdmi_enable_scrambling function
> in the detect callback if there is a mode and it needs the scrambler to
> be enabled.
>
> Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index d36b3b6ebed1..fab9b93e1b84 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -180,6 +180,8 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
>  static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi) {}
>  #endif
>
> +static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder);
> +
>  static enum drm_connector_status
>  vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
> @@ -216,6 +218,7 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>                         }
>                 }
>
> +               vc4_hdmi_enable_scrambling(&vc4_hdmi->encoder.base.base);
>                 pm_runtime_put(&vc4_hdmi->pdev->dev);
>                 mutex_unlock(&vc4_hdmi->mutex);
>                 return connector_status_connected;
> --
> 2.31.1
>
