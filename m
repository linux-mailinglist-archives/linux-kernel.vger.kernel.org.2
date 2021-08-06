Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1513E277C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbhHFJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244660AbhHFJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:40:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2983CC06179C;
        Fri,  6 Aug 2021 02:40:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b11so10288783wrx.6;
        Fri, 06 Aug 2021 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=il1yIk46p3XJvX3l/iCGJYKMOJQDsOFZaHzkEJnhC4s=;
        b=nuIeU29wdllClgvVY6ItDDkgkpA8H4BEh+o72svM8IPYyYmZshm50ziyU08GQlpoy6
         zCmVfaOPjzS34DbHZFM3V5AvFXfkROl5vKglIau9BvFd8xu2HMyJxOyNtA6SUitThN+v
         9bHglfZMHe4scgotcxrovRZdRYMZUwWHhe0iX8qZNGvuoqaEN8Tvp1J7UAsWDugQENxW
         FAStR3oxkRhzTmYCzUJVcUWlE3EGRJb4FtuWyd1b6M4kWCQ8JYgCY/5cIRRcrwr9n/3e
         lA0Y8Iaz8m4BnBSy4ebRlE2koMb5KtmNFuZRW74iC0/ZoA+zUgLljl0SiNtOkglNPup6
         cesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=il1yIk46p3XJvX3l/iCGJYKMOJQDsOFZaHzkEJnhC4s=;
        b=SnncPatasVE9KHVzR8Qm0OMGpnfgdCS60qhW0DM7hIhgUuE3KJ6ouI4He1XonxTwsT
         I5YRVZeATVR0P+N66Pu7qlLelxcu1XeN0N6+fopUK+vyG6MeF9xLZXjkKCyEkG8Bvap+
         A+zvkvYV9Mt0vjYRtvu9sKPxXR0/07t3AJvxj0Rfi88gRTAMQWh3GZMbWnIsS25eogUn
         qyRPFe6KGwVE+LjWDtkKNj+cJTv2etJoP7myZgGNYGkHvPyTz0u6z2Mf8JdgQrt/Prok
         TrXGsSRYsA3KwOVwTv2MoAb9tRH/dEdrC+m/IJ5e4QtFYi+lR6EebfaHmQpTPNqF0D/t
         4w/w==
X-Gm-Message-State: AOAM533rTdZEK6+hqW+2OdIeo9rVOAt+JF1nWkmPkAkTIy68zL3lTwRX
        TOA/Z0qYjq99ka+FrVH/JYc=
X-Google-Smtp-Source: ABdhPJzhi0NyuKsSrjL5UsR5Pm0H4x173l7Ah+PDgzXqIso2NXSwu3FUoCGjvRK7wUSBnGn0vtdXLw==
X-Received: by 2002:a05:6000:18c2:: with SMTP id w2mr9680891wrq.282.1628242809760;
        Fri, 06 Aug 2021 02:40:09 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l2sm8846032wru.67.2021.08.06.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:40:09 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Mathias Steiger <mathias.steiger@googlemail.com>
Subject: [PATCH] drm/meson: fix colour distortion from HDR set during vendor u-boot
Date:   Fri,  6 Aug 2021 09:40:05 +0000
Message-Id: <20210806094005.7136-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the OSD1 HDR registers so meson DRM can handle the HDR
properties set by Amlogic u-boot on G12A and newer devices which result
in blue/green/pink colour distortion to display output.

This takes the original patch submissions from Mathias [0] and [1] with
corrections for formatting and the missing description and attribution
needed for merge.

[0] https://lore.kernel.org/linux-amlogic/59dfd7e6-fc91-3d61-04c4-94e078a3188c@baylibre.com/T/
[1] https://lore.kernel.org/linux-amlogic/CAOKfEHBx_fboUqkENEMd-OC-NSrf46nto+vDLgvgttzPe99kXg@mail.gmail.com/T/#u

Fixes: 728883948b0d ("drm/meson: Add G12A Support for VIU setup")
Suggested-by: Mathias Steiger <mathias.steiger@googlemail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Neil Armstrong<narmstrong@baylibre.com>
Tested-by: Philip Milev <milev.philip@gmail.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 5 +++++
 drivers/gpu/drm/meson/meson_viu.c       | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 446e7961da48..0f3cafab8860 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -634,6 +634,11 @@
 #define VPP_WRAP_OSD3_MATRIX_PRE_OFFSET2 0x3dbc
 #define VPP_WRAP_OSD3_MATRIX_EN_CTRL 0x3dbd
 
+/* osd1 HDR */
+#define OSD1_HDR2_CTRL 0x38a0
+#define OSD1_HDR2_CTRL_VDIN0_HDR2_TOP_EN       BIT(13)
+#define OSD1_HDR2_CTRL_REG_ONLY_MAT            BIT(16)
+
 /* osd2 scaler */
 #define OSD2_VSC_PHASE_STEP 0x3d00
 #define OSD2_VSC_INI_PHASE 0x3d01
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index aede0c67a57f..259f3e6bec90 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -425,9 +425,14 @@ void meson_viu_init(struct meson_drm *priv)
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
 	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
 		meson_viu_load_matrix(priv);
-	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
+	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
 		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
 					       true);
+		/* fix green/pink color distortion from vendor u-boot */
+		writel_bits_relaxed(OSD1_HDR2_CTRL_REG_ONLY_MAT |
+				OSD1_HDR2_CTRL_VDIN0_HDR2_TOP_EN, 0,
+				priv->io_base + _REG(OSD1_HDR2_CTRL));
+	}
 
 	/* Initialize OSD1 fifo control register */
 	reg = VIU_OSD_DDR_PRIORITY_URGENT |
-- 
2.17.1

