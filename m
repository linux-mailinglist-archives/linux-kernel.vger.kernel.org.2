Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70994202BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhJCQgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhJCQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 12:36:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F854C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 09:34:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s21so25777130wra.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=AfcjZljpnyi3x3inUnv1hf4IgNO1UtATkc18L3EpJlA=;
        b=ZquaEFNQQG+cc6p2QntDlwSZZ2TVIFbSQfAy4SKNNPT3whjpR1sAQoSozsJT1/kpKk
         I/cIcC8trxXuEg4ZeM5AhrwIf2NLSPOGhRfTI/DJdBPL6Nchev0dGnQ9OvgqWmEjEEyT
         gteCetHJowRpJaX6Bd+xJv6c5UlC9zuljd3Hp7jBtJKovnoC5OiFdrd8DX0BpSBdOP2A
         21Ousy+rgBkf7EBKxztczs/owRHGApd2+xEIoPGN54LHA+gq4i+H6FjMfaLKIMqCK5rM
         zxjz1RH4+7GyocDb5OA388Z0T0dhnQ7s6lald6mdWOYmmS6h5N9Z+LvNRbo+GK5mxTT1
         IGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=AfcjZljpnyi3x3inUnv1hf4IgNO1UtATkc18L3EpJlA=;
        b=V51MBGUSSqzrPjQvW+keDnYx64+HM7iSSEpwd0uvRHVEK2y27pPkdlGZmKJbqIOewO
         k0VrE+BVRFhTbKPhe69g8k+1qxV6doSktMoqSkHohQj33/G7AREP7Nbg6zxx24KhcCeL
         vxv1RPUKX7WYIVLmbh/o0jnfb0EMkc5L/2izk3xXJV1E9EMARrEaWJXT85lwD5yzddzr
         FggrdjdwqdJZvnFU94TZoOL7Yr8Md7whOUze3M5OAZflElmK6DIvip7TooM4eb0Kn5/8
         WvpGs9r8nU9VyOQdZtPE+o8piJ7Cct3eQ7W7+x2n/qCy51R315boObifQciS2VFHPQsV
         FUBw==
X-Gm-Message-State: AOAM531QbWy87TTMMqMEIyOS1ra4wHTgWgx9LExplXxj7yIc+80h8RuP
        49bI8DjJh2+X9hfCfZpw+zFrLA==
X-Google-Smtp-Source: ABdhPJxDks6Yk+yh8WWF/R0E0aUU/uhv3pPrPdejRwi6v3WACZsH0mug7PHzZQbWOFqIdv6TAvuPYQ==
X-Received: by 2002:adf:97d4:: with SMTP id t20mr3262138wrb.174.1633278868815;
        Sun, 03 Oct 2021 09:34:28 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o12sm12084828wms.15.2021.10.03.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:34:28 -0700 (PDT)
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control
 questions and issues
Date:   Sun, 03 Oct 2021 17:57:34 +0200
In-reply-to: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
Message-ID: <1j35pivzho.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 03 Oct 2021 at 01:43, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hello Jerome et al.,
>
> on Amlogic Meson SoCs which use the AIU audio controller we have the
> so-called "machine gun noise" (MGN) issue, reproducible for example in
> Kodi. So far nobody was able to identify the cause of this issue. My
> idea was to at least narrow down the issue so we can categorize it. For
> that I wanted to get the SPDIF output from AIU to the HDMI controller
> working.

Ok, I'll clarify (again) about this issue.

This issue is on AIU only (not the AXG series), on the i2s encoder
regardless of the output (HDMI, internal and external codec)

This encoder support either 2ch or 8ch mode, nothing else.
As long as only 2ch was supported, there was no problem.
In order to switch between 2ch and 8ch mode.  AIU_RST_SOFT_I2S_FAST and
AIU_I2S_SYNC shall be "poked" (check iu-fifo-i2s.c and
aiu-encoder-i2c.c). Without this, the switch is not done.

What these do, how and when it should be done is unclear. I tried
several combination. At the time I found something stable-ish but it was
not perfect.

At the time, It was completely new driver. Even if was not rock solid,
it was still progress and I opted to upstream it with an imperfect 8ch
support so people could help debug it. This was mentioned in the
original submission.

The other solution is to restrict to 2ch mode and remove
AIU_RST_SOFT_I2S_FAST and AIU_I2S_SYNC pokes. There will be no noise
anymore.

>
> On Amlogic Meson GXBB/GXL/GXM SoCs a DesignWare HDMI TX controller is
> used. This has an SPDIF input but there's currently not driver for it.
> On Meson8/8b/8m2 SoCs I am working on a HDMI driver for the TransSwitch
> HDMI controller which - just like DesignWare HDMI TX - supports SPDIF
> and I2S inputs.
> I decided to add SPDIF support to the latter since the code from the
> vendor driver is much easier.
>
> It took me a while to figure out why I would not get any audio output
> from AIU SPDIF to the HDMI controller - or from there to the sink.
> The "fix" for this issue is the RFC patch which is part of this series.
> Any feedback would be great as I am still new to the ASoC subsystem.
>
> Another part I am still struggling with is the audio "routing" (due to
> lack of a better term - please correct me if this is not the right word
> to use for this case). I have the following description in my .dts:
> 	sound {
> 		compatible = "amlogic,gx-sound-card";
> 		model = "M8B-ODROID-C1";
>
> 		assigned-clocks = <&clkc CLKID_MPLL0>,
> 				  <&clkc CLKID_MPLL1>;
> 		assigned-clock-rates = <294912000>,
> 				       <270950400>;
> 		dai-link-0 {
> 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> 		};
>
> 		dai-link-1 {
> 			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
> 		};
>
> 		dai-link-2 {
> 			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> 			dai-format = "i2s";
> 			mclk-fs = <256>;
>
> 			codec-0 {
> 				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> 			};
> 		};
>
> 		dai-link-3 {
> 			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
>
> 			codec-0 {
> 				sound-dai = <&aiu AIU_HDMI CTRL_PCM>;

Ok, the obove sums up the problem around this RFC.

Here you describe a DAI link (think of it as wires) between the SPDIF
encoder (output) and AIU_HDMI input PCM. This is not what the HW is and
it is not possible.

Let's start from the HDMI controller.
The designware (on amlogic SoC) has 2 interface for audio input.
1) PCM/I2S: a classic interface 2 clocks and N data line
2) SPDIF: The Sony Philips 1 wire interface

Whatever comes up on 1) has to be some sort of i2s signal. So SPDIF
won't fly there.

AIU_HDMI output is Hardwired to 1). It is just just a digital mux,
implemented as an ASoC codec which allows to seleted one of 2 audio
sources:
A) the i2s output implemented as part of the AIU
B) the PCM output, part the AUDIN (yes, an output in AUDIN) block. This
is not implemented ATM.

So trying to handle SPDIF through AIU_HDMI is wrong.

> 			};
> 		};
>
> 		dai-link-4 {
> 			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
>
> 			codec-0 {
> 				sound-dai = <&hdmi_tx>;

your HDMI controller should have an argument to the phandle if it
supported both I2S and SPDIF inputs

> 			};
> 		};
> 	};
> The driver for &hdmi_tx defines:
> 	struct hdmi_codec_pdata pdata = {
> 		.ops			= &txc_48352_hdmi_codec_ops,
> 		.i2s			= 1,
> 		.spdif			= 1,
> 		.max_i2s_channels	= 8,
> 		.data			= priv,
> 	};
> In hdmi_codec_ops.hw_params I always get fmt->fmt HDMI_I2S unless I
> remove all I2S references from the .dts snipped above (only then
> HDMI_SPDIF is detected). Based on the selection of the "HDMI Source"
> enum in aiu-codec-ctrl I was expecting the format to update as well.
> That unfortunately doesn't happen and I don't know how that can be
> achieved.

It is not meant to. The dai_link and the endpoint are i2s.
Your HDMI controller should have 2 inputs and should have a way to
select one or the other. The format at each of the (internal) input does
not change

>
>
> Best regards,
> Martin
>
>
> Martin Blumenstingl (1):
>   ASoC: meson: aiu: Fix HDMI codec control selection
>
>  sound/soc/meson/aiu-codec-ctrl.c  | 108 ++++++++++++++++++++++--------
>  sound/soc/meson/aiu-encoder-i2s.c |   6 --
>  2 files changed, 80 insertions(+), 34 deletions(-)

