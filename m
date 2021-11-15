Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F354244FD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhKODVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:21:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51424 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236388AbhKODVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:21:13 -0500
X-UUID: c0b6b98dd21a4ca89533323ab4fab714-20211115
X-UUID: c0b6b98dd21a4ca89533323ab4fab714-20211115
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1022509215; Mon, 15 Nov 2021 11:18:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Nov 2021 11:18:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Nov 2021 11:18:15 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        <james.hsu@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] arm64: update compiler option for PAC
Date:   Mon, 15 Nov 2021 11:18:08 +0800
Message-ID: <20211115031810.29701-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We pass -mbranch-protection=pac-ret+leaf to support PAC
when we use GCC 9 or later.

Before GCC 9, we pass -msign-return-address=all to support
PAC.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 Documentation/arm64/pointer-authentication.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
index f127666ea3a8..055d08b0d42d 100644
--- a/Documentation/arm64/pointer-authentication.rst
+++ b/Documentation/arm64/pointer-authentication.rst
@@ -54,8 +54,10 @@ virtual address size configured by the kernel. For example, with a
 virtual address size of 48, the PAC is 7 bits wide.
 
 Recent versions of GCC can compile code with APIAKey-based return
-address protection when passed the -msign-return-address option. This
-uses instructions in the HINT space (unless -march=armv8.3-a or higher
+address protection when passed compiler option as following.
+Pass -msign-return-address when we use GCC 7, 8.
+Pass -mbranch-protection when we use GCC 9 or later.
+This uses instructions in the HINT space (unless -march=armv8.3-a or higher
 is also passed), and such code can run on systems without the pointer
 authentication extension.
 
-- 
2.18.0

