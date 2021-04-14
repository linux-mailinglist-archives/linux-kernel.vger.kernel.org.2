Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25335FD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhDNVUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhDNVTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95397C061760;
        Wed, 14 Apr 2021 14:19:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z1so25421500edb.8;
        Wed, 14 Apr 2021 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z55R7ew9RrmSKfUTHbSEwYVWparxSnYf7XjT/Qh3Lhc=;
        b=N1o1pvV2iCE2a3kFZl3YOTR4PX8BQUpsJxX0GT20hTNld5JlWEVLQBBEeznqhVkdQM
         TPQjLKZiYyUit/faoox5r0BEciJErRg6Y17JVuhXjgjGWmpzaARE2YPP2FtVPJAeSfmd
         LD5y4r+vTuKjgSCOLFdUb+qyjUZRGydBOu5jlbi0QffxxlpgSKx1cBAj9bPUMLUlpr2/
         MRw97MWZN9b8a1oIDC4Mv2BQAFcO/vAWrkhQxGuB5LhLi0y8vf/BPr9KXGYRdKaZLTOo
         CrR0KjjT4KbN97nhdpN3H1ePtI9+4ks1Dvef1wQuQANb49mYMsuwCWXbA12+9cGfiM6v
         d2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z55R7ew9RrmSKfUTHbSEwYVWparxSnYf7XjT/Qh3Lhc=;
        b=nPXtaGJEeabxc5987ORUP16ya+BbebVLxGg1RoUhwDtHNl6QZFRchL1wTf/fdQV8h+
         gsSqS+sKMBGRUVUZcl+MNtJt9pY3fwJW5gqQWbq+nuHR+0MsRdwriFVdXeRXooV1wUvl
         kkgdkDM7lDpMLkWFRloqcHJvl2JONo+Tzz87unPGuS2GDoZgdNsGRCsX6y7rOH4K72mw
         4XO8I6y9HGp7Io6xEI0TUo8KnFsqsJnmAm4WzcqkfZA+U1qKb5KdTqsJj4EmP/mYV7Sc
         FKD3cxFppC54JHgz1nF3itJDwomJGp/1YDKE3hA1RmEcooalmK+8WsTFJ3wKvXUCJXkK
         AksA==
X-Gm-Message-State: AOAM531Exrvka+1qsJuvLMIF99kF/prgFRRdYk3LJB+O7kIe9j/M8i0k
        ptdVl5Uwr6ath+vXZWxq5is=
X-Google-Smtp-Source: ABdhPJzpuELtVpUNyBOZpoX7z2xjB0rRxkyFVN07R7UYqHcQdes7+16tCiBFNsJGGS3rlNKGtC0jMA==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr211586edb.343.1618435153439;
        Wed, 14 Apr 2021 14:19:13 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:13 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/11] dt-bindings: add power-domain header for RK3568 SoCs
Date:   Wed, 14 Apr 2021 23:18:53 +0200
Message-Id: <20210414211856.12104-9-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

According to a description from TRM, add all the power domains

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
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

