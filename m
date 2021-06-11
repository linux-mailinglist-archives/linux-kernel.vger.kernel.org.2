Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098EF3A3B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFKF3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:29:08 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41514 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFKF3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:29:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 7198A44437;
        Fri, 11 Jun 2021 07:27:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id caN4VxDcJrYw; Fri, 11 Jun 2021 07:27:00 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 074AD44439;
        Fri, 11 Jun 2021 07:26:57 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v9 5/5] nvmem: eeprom: add documentation of sysfs fram and sernum file
Date:   Fri, 11 Jun 2021 07:26:52 +0200
Message-Id: <20210611052652.7894-6-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
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
v9: rewritten description
---
 .../ABI/testing/sysfs-class-spi-eeprom        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
new file mode 100644
index 000000000000..4e69c78f9f65
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
@@ -0,0 +1,20 @@
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
+Date:		May 2021
+KernelVersion:	5.14
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+	Contains the serial number of the Cypress FRAM (FM25VN) if it is
+	present.  It will be displayed as a 8 byte hex string, as read
+	from the device.
+
+	This is a read-only attribute.
+
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+	Contains the FRAM binary data. Same as EEPROM, just another file
+	name to indicate that it employs ferroelectric process.
+	It performs write operations at bus speed - no write delays, capable
+	of 10^14 read/write cycles and 151 years data retention.
-- 
2.25.1

