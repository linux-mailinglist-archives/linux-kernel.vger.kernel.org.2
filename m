Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261D42D7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJNLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:08:29 -0400
Received: from mx24.baidu.com ([111.206.215.185]:40316 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230080AbhJNLI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:08:28 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id 4D3DF440CDEFBF783E64;
        Thu, 14 Oct 2021 19:06:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 14 Oct 2021 19:06:20 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 14 Oct 2021 19:06:20 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] MAINTAINERS: Update the devicetree documentation path of hyperbus
Date:   Thu, 14 Oct 2021 19:06:14 +0800
Message-ID: <20211014110614.3320-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex16.internal.baidu.com (172.31.51.56) To
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
*resend +Cc others.

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

