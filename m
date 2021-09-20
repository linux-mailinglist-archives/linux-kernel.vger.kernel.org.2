Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5783412B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbhIUCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbhIUCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:04:56 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84300C143A49
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:17:22 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id l17-20020a4ae391000000b00294ad0b1f52so6149761oov.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JjZwsjLoE1v3IYa2GVHYD3KilZhhQVThWYCXDu9nvYo=;
        b=a63x+bgfAIdvw+z6zqMvEu6JrCNqun+9IqImsNVfxFsirapOdMZ+eBj0e2g1IRZA8g
         AhQnWYI3S1LMtRTf3cyc5VHr2OowcGQUtv7/UympQw8t+7yyJIH+q8S1hc4KHM47rWK6
         ICe0PLjGSWwqVqs4PwDznSR8RBSF3gFpTPQfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JjZwsjLoE1v3IYa2GVHYD3KilZhhQVThWYCXDu9nvYo=;
        b=NqLxd89C3KkuqDGspG7HMuQjVdjB++hmJ/qnurwlBK54U+Q58pVECDi/E72DJnRQfW
         scgoMVyquVLwGxabZ/CTijT4VmNGcyQXWIPftc4ncg53REZAaU/FHwV6fvSbQvO3NCIe
         afmQ9Q4TOA2b9z4FEuJyLdYj7xqSSeRdAp3JIBm7MgSQZ8z7/BrfSF86VzIIiXzwhSVH
         CmIx2DKjylY384M+MGzN7TqUfeLpKOHsiS6xYMTNusbhwfsI2OMuSpzkpse7z6hgzKPP
         kRNHs5n5UNAb/L4PDMzfNsbKsiDj9GwbrA1PNZauyfgdbYlePhACkj6P1mZdKfNpurQd
         bTdw==
X-Gm-Message-State: AOAM533kQvfGJKh9r5KVLDMf7D55gL9BgyhiWKvUGyn/BRW3TB2f21oA
        /ESC24kyp0A//VmxT98w0i7DYkX29RuO7SDJqxMY8g==
X-Google-Smtp-Source: ABdhPJwVjR/WftKlNJXp2AGVuRgbTEYRYkgthir6kT3bKkja1m6mMkzqMgaNf1nOTAkyliApojmA+4e7jQQ/i3tbxgo=
X-Received: by 2002:a4a:c3c2:: with SMTP id e2mr7886842ooq.8.1632161840976;
 Mon, 20 Sep 2021 11:17:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 11:17:20 -0700
MIME-Version: 1.0
In-Reply-To: <1632123331-2425-2-git-send-email-srivasam@codeaurora.org>
References: <1632123331-2425-1-git-send-email-srivasam@codeaurora.org> <1632123331-2425-2-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 11:17:20 -0700
Message-ID: <CAE-0n51L7YSA4FDLv_2Q9U3nzxK1YY8hRtZ-G0cs42nomySMTA@mail.gmail.com>
Subject: Re: [PATCH 1/7] ASoC: qcom: Add compatible names in va,wsa,rx,tx
 codec drivers for sc7280
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

Quoting Srinivasa Rao Mandadapu (2021-09-20 00:35:25)
> Add compatible names for sc7280 based targets in digital codec drivers
> va,wsa,rx and tx.
>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c  | 1 +
>  sound/soc/codecs/lpass-tx-macro.c  | 1 +
>  sound/soc/codecs/lpass-va-macro.c  | 1 +
>  sound/soc/codecs/lpass-wsa-macro.c | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 196b068..520c760 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -3578,6 +3578,7 @@ static int rx_macro_remove(struct platform_device *pdev)
>
>  static const struct of_device_id rx_macro_dt_match[] = {
>         { .compatible = "qcom,sm8250-lpass-rx-macro" },
> +       { .compatible = "qcom,sc7280-lpass-rx-macro" },

Please sort alphabetically on compatible string.

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
