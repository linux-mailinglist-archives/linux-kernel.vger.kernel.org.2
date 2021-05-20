Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA36138B3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhETQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:04:19 -0400
Received: from router.aksignal.cz ([62.44.4.214]:57582 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhETQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:03:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 3E7DB491C4;
        Thu, 20 May 2021 18:01:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id rlWh57sei_Wo; Thu, 20 May 2021 18:01:36 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 04DBC491C2;
        Thu, 20 May 2021 18:01:33 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v5 5/5] nvmem: eeprom: add documentation of sysfs sernum file
Date:   Thu, 20 May 2021 18:01:27 +0200
Message-Id: <20210520160127.51394-6-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
References: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added sysfs sernum file documentation.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v5: new
---
 Documentation/ABI/testing/sysfs-class-spi-eeprom | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
new file mode 100644
index 000000000000..4f063a97b735
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
@@ -0,0 +1,6 @@
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
+Date:		May 2021
+KernelVersion:	5.12.1
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+		Exports serial number of Cypress FRAM (FM25VN). 8 bytes as is in chip in hex string.
--
2.25.1

