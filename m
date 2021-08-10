Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53A3E51D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhHJERD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhHJERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:17:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82895C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:16:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e19so5708149pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U1ZCxqdGoaf55/CTcj5ISosMneiCtYYe3Xxj887/aoU=;
        b=hHIYpognbzOKWWou01shBFX8B6rVjSPSVv+Vol6SK02fq/32t1tml9z9ug0Yk4tW+3
         n+p2M9J53QpjZd5hPByWcqcdZH7+k1vjAQyL3WnuBJrh8WqcEJ8bkfujqI2DLdxUag9m
         cwtl7OVhQGQxK//bcQ9RIBrqYSjJh+RMnWue4N28F7CSgpjNijvp8CfcMme5wJbfxAmp
         Pb54Q57FyBGlfdBnefH17viiNugtkGHKusaYbZo5fA1SSPhHJDnok9IiPOvb81Zzym67
         Tz1vREtYpsJ433KqyxYF8P5TvlkiOeFJ5a4V43meSC9ZfyS9pRDr0G7f5o5b6gvzjzsl
         T0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U1ZCxqdGoaf55/CTcj5ISosMneiCtYYe3Xxj887/aoU=;
        b=nbHDvA4KhjpE9cGkI5rCg2SnKIEfVHxzaq7FlLl69gh84Zr9NI6ETK1+fE5T1C9r2v
         DWDm3DcYpT/faK/m/Y0iztqBah21pSnsWQBy0q4LwFuj084N2iVU25Bsxuy3XrT4Pc4y
         rjO0eXS9EsDilziKfqzv1EVJ0FiDyx+uAYEP6wxOScrO8dQZ9orlRYU9L0Zvgrhw10+6
         QQccSwpv1Wf2WoLkr9cYpQhW7/SyCrk1/KCZWPjYHPx6IUk8Ir6hPBL8fVNNjj7GZ2zM
         9W9LvKUaK9PXr5NCFJCCelArALZNfEENL/EEHLChiRLL7cbbft6vbL5wQGV7IX53jKIy
         SkSg==
X-Gm-Message-State: AOAM531CyVUkBeRkl6jP0lbGX6Tfn2HXYGUR6mnucZSSfFJ1sBk70KKI
        yKdcNDsDH5gRjMqvExzFAmo=
X-Google-Smtp-Source: ABdhPJxg0dSgmJwiGBZqXBbjejI1SZjtESI5ts60+1k7XaHzE1ixy6ISeV5GB8zmR8iq4wF/xHl5cA==
X-Received: by 2002:a63:5fd4:: with SMTP id t203mr131411pgb.141.1628569000118;
        Mon, 09 Aug 2021 21:16:40 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id g22sm12741647pfo.164.2021.08.09.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 21:16:39 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH 1/2] arm64: dts: meson: add spdif out to khadas-vim
Date:   Tue, 10 Aug 2021 12:16:29 +0800
Message-Id: <20210810041630.3673406-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spdif output audio support to khadas-vim

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 60feac0179c0..01f13822a616 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -64,6 +64,13 @@ hdmi_connector_in: endpoint {
 		};
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
 		model = "KHADAS-VIM";
@@ -97,11 +104,21 @@ codec-0 {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
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

