Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CFE409D73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbhIMTwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbhIMTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:52:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:51:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x10-20020a056830408a00b004f26cead745so14961522ott.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=7y5Kp92MxlMIM/1uVfkHDfbY3sPUaGnffDNVZpUsrD8=;
        b=Zodc0o0JSl2wPuA2Y12NHWaoDY6QABXb137QrHTXqY11BK/0mIsSmDtqRM4Zm7UmRG
         NDS8f4Q5f7Sc3gTutg/hC+SubqhccAhKu6HsGcUna0XluSh0IyQOT9ytmBIL+CvFukJv
         wuSKCsLqUBP1ML9pxEFAKZPdUExJgd3OvfLFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=7y5Kp92MxlMIM/1uVfkHDfbY3sPUaGnffDNVZpUsrD8=;
        b=iGBlJed8iQPHFRIOqYxSZnXhakO7w7GUD1hl+ycCnY3XQiLv9hQ1luRy6jcTH/SGS9
         nnxP3GAWk0TERfcmXBPwLLfFN1mBDUrpu5Xf6636/wx8X5wv3u7+654oXXkMVOUth51E
         MuSIjxMml7fpEVKNlqqLqiyuCQAkil8AoBT7ynSdLGahR0QNwjEUXI2qFJF3AXkbbUwc
         8QvtX7cPgP6nFjf1KqhEtsMpGnbPR5Z9heum282x+4G4akFvofULxRtBSMft2jq0NIk4
         N6RYkCH2Zs6mORou7EmVjn95fVwiXVXaqBGxaCSIZpzEwNgyP8/KIU0LOM1sMDQMIFat
         vFgw==
X-Gm-Message-State: AOAM531k7R50ELHZbHs19lK/nl7GF+iU+YaVLBzbko40suc5mCXeePFK
        k3ttd8WKiNze2BAHuEPzhSf1dKZ+hJSzuRSH9dwONg==
X-Google-Smtp-Source: ABdhPJy8cOper52GzW4GbJAI4BPyVQYu27nMzrhL6XZsTO4p+Lv1yS1UiO9YJYTrQ5nwZM9IcOtzIoPX1a3xvmpfAnI=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr11189838ote.126.1631562679479;
 Mon, 13 Sep 2021 12:51:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Sep 2021 12:51:19 -0700
MIME-Version: 1.0
In-Reply-To: <1631539062-28577-2-git-send-email-srivasam@codeaurora.org>
References: <1631539062-28577-1-git-send-email-srivasam@codeaurora.org> <1631539062-28577-2-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 13 Sep 2021 12:51:19 -0700
Message-ID: <CAE-0n50=ABP+fs1U3JjiqMSKphfxFsZBqQQYwVH2o_iOE1Wu_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: google: dt-bindings: Add sc7280-herobrine
 machine bindings
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-09-13 06:17:41)
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> new file mode 100644
> index 0000000..e0d705f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/google,sc7280-herobrine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google SC7280-Herobrine ASoC sound card driver
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> +  - Judy Hsiao <judyhsiao@chromium.org>
> +
> +description:
> +  This binding describes the SC7280 sound card which uses LPASS for audio.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - google,sc7280-herobrine
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^dai-link@[0-9a-f]$":
> +    description:
> +      Each subnode represents a dai link. Subnodes of each dai links would be
> +      cpu/codec dais.
> +
> +    type: object
> +
> +    properties:
> +      link-name:
> +        description: Indicates dai-link name and PCM stream name.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
> +
> +      reg:
> +        maxItems: 1
> +        description: dai link address.
> +
> +      cpu:
> +        description: Holds subnode which indicates cpu dai.
> +        type: object
> +        properties:
> +          sound-dai: true

Shouldn't sound-dai be required?

> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        properties:
> +          sound-dai: true

Shouldn't sound-dai be required? I don't know but maybe also additional
properties is false for this node too?

> +
> +    required:
> +      - link-name
> +      - cpu
> +      - codec

Should 'reg' be required?

> +
> +    additionalProperties: false
