Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87039E1D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFGQOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:14:20 -0400
Received: from router.aksignal.cz ([62.44.4.214]:50678 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFGQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:14:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 4795C44415;
        Mon,  7 Jun 2021 18:12:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id gM5VKMylS0RI; Mon,  7 Jun 2021 18:12:08 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id A869A44417;
        Mon,  7 Jun 2021 18:12:05 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v8 5/5] nvmem: eeprom: add documentation of sysfs fram and sernum file
Date:   Mon,  7 Jun 2021 18:12:01 +0200
Message-Id: <20210607161201.223697-6-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added sysfs fram and sernum file documentation.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v5: new
v6: no change here
v7: no change here
v8: added fram file doc
---
 Documentation/ABI/testing/sysfs-class-spi-eeprom | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
new file mode 100644
index 000000000000..b41420fe1329
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
@@ -0,0 +1,13 @@
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
+Date:		May 2021
+KernelVersion:	5.13
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+		(RO) Exports serial number of Cypress FRAM (FM25VN). 8 bytes as is in chip in hex string.
+
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
+Date:		June 2021
+KernelVersion:	5.13
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+		(RW) FRAM data.
-- 
2.25.1

