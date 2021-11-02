Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31624432D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhKBQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbhKBQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD753C0797B5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:21:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v127so16021219wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuNpocQi4pocnnGlw+gkPjkIozlrXXBhAiLbx0uyBSE=;
        b=TQfVT0o9MR49aeFAQKvXyRgJnF8SgQZwxFl6y5i0aLo8NLuJQauP37MW/cddpDOslf
         sCe/WNGTQEjcf7Wwk1bDINL/ejg1TfDz3nJf4rvipi+dLKmRGBsO5j+5w9SwKqa9sSN+
         NSIxGTcMP1uqxkf31C7Zlj+3Rr7c0NsxxklN7wEG3Sn1oc4KqXgtaL2dd62SfdPfxbH/
         IuOf7JrXRfqqYeh7vqkJqUpb5eDUDLSuXe7CgzOzdKmGgrW4E3uFzPY8cJPLkPQxqNmv
         2jzh36GecFwHi1hb5DcpO6wegifg/g2E9GpjK2q1pvasSQoIx3iRwPm7ZEo9Q/ge9rUb
         lM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuNpocQi4pocnnGlw+gkPjkIozlrXXBhAiLbx0uyBSE=;
        b=hPkyNVrSQlfVIpGGFk4kXfH0hh6bnl2nKT2ruILiFix4nueeq1ue+RsorYPACABg1B
         I2fKfgVremJfE+87enBQ32GMmKn6FVch6ps3f5dy4GtYLnnqueu7MGK7zAPc7K//7pBE
         /+CRcGTqoSPlFaD3OvVeELLHzJqx2zX9JnKpjwqrisdkyDwpZZKoaSZcSN9Zo7li9J33
         Zhw7m2rGVVX5+sP5ANjwbofzx3C+I4mvJdcActilsjGHzS2hsaEmH+u0ozEnPLo/9Sa1
         w68GJ8pAENq9AmgfaIvtEb9RDTV/GCfZgGC/CxxhFfqm+fwL0STFtMIf796FBJYfsHho
         g1tA==
X-Gm-Message-State: AOAM530R9VbwbP4In4KhGM1fhfkWwAvZT0EmebbWmjk0GztrmKzMVC6O
        IPcICmNv2dDJ4G3GZMnl92DMrqvwGgEw07ZWv7KwLQ==
X-Google-Smtp-Source: ABdhPJwTeeL5hbLH4I+o+Y0n9y/WzHOMWRv0uAn5PLot7TrFzvgrzlzMJujU5AxE48Mi2iCqMBuWV5qa+Esy7ZbVgNo=
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr8408896wmh.106.1635870103486;
 Tue, 02 Nov 2021 09:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-4-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-4-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:21:27 +0000
Message-ID: <CAPY8ntB7e_=CWoWz=zf-ZHyaUYsEsgO2gzEDqNQno0vX_jqhcQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] drm/vc4: Make vc4_crtc_get_encoder public
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
> We'll need that function in vc4_kms to compute the core clock rate
> requirements.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
>  drivers/gpu/drm/vc4/vc4_drv.h  | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index e3ed52d96f42..7cfd4a097847 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -281,10 +281,10 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
>   * allows drivers to push pixels to more than one encoder from the
>   * same CRTC.
>   */
> -static struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
> -                                               struct drm_atomic_state *state,
> -                                               struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
> -                                                                                        struct drm_connector *connector))
> +struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
> +                                        struct drm_atomic_state *state,
> +                                        struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
> +                                                                                 struct drm_connector *connector))
>  {
>         struct drm_connector *connector;
>         struct drm_connector_list_iter conn_iter;
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 4b550ebd9572..f5e678491502 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -544,6 +544,11 @@ vc4_crtc_to_vc4_pv_data(const struct vc4_crtc *crtc)
>         return container_of(data, struct vc4_pv_data, base);
>  }
>
> +struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
> +                                        struct drm_atomic_state *state,
> +                                        struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
> +                                                                                 struct drm_connector *connector));
> +
>  struct vc4_crtc_state {
>         struct drm_crtc_state base;
>         /* Dlist area for this CRTC configuration. */
> --
> 2.31.1
>
