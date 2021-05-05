Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B04373DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhEEO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhEEO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:29:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69132C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:28:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gj14so895728pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkhgClM1UbbpkX/kyBOWEOSsONynpU+16Pjzhic0mWo=;
        b=W4bBfp+mvMkITOt1lWRHvj+YNrG0HqXBeHQrXIgTq/PSF9EJ5YlkW2hnqYZFCq8eHt
         ZmfFV3hmi2F1S/1wZ8gVvOVgvVN+BwA7Zhu6h2Ti+loWbllUK/Ky57dLE+Hil1oo3BlO
         fawPKw+g/t3a1a1EWNJEUl7cpe8kwp4yPtbAkCjGrXxfFGBPajKllJxDrhR20HsdNb3T
         REG3+LK0jh/RHc/ulNcETJ4HIY7oHBdOEDT/mtX+AvDJd5DCwAA64+mzAHHVbrFg9RHo
         nZRLWOzmNf96cVKkRa6DQCy9OPZFbPl9vrkq1dfE7a0H+gnEqbqbgsXuOpGtQavgj7s9
         mpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkhgClM1UbbpkX/kyBOWEOSsONynpU+16Pjzhic0mWo=;
        b=jfibdSP+jIH/OuImVe31wOEobvxuiN0Zw4jQJ5iqylkhpH9fw9un0a1xyYpbCaSaNT
         52kJ6qcSN14IH/N2PP92o7KJjbyCoMOrjB5/+L1VQ9itFVVDl57ooukjtenDx0YaLrO/
         TTPk5fnUTQqR6G1EzrBHGAybvfN3/sgiVa6DYYJt20CbJ5cREMD0OeeCiU0Ty2AIwgUE
         STlEwwEgj/txUK8zYRRtzolCOWSG0Ckij/Kfqv9YTfCBCnZafTvzKHvXTY69VuQONIjV
         jv6H9Rajdfn2shcIOAKCamKxH1+YhobzpnbGQl+gUohUiQC3DB/st1MIlRuhfO0Q7gLV
         dSKg==
X-Gm-Message-State: AOAM5316w0enFjgeZ1WelH6LYsEAdqoitQHJ8w8c7cmharnGAdWUD6mn
        Z6TT6seRHgcDomZiDmbIYGaQeQVfOY32DEtUp7CD7w==
X-Google-Smtp-Source: ABdhPJzD0BPZ4Kttar89LthjOLYQn3AIAVr6aTribgASi7P42SF9sSIdN9GwAlX+BBW9j5G5abaKUwvUp99ZK8VWsfI=
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr4476555pjl.19.1620224899954;
 Wed, 05 May 2021 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504220207.4004511-1-adrien.grassein@gmail.com>
In-Reply-To: <20210504220207.4004511-1-adrien.grassein@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 5 May 2021 16:28:08 +0200
Message-ID: <CAG3jFyu-aWLoiJ01h1DebVz66qtmt_T8adROKNBGBOzqbJvZvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix LONTIUM_LT8912B dependencies
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     msuchanek@suse.de, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Thanks for the quick fix.

On Wed, 5 May 2021 at 00:02, Adrien Grassein <adrien.grassein@gmail.com> wr=
ote:
>
> LONTIUM_LT8912B uses "drm_display_mode_to_videomode" from
> DRM framework that needs VIDEOMODE_HELPERS to be enabled.
>
> Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 400193e38d29..70bcceaae9bf 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -68,6 +68,7 @@ config DRM_LONTIUM_LT8912B
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select REGMAP_I2C
> +       select VIDEOMODE_HELPERS
>         help
>           Driver for Lontium LT8912B DSI to HDMI bridge
>           chip driver.
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
