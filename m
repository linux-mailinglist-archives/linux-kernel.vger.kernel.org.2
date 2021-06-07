Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3C39E970
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:20:37 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:21657 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhFGWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:20:34 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 4819c7db-c7de-11eb-9eb8-005056bdd08f;
        Tue, 08 Jun 2021 01:18:27 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huy Duong <qhuyduong@hotmail.com>
Subject: [PATCH v1 2/3] eeprom: idt_89hpesx: Restore printing the unsupported fwnode name
Date:   Tue,  8 Jun 2021 01:17:56 +0300
Message-Id: <20210607221757.81465-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607221757.81465-1-andy.shevchenko@gmail.com>
References: <20210607221757.81465-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iterating over child firmware nodes restore printing the name of ones
that are not supported.

While at it, refactor loop body to clearly show that we stop at the first match.

Fixes: db15d73e5f0e ("eeprom: idt_89hpesx: Support both ACPI and OF probing")
Cc: Huy Duong <qhuyduong@hotmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 45a61a1f9e98..3e4a594c110b 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1126,11 +1126,10 @@ static void idt_get_fw_data(struct idt_89hpesx_dev *pdev)
 
 	device_for_each_child_node(dev, fwnode) {
 		ee_id = idt_ee_match_id(fwnode);
-		if (!ee_id) {
-			dev_warn(dev, "Skip unsupported EEPROM device");
-			continue;
-		} else
+		if (ee_id)
 			break;
+
+		dev_warn(dev, "Skip unsupported EEPROM device %pfw\n", fwnode);
 	}
 
 	/* If there is no fwnode EEPROM device, then set zero size */
-- 
2.32.0

