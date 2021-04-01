Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF96351A68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhDASAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhDARq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:46:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D5C0045E1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 07:39:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f17so1148332plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJd+MUFo0XX0bZ87nAzur9O3CX6wH0hMl9szGovIO+U=;
        b=lT8rLoA46GAsqanEivZwqwGf8FFfuPDGksXMy8dE1ySACchbIqAtpInKtAyJ5Yqe9k
         GzsqRT4MRlwH4ev0c46sD16C2EaZsJ/87dxJ7+FFNKu77qJwACz5JF/bzLCymjmyvRN/
         LDm/EiPP1kwy8nckigs4rv4bEV/e0Y2iRMMQGt0KldiN+C813ng5sRuB4ND1ZdUqlJc0
         nUMWRadeX1yrZ4kCF3vYWwcRtZuP46Dw95sEGcBSwhgtMAzTBu+rSTnLf4K9p2jwvg5A
         VYwpulwlpikyBGlMD1XMbyeomiajTx5AsFgoSmcc7IUS8Ivon4jhXB6SM9pUeyhmKoA5
         Avyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJd+MUFo0XX0bZ87nAzur9O3CX6wH0hMl9szGovIO+U=;
        b=oJm97xzZWD8/jjmbtEwjvCCe7BW3eVXZmNkgD+UEgj88SGJzMnU//9Pe0V2HlWUmhw
         ffdK9YO7WPsH9POV9vSAtINLTRIvGbqagmH8sqLJ8kulgKYDByOsyvrOeTgslnn0BVaV
         fm0xK5+ftxfdXJWFqWXKgWGOr7nbxOVirBXYmcf3VVbs1+NFrfpWRASEdFHL1o6w1i7u
         sNYouiMrxWuKSgV/vTbXpLar3hEb+ShTFqQfDS/kGwRnlLl8Ng9aZDqcpNGtKrXub/RV
         hGqdY/9cIyyuCpZqLyUanEGvl2opaJlcEXW84TRC2ImH7+60PkNIOIzSAww4kOr94UZo
         TqPg==
X-Gm-Message-State: AOAM533vp8ewKfCeRhhIBnQvhD2BQc9ZqgRMCXLbnMoQcYFfUP5DEqv+
        Ej8pYWPRDB0blLU3Qy2yj6s1nWVpgHf3FGmB3ottyA==
X-Google-Smtp-Source: ABdhPJx5J2TMYKbVuGkqz4CgIBmuDV05Jucwa3rkV95Iqq7+kFDcfqmogyShve1r3BsgBXZyMLNsn0GDbOWgYFavOpQ=
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr9381570pjs.75.1617287962645;
 Thu, 01 Apr 2021 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210222215502.24487-1-julianbraha@gmail.com>
In-Reply-To: <20210222215502.24487-1-julianbraha@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 1 Apr 2021 16:39:11 +0200
Message-ID: <CAG3jFysbOHbDGDWNnyOUH5tyLAxAWutp6HHnO-97BagnLqA8Yg@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: drm: bridge: fix kconfig dependency on DRM_KMS_HELPER
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Julian,

Nice catch, this patch looks good to me. I've pushed it to drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=62066d3164467167fc27b2383f67d097e39bf176

On Mon, 22 Feb 2021 at 22:56, Julian Braha <julianbraha@gmail.com> wrote:
>
> When DRM_TOSHIBA_TC358762 is enabled and DRM_KMS_HELPER is disabled,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
>   Selected by [y]:
>   - DRM_TOSHIBA_TC358762 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
>
> This is because DRM_TOSHIBA_TC358762 selects DRM_PANEL_BRIDGE,
> without depending on or selecting DRM_KMS_HELPER,
> despite that config option depending on DRM_KMS_HELPER.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index e4110d6ca7b3..909d0a5643c2 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -183,6 +183,7 @@ config DRM_TOSHIBA_TC358762
>         tristate "TC358762 DSI/DPI bridge"
>         depends on OF
>         select DRM_MIPI_DSI
> +       select DRM_KMS_HELPER
>         select DRM_PANEL_BRIDGE
>         help
>           Toshiba TC358762 DSI/DPI bridge driver.
> --
> 2.27.0
