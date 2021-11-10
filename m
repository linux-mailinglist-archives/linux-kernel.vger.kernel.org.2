Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9731F44C8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhKJTW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhKJTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:22:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C15C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:20:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t30so5789778wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wel6pilwDQh+J/gem87j8LshxcVMW1VIsxazNd0cXWs=;
        b=So5x8dQurXJxS+4trJo2fR9qGGZzfIMwFqojWWVX4YGqFIz5vDQL/7cox9Nqzd2nmS
         FVWIY4+YbywlogWvmfninC1MUo/9j/umJKn/PHMGRzWtQbVwi5qLTvuoonEmE661kobY
         WC3OT/2fleolmG6zTD5BCV+UuI5FeTUKSSFsuZcOUW0sV8u26fOF72+MME/1Qg/ZEms+
         Tg91MWcZy1D3kRtMrjbQnqeKiGU8KIqdBfEijRLGcKkm2qq4DmqzD7uACTmvUWjuIZ8o
         L/rNJwLTq/UJtZKhkDdIahIfY25TwAuI2yL81Qirsh9YqHBh/Dycy9+CDSghk5oFVU9q
         Jcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wel6pilwDQh+J/gem87j8LshxcVMW1VIsxazNd0cXWs=;
        b=NkYnxvDF7QnJk2hhY5SxSyfbsyocNzI/9UzMsWwkp4A/wu+llCw5D6sWlkZf8fAq1I
         2IDyEd5GWnBC3xpYsuDMEVPFvLEAbz89pRNP5QZqZVPMi3JQIAsuu9Y+O2ZPl2eIuTv2
         z5ZXDT/chXW1eBmnBkCJOh6rTTvY965RFtczqlVnbTVdozv09vFsf+EiQyAUOv8aklAI
         Ol+TKgeshCdNnyXMU52NbCkAM9SU8HGbudUg2s/hvTUCuPbje6dfjNwXqdZhxq2RgcnX
         DoIHdoT4tUQ2aHcdGdBwWDRm9huTWXu3V8J6yxkBBIJ8vfwArNmoD8QcHVSz22fIIsbn
         Ezmw==
X-Gm-Message-State: AOAM530e4uB4NX7YtmeY8dK3lNG9NFSdWPN8yI5FaYv7RvCwHBAS35gr
        4Je1i4nzuW0eR6EAKJ+pRsE=
X-Google-Smtp-Source: ABdhPJzhllPLHbIxmy8REeDtsaHpQplCe9EN39q7wcVyZtop6YVZsvXBwXpfo98cNzaYFpG1nGjA+A==
X-Received: by 2002:adf:d091:: with SMTP id y17mr1698240wrh.418.1636572008022;
        Wed, 10 Nov 2021 11:20:08 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id z6sm867158wmp.1.2021.11.10.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:20:07 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, jonas@kwiboo.se,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: handle ELD when DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date:   Wed, 10 Nov 2021 20:20:06 +0100
Message-ID: <5763693.lOV4Wx5bFT@kista>
In-Reply-To: <20211029135947.3022875-1-narmstrong@baylibre.com>
References: <20211029135947.3022875-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

sorry for late response.

Dne petek, 29. oktober 2021 ob 15:59:47 CET je Neil Armstrong napisal(a):
> The current ELD handling takes the internal connector ELD buffer and
> shares it to the I2S and AHB sub-driver.
> 
> But with DRM_BRIDGE_ATTACH_NO_CONNECTOR, the connector is created
> elsewhere (not not), and an eventual connector is known only

^ typo, 2x "not"

Other than that, it looks good.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> if the bridge chain up to a connector is enabled.
> 
> The current dw-hdmi code gets the current connector from
> atomic_enable() so use the already stored connector pointer and
> replace the buffer pointer with a callback returning the current
> connector ELD buffer.
> 
> Since a connector is not always available, either pass an empty
> ELD to the alsa HDMI driver or don't call snd_pcm_hw_constraint_eld()
> in AHB driver.
> 
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 10 +++++++---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  4 ++--
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c |  9 ++++++++-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           | 12 ++++++++++--
>  4 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/
gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> index d0db1acf11d7..7d2ed0ed2fe2 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> @@ -320,13 +320,17 @@ static int dw_hdmi_open(struct snd_pcm_substream 
*substream)
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct snd_dw_hdmi *dw = substream->private_data;
>  	void __iomem *base = dw->data.base;
> +	u8 *eld;
>  	int ret;
>  
>  	runtime->hw = dw_hdmi_hw;
>  
> -	ret = snd_pcm_hw_constraint_eld(runtime, dw->data.eld);
> -	if (ret < 0)
> -		return ret;
> +	eld = dw->data.get_eld(dw->data.hdmi);
> +	if (eld) {
> +		ret = snd_pcm_hw_constraint_eld(runtime, eld);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = snd_pcm_limit_hw_rates(runtime);
>  	if (ret < 0)
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/
drm/bridge/synopsys/dw-hdmi-audio.h
> index cb07dc0da5a7..f72d27208ebe 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> @@ -9,15 +9,15 @@ struct dw_hdmi_audio_data {
>  	void __iomem *base;
>  	int irq;
>  	struct dw_hdmi *hdmi;
> -	u8 *eld;
> +	u8 *(*get_eld)(struct dw_hdmi *hdmi);
>  };
>  
>  struct dw_hdmi_i2s_audio_data {
>  	struct dw_hdmi *hdmi;
> -	u8 *eld;
>  
>  	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
>  	u8 (*read)(struct dw_hdmi *hdmi, int offset);
> +	u8 *(*get_eld)(struct dw_hdmi *hdmi);
>  };
>  
>  #endif
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/
gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index feb04f127b55..f50b47ac11a8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -135,8 +135,15 @@ static int dw_hdmi_i2s_get_eld(struct device *dev, void 
*data, uint8_t *buf,
>  			       size_t len)
>  {
>  	struct dw_hdmi_i2s_audio_data *audio = data;
> +	u8 *eld;
> +
> +	eld = audio->get_eld(audio->hdmi);
> +	if (eld)
> +		memcpy(buf, eld, min_t(size_t, MAX_ELD_BYTES, len));
> +	else
> +		/* Pass en empty ELD if connector not available */
> +		memset(buf, 0, len);
>  
> -	memcpy(buf, audio->eld, min_t(size_t, MAX_ELD_BYTES, len));
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/
bridge/synopsys/dw-hdmi.c
> index 62ae63565d3a..54d8fdad395f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -757,6 +757,14 @@ static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, 
bool enable)
>  	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  }
>  
> +static u8 *hdmi_audio_get_eld(struct dw_hdmi *hdmi)
> +{
> +	if (!hdmi->curr_conn)
> +		return NULL;
> +
> +	return hdmi->curr_conn->eld;
> +}
> +
>  static void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
>  {
>  	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> @@ -3432,7 +3440,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device 
*pdev,
>  		audio.base = hdmi->regs;
>  		audio.irq = irq;
>  		audio.hdmi = hdmi;
> -		audio.eld = hdmi->connector.eld;
> +		audio.get_eld = hdmi_audio_get_eld;
>  		hdmi->enable_audio = dw_hdmi_ahb_audio_enable;
>  		hdmi->disable_audio = dw_hdmi_ahb_audio_disable;
>  
> @@ -3445,7 +3453,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device 
*pdev,
>  		struct dw_hdmi_i2s_audio_data audio;
>  
>  		audio.hdmi	= hdmi;
> -		audio.eld	= hdmi->connector.eld;
> +		audio.get_eld	= hdmi_audio_get_eld;
>  		audio.write	= hdmi_writeb;
>  		audio.read	= hdmi_readb;
>  		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
> -- 
> 2.25.1
> 
> 


