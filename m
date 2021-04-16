Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA16361D83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbhDPJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:33:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50812 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241846AbhDPJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:32:59 -0400
X-UUID: 542ecd2361ec4b18807be65b8aa7aa9c-20210416
X-UUID: 542ecd2361ec4b18807be65b8aa7aa9c-20210416
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 11946504; Fri, 16 Apr 2021 17:32:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 17:32:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 17:32:30 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable MediaTek DRAMC common driver
Date:   Fri, 16 Apr 2021 17:32:18 +0800
Message-ID: <1618565538-6972-5-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 13DF5259ACF754A1C8355D8857F1BF498FD04F2B3C8B8E785D4E4A59B96A78172000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables MediaTek DRAMC common driver to be built
as a module by default for the ARM64 builds.

Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f63..49d7464 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1163,3 +1163,4 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_MTK_DRAMC=m
-- 
1.7.9.5

