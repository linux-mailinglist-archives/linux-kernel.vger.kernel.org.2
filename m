Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465FD3EEAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhHQKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbhHQKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:12:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445AC061764;
        Tue, 17 Aug 2021 03:11:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gt38so16374288ejc.13;
        Tue, 17 Aug 2021 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jqw1AzmRK6zGBEx+a2c5M5+dO2MAySjNQQ8o1qXDJs8=;
        b=ZOD4sNytd4WPSZyPmbX2m9LgLSk9COCpOOmzj4bjLOzp2hFpikCaBnzFGgBEJXICwt
         DFV6SrstOLxM3pjIJQkIqAsjum+an8vUqUMGq4tdyNV+qQLzWl24Xn6SIoHoZiT9HmYs
         K6tTCTfaBYOh91jPdHHjTqZ9i22gfQjdka4U+GzF0Om23yB3MrVUsgNm8U+9JusW64Tz
         V1BHhVIxeqkxBphRPnqyzO33KJn02nxmZ4XjS4gU2sPLGkTt+gWcF1QVjPF6t4Wljy+X
         3UMt9JMbllLtSImr1hQHs/PyaM3QIy0V6JWU/I2K4yx+UPq+RTJBXjI6OSHlMMH9xHIq
         Ie2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jqw1AzmRK6zGBEx+a2c5M5+dO2MAySjNQQ8o1qXDJs8=;
        b=mkVR/tcovL/pyu+RRi5ixZ65fph16qHVqgW2AaMdVPwqm52M/G9NrKm1x7aXXMS51O
         6+MRTgJwX6mURK1Gxk3ktpqQLHTJvUiKHCUcJ0yAFQ5xJXu8zcTBZcuoBaCW1oXyWfXj
         NNtBOfaybmm4ucF/SBmqcrsyCM7LKv59l0kqlXdcgMpTOl5Nj9mm/wBVZnKD7p5HcW0f
         4Srgi96I46c1htRE4nx5qbAWF/ZDPlmvK3PdVYFzMUyXWdh2RBzEd+ciS8iIeeUcM7Kt
         NLKCswaiY3u5Mnz0Asx6j6moDVP2vmGnQXEkbekKCHQDRulSd/VLoG+quXO6BCB4tudr
         UdDg==
X-Gm-Message-State: AOAM5312VAVqOBGBDLyuOxYFukRPTOOz8iV0EupLrsqG6ln0snneNZ2p
        +4kn46O/1CceCZDF0yHN+yo=
X-Google-Smtp-Source: ABdhPJx7FraHwOny+E8f8qN3AMF/gbn3eNC37y6iQIiMzCrRbYBFSEtrtKJm1qLG9Pa6rK1MeNaVHg==
X-Received: by 2002:a17:906:4e59:: with SMTP id g25mr3104501ejw.399.1629195115109;
        Tue, 17 Aug 2021 03:11:55 -0700 (PDT)
Received: from localhost.localdomain ([185.213.155.232])
        by smtp.gmail.com with ESMTPSA id m6sm822920edq.22.2021.08.17.03.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:11:54 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Rockchip I2S/TDM controller
Date:   Tue, 17 Aug 2021 12:11:15 +0200
Message-Id: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I come bearing four patches for your consideration.

The first of these four patches adds a driver for the Rockchip
I2S/TDM controller, used in interfacing between the AHB bus and the
I2S bus on some Rockchip SoCs. This allows for audio playback with
a matching codec.

The controller has three different modes: I2S, I2S/TDM and PCM.
It is distinct from the earlier Rockchip I2S controller, and
therefore not just an extension of that driver.

The driver is based on the downstream version, though various
changes have been made to hopefully make it more palatable to
upstream. Some needless code duplication has been refactored, and
the probe function will no longer let wrong device tree values
write nonsense to hardware registers. Properties have been renamed
and had their semantics changed. I won't bore you with the details
of what downstream did, since that's not what I'm submitting, but
the changes are significant enough that I've added myself to the
list of authors.

The second patch adds the YAML device tree bindings for this, which
have been written from scratch by yours truly. Since I didn't like
having random integers mean things, I defined them as constants in
a header file for the bindings.

The third patch adds the i2s1 controller to the rk356x device tree.
I didn't add any of the other i2s controllers on that SoC for now as
I have no way of testing them; in particular, i2s0 is tied to HDMI,
so needs a functioning VOP2 driver to even have a chance of working.

The fourth patch makes use of the i2s1 controller to enable analog
audio output on the Quartz64 Model A through its RK817 codec. I've
tested this to work properly at both 44.1 kHz and 96 kHz, so both
mclk_root0 and mclk_root1 are definitely functioning.

This is my first kernel contribution, so I most likely did
something horribly wrong. That's why I'm more than happy to receive
any criticisms and concerns over how the driver is implemented,
because I've run out of ideas on how to make it clearly better
myself.

I'd also like to extend my thanks to Peter Geis, who has been
acting as somewhat of a mentor and gave me occasional feedback
and ideas during the writing of this patch series.

Regards,
Nicolas Frattaroli

Nicolas Frattaroli (4):
  ASoC: rockchip: add support for i2s-tdm controller
  dt-bindings: sound: add rockchip i2s-tdm binding
  arm64: dts: rockchip: add i2s1 on rk356x
  arm64: dts: rockchip: add analog audio on Quartz64

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  221 ++
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |   36 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   26 +
 include/dt-bindings/sound/rockchip,i2s-tdm.h  |    9 +
 sound/soc/rockchip/Kconfig                    |   11 +
 sound/soc/rockchip/Makefile                   |    2 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 1804 +++++++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  400 ++++
 8 files changed, 2508 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 include/dt-bindings/sound/rockchip,i2s-tdm.h
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.c
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.h

-- 
2.32.0

