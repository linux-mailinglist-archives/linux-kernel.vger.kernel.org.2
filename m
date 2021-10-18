Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9194315E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJRKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhJRKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:23:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF5CC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:21:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso9829145wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=7GC/r7oF7FaZ4vYYtjlckZsfjl97Nd102niiiNEyke0=;
        b=OghATFW5VHSslzpfS5gkkA3/wlUiyyp1eis6npEz+q00Ysaim+UMA3aq/59CpBm3sw
         xsgz5lLt1yZ90HXx0+Zb99O7Dj6PQlMsZYE7CuH0bJAL8QmybrshSuijhh9Vnzl9izgC
         xioP+eojPe9F21OJuHl8mpZfK19IRHt0psbKuq8q38MZOGSfEnwIp0/d0duLLLhWFrjC
         XlhQZwF1kEsxPUuFiEtQIa6aLHq0fc8mnMtBBwFPqL6Bh0YUrIiPT2VeL9tgAVz8Aqg6
         nE/phqoMR4WvNkv+U7wd4GP3cEApRXz3D4JcS5QYxcy+pSqUXvBEI20CCcuSkwMo/9ed
         GYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=7GC/r7oF7FaZ4vYYtjlckZsfjl97Nd102niiiNEyke0=;
        b=Uaf0o+VwZrkZiucggLSJgrlSz1G9fCnlDF1lr+GseJg8obY+QxFJyetFa7XeAruguj
         IZcuqHvgrIVjIosLeHm5H0Q2C2mS+VvLcwtW38fQ3vaFHatdiseWHS+PUbQqfog+bSwt
         IpNkuK8J4UUha5kX4Xa/bbxRGWjHu7UtECvwkFeOh/OAppnkrqhv3m2BgOv+zrF5bFkd
         6OkfLSkFYhYWZr9yj4tTNh2m0pSUsSivT5Gbn/YrqX6+Lh8jTzl11LbG7e3cIgmx5zR8
         4QmNZkHsTDkHNBsY+yMfh8OmaEzeZSNbdF5MWp3TWmqMJ2MQPCk65FaIB9sdAiu/IgcA
         mkdg==
X-Gm-Message-State: AOAM531oG+sHrZrasrU4p202gNfcEoQXzHkTvArEL0qSBqNAZYrlIQW7
        I3eFJbu3uwPhVb299dd13Q8P7A==
X-Google-Smtp-Source: ABdhPJxggso4popQo8nuVeqxw6FVBixaoIjtOeSS511+JxQ97xNYgGJ/yoNLOwTLoxJL3J3keWTBZg==
X-Received: by 2002:a1c:4d06:: with SMTP id o6mr42793789wmh.137.1634552468356;
        Mon, 18 Oct 2021 03:21:08 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m15sm12311398wmq.0.2021.10.18.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:21:08 -0700 (PDT)
References: <20211017160028.23318-1-christianshewitt@gmail.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: meson: implement driver_name for snd_soc_card in
 meson-card-utils
Date:   Mon, 18 Oct 2021 12:20:03 +0200
In-reply-to: <20211017160028.23318-1-christianshewitt@gmail.com>
Message-ID: <1j1r4ivdkc.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 17 Oct 2021 at 16:00, Christian Hewitt <christianshewitt@gmail.com> wrote:

> Implement driver_name to provide an alternative to card_name for userspace
> configuration of Amlogic audio cards.
>
> Suggested-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> The meson AIU/AXG drivers currently require alsa confs based on the board
> model name which is unique to each board. This is very flexible for audio
> use-cases, but not very maintainable for distros with a single use-case
> that need to support a large number of different Amlogic boards. Using a
> driver name to match the card conf instead of card/model name reduces the
> number of confs needed in the LibreELEC (Kodi) distro from 41 to 2.
>
>  sound/soc/meson/meson-card-utils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
> index 415cc0046e4b..29b0174f4b5c 100644
> --- a/sound/soc/meson/meson-card-utils.c
> +++ b/sound/soc/meson/meson-card-utils.c
> @@ -302,6 +302,7 @@ int meson_card_probe(struct platform_device *pdev)
>  
>  	priv->card.owner = THIS_MODULE;
>  	priv->card.dev = dev;
> +	priv->card.driver_name = dev->driver->name;
>  	priv->match_data = data;

I was preparing something similar to help with alsa-ucm so

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

>  
>  	ret = snd_soc_of_parse_card_name(&priv->card, "model");

