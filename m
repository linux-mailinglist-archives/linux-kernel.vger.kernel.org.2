Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8035D3DBB57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhG3Oud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:50:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33458 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239453AbhG3OuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:50:11 -0400
X-UUID: ba832a4059454e1d80570db03fae8af3-20210730
X-UUID: ba832a4059454e1d80570db03fae8af3-20210730
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 520644903; Fri, 30 Jul 2021 22:50:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 22:49:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 22:50:00 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 0/1] arm64/cpufeature: Support optionally disable MTE
Date:   Fri, 30 Jul 2021 22:49:52 +0800
Message-ID: <20210730144957.30938-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

For some case of low-end devices with limited resources,
an option to disable MTE support is necessary.

This patch supoorts to override id-reg on the 
shadow capability via comandline and suppress MTE feature.

=== Test ===
QEMU5.2 + MTE
passed "arm64.nomte" in cmdline
boot log:
..(skip)
[    0.000000] CPU features: SYS_ID_AA64PFR1_EL1[11:8]: forced to 0

Changed since v3:
 - Add documentation text

Changed since v2:
 - Use id-reg override machanism to suppress feature.

Yee Lee (1):
  arm64/cpufeature: Optionally disable MTE via command-line

 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.18.0

