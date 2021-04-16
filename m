Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4D361B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhDPIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhDPIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9DC061574;
        Fri, 16 Apr 2021 01:07:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so40798613ejc.10;
        Fri, 16 Apr 2021 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRa3Sz1jxpiHgGK3l0+BR6ViiX/+KtB8X1pc8tNr5BA=;
        b=hSxVTde4hzUJJ3kqcnitKIF5zKYI33+A1jwelnwAaGliSykDLhXD+MeIB0DjvkbYL5
         EHzzzpCSOCRqsGAdyNwnCxiXccSH5sWKkudvESxPUEDoiukverRspuXgthCBpsnEHXcH
         0Flk0FssVtyEDCvZvrbHNJ3AeF/w1qopkjXNY8vmGLTpbp0pkG8Cc3dqxarksPYOIg8y
         gGDsPhe7bQQS0WUsHK0T7Myzi94eHJaKSqkshFRkDRgPMi4ipYraCDaFKxdkRdPotW6T
         GCPtqWhXNfhcJz5fB4SLeuzX7ymzwB7Fjf0aL/0igVykGKZhZAZXi8aQdqcGT6+t0c5U
         4LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRa3Sz1jxpiHgGK3l0+BR6ViiX/+KtB8X1pc8tNr5BA=;
        b=OZsEADGPVJSOvxmmKl2yL9bwtjc1NGuSGziijCJL0oYqVK0FhZQnEctvZeZBRM73fo
         NWgAdWbqU7LXRZoyNpAkLWqDKMksrlIS7yutYgyT9wNi3PQ1Fe0hrtxX27tIC6w3hB5n
         uVMex+AhFCEO/8vyophJ+/SWiUAYidyJuENs8NoXJb1dYLgKAuOzxSESN7xwSeVZuWRZ
         3j1voCMuhD2uWAVaUfrSGmX0IXD/2txuE3JEzN9rEoBVQ14pyYmS3z7adXBDMn0NmnlB
         +XOleb4O7MwfwQp1vPbM3g59qU5cZ9lgGnF7HurRyEsnoc8GyU49FZxI5PeRxdzeKWKd
         SoCg==
X-Gm-Message-State: AOAM531q5Di7rWZ3FM7lhYB22rbRNbGAd6Sw761ab+r4+uldEl4SuXT6
        BxIsbNbLzClZzsJZWTQquyx2Q5eKUd2lmpkR
X-Google-Smtp-Source: ABdhPJwhQ9LYeaZP6fmhFtVDMudfv2gmkOGfFAQeKASDeImv5GzK+2otJvjyXH1knh6loPNP467/xg==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr7419568ejj.494.1618560457694;
        Fri, 16 Apr 2021 01:07:37 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:07:37 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/15] dt-bindings: add power-domain header for RK3568 SoCs
Date:   Fri, 16 Apr 2021 10:03:37 +0200
Message-Id: <20210416080342.18614-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
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

