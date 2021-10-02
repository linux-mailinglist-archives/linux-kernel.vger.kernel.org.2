Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41741FEC6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhJBXpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 19:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhJBXpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 19:45:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF1C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 16:43:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so14731652wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T6wA479aMjXiGVQMPU8TC7VB5tEcMArPpG5ub2OJHk=;
        b=EUhZfVpGDD6qg834LaUvUxb9ZhDqAco06iXtwjwHY0t+P8zjiqQea4m2vej+OHxL/l
         Y9mM1kUwszAQ25fM1xo1dLgXBC/nFzrAFFqUEvI/5eVVKy5RL8SSeenVB5i7Nv6dYGl9
         BZFV9xkLNKKFml88jtYV9xgbx0khTQug76YELXAQeCyWcQHfeaU1f4scvMlhAGKsj3b3
         C+Q+XSD1TRfSItSDklV22WZKxvf6Jw2radWrncD7geXukbtzwAjmq+4s9ZrXFRmbvXEU
         WPboa8oE9uQd9eDA39TWhg9PjdTjpW3EGvdA56dQFQ6vdJpr+EUtgqBoVvgxImd/mWDY
         b1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T6wA479aMjXiGVQMPU8TC7VB5tEcMArPpG5ub2OJHk=;
        b=LGl25kNZqHjBUORurPzGOY6Eji6m1DHwSlfaDNXo1dpulnrWDzTe++c1nPRow6o2p3
         glB8OerSKYHPtVN+t/Y5YlKIHl/9a9XMq+dgONQla/5AWmnk5EV08VCGQbIflwTOIXbN
         oSHvUP62kqULc/oV7/yu1qF9+TLrHRbxCXQkpKkPwyAg1uxenCfW+ZlrDLeRYXZ/BQun
         gzN/tmXU/TOWrherI1d6PxiQk9NGU/QiarWLjx2iRtVnZq5hzbPqKbAKvVMjWXHtIpcn
         7iASB3HHhEgwdEgU3WlSQJTG8N2Mrp++XoptJl8bCaF+d60kxOuH4qUUBPhlby0iu3MF
         Cjow==
X-Gm-Message-State: AOAM532JdkHiXiNEuMHI5yxFpTfBpkCoNDM5XKvnnOKLMwsexQ8i+AEg
        uEx8vSkGhbCuTh5wuk1FBLQnDo+wWJo=
X-Google-Smtp-Source: ABdhPJz/j7AnQVPkNfWnlxPyZBz5ITWoO6U2bBx+6+JZMWi8y1ZoDmE4l6z7g9WKHWWnom6z6VtlwA==
X-Received: by 2002:a1c:2c3:: with SMTP id 186mr11197754wmc.14.1633218211603;
        Sat, 02 Oct 2021 16:43:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7bbe-df00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7bbe:df00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id z6sm13999463wmp.1.2021.10.02.16.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 16:43:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control questions and issues
Date:   Sun,  3 Oct 2021 01:43:12 +0200
Message-Id: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome et al.,

on Amlogic Meson SoCs which use the AIU audio controller we have the
so-called "machine gun noise" (MGN) issue, reproducible for example in
Kodi. So far nobody was able to identify the cause of this issue. My
idea was to at least narrow down the issue so we can categorize it. For
that I wanted to get the SPDIF output from AIU to the HDMI controller
working.

On Amlogic Meson GXBB/GXL/GXM SoCs a DesignWare HDMI TX controller is
used. This has an SPDIF input but there's currently not driver for it.
On Meson8/8b/8m2 SoCs I am working on a HDMI driver for the TransSwitch
HDMI controller which - just like DesignWare HDMI TX - supports SPDIF
and I2S inputs.
I decided to add SPDIF support to the latter since the code from the
vendor driver is much easier.

It took me a while to figure out why I would not get any audio output
from AIU SPDIF to the HDMI controller - or from there to the sink.
The "fix" for this issue is the RFC patch which is part of this series.
Any feedback would be great as I am still new to the ASoC subsystem.

Another part I am still struggling with is the audio "routing" (due to
lack of a better term - please correct me if this is not the right word
to use for this case). I have the following description in my .dts:
	sound {
		compatible = "amlogic,gx-sound-card";
		model = "M8B-ODROID-C1";

		assigned-clocks = <&clkc CLKID_MPLL0>,
				  <&clkc CLKID_MPLL1>;
		assigned-clock-rates = <294912000>,
				       <270950400>;
		dai-link-0 {
			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
		};

		dai-link-1 {
			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
		};

		dai-link-2 {
			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
			dai-format = "i2s";
			mclk-fs = <256>;

			codec-0 {
				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
			};
		};

		dai-link-3 {
			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;

			codec-0 {
				sound-dai = <&aiu AIU_HDMI CTRL_PCM>;
			};
		};

		dai-link-4 {
			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;

			codec-0 {
				sound-dai = <&hdmi_tx>;
			};
		};
	};
The driver for &hdmi_tx defines:
	struct hdmi_codec_pdata pdata = {
		.ops			= &txc_48352_hdmi_codec_ops,
		.i2s			= 1,
		.spdif			= 1,
		.max_i2s_channels	= 8,
		.data			= priv,
	};
In hdmi_codec_ops.hw_params I always get fmt->fmt HDMI_I2S unless I
remove all I2S references from the .dts snipped above (only then
HDMI_SPDIF is detected). Based on the selection of the "HDMI Source"
enum in aiu-codec-ctrl I was expecting the format to update as well.
That unfortunately doesn't happen and I don't know how that can be
achieved.


Best regards,
Martin


Martin Blumenstingl (1):
  ASoC: meson: aiu: Fix HDMI codec control selection

 sound/soc/meson/aiu-codec-ctrl.c  | 108 ++++++++++++++++++++++--------
 sound/soc/meson/aiu-encoder-i2s.c |   6 --
 2 files changed, 80 insertions(+), 34 deletions(-)

-- 
2.33.0

