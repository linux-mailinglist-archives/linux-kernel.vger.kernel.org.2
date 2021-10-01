Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7061641F2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbhJARR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbhJARR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:17:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FAFC061775;
        Fri,  1 Oct 2021 10:16:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ba1so37289939edb.4;
        Fri, 01 Oct 2021 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfCu/nNwO7AGzA8uGp45U8eywpx0lfbMyI4anCyuLtI=;
        b=LyeRdr3V+ofrVQMoJDopsWuq+NNZNykiMUcYdt6S+eoTlab74HmZfz8t0RoEoPPil4
         vQC4MEDevmmiY0gxmlFT81eQNnoBhiZr878YhZPYF4mjWO5N2Mi+L4I9zSag3z7Fg0pC
         J54fsY2C6OgdNhH6LxH46aB/xxG+uIDyzaoD6xZDajrmNFJ3VNnA+viL3G4nYxXoTxZz
         /kOH5sninpvb/4ttLBcJzPRWLza2NDamVkPmDgApuyC2+/XZCKRc3Yo6zV/w/nrE9OZO
         U8E46qUcpus+2rvvvJqZZIJwZFiEauVl/Z4l1IwTSCG0zQBTbPKdMZNsYdFjC0Erkxk3
         wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfCu/nNwO7AGzA8uGp45U8eywpx0lfbMyI4anCyuLtI=;
        b=IHUz9gxo6yMupH5QZ93CVszrnYCicJgl4El1MYUIhycaZzJuILmszM+QsMldHc0ey/
         yjIncCljrGC0Qpo+7moodhQaNBFNb6VWAatkgl9e12JJDL0qsAX+E/FSMpbngnGOwbv+
         IkxX8wgZ0flgQFEMVXy2M/r0obdt4tly54XD8fnvx/ejMVqRNWWObG+IY5VqFnHb8lEp
         b+7fDpl3SYyxSJwkDrXv4KRycKF2VG5TeRKAwlPoI4N2KDMFETmjJhzYvs3dokBbXVa3
         QHrCNiTMfAEzdtaUJIIXRNf2FV4cdLgEi6tRosCnFO4B7+PviChR5BpMGkpOtWKQWMqF
         dGqw==
X-Gm-Message-State: AOAM531ECF0qIXkhcZnL7ODl+/Xf20FshR+qIEfRtkmF6kjGi0elU4wi
        mE07uVota9jJcKVdU81Lb9M=
X-Google-Smtp-Source: ABdhPJxA92NBJBLyMapmOz4v0fbfmiaX7QSS24orSuF3nZDF9oaOr8tQQkhTejP9C6G1X5Djap2gww==
X-Received: by 2002:a17:906:2cc9:: with SMTP id r9mr7744000ejr.138.1633108570339;
        Fri, 01 Oct 2021 10:16:10 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h10sm3588130edf.85.2021.10.01.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:16:09 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Rockchip I2S/TDM controller
Date:   Fri,  1 Oct 2021 19:15:27 +0200
Message-Id: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is version 5 of the I2S/TDM driver patchset. A big thanks
to everyone who has provided their valuable feedback so far.

Changes in v5:
 driver:
 - change comment style of the first comment to C++ style
 - make refcount non-atomic, as it's only ever used inside
   a spinlock
 - use newer SND_SOC_DAIFMT_CB* defines
 - change ternary statements to if/else conditions
 - make _clk_compensation_put return 1 if clock changed
 - implement set_bclk_ratio callback
 - always set half frame sync mode in TDM mode
 - automatically enable mclk-calibrate mode when the clocks for
   it are specified in the device tree
 bindings:
 - add Reviewed-by: Rob Herring
 - drop rockchip,frame-width property (done by set_bclk_ratio)
 - drop rockchip,fsync-half-frame property
 - drop rockchip,mclk-calibrate property
 dts:
 - drop empty codec block from Quartz64 device tree

Changes in v4:
 driver:
 - factor TDE/RDE enable/disable into their own inlined functions
 - add an RDE disable in a location where it looks like it was
   forgotten (rxctrl else), judging by corresponding TDE code
 - remove parentheses around CLK_PPM_MIN/MAX values
 - wording + titlecasing in the clock compensation control
 - use if statement in precious_reg instead
 - refactor rockchip_i2s_io_multiplex to have the switch statements
   in a function call to make the function less unwieldy
 - get rid of IS_ERR checks around clk enable/disable calls where
   already checked before by the probe
 - reworded some error message strings
 - fix potential deadlock in txrxctrl found by Sugar Zhang
   using spin_lock_irqsave
 - fix potential deadlock in trcm_mode found by Sugar Zhang
   using spin_lock_irqsave
 - use devm_platform_get_and_ioremap_resource in probe
 - only set DMA things if controller has capture/playback ability.
   Did not move this into init_dai because I'd then need to pass in
   the res and probe it earlier in the function, and it's also used
   elsewhere in the probe function
 - use _get_optional_exclusive for reset controls, as some controllers
   only have capture or playback capability
 bindings:
 - remove status = "okay" since that's the default
 - change the path configs to be an enum
 - rename "foo" to "bus"
 - make resets optional as controller may lack either playback or
   capture capability, and therefore also doesn't have a reset.
   At least one reset is still required, because a controller with
   no playback and no capture is not very useful

Changes in v3:
 driver:
 - alphabetically sort includes
 - check pm_runtime_get_sync return value, act on it
 - remove unnecessary initialisers in set_fmt
 - use udelay(15) in retry code: 10 retries * 15 = 150, so at worst
   we wait the full i2s register access delay
 - fix some weird returns to return directly
 - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP, also put
   __maybe_unused on the runtime callbacks
 - use (foo) instead of foo in header macros for precedence reasons
 - when using mclk-calibrate, also turn off/on those clocks during
   suspend and resume operations
 - remove mclk_tx and mclk_rx reenablement code in remove
 - move hclk enablement further down the probe, and disable it
   on probe failure
 - make reset controls mandatory, since the bindings state this too
 - use _exclusive for getting the reset controls
 - change reset assert/deassert delays to both be 10 usec
   (thank you Sugar Zhang!)
 - properly prepare and enable all mclks in probe, especially before
   calling clk_get_rate on them
 - if registering PCM fails, also use the cleanup error path instead of
   returning directly
 - bring back playback and capture only but in the way Sugar Zhang
   suggested it: set those modes depending on dma-names
 - rework clock enablement in general. Probe now always enables these,
   instead of relying on the pm resume thing
 - add myself to MAINTAINERS for this driver
 dt bindings:
 - fix a description still mentioning clk-trcm in the schema
 - document rockchip,io-multiplex, a property that describes the
   hardware as having multiplexed I2S GPIOs so direction needs to
   be changed dynamically
 - document rockchip,mclk-calibrate, which allows specifying
   different clocks for the two sample rate bases and switch between
   them as needed
 - dma-names now doesn't have a set order and items can be absent to
   indicate that the controller doesn't support this mode
 - add myself to MAINTAINERS for these bindings

Changes in v2:
 - remove ad-hoc writeq and needless (and broken) optimisation in
   reset assert/deassert. This wouldn't have worked on Big Endian,
   and would've been pointless on any other platform, as the
   overhead for saving one write was comparatively big
 - fix various checkpatch issues
 - get rid of leftover clk-trcm in schema
 - set status = "okay" in example in schema instead of "disabled"
 - change dma-names so rx is first, adjust device trees as necessary
 - properly reference uint32-array for rx-route and tx-route
   instead of uint32
 - replace trcm-sync with two boolean properties, adjust DT changes
   accordingly and also get rid of the header file
 - get rid of rockchip,no-dmaengine. This was only needed for
   some downstream driver and shouldn't be in the DT
 - get rid of rockchip,capture-only/playback-only. Rationale being
   that I have no way to test whether they're needed, and
   unconditionally setting channels_min to 0 breaks everything
 - change hclk description in "clocks"

Nicolas Frattaroli (4):
  ASoC: rockchip: add support for i2s-tdm controller
  ASoC: dt-bindings: rockchip: add i2s-tdm bindings
  arm64: dts: rockchip: add i2s1 on rk356x
  arm64: dts: rockchip: add analog audio on Quartz64

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  198 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |   31 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   26 +
 sound/soc/rockchip/Kconfig                    |   11 +
 sound/soc/rockchip/Makefile                   |    2 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 1848 +++++++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  398 ++++
 8 files changed, 2520 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.c
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.h

-- 
2.33.0

