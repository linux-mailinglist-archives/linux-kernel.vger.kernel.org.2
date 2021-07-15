Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A507F3C9D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbhGOLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbhGOLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:15:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1959AC06175F;
        Thu, 15 Jul 2021 04:12:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e11so3088839oii.9;
        Thu, 15 Jul 2021 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7yK9VzLEQCG6XE//c9cVdti/iHPJ3DxnhKwu9cnsjI=;
        b=NlMo7/06IiuX+CxJRiTWwRLYAECimiW0KcSKx3FPDyhg//qYD+xUnzoPnUGxdN/YZM
         L8QIWKpiGVXGMzF5Rs1pbhzfiDd0bVzRgb6E8/AAdfrIYlE/fhxV8s1Ngwmvlsrz/GIl
         aL/RlzPYC5j6aQfvfY8kkeK45rCPEJ4hTqhPn/q2dWzSGd2k18aUnDJbE7e6eLaFSpmr
         1PgjcCYt04tTWmzSvtIw0MeTyl4+C2pESNcbZ9Vi9HMI5ZmESxO85j6Jgemf6Xe6L2fV
         2D02skzT9DUri5jE0CHzIMB1Cg+ysuyMYfXTwi5W9Adrjbhtxq/GC9Dvro4VcA20R42q
         /elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7yK9VzLEQCG6XE//c9cVdti/iHPJ3DxnhKwu9cnsjI=;
        b=iC9eMPquFYAy0rJD5Bans4J/6776E824sDBJ1wxIOx5T6cDPhkm7xqp6asXq0XLAmD
         71X2vvlWSymSk2SQ9uSW233zcpsk0tc9iD7PpbMcsskk1pWe93MzeE3wXcMgUhqAbJfL
         Di1PXRezC/6/RgvSG3xarAOLBSYKODr9et6anpje9Wvap2CzErRMaaeaIIwpkaOoiSox
         h6zw41KOOp8H81NdmSaKvjQqIU6M3VsJ0l1HCwVBWD4JDhrWW1AJh/qBPv33MUnXZYlk
         TbexGPOoVK7mSv2zWs2u3n9E/XwdHFZBP3onPp9V5KU/V4N6SmrrHV5+VFCx1J1OzYVy
         BZpg==
X-Gm-Message-State: AOAM531qxYBhQzC/ZqvS0KT+I5C84tOqZ8rPBNQ4v69aAACXZdGL1E8H
        zewo05eJ5GOTFxdtGNqX0lEkQcqGtUTorSrHS9c=
X-Google-Smtp-Source: ABdhPJzOFkRPM1F5bStdEZ0HnTr0PNZpn8ngy3uh/IeBzMB96wnzSxAwpctzKDpwPU357CBdQwPf/oPm4PKS8eRVHl0=
X-Received: by 2002:aca:c6c9:: with SMTP id w192mr3095017oif.47.1626347575562;
 Thu, 15 Jul 2021 04:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210527074202.1706724-1-hsinyi@chromium.org> <20210527074202.1706724-3-hsinyi@chromium.org>
In-Reply-To: <20210527074202.1706724-3-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 15 Jul 2021 13:12:44 +0200
Message-ID: <CAFqH_50_EP_aBs3UuBNCFbgqFHS=jizberM8pZY6EhpOnWnbVw@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 3/3] arm64: dts: mt8183: Add panel rotation
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 27 de maig
2021 a les 9:42:
>
> krane, kakadu, and kodama boards have a default panel rotation.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

It looks good to me, so

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

and, on a Lenovo IdeaPad Duet. The display appears well rotated now.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
  Enric
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcfa3370..793cc9501337 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -263,6 +263,7 @@ panel: panel@0 {
>                 avee-supply = <&ppvarp_lcd>;
>                 pp1800-supply = <&pp1800_lcd>;
>                 backlight = <&backlight_lcd0>;
> +               rotation = <270>;
>                 port {
>                         panel_in: endpoint {
>                                 remote-endpoint = <&dsi_out>;
> --
> 2.31.1.818.g46aad6cb9e-goog
>
