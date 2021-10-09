Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CA4277BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhJIG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 02:29:48 -0400
Received: from mx22.baidu.com ([220.181.50.185]:37282 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbhJIG3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 02:29:46 -0400
Received: from BC-Mail-Ex11.internal.baidu.com (unknown [172.31.51.51])
        by Forcepoint Email with ESMTPS id 4CB682003571ECDC9FB2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 14:27:39 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex11.internal.baidu.com (172.31.51.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 9 Oct 2021 14:27:38 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 9 Oct 2021 14:27:38 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update the devicetree documentation path of hyperbus
Date:   Sat, 9 Oct 2021 14:27:39 +0800
Message-ID: <20211009062740.833-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the devicetree documentation path
to "Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml"
since 'cypress,hyperflash.txt' and 'ti,am654-hbmc.txt' have
been converted to 'ti,am654-hbmc.yaml'.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b255cf4fca8..48949cd7f898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8783,8 +8783,7 @@ S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
-F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
-F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
-- 
2.25.1

