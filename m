Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E806439E96E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFGWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:20:14 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:21561 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhFGWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:20:13 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 439cfaf6-c7de-11eb-9eb8-005056bdd08f;
        Tue, 08 Jun 2021 01:18:19 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huy Duong <qhuyduong@hotmail.com>
Subject: [PATCH v1 1/3] eeprom: idt_89hpesx: Put fwnode in matching case during ->probe()
Date:   Tue,  8 Jun 2021 01:17:55 +0300
Message-Id: <20210607221757.81465-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_get_next_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: db15d73e5f0e ("eeprom: idt_89hpesx: Support both ACPI and OF probing")
Cc: Huy Duong <qhuyduong@hotmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 81c70e5bc168..45a61a1f9e98 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1161,6 +1161,7 @@ static void idt_get_fw_data(struct idt_89hpesx_dev *pdev)
 	else /* if (!fwnode_property_read_bool(node, "read-only")) */
 		pdev->eero = false;
 
+	fwnode_handle_put(fwnode);
 	dev_info(dev, "EEPROM of %d bytes found by 0x%x",
 		pdev->eesize, pdev->eeaddr);
 }
-- 
2.32.0

