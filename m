Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390BF425A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbhJGSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbhJGSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:01:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43898C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:59:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so8583260otb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=R7oz/IASrAb/4S/A1hee4Ri/gQz0oKdB3ob6dMUeA4I=;
        b=JvGo9D9xRiy8w/STgotFKvcJot6b4pk0BA8Kl5UxeFRlGy7KLQTPBd9FMo2O8BkKmI
         YkjaEgVWvN6bFfcd9vjw5/fZfb3GH2zaXJVZ2GlrBILlTcAV2eJlZJpqbosYgNqQAsoR
         9LiTE2MTlB2FBiwHuPUVl9VEPQk9DV03+XJzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=R7oz/IASrAb/4S/A1hee4Ri/gQz0oKdB3ob6dMUeA4I=;
        b=JELr2AUTFOINQBfSZ7E2byRvrq86bugVi8XtiMlTkXL2bzGYewlYO/V8Zvx/B7mIUt
         zL6N5AAXij+BXMLzYw+wxEH83PRHqNYbunQGQ4yTTM2E7mcV0KSq4S5oAYMUqIPrv538
         xVJiLwzsFXGlY58PTEUxOOMNqqCmJVzNkQ/Ewtd/jBLREJ6z5KCzhwZFEBYoVZYj6Iym
         vhFog3jvrDmACu1P1EvRnpykr1WMJ77gD+jbifeN2+cNZwfJqRPeuYJRcFmiBYInMPj/
         eMOYEWb914FyySFYCsXhT9rA2Jq/DvRGapD92d/txhL5u/vk2P+YhcnhboVGtxY9uRWv
         HvVg==
X-Gm-Message-State: AOAM5316lZ5l4qAwlBHF1Pdpc8ngOLkDLW9+ZGdkorcUdmfOg3pv1uZg
        Lg8aATegHC7thM6TZsLILbtfRTRP7ExD/Ca2WUoQqA==
X-Google-Smtp-Source: ABdhPJyShabx+Bv1Ts3hPeR1WVsMR/XNDLbLDJ40g/qGwpZoSFC/DiaaGOf5FZHOhggTg5HxhlGAhw7oD3ncFoWjMX0=
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr4647448ote.159.1633629593547;
 Thu, 07 Oct 2021 10:59:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 13:59:53 -0400
MIME-Version: 1.0
In-Reply-To: <1633614519-26680-3-git-send-email-srivasam@codeaurora.org>
References: <1633614519-26680-1-git-send-email-srivasam@codeaurora.org> <1633614519-26680-3-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 13:59:53 -0400
Message-ID: <CAE-0n51qO1q5ZF-fAf2Gma9a2B+iSyoQnJdJ8Fnmsz+DG0rwPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi
 pinctrl compatible
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-10-07 06:48:38)
> Add device tree binding compatible name for Qualcomm SC7280 LPASS LPI pinctrl driver.
>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> index e47ebf9..578b283 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> @@ -16,7 +16,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: qcom,sm8250-lpass-lpi-pinctrl
> +    enum:
> +      - qcom,sc7280-lpass-lpi-pinctrl
> +      - qcom,sm8250-lpass-lpi-pinctrl

I suspect we need to split the binding because the function list needs
to change. Can you make a whole new file that's probably largely a copy
of this file and/or extract the common bits into a meta schema and
include that in both the files? Then the function list can be different
and the clock property can be omitted in the sc7280 file.
