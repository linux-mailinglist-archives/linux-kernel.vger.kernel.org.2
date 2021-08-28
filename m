Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD953FA624
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhH1ODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhH1ODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:03:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB188C061756;
        Sat, 28 Aug 2021 07:02:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bt14so20348190ejb.3;
        Sat, 28 Aug 2021 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGMD8G1jIPuTkP7k4fL/JNaabjrqckiKTYDIJ4uuuE0=;
        b=GbNbCHzhYOTSJwpk8QpPayaXfLVMx3hzQag0i1ovxDU8buCO+kdz7SVUxd++BPbnuQ
         h/fqLmzZgFg+t6vs4plyajV/fX4vK05/eEZiFkXIWWpgISSy2DBiZKR254KJoby7WkwX
         jt8TclTBhwiwfGP9JqjNk2UoH2QiTQm+Fox+LgfWm38So4gzzxVxBqEZMwhlwSdgr6Im
         6jjnr3TQVFVnwvXkXDp0x3lPLWaKFOmKowOaRGd4C8A5nOIynhqCrXCLfpCIZ2W6SqUK
         eHKGIXO7z25tbuxJqD61mqaCSrF6xpm4z3lHbFMSrLjWmrzdi3RKWSqzFMO3b5MF4stg
         oyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGMD8G1jIPuTkP7k4fL/JNaabjrqckiKTYDIJ4uuuE0=;
        b=K5p0S2t25PWd297Jd2s30mZ1QfGSygOJbvgN7PyZ39GNVb2AdsgCrIBTlhZDuOYyZZ
         Gd6PsNAdJowog1V4Kzbz1GskZjeZdOqSW+NjKnMCC6quOAJiNOK2NzlRX2P/zjnE+4Q3
         XPLNIx9TUlzLuyE6kiuMXUozzDkeMOoSbuYYkQRDRcpWqM6LPAWNACeSKi3HcliWILT3
         owkAUFLRfeCYRAFKQqVDTGmhCb7rzVzq5nqBhxEZOsNwGgD47TvtWEyw/azbcel/o3Pj
         RiCUflWFhrAQxihKP6e0SVD+MPnTQFYJcfhvO3Hkz2jhg/+Tno9Tz2Iwsh6BGshIeDEe
         dxnQ==
X-Gm-Message-State: AOAM5309aX2CGBOOOoxZIaO6EP8XD+dE1hzW2RVtlXYcXmRQECFZ3dMW
        uPeE670nYAq3ci29+jLnvX0=
X-Google-Smtp-Source: ABdhPJw6u0+tq5UMYxj/3pOPrn8zfR/ErHG3LVTAGGRJqwoXlKkcOEk6Mimyf1b4/vxX247Xe2v0TA==
X-Received: by 2002:a17:906:3383:: with SMTP id v3mr10421811eja.213.1630159330279;
        Sat, 28 Aug 2021 07:02:10 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id cn16sm4953982edb.87.2021.08.28.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 07:02:09 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Rockchip I2S/TDM controller
Date:   Sat, 28 Aug 2021 16:02:00 +0200
Message-Id: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is version 3 of the I2S/TDM driver patchset. A big thanks
to everyone who has provided their valuable feedback so far.

I've decided to omit the original cover letter for this version,
as it got quite long and had some things that are outdated or
weren't the case as I've discovered from better understanding
the driver code.

I've decided not to remove the synced reset code. The udelay
matter has been settled, and it is code that most likely works,
even if I cannot test it right now. The implementation of half
a reset controller is ugly, but specifying a generalised n-reset
synchronised reset is a bit more complex to do than just doing it
for 2, so I'd prefer putting that work off until later.

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
  dt-bindings: sound: add rockchip i2s-tdm binding
  arm64: dts: rockchip: add i2s1 on rk356x
  arm64: dts: rockchip: add analog audio on Quartz64

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  218 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |   35 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   26 +
 sound/soc/rockchip/Kconfig                    |   11 +
 sound/soc/rockchip/Makefile                   |    2 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 1845 +++++++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  398 ++++
 8 files changed, 2541 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.c
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.h

-- 
2.33.0

