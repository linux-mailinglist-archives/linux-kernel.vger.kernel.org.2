Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC0362F97
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhDQLbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhDQLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0CC061761;
        Sat, 17 Apr 2021 04:30:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so45809514ejz.11;
        Sat, 17 Apr 2021 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRa3Sz1jxpiHgGK3l0+BR6ViiX/+KtB8X1pc8tNr5BA=;
        b=UxWpkQZTVCLbvHFEZEnU0eLmU9PmJkiTiGud3ua3H5TUUuDboNjUZU1wvVA9Vauvmz
         q8H5nlYTFr61FSWWW+oMxCErulReHvStoHZXm4a9YimMQNaMFV2kHzEj0DTkyPXnkHAM
         aG8ST760j6b7rSWPCEW/NFjHWltTsW3LLfDVhXBU0pDyp5fdovYsvpe8uoOlkuOsKYDn
         5VN4/KcYfAV8GAdB8nbSzQL30JFP4S3XPBZ7opVohHSabPWOGGy2gTETcOBQArrg5Mz4
         HrJhLIF8Ap914URwfnlUwLrPKVbQCNh2ESV5lxZr+9uD7A4u075V+9QNAS281h4I3Zbt
         Qq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRa3Sz1jxpiHgGK3l0+BR6ViiX/+KtB8X1pc8tNr5BA=;
        b=swcb5NzPqFfMpSKoba9dzVVoEncey4PkMR/QQFocUfR0z+uwJMw1ALHPb8bdjgwoyv
         4o3YOdm/y/ilYLMP3KtboG6eqgoLjLW/We0lMmf6bFa261dMSc6BW/+EUP/hAnAZFkMv
         b1T61icGrcFitGAjegMhbNGw6S8QaXTqDzJXfY9Bxjy5iWZ3DdrOf9QREYgtnMinEqji
         kGYcNeJsg4cKAnVUAFLtZjGYeqnuaTIHe6zTDtIG5bPnWY4cDO9IuqGCshPjaXbV5oFE
         37XeP2TG/edwk8PoLEpv9DGUkVHDFjVGpA2/kfXLq/p2ykoDIDrtuOdEaws8JJzO2mGg
         bw0Q==
X-Gm-Message-State: AOAM531qjKhDPZLvbGh4s13F8JBQUlWPnv9X5j0s0NlNDthsW4RgPaHi
        gO6WAOw4SVAeckC7z6Cfh9Q=
X-Google-Smtp-Source: ABdhPJz/BvHl5h8iOnTT71av4QuClNlMfDbXbT/HEfeUKCP98y5JB7MZ5urAlVG9xJOe1kslFYkC9w==
X-Received: by 2002:a17:906:c419:: with SMTP id u25mr13021703ejz.332.1618659014468;
        Sat, 17 Apr 2021 04:30:14 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/15] dt-bindings: add power-domain header for RK3568 SoCs
Date:   Sat, 17 Apr 2021 13:29:47 +0200
Message-Id: <20210417112952.8516-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

According to a description from TRM, add all the power domains

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/rk3568-power.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3568-power.h

diff --git a/include/dt-bindings/power/rk3568-power.h b/include/dt-bindings/power/rk3568-power.h
new file mode 100644
index 000000000..6cc1af1a9
--- /dev/null
+++ b/include/dt-bindings/power/rk3568-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_POWER_RK3568_POWER_H__
+#define __DT_BINDINGS_POWER_RK3568_POWER_H__
+
+/* VD_CORE */
+#define RK3568_PD_CPU_0		0
+#define RK3568_PD_CPU_1		1
+#define RK3568_PD_CPU_2		2
+#define RK3568_PD_CPU_3		3
+#define RK3568_PD_CORE_ALIVE	4
+
+/* VD_PMU */
+#define RK3568_PD_PMU		5
+
+/* VD_NPU */
+#define RK3568_PD_NPU		6
+
+/* VD_GPU */
+#define RK3568_PD_GPU		7
+
+/* VD_LOGIC */
+#define RK3568_PD_VI		8
+#define RK3568_PD_VO		9
+#define RK3568_PD_RGA		10
+#define RK3568_PD_VPU		11
+#define RK3568_PD_CENTER	12
+#define RK3568_PD_RKVDEC	13
+#define RK3568_PD_RKVENC	14
+#define RK3568_PD_PIPE		15
+#define RK3568_PD_LOGIC_ALIVE	16
+
+#endif
-- 
2.11.0

