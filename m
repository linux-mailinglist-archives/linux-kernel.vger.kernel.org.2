Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC13420029
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhJCFPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:15:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0AC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:13:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j13so13011451qtq.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ulbTVNSJ2iNJZxZK00NR1PC8WsHr0mc+HEMbZmRuv3I=;
        b=IPEybbj+ehfBzk/ZqtSTakokncT+6/v3I9sZ7U/Lq8nq+kmPdjczyC42Pf8HFViAv3
         a/dbCxlfCvCOXsN40cX7ptcPd8/qRfnft22roUwExNnDBs2ACE2aTuNp0fWTqrEvAChF
         5zaeCMNt1Q5WCRy+RNwUoZL7XdZPWfGD8VYvnecINloko/xgVY8WSjjuLWC8GTb/7oer
         GtyoFTT0j/WypuRNfLI8qlHpCmn5DnKPyG57VSCM/sBljNi6ZvtUCQPikyBdRvPMmbig
         V1M0ZnSwB1mH6fc7ipKg/9KS5COMOv/0JRcrDig7oBf6NawBPH8cFN6/2Vbq7qmnog4K
         6Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ulbTVNSJ2iNJZxZK00NR1PC8WsHr0mc+HEMbZmRuv3I=;
        b=ccGeBEZLQ4EMPH0RT1j69QJhV1g1s2TRRWekdo9rEothiNh3m5jPXBlWLkcQYIZoBy
         9abYMd4SRnNCqojQPIpZJUCJ0tEvZxpoF6jnThjf04a3uwQkS8lAUBaUZ4JKi/btYiHv
         TKTcnHno+fo2Q/bZfZlOLCX5dEhs+ZnpwXcc0v6wypyU9o+kGr5xnJIjk4MGZxOJ5rcS
         IxiZWYwGqYLUnVX4UrS1axAkPdTkMQUTUYW0RP1MMiILO8vrD1jo9tmXLUFhjH2TKgem
         NAwWX4LUgoTmpDwQAwiTpjxXoG8/ooSfgB0P+eq/Du8TITCo17EdYY53uNZmnvCJktnb
         8Dsw==
X-Gm-Message-State: AOAM531kmlXA111yiDobugPN0NOhqPFf/01ozKeiKrh7XyNMzT779ZyX
        hpHx2D9qI80EboFJYFdH/f5nwCSSAs9e/Q==
X-Google-Smtp-Source: ABdhPJzioSuGzx0Q7e0kRaQ5WWNQA4BhFy7b5Z30W2SOkuqm96ro8a6xkF6I1iBN61fBfkX7h8zVOg==
X-Received: by 2002:ac8:6b43:: with SMTP id x3mr6815822qts.190.1633238000236;
        Sat, 02 Oct 2021 22:13:20 -0700 (PDT)
Received: from geday ([2804:7f2:8280:6c81:98f0:31ff:fe93:2dc7])
        by smtp.gmail.com with ESMTPSA id p9sm5518208qkm.23.2021.10.02.22.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:13:19 -0700 (PDT)
Date:   Sun, 3 Oct 2021 02:13:19 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control
 questions and issues
Message-ID: <YVk77/SIxr8Vt8TQ@geday>
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 01:43:12AM +0200, Martin Blumenstingl wrote:
> Hello Jerome et al.,
> 
> on Amlogic Meson SoCs which use the AIU audio controller we have the
> so-called "machine gun noise" (MGN) issue, reproducible for example in
> Kodi. So far nobody was able to identify the cause of this issue. My
> idea was to at least narrow down the issue so we can categorize it. For
> that I wanted to get the SPDIF output from AIU to the HDMI controller
> working.
>

Hi, Martin,

The MGN issue surely must be that one when using ALSA directly
(no dmix, no JACK, no Pulseaudio, no Pipewire, no nothing) and
when the track changes or we pause it, when it resumes we get 
noise instead of sound, correct?

If so, thanks for trying to track this down!

I bring it up because Googling it seems to head straight to a
Neil Armstrong post to linux-amlogic about what works and what
doesn't on linux-meson currently, and only if you dig deeper
you find a couple of reports apparently by the same person
about the "machine gun noise" thing.

It doesn't sound like a machine gun noise to me :)

More like brown noise, but anyway what I'd like to note to
everyone involved is that this one is a major dealbreaker.
Unless using JACK, Pulseaudio, Pipewire (?) or at least dmix
audio will degrade at the second song or when the user first
pauses and then resumes a stream, completely ruining the
experience.

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
> 			};
> 		};
> 
> 		dai-link-4 {
> 			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> 
> 			codec-0 {
> 				sound-dai = <&hdmi_tx>;
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
> 

Hm, that sounds weird. I hope you get the answers you are looking for.

Thanks,
Geraldo Nascimento

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
> 
> -- 
> 2.33.0
> 
