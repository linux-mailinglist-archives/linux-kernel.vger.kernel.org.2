Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7430924C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 06:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhA3Fox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 00:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhA3FlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 00:41:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF009C061573;
        Fri, 29 Jan 2021 21:40:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s24so6864721pjp.5;
        Fri, 29 Jan 2021 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO+dTyu0Ai+JgXkbLN4mpIgMxzzbIfn+Gkh1UirZ+w0=;
        b=Ql+2kWyOoQtxwkc7Xh87pKZeIG5pnj5MbLPeUbWgtyVrkfmOGwl/+FpLlElmQdaxZi
         kGp50s4fNPeACBJdAE2+925S4nPXN6N/MUg7MxL5m/Zh8+BwykJmpqZXt2qOULjtMAH4
         A2J7rSvNmjxCXQQnEz7gMbVKvnXAEyOI+1Ql8RoC20O8VR2SZXafFusnzteAS3205ZIb
         7QWmbPnqKhaKO6zcIA1cnOWJogY6uqga+9DpoZX3d3YXEyCT8Q8hsmtRwjro4UkC1hTf
         4OY0EH0VtHvA5A28/EAIXezKfKToShwqd7TIyL37SpfejuWAn192PDHNqdPckCI1GqlP
         A6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO+dTyu0Ai+JgXkbLN4mpIgMxzzbIfn+Gkh1UirZ+w0=;
        b=LxWnsfkuijVc6lsrirCu3lppk25LDLZOmssLM2f3hvU8/xFGdBTOU8j+MoIJxghu2A
         pRiQTo2kdiKIOikiiqe/S+2MCUAmeplBDJEwsU3wMmJd1YrnkCLZ21IF+KqUC02tytOq
         E0O8j63kgQDysToezW4cP1VySoISOdzmW9jhc1o5LZG+xTdAoYpWmDWZ5Cm6qnmWkb5c
         GAq5Xw9oiV0wIrpX2aGF9n2rpuY7a7Imdc1fsE+bM/ANFXUpAlN0c9LqdPvt7ouUJHnj
         Bc8dW2lbE3sqK4Y4KDOJxeXdn0TE6YDq8gPRUJ8kj9v1NIeXZzW2oJOxFkowfEZMRMxz
         IV9A==
X-Gm-Message-State: AOAM532TE/8DS5U+EmuG7Q1XWadBWPj/XyWWCFgur1OBUSJpdV7196rT
        Z3481pbyaiUCDY5dazxKe+s=
X-Google-Smtp-Source: ABdhPJxxaYBoKQANWDrm18IPWzKyIai6drc6hbwdL3dgAul+8/dCXjO9ajA6pYDTOhZLE1tjDDcNtA==
X-Received: by 2002:a17:902:9005:b029:da:f580:c5f7 with SMTP id a5-20020a1709029005b02900daf580c5f7mr8076247plp.85.1611985235315;
        Fri, 29 Jan 2021 21:40:35 -0800 (PST)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id k10sm10942376pfk.0.2021.01.29.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 21:40:34 -0800 (PST)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH] arm64: dts: meson-gx: remove wrong reserved BL31 memory
Date:   Sat, 30 Jan 2021 13:40:22 +0800
Message-Id: <20210130054022.2020338-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel boot fail on Khadas VIM1 VIM2 (meson GX) boards
SOLUTION: just remove wrong mem reservation for 0x10000000 0x200000

 ## Booting kernel from Legacy Image at 08080000 ...
   Image Name:   kernel
   Image Type:   AArch64 Linux Kernel Image (lzma compressed)
   Data Size:    4657736 Bytes = 4.4 MiB
   Load Address: 0f080000
   Entry Point:  0f080000
   Verifying Checksum ... OK
 ## Flattened Device Tree blob at 08008000
   Booting using the fdt blob at 0x8008000
   Uncompressing Kernel Image
 ERROR: reserving fdt memory region failed (addr=10000000 size=200000)
   Loading Device Tree to 000000007bf23000, end 000000007bf2d3ce ... OK

 Starting kernel ...

 bl31 reboot reason: 0xd
 bl31 reboot reason: 0x0
 system cmd  1.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 726b91d3a..71083b89d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -32,12 +32,6 @@ hwrom_reserved: hwrom@0 {
 			no-map;
 		};
 
-		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon@10000000 {
-			reg = <0x0 0x10000000 0x0 0x200000>;
-			no-map;
-		};
-
 		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
 		secmon_reserved_alt: secmon@5000000 {
 			reg = <0x0 0x05000000 0x0 0x300000>;
-- 
2.25.1

