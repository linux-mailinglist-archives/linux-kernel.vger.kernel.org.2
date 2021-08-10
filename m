Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4B3E51D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhHJERI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhHJERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:17:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FADEC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:16:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so2546402pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiSNmAnyZus5dcVLvfEuPhPiZnZR0/AbgyI2eI5d9iM=;
        b=MSQIg5PW6zun2u0DBHggz1QzDX2mMk7hAht2dn4+T0k/KAIbBajPGhjcmeidbhc7Od
         ZzdzLKM4OUQ/6cRusIyVMbg1BTqmN8wSLLhS9JL6/BGjkQHJHL3uTw/WNHKdyxlFjzY8
         opB8z5C2gZw72wGVACB9A4TPEKsZYRKzIDp94xvLlUpB8FyVKuKWk1GFejq2+ohGmauM
         qS0VAzfGxSdmItBwHNFs9R+649Ncd816yX4H2+ArJDYlsoAIXE9cxszR7s5Wy8WCY2zi
         6lDzSFLxpcZzsWCT5SLLq0G9VwtDh09oXJn1cDgeBo5nc5pYaL6rtgHyZSUK4MEB2mLe
         jcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiSNmAnyZus5dcVLvfEuPhPiZnZR0/AbgyI2eI5d9iM=;
        b=iE4xCVu46KJ+Clnz/87oEczZMno7+a2UT9qhhMAJc8IkMLrRgjJrhvm5aC5BS77hTd
         F3qW8mWOURv+DHTPmaq4YDlBGP5shLqKpRCF3Bh5mj7es4/X+xQXHvqcsvtS7/7zhWxC
         CXF4yZ7ZTX6WnoUKN1oJN2ljRz9k6EHNI4AFLIBBzWrpo97OCKikCgafSwMZE+Qh8oEt
         byjJ4k4jmaHmcCqdklgFEWCu37AgAod92zgB3vT/DgZy7WBi5oamE1ASceUo29mEtWjN
         oqmxqwRGcgNWBjpyJyGzVGhOiMpoJYq0b7MQ+Eu4JXTsIE/kuj3H3HIDzjWBO9cY5N3x
         rT9Q==
X-Gm-Message-State: AOAM5312iT3+mPoqv269AHGeG/+BGmm5IKa9N5nB+4NSMkLi2++BKKs2
        LHWmptbCqAGY9skq50lihGE=
X-Google-Smtp-Source: ABdhPJwO2JBpaCbhFltHLY50YQJniRKPIQv51e4Ev+QeP17djuAbvRw65rOIXmBZk789A4PXLZeofQ==
X-Received: by 2002:a17:90a:5588:: with SMTP id c8mr2787556pji.36.1628569004240;
        Mon, 09 Aug 2021 21:16:44 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id g22sm12741647pfo.164.2021.08.09.21.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 21:16:44 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH 2/2] arm64: dts: meson: add spdif out to khadas-vim2
Date:   Tue, 10 Aug 2021 12:16:30 +0800
Message-Id: <20210810041630.3673406-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810041630.3673406-1-art@khadas.com>
References: <20210810041630.3673406-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spdif output audio support to khadas-vim2

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..a129a827f6ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -146,6 +146,13 @@ wifi32k: wifi32k {
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KHADAS-VIM2";
@@ -179,11 +186,21 @@ codec-0 {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+			sound-dai = <&spdif_dit>;
+			};
+		};
 	};
 };
 
 &aiu {
 	status = "okay";
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
-- 
2.25.1

