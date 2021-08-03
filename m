Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016A23DE702
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhHCHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:08:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52360 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234055AbhHCHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:08:43 -0400
X-UUID: 957638fef2044e9c9e6c04fa6efe2b9d-20210803
X-UUID: 957638fef2044e9c9e6c04fa6efe2b9d-20210803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2072926632; Tue, 03 Aug 2021 15:08:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 15:08:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 15:08:27 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 0/1] arm64/cpufeature: Support optionally disable MTE
Date:   Tue, 3 Aug 2021 15:08:21 +0800
Message-ID: <20210803070824.7586-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

An option in runtime to disable MTE support is necessary for some
scenarios such as HW issue workaround, FW tests and 
some evaluation works in performance and resoruce costs.
 
This patch supoorts to override id-reg on the
shadow capability via comandline and suppress MTE feature.

SCTLR_EL1.ATA/ATA0 setting is moved to cpu_enable_mte()
since they are not allowed to be cache TLB.

All works in this patch turn off related software support,
but not fully disable MTE in HW side.

=== Test ===
QEMU5.2 + MTE

(1) normal boot
MTE feature is enabled and HW-tags KASAN works.

(2) passed "arm64.nomte" in cmdline
boot log:
..(skip)
[    0.000000] CPU features: SYS_ID_AA64PFR1_EL1[11:8]: forced to 0

====
Changed since v4:
 - Move ATA/ATA0 setting to cpu_enable_mte()

Changed since v3:
 - Add documentation text

Changed since v2:
 - Use id-reg override machanism to suppress feature.

Yee Lee (1):
  arm64/cpufeature: Optionally disable MTE via command-line

 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/include/asm/sysreg.h                 | 3 +--
 arch/arm64/kernel/cpufeature.c                  | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.18.0

