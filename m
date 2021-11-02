Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD74432F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhKBQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhKBQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCEBC0797B8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:25:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r8so21360483wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UVbCn+dweftJ4UThMfodLelIWvo3obPmmaxdZTGfog=;
        b=Fc43d8+8UQDqpXQpsb+NlcnNHH7EZ8igqz4gIwWrH/WoOalk1npGU9P9LJqNHHS1W4
         qkSoAtH67pe4gmFzMGMEtM2QGbxgR2DE2b16xKQtc/XiZB2PI9GRIDbWg4cWWOOuZTco
         hu4WMUEUo7Q6DL6kQ9VEKUpcJkOnA8ipSGIAKFNJRI9aFhE/cOa1jy+E3kh2ny9tfAhI
         NL95lYzHB/IDrULrtDv9BhphGKLR5mVH2MM1MyD5snuzmh5LyvAXj4cT0Rq4r6M0cepm
         8eOn9aKUQz/kPWN8J6hRGByYux06kgL1HWy2WEpaPheqk3CI2cfY4SmuKBWwfQv7io0K
         JbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UVbCn+dweftJ4UThMfodLelIWvo3obPmmaxdZTGfog=;
        b=FbsLi8dQF8cdQhM5/fsoICOCPRHMZC6Kzl0KBtTtHZSQRsFb6nR7rH6LAaB+u2l4Po
         TAzu1GNvZlO/xWTWgrrJzizHixb59QfmLFwch0EEmDrrfHS7v/F9DB/Za9qRVYd7lltb
         HC4EpCOE5THul51nKJba1+8DxeQ+e6b7U64C59f9uVMFCsv6c5IK7AnrFcQ1xOndpMFV
         2SrC1mxXb69d8tBGYeKFMDyr3iNCvRsi5ppuVuKTdRxleX5wHmZQJg4UPxZMNsO45VRe
         uUX59svFjYauM4DvCkST24TkAz4V8yiNeeT8J5MdCObNONfch4+odunO6BFwQsl5N65F
         0RVg==
X-Gm-Message-State: AOAM530vc1JIHG90ByZMJJMa3YZN1QoNthep9taeo+vImegaelsZ1uRF
        WibamjnZs0hvm5cDUUI71Cpvwzu9zwLN0DCz7EnIWg==
X-Google-Smtp-Source: ABdhPJwxkkRG0ys6ur+FK/m7LPeGgM2Dl9LR5lM6EbYjmNKYjg8TbseGiHPCBRGubUjKaQlGMekP5J1laoKvxFHiu2k=
X-Received: by 2002:adf:a143:: with SMTP id r3mr48449737wrr.8.1635870316662;
 Tue, 02 Nov 2021 09:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-5-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-5-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:25:00 +0000
Message-ID: <CAPY8ntB=SCKArD5O_Zic_dPxCO0RZxr==EnfdWcghiuNtBHZ3A@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] drm/vc4: crtc: Add encoder to vc4_crtc_config_pv prototype
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
> vc4_crtc_config_pv() retrieves the encoder again, even though its only
> caller, vc4_crtc_atomic_enable(), already did.
>
> Pass the encoder pointer as an argument instead of going through all the
> connectors to retrieve it again.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 7cfd4a097847..e5c2e29a6f01 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -315,12 +315,11 @@ static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_FIFO_CLR);
>  }
>
> -static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encoder,
> +                              struct drm_atomic_state *state)
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
> -       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
> -                                                          drm_atomic_get_new_connector_state);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>         const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
> @@ -597,7 +596,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>         if (vc4_encoder->pre_crtc_configure)
>                 vc4_encoder->pre_crtc_configure(encoder, state);
>
> -       vc4_crtc_config_pv(crtc, state);
> +       vc4_crtc_config_pv(crtc, encoder, state);
>
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
>
> --
> 2.31.1
>
