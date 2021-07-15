Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9263CA498
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGORjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:39:48 -0400
Received: from out28-170.mail.aliyun.com ([115.124.28.170]:36885 "EHLO
        out28-170.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGORjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:39:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4251755|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0177336-0.00103703-0.981229;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.KiGpPy7_1626370606;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.KiGpPy7_1626370606)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 16 Jul 2021 01:36:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org, daniel.lezcano@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com
Subject: [PATCH] dt-bindings: timer: Add ABIs for new Ingenic SoCs.
Date:   Fri, 16 Jul 2021 01:36:45 +0800
Message-Id: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add OST_CLK_EVENT_TIMER for new XBurst®1 SoCs.
2.Add OST_CLK_EVENT_TIMER0 to OST_CLK_EVENT_TIMER15 for new XBurst®2 SoCs.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 include/dt-bindings/clock/ingenic,sysost.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
index 063791b..d7aa42c 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -13,4 +13,23 @@
 #define OST_CLK_PERCPU_TIMER2	3
 #define OST_CLK_PERCPU_TIMER3	4
 
+#define OST_CLK_EVENT_TIMER		1
+
+#define OST_CLK_EVENT_TIMER0	0
+#define OST_CLK_EVENT_TIMER1	1
+#define OST_CLK_EVENT_TIMER2	2
+#define OST_CLK_EVENT_TIMER3	3
+#define OST_CLK_EVENT_TIMER4	4
+#define OST_CLK_EVENT_TIMER5	5
+#define OST_CLK_EVENT_TIMER6	6
+#define OST_CLK_EVENT_TIMER7	7
+#define OST_CLK_EVENT_TIMER8	8
+#define OST_CLK_EVENT_TIMER9	9
+#define OST_CLK_EVENT_TIMER10	10
+#define OST_CLK_EVENT_TIMER11	11
+#define OST_CLK_EVENT_TIMER12	12
+#define OST_CLK_EVENT_TIMER13	13
+#define OST_CLK_EVENT_TIMER14	14
+#define OST_CLK_EVENT_TIMER15	15
+
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
-- 
2.7.4

