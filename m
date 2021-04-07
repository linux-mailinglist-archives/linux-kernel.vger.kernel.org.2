Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C63561E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbhDGD3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:29:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38892 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348344AbhDGD3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:29:04 -0400
X-UUID: 6f7c191b6cfc4f7c9ab6082260065597-20210407
X-UUID: 6f7c191b6cfc4f7c9ab6082260065597-20210407
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1913985007; Wed, 07 Apr 2021 11:28:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:51 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 3/8] dt-bindings: apu: Add MT8192 APU power domain
Date:   Wed, 7 Apr 2021 11:28:01 +0800
Message-ID: <1617766086-5502-4-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create MT8192 APU power domain bindings.
Add top power domain id.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 include/dt-bindings/power/mt8192-apu-power.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8192-apu-power.h

diff --git a/include/dt-bindings/power/mt8192-apu-power.h b/include/dt-bindings/power/mt8192-apu-power.h
new file mode 100644
index 000000000000..b821bd4811a6
--- /dev/null
+++ b/include/dt-bindings/power/mt8192-apu-power.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8192_APU_POWER_H
+#define _DT_BINDINGS_POWER_MT8192_APU_POWER_H
+
+#define MT8192_POWER_DOMAIN_APUSYS_TOP	0
+
+#endif
-- 
2.18.0

