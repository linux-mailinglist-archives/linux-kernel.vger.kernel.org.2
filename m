Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712843E8933
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhHKEYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHKEYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:24:46 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D3C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:24:22 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bi32so2755431oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4+a6akEpZU2Rl1zSGbSNGtRGCQXtOnzuxporXN9r8kw=;
        b=jxMCTvQXPanclZeeolIVPBZrNb2967Z1Vp2PMXijVJmWvLi/cbZqfziutKJ4IyjCrJ
         nO2uQc0OKlVaO9WhXLQe3GJsSpfEOrev5/i/FeojQKagbej9L6LA1JPam9PX75WCLWcA
         SbbfYEJY5aHpmmLGnMIUfVO+m5ApnGwCwp5dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4+a6akEpZU2Rl1zSGbSNGtRGCQXtOnzuxporXN9r8kw=;
        b=mbY1L7IpO2NwuVLGuy8TG5PqYS+x1xdHrcVVpF7NT+/FyVp1JzEwK5xomDzz1qWSzr
         skXRGc78rKZ61DM0f/l3jUiFPR8XVS1/bOddKmBTbaH0NjcbXdrxVVc5WklXG/ZmryPH
         9/hgZFmLg8EJ0KSiEeJQ6PJ18Ao0HQM897ykhzOdM39EeUMRj1zJ20ppTyAKY1ZX4gbJ
         bnUr+WO2sa7DinJamE5+Ayd74A1hfqfZSYLUT4yOrAvygEyF4dUc1slFXQBia54HHLo8
         vpArmSP66xUHRHvgVeWomjDBzUCVNR43ro4ckB0tMTBBpT4fqDEHxo3Dxl8LxTJFpfE3
         XPIg==
X-Gm-Message-State: AOAM533UwaeLNVHhNJeqSZHX1lYvNPUaLuoAw9kIZAkNg/cH3RZISHtC
        mT4dSOaK+VhkYZqbu7lRsyf8TuvKAqTQsYsB26S2/g==
X-Google-Smtp-Source: ABdhPJxhuBLsVb23ZNxG/JRW3v8sQ+/Xa1+LNCkfc0G3wJkAgaq2+FaAG51xDk5Ag9SJd5Qlf9jHNaCGwd6V1n67aQc=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr8782072oiu.19.1628655862338;
 Tue, 10 Aug 2021 21:24:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 21:24:21 -0700
MIME-Version: 1.0
In-Reply-To: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 21:24:21 -0700
Message-ID: <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-08-10 16:59:15)
> When I booted up on a board that had a slightly different codec
> stuffed on it, I got this message at bootup:
>
>   rt5682 9-001a: Device with ID register 6749 is not rt5682
>
> That's normal/expected, but what wasn't normal was the splat that I
> got after:
>
>   WARNING: CPU: 7 PID: 176 at drivers/regulator/core.c:2151 _regulator_put+0x150/0x158
>   pc : _regulator_put+0x150/0x158
>   ...
>   Call trace:
>    _regulator_put+0x150/0x158
>    regulator_bulk_free+0x48/0x70
>    devm_regulator_bulk_release+0x20/0x2c
>    release_nodes+0x1cc/0x244
>    devres_release_all+0x44/0x60
>    really_probe+0x17c/0x378
>    ...
>
> This is because the error paths don't turn off the regulator. Let's
> fix that.
>
> Fixes: 0ddce71c21f0 ("ASoC: rt5682: add rt5682 codec driver")
> Fixes: 87b42abae99d ("ASoC: rt5682: Implement remove callback")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>
>  sound/soc/codecs/rt5682-i2c.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
> index 4a56a52adab5..1cc07812b5ac 100644
> --- a/sound/soc/codecs/rt5682-i2c.c
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -117,6 +117,13 @@ static struct snd_soc_dai_driver rt5682_dai[] = {
>         },
>  };
>
> +static void rt5682_i2c_disable_regulators(void *data)
> +{
> +       struct rt5682_priv *rt5682 = data;
> +
> +       regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
> +}
> +
>  static int rt5682_i2c_probe(struct i2c_client *i2c,
>                 const struct i2c_device_id *id)
>  {
> @@ -156,6 +163,10 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
>                 dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
>                 return ret;
>         }

Nit: Add newline here.

> +       ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
> +                                      rt5682);
> +       if (ret)
> +               return ret;
>
>         ret = regulator_bulk_enable(ARRAY_SIZE(rt5682->supplies),
>                                     rt5682->supplies);
> @@ -285,7 +296,6 @@ static int rt5682_i2c_remove(struct i2c_client *client)
>         struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
>
>         rt5682_i2c_shutdown(client);
> -       regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
>
>         return 0;
>  }
