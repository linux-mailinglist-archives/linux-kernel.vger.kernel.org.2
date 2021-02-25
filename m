Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD191325535
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBYSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:09:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18992 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhBYSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:07:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6037e7340001>; Thu, 25 Feb 2021 10:06:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 18:06:44 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 18:06:41 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh@kernel.org>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk and pll
Date:   Thu, 25 Feb 2021 23:36:02 +0530
Message-ID: <1614276364-13655-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614276404; bh=9ywFTvkZa5lV3oP3sSlaxK8fYTSk9Azn5gp12WflYbY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=Qj6u+1PvzAC8CJJTxccDuj8mUtADkD1O1knBKonobjhCb55KhvR6Y4u1SL7K9D9HR
         wga4vy8FOYy5+kqukd/ferK5IYIPCvoX+YgWS/BkqqLgQmgeAkH+hRJFjKoBLZbcrn
         uF/TJl0UmXUKplNpKq9wQVnZF34dQ1s1PbK6h+1hI3QkOWrEG9DL17x+heAnwgTpY1
         DLybd+5UkVt0NzFl7cmHe/5TEKHQDk7X93dGKxAhROS4aM7pa3HshhxwNN85Iu9KQm
         MnLqzxFspfZZiJeQ+FR32RV9xQDzQGQvMq2VMTCLLaTR80arQqdSl+up4shNzfg583
         cnYxLXWFtNvkg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC core provides callbacks snd_soc_dai_set_sysclk() and
snd_soc_dai_set_pll() for system clock (sysclk) and pll configurations
respectively. Add bindings for flexible sysclk or pll configurations
which can be driven from CPU/Codec DAI or endpoint subnode from DT.
This in turn helps to avoid hard codings in driver and makes it more
generic.

Also add system-clock related bindings, "system-clock-direction-out"
and "system-clock-frequency", which are already supported.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/sound/audio-graph-port.yaml           | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 766e910..4f50291 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -71,6 +71,77 @@ properties:
             description: CPU to Codec rate channels.
             $ref: /schemas/types.yaml#/definitions/uint32
 
+          system-clock-frequency:
+            description: |
+              Specify system clock (sysclk) frequency for CPU or Codec
+              component. Or if a clock is specified in the CPU or Codec
+              device node and a scaling factor is given with "mclk-fs",
+              sysclk will be calculated as a multiple of stream sample
+              rate and "mclk-fs". The rate is updated when stream starts.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          system-clock-direction-out:
+            description: |
+              Specifies clock direction as "out" on initialization. It
+              is useful for some CPUs with fixed clocks.
+            $ref: /schemas/types.yaml#/definitions/flag
+
+          system-clock-id:
+            description: |
+              CPU or Codec component may have multiple clocks. A specific
+              clock may have to be configured. In such cases the clock
+              ID needs to be specified.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          system-clock-source:
+            description: |
+              CPU or Codec component may have multiple sources for its
+              system clock (sysclk). In such cases the sysclk source
+              needs to be specified.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          pll-id:
+            description: |
+              Specify PLL that needs to be configured. This is useful
+              when the CPU or Codec component has multiple PLLs.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          pll-source:
+            description: |
+              When PLL has multiple reference clock sources, the exact
+              source needs to be specified for the required configuration.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          pll-input-reference:
+            description: |
+              Specify how to calculate input frequency for the PLL.
+              Depending on the identifier, input frequency can be
+              calculated at runtime. For example if I2S bit clock is used
+              as reference, rate depends on actual PCM parameters (rate,
+              channels and bits) during an audio session. If a fixed rate
+              is used, then "pll-input-frequency" can be used instead.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            const: 2
+
+          pll-input-frequency:
+            description: Specify fixed input frequency
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          pll-output-reference:
+            description: |
+              Specify how to calculate output frequency for the PLL.
+              Depending on the identifier, output frequency can be
+              calculated at runtime. If output clock is used for MCLK purpose,
+              then it may depend on "mclk-fs" scale factor. In such cases it
+              needs to be calculated at runtime. If a fixed output frequency
+              is needed, then "pll-output-frequency" can be used instead.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            const: 1
+
+          pll-output-frequency:
+            description: Specify fixed output frequency
+            $ref: /schemas/types.yaml#/definitions/uint32
+
   ports:
     description: multi OF-Graph subnode
     type: object
-- 
2.7.4

