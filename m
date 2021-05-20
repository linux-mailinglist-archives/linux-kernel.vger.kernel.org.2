Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8B38B85B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhETU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhETU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:27:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B073C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:25:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so20854072edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6+wHMIa16BIAfcr0/AspV73VlTuSsDUuM2FpOlowOc=;
        b=O9qoQYrizwrGO33O23Eh/taGb21Uq+Sf41L3WzruURauHfByuEuoJ1UE1mSl0b+3i4
         NSD8MlBu7ZqxAXskQNYjyW0Cf3HNjspL2OeWNALMprYILIwuDFRwj/iD5XNMi4tftycW
         EsknKdePJnUKRI7GwYUV4vgaiBNKlvfZYpI3YgA+pOtRuOdBwCcz6pJyixy1j6tnjTwA
         xc2nWDa5LBBVMSo3KVFY7ratdf/2jGMvaBkcjlxZeGivKjGwBBF3BqIOAyT5GGFYupwY
         OXfUcXE+pz37Vs2ya5wtU7hZnc0G6kQwzloGCssXZuruhVK/nWdQ7GD3YjcBN8DK7xpf
         IPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6+wHMIa16BIAfcr0/AspV73VlTuSsDUuM2FpOlowOc=;
        b=ENViASengEISP6hTgN2S+ReWN8Yc1ly0ljxqPRYObr3TYunicswcaJoxA+eaHu5F8N
         KyHFV/MLuBagKtyXLYEtTTO/H2/sChpnUyaWwmhGp+/f01kteFQIvPnmdsG5YBwZCjk0
         vwPoqFF4ikOOgFNwxDU4RK4Fxe1TgmSoNJ4FptW536kN/LOzXjmRGH1qc+8bOAFKWo3w
         gdoSxeSg2DxBX5AURhxRmUyJMd11MlRV4Qs/lWq4AWFCuGTqbOWPgCQKzQslkOCMr4Fz
         OtJXueX55ny4kCe3z/kbGWFMVk6FEAv5xrA23nVHrj9T/5J8dtQKmjaNtRanAxf0H4fb
         HbSg==
X-Gm-Message-State: AOAM530+7fd1K/P52Hh93gdbEDZz3mDIXsv7Cxuqvnr9aeAIwxfqFKcr
        ZO0qq1++Gx8uqdRL1LO1yFJOpuJcUecGA5V+AAU7TPmB0/8=
X-Google-Smtp-Source: ABdhPJw8pr02cKMNKMU/gav1Jo5Bo/EIho2tm3jRn7MMn/JFbkOi35Bg7rsUYA+POgIEX4ds0rT2SCk9e8a1tOYJReE=
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr6952362edz.146.1621542356228;
 Thu, 20 May 2021 13:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210430082744.3638743-1-narmstrong@baylibre.com>
In-Reply-To: <20210430082744.3638743-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 20 May 2021 22:25:45 +0200
Message-ID: <CAFBinCC0aaMUbBkJ4bjhFa0A+sZH1muyW6kqAQYfjjXOkrNPGg@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: fix shutdown crash when component not probed
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

since this has not received any Reviewed-by yet I tried my best to
review it myself

On Fri, Apr 30, 2021 at 10:28 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -485,11 +485,12 @@ static int meson_probe_remote(struct platform_device *pdev,
>  static void meson_drv_shutdown(struct platform_device *pdev)
>  {
>         struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
this part made it hard for me because I was wondering where the
matching dev_set_drvdata call is
it turns out platform_set_drvdata is used instead, meaning for me it
would have been easier to understand if platform_get_drvdata was used
here
that's however nothing which has changed with this patch

> -       struct drm_device *drm = priv->drm;
>
> -       DRM_DEBUG_DRIVER("\n");
> -       drm_kms_helper_poll_fini(drm);
> -       drm_atomic_helper_shutdown(drm);
> +       if (!priv)
> +               return;
> +
> +       drm_kms_helper_poll_fini(priv->drm);
> +       drm_atomic_helper_shutdown(priv->drm);
>  }
then this part finally made sense to me (as non-drm person), as
platform_set_drvdata comes near the end of meson_drv_bind_master (so
any errors would cause the drvdata to be NULL).

with this I can also give me:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
in addition to my:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Can you please queue this up for -fixes or do we need to ask someone to do it?


Best regards,
Martin
