Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E963FEE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbhIBMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhIBMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:51:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185CC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:50:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1281493wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=a67C6dNL5nIJT92Nus3ptLY8+mQH3bjCFrhDFLwmJFM=;
        b=oSqbiZE3H987kD4hq6o9Ds4oDd3rs+cX4AFxRA6Ef6dJ8+NceyxkAikOSVSziB+BjE
         bunyHly9lgp52gmixcJFwTO+qIhQwz+mO5cB70pOD/wE/qSr4jQsEwviDcn29O3ZRbGm
         2smfKt0cLilFMBrhxz9oLoBT9Vf+T/W2Q75wTVKQbZbDjvCkdCKJnQH5Ys4+7AVVSNoY
         qkGXeuuHloTvVyfmtruFOxY7d7s1qx8iPFbYIitgZdO6la4enQhKVkcSHd+s6l8G4p+i
         5YliV3McHq4EwYehkeoh6Q/2sdAJtCyNfOSG/Wt95LvbeIXPPDy0piWpYHJGc3SRdTxv
         r1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=a67C6dNL5nIJT92Nus3ptLY8+mQH3bjCFrhDFLwmJFM=;
        b=TwunNOsXb+/I7gzpBzJ3JWWbraqTIrPPOlXPLJQ6HwMPHQG3QB+0fpkPS1d0tdjIQ+
         hAg1MBt0sQOgT8Ew4OuTI4QTuRbk3/YWrk7vF0+3vdu/xGJ4rUkw6at21uIVjYzjTMtY
         EnkTUlNlZAd9wZ723GGkBShZRUOfb57j16A8kCfy1yNPUcHpQWBIHSi23yzrwm/wgOu6
         HCDiCACz8b4KYa6YeXdheymxpKW9yV9km7WAxBItijHLbQJkiQn6qxRo+Hc370Ghmb4e
         XXxGs8PshvSgui16xiJUz/TfHJJSlyyCq5L/INlgZQ+FU40sYXW2M/lwq6pTvBUnF/B3
         N4gA==
X-Gm-Message-State: AOAM530sik6Z9atDj1HbZp2MEPNicBAdWNK9HefhaKi5D2IdoBkRcTP7
        toet9zMXB5dg3/L0BBEZvfJ/lw==
X-Google-Smtp-Source: ABdhPJzdZJ+Ta6IS5+ARF1e91+6ra1TrvOd1v2Bx44u/bXB4BQfewSiivQ+Jp8r2eWIdUAEwOPPJMg==
X-Received: by 2002:a1c:98d8:: with SMTP id a207mr2918351wme.16.1630587022216;
        Thu, 02 Sep 2021 05:50:22 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1728988wrr.91.2021.09.02.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:50:21 -0700 (PDT)
References: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
 <1630562033-13231-2-git-send-email-spujar@nvidia.com>
User-agent: mu4e 1.6.5; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, stephan@gerhold.net,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: Add json-schema documentation for
 sound-name-prefix
Date:   Thu, 02 Sep 2021 14:47:27 +0200
In-reply-to: <1630562033-13231-2-git-send-email-spujar@nvidia.com>
Message-ID: <1jpmtr5egi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 02 Sep 2021 at 11:23, Sameer Pujar <spujar@nvidia.com> wrote:

> The 'sound-name-prefix' is used to prepend suitable strings to a
> component widgets or controls. This is helpful when there are
> multiple instances of the same component. Add relevant json-schema
> and is inspired from sound-name-prefix.txt documentation.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/sound/name-prefix.yaml     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/name-prefix.yaml b/Documentation/devicetree/bindings/sound/name-prefix.yaml
> new file mode 100644
> index 00000000..b58cc9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/name-prefix.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/name-prefix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Component sound name prefix
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>

Since this file is referenced using "AllOf", am I going to be listed as
maintainer of all the drivers using the property below ? I'm not sure I
want that ... :P

Maybe it would be better to drop the above ?

> +
> +properties:
> +  sound-name-prefix:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Card implementing the routing property define the connection between
> +      audio components as list of string pair. Component using the same
> +      sink/source names may use this property to prepend the name of their
> +      sinks/sources with the provided string.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    analog-amplifier@0 {
> +        compatible = "simple-audio-amplifier";
> +        sound-name-prefix = "FRONT";
> +    };
> +
> +    analog-amplifier@1 {
> +        compatible = "simple-audio-amplifier";
> +        sound-name-prefix = "BACK";
> +    };
> +
> +...

