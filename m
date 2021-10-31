Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110B244107D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJaTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhJaTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:42:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB68C061570;
        Sun, 31 Oct 2021 12:39:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w1so3568358edd.10;
        Sun, 31 Oct 2021 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7Um4mUV79LuOrqozwijQdh04ZeZMr8lNOl1Ry7Klkc=;
        b=JBmPnOGFYpfbPwmjvMZ4yx4s6/ckgRAi2dKY5isYV+ClnaBBViS5BJ29bmz7iPqdbO
         DnUd+xlIjWZvYCE5Bv67PU5hRIo2ulTAMJ/8Azo6A17TKXd6Wpvq6mrqGT2mPNemm/T3
         Afl/zmDHNsHjBWTRCSC0C7MjR+fo2JyKgb9SG8y8oDYDa0YNUEQt0Sp8xJSIT4jJz63+
         8Khlw0kMKmCtka19DRKq/2Fld0194KQQk2MaRZfSYydEyiikr21CQvyG7gRaPnWirnHe
         PMYFs+xBe1mbUvhrYKI3VJvDQ9jUbRO6OXVjxgLk3GyBhpGyC2u5iqOFeKVswbjgpKer
         1r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7Um4mUV79LuOrqozwijQdh04ZeZMr8lNOl1Ry7Klkc=;
        b=wz17Xf6SNfLbVlwTrVn1A4Qxtsfs4u3bJJrlzTY6BVrUhwJap6tpq//Wu85fKK3abd
         RVGXT61qYySEMqKzFWIhhdc0zc0h/l/VcdsVSxVw0QcQhyKGKpg0i8L7EefRCszUWdQS
         By0q2BmZ/SrvvXa/l9p2/eI/eLNmi8n9l6javfml4kRG39a0ER/up12r0y1QyN8ALqDL
         al9izd4pWNWyrPn3JnJ/qM2dU4EYO6XUSkeFuG9UABXLm8ZuZzhuzdy9M1fuQkXYgYYV
         /YXdk0Kfg3t/UgbFFS11F+NDVPeUm03NslzGQRssGlQSrN0JQ03kk6GaIoRDzh1xJMpc
         SRkQ==
X-Gm-Message-State: AOAM530ClRRb4ygM0+f4xBPOEeselKWI8RRbXCtoj3u/K1QtWHa+uq+C
        LVQtxAUBMa8TyLMXYg5/F62xSPnkaUHRwWoT94s=
X-Google-Smtp-Source: ABdhPJzZRpzEZC58TA6BZt5J3AJla2LE886DnrZUGf+xPMtbZrcWc5+cvzmXAdYOLXVy5P3t9lPPq4NCKMpEhMPm0dk=
X-Received: by 2002:a50:da0a:: with SMTP id z10mr33926433edj.298.1635709190027;
 Sun, 31 Oct 2021 12:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211029114948.41841-1-david@ixit.cz> <20211029114948.41841-2-david@ixit.cz>
In-Reply-To: <20211029114948.41841-2-david@ixit.cz>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 31 Oct 2021 20:39:39 +0100
Message-ID: <CAFBinCBVXNYG62jKABhJJt0m61+vQKqEyC4Mk5Ljg7htN-brTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: make dts use gpio-fan matrix instead
 of array
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 5:51 PM David Heidelberg <david@ixit.cz> wrote:
>
> No functional changes.
>
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
for meson-gxm-khadas-vim2.dts:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
