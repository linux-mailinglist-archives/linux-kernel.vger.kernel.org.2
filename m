Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13D14508C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhKOPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhKOPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:43:30 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F50C06120B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:40:30 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 14so21827317ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xA9lBq8mLtVYoVShn/lV6rQBtv+0+irQSNd2bGYl8wM=;
        b=cr5KrewBV50z6KbWdhDOgYEcn9amYBRGAJzIYoYdQ138g5EXEd8Wj7I0r0vFeC+UI5
         7dTdwxMMhLmwg2QiOPiTawZE2+y2a5HAI9T3CqXDDXMi+MqqC8neiuKFkwm+rokbCfhQ
         JUYEwpKRXn2eC1bJ4g/b8inWBe02RB3wjefRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA9lBq8mLtVYoVShn/lV6rQBtv+0+irQSNd2bGYl8wM=;
        b=vAhJbiuHJykO0KICRA4E/fmFpGgy0BlfQaNTVWeWJI9yg2Aum+ri5bcEVy5UrEbGJe
         Ku6ZkW1CbleNkz3L6fIuo0gr6hBoZNKDDIFFksuWTWCA1LyU3uiIuuyAsC0m6Fnuod/6
         OWnhII8gGdP9Nxy3pDIroBSONJOo8GWwjmvsl+c+4zvnZwnTigMFU5mE05FNTao+92Mf
         dYundgZekusPSTHnljrOfqeCi42XEfzkabK7dgqWqku3pqXsZNVsse2i0hLfdEkp9Rrf
         evvip3V9yKp3TVJLkt7T1s0orfUXvQzorgRk9G6ARVs4iJWWR/rXGEuy3O7NMAICoNFg
         nRbg==
X-Gm-Message-State: AOAM532DF0E8sMq6SzemPQTEc75jabnRiYJYJfj+cfWbAF+1YEAZ/zr9
        FrrOAdBwS8AzRcKA739GzorvT7jSrzlVIw==
X-Google-Smtp-Source: ABdhPJxOs3iW0JGRXwY/PPYArDyqAYK2hO6z4lARH2lOZa/nBe8ywaoGa9lkfLyT1NFX/WGDn4/9qQ==
X-Received: by 2002:a05:6602:2cd4:: with SMTP id j20mr14388646iow.106.1636990829624;
        Mon, 15 Nov 2021 07:40:29 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id j15sm10377838ile.65.2021.11.15.07.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 07:40:29 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id 14so21827065ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:40:28 -0800 (PST)
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr26347505iow.168.1636990827374;
 Mon, 15 Nov 2021 07:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20211115030155.9395-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20211115030155.9395-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Nov 2021 07:40:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XkYKsQUkZxV2hpvTfq2u4n7Cf_Mk3WaSx5COJvsjG-sw@mail.gmail.com>
Message-ID: <CAD=FV=XkYKsQUkZxV2hpvTfq2u4n7Cf_Mk3WaSx5COJvsjG-sw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7180: Fix ps8640 power sequence for
 Homestar rev4
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     philipchen@chromium.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 14, 2021 at 7:02 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> When powering up the ps8640, we need to deassert PD right
> after we turn on the vdd33 regulator. Unfortunately, the vdd33
> regulator takes some time (~4ms) to turn on. Add in the delay
> for the vdd33 regulator so that when the driver deasserts PD
> that the regulator has had time to ramp.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
> index fb27106bbb4a..0de0c97f5728 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
> @@ -15,3 +15,7 @@ / {
>         model = "Google Homestar (rev4+)";
>         compatible = "google,homestar", "qcom,sc7180";
>  };
> +
> +&pp3300_brij_ps8640 {
> +       regulator-enable-ramp-delay = <4000>;
> +};

It should have been pointed out somewhere in the post, but this patch
depends on Philip's most recent, which is:

https://lore.kernel.org/r/20211029152647.v3.4.If7aaa8e36f1269acae5488035bd62ce543756bf8@changeid/

This seems fine to me. Apparently this 4ms delay isn't needed
lazor-rev9 (at least they were happy with the signals on that board)
which is why this is a homestar change. That can make sense since the
components on the two boards may be different.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
