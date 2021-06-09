Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9663A1DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFITdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFITdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:33:46 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC3C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 12:31:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so1175775otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=/5hRR3JhxA61/7kGbJ52XF4Id3fG9uBeIzCvCACHPQw=;
        b=MMFEzs5U6IDNKqGfwXrix6STIsbRevLZaidgF9ycrqSfLwnZd2nH5WPjEDTby0ZOMT
         8mSMBVUXuPyJIo4vUqhf5ZC9cfz4dg6jelk7kAgdMPS1kHmslrmOtoqpiLM/7/f0b9tk
         3nPQf+T5651vsSqqm8Tz1nlX7vFJ6ukPeraZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=/5hRR3JhxA61/7kGbJ52XF4Id3fG9uBeIzCvCACHPQw=;
        b=R08Pbu0w/Ddo7q7C6ReHUf0aW5QECfWJjz4wWa+fg+ntoniuMMHTbgJjZ2PHlAcOsM
         6E4R6PHJT3jRym24fpcpj9idOG7tfuGOqfWjPMQrG9ur9qx76j1YBpcH+3reDhe5iTZv
         YqlQOl4kncACASWJW58m9rvNcuMR4lSsN8vBJdxZoLAfw2qAAvradPHXdtUT3C8+bGRO
         MV4lyGvisz6dWXr2jn+shYlEbmXq8mkzW1OsavZI/or8lDPgCXHYyxCZozUgVBOHjGat
         Jips8V3l/562FjshE5wpl0wBLxg+XloMi+GfqgoEo6ZFZkfJ/b3XI+JkiID2AiBk5BXR
         Dlzg==
X-Gm-Message-State: AOAM530sPVHrmPHNzEX/n3yfzgGE7FEGkw6TsgHmMfDf52lTZ0aPULXT
        kjvvWt3uMghZy3m0VBT/7CYX1wetMQUxs/NcgUeaOw==
X-Google-Smtp-Source: ABdhPJwbGOmwALrdCY6bSX1H2qs6NY1fPr3SD/WDtOxCLEy4O9BT2CZIneFt6DfO7TE5QTj4TK4ORmu+XZn+RYoNM64=
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr865886ota.34.1623267094752;
 Wed, 09 Jun 2021 12:31:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Jun 2021 12:31:33 -0700
MIME-Version: 1.0
In-Reply-To: <20210609133039.4648-1-srivasam@codeaurora.org>
References: <20210609133039.4648-1-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 9 Jun 2021 12:31:33 -0700
Message-ID: <CAE-0n53Jy_kRK-6L4bZMZ2EAv2n3b9PX2GZSaUodZtU8P7P=6Q@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: qcom: Add four speaker support on MI2S secondary
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

Quoting Srinivasa Rao Mandadapu (2021-06-09 06:30:39)
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index c62d2612e8f5..aff39c9f6326 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -29,6 +29,15 @@
>  #define LPASS_CPU_I2S_SD0_1_2_MASK     GENMASK(2, 0)
>  #define LPASS_CPU_I2S_SD0_1_2_3_MASK   GENMASK(3, 0)
>
> +/*
> + * Channel maps for Quad channel playbacks on MI2S Secondary
> + */
> +static struct snd_pcm_chmap_elem lpass_quad_chmaps[] = {

Can this be const?

> +               { .channels = 4,
> +                 .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_RL,
> +                               SNDRV_CHMAP_FR, SNDRV_CHMAP_RR } },
> +               { }
> +};
>  static int lpass_cpu_init_i2sctl_bitfields(struct device *dev,
>                         struct lpaif_i2sctl *i2sctl, struct regmap *map)
>  {
