Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6642FDD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbhJOWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhJOWJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:09:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A27C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:07:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so43356145edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEPuILzn8A/tb4FgOT0nL/Q0aVprlx+TzeMfH0xSkng=;
        b=ItI+9yo9glXHT4IvBd+1RhAfsc5PnfbvkeLAGL38PcdKsXZ0kscSOA0bux1h24L5AJ
         R9R923qh5I98RpB26cp7oC8SgLgt1VkEEMJ9v5mrRWLB1BeDwW6nscU9ilENcIYSxyFR
         l2TYYmwAaRLibcHsp/u7Xxl6vz6eI4BCJROzsYU+NAe8Dwf/SOSko4OM57bipfymsKl7
         8LHRUcAlVr/YJb0tQpfu1BQjLPZM9X+9chhaob3Um5k9LGik3zZIiHquzNUWrpSIxi9o
         fYAHJ4eVoB+YkbDPLh5p/XlwO8l6U1zuZXxM05N13qkTxXFg0p1oGGvGUDgxLspsPxLx
         EwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEPuILzn8A/tb4FgOT0nL/Q0aVprlx+TzeMfH0xSkng=;
        b=yTfhMyVtQ2FjWijaX0CiXMIbnlPmQisUJf9WbMGmvQqRZOAyVQUx7Q6PyHtZxMlugj
         zHCK5Ykgg96QdnPjIFvck6Ua9JcBLpsRh+34I+kCUqpVxggP/tH2oSTVgdR5GKK66l2x
         Tj1F/9gFgY3NhqD3w4rcbQ8aa1rjUsIWSSAvCM8WejH4h8HXxLRZPimBfJ7VXHcfoBNs
         5tFvpqlnkk7QsMPlitdFmoep4mquWT8WevqA6925SDjWzM6T3P+jQXlnGm4NFf5WKPP2
         k+4aZ1i3zqk/QW38jbMwSY+sGtVd7GhAabOEjRAgeqOIqyr5CQtCTZ+mLI+DB/XAsi+e
         gPKg==
X-Gm-Message-State: AOAM531vslNUWXO+/ERxpEOqJLyLmB8IG9AzsHYv0dacDeFIhD3+m7jV
        /288Ue7Mg7bA8IqRSj+TWcx3edEIQCo0YwpANt2od1kX89E=
X-Google-Smtp-Source: ABdhPJz1ai8dR1OFBDh7IzSW9u4hxzvcUqM2tgq5qQyCsHsN1/wnXC4Qz2Hcy2NMTPIAjsBrcoY7rEAFdcOFm9FB9KQ=
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr21546574edt.327.1634335634903;
 Fri, 15 Oct 2021 15:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-5-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 00:07:04 +0200
Message-ID: <CAFBinCB_Z+errWL4C-K3WrPu2B7gxr3NRFsF3_Xoy48XDsOb-A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This implements the necessary change to no more use the embedded
> connector in dw-hdmi and use the dedicated bridge connector driver
> by passing DRM_BRIDGE_ATTACH_NO_CONNECTOR to the bridge attach call.
>
> The necessary connector properties are added to handle the same
> functionalities as the embedded dw-hdmi connector, i.e. the HDR
> metadata, the CEC notifier & other flags.
>
> The dw-hdmi output_port is set to 1 in order to look for a connector
> next bridge in order to get DRM_BRIDGE_ATTACH_NO_CONNECTOR working.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
another great piece which helps a lot with HDMI support for the 32-bit SoCs!
I have one question below - but regardless of the answer there this gets my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       pdev = of_find_device_by_node(remote);
I am wondering if we should use something like:
    encoder_hdmi->cec_notifier_pdev

> +       if (pdev) {
> +               struct cec_connector_info conn_info;
> +               struct cec_notifier *notifier;
> +
> +               cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
> +
> +               notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
> +               if (!notifier)
> +                       return -ENOMEM;
> +
> +               meson_encoder_hdmi->cec_notifier = notifier;
> +       }
and then move this logic to meson_encoder_hdmi_attach()
This would be important if .detach() and .attach() can be called
multiple times (for example during suspend and resume). But I am not
sure if that's a supported use-case.


Best regards,
Martin
