Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495F53F33C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhHTS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbhHTS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:28:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC97C061575;
        Fri, 20 Aug 2021 11:28:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b7so15278834edu.3;
        Fri, 20 Aug 2021 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fwJK6cnEZCMjdsnKpqrNeZQk4XPHKUiIqGOR28Ciyc=;
        b=f9cByAwt5N7co5rgLKUdcfgA3NWyB8162sDzKYPn0MfsiCQGnTm6Po9A5Yz9vGAJhN
         adtn6UIXbJ1zm0Ax5yU1pgAKgJeFCyyYM2rvRMhK7AQBy8mkuwe2lfDflteCV9s4TmMj
         Al7TVZS7MX7aA/U3nz3RvspdJelXqNjXSbTJCShro89hsFSXXpfIeAMl+WYXJKNhs/JY
         3HVYd6Yg34SLpsWSjuQwCCj+oeZJbRHwVNI7++0BA1dClsMr5+Qw468EQeT/YlHkQN4a
         wGu2FNyH2eCUti/TfIVVtqTwNdpfAcRlTswIbNf1V8AAp/pAvXU5MKgt2vDXWnSdAJl4
         tC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fwJK6cnEZCMjdsnKpqrNeZQk4XPHKUiIqGOR28Ciyc=;
        b=myw1HrDtInMjORxFzJUFHiyIDWRKFtroUdaVUr5Fi3Xf+u8E8wV4puV3oKj4x1hdJX
         qbHLsMKTNSZ92p+IyLbYPLH4PtWcFwwES9wCLLj3YJ++gC3lfq9lxKDkAI6RYXKHMWxc
         sY08TqBFp7YoeBIu3ix6HYkoBdfgbU74irYkSUmQOyBBw7c/DqsLjogGjef7qQ04lAkf
         B+wyfF3SeOmBxUNr8ugYbbNI+fz06+UYjNFkobvNvcb3/XuwRbjO+A4pSaY1vcqShtxn
         85hlM0jbiuhwhreZmdKx4ZwhjkVNXiSobKbkJIzPnHubcLjKRfqnvlZRMPNJlyi0iNBa
         SlOw==
X-Gm-Message-State: AOAM531WHqG3h1YLMAqM4l9ssXFo6kf0txfsA2wzy/J/7+9/qk6BB7zd
        QgNdPvKDOcj1vExxfmb1+tE=
X-Google-Smtp-Source: ABdhPJzJfYq4YbWtWWxg0FlVHG1GBA1BRHiyIib6NSGMRYw5NSToA66ll1pqB7aSeGllAPnac5DuPA==
X-Received: by 2002:a05:6402:100d:: with SMTP id c13mr23727138edu.261.1629484094603;
        Fri, 20 Aug 2021 11:28:14 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n10sm3255724ejk.86.2021.08.20.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:28:14 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Rockchip I2S/TDM controller
Date:   Fri, 20 Aug 2021 20:27:27 +0200
Message-Id: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Additionally, I have been made aware that registers and code seem
to be an extension of the rockchip_i2s driver. This is true,
though merging the two seems like more effort than just slapping
a few compatibles and properties into the mix. I'll investigate
it further in the coming weeks, but would likely still prefer
basing any unified driver on mine rather than the other way
around, since I think it has better code quality now.

Original cover letter:

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

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  193 ++
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |   35 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   26 +
 sound/soc/rockchip/Kconfig                    |   11 +
 sound/soc/rockchip/Makefile                   |    2 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 1737 +++++++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  398 ++++
 7 files changed, 2401 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.c
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.h

-- 
2.32.0

