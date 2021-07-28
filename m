Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28B93D8B08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhG1JpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:45:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54428 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231743AbhG1JpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:45:04 -0400
X-UUID: 978d33e1012a4013bdb52d88f7ed94dd-20210728
X-UUID: 978d33e1012a4013bdb52d88f7ed94dd-20210728
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 275052168; Wed, 28 Jul 2021 17:45:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 17:44:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 17:44:59 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] arm64/cpufeature: Add an option for mte support
Date:   Wed, 28 Jul 2021 17:42:57 +0800
Message-ID: <20210728094302.9949-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Arm64 introduced mte to enforce memory protection but also increased
the system requirements, such as the additional tag memory and the
firmware control complexity. For the case of products with limited 
resouce or low-power environment, the requirements to support mte 
is unlikely reached. Hence, a solution for low-end devices is 
necessary. 

This patch Add an option for mte support. An parameter from system
is used to indicate its states for all requirements. If not, mte
is disabled both in kernel and userspace. 

=== Test ===
QEMU5.2 + mte

passed cmdline : "arm64_mte_not_support"
boot log:
...(skip)
[    0.000000] CPU features: detected: Memory Tagging Extension
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: MTE is disabled since system does not support.

Yee Lee (1):
  arm64/cpufeature: Add option to disable mte support

 arch/arm64/include/asm/cpufeature.h |  4 +++-
 arch/arm64/kernel/cpufeature.c      | 13 +++++++++++++
 arch/arm64/kernel/image-vars.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.18.0

