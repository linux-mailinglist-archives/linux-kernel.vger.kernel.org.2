Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14233D9B95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 04:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhG2CH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 22:07:28 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56782 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233162AbhG2CH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 22:07:27 -0400
X-UUID: 6906614404ac48b2a75628a8be705c06-20210729
X-UUID: 6906614404ac48b2a75628a8be705c06-20210729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1630291173; Thu, 29 Jul 2021 10:07:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 10:07:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 10:07:20 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/1] Add option to disable mte support
Date:   Thu, 29 Jul 2021 10:07:11 +0800
Message-ID: <20210729020717.15142-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

For some case of low-end devices with limited resources,
an option to disable mte support is necessary.

This patch Adds an alias in id-reg override mechanism
to suppress the mte feature via passing a param.

=== Test ===
QEMU5.2 + mte
passed "arm64.nomte" in cmdline
boot log:
..(skip)
[    0.000000] CPU features: SYS_ID_AA64PFR1_EL1[11:8]: forced to 0

Changed since v2:
 - Use id-reg override machanism to suppress feature. 

Yee Lee (1):
  arm64/cpufeature: Add arm64.nomte to override id-reg

 arch/arm64/kernel/idreg-override.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.18.0

