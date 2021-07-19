Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA43CDD92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbhGSO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344043AbhGSOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:39:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 994E9610A5;
        Mon, 19 Jul 2021 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626708023;
        bh=0h2qSmuEsCssLFk/1RU6+0pu9TVerLTrCLKPhf+uXW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rehk7oVzaA1egC1XUr2JbPhdu2rFTmvZTj/BkqWOvg2eVxH3q+UiyDnLm/EOPIHe3
         VcUeWu4OHgt3vUYlgrIaIGmeBnoBemVu49EHDFCxxsD45VV5VqVceXQ20xrs8NERcQ
         dm0bnuo8fVFjNMT5osklEVSoGisDEUARFyz4v7oM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Duong <qhuyduong@hotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 143/315] eeprom: idt_89hpesx: Put fwnode in matching case during ->probe()
Date:   Mon, 19 Jul 2021 16:50:32 +0200
Message-Id: <20210719144947.592438358@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144942.861561397@linuxfoundation.org>
References: <20210719144942.861561397@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit 3f6ee1c095156a74ab2df605af13020f1ce3e600 ]

device_get_next_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: db15d73e5f0e ("eeprom: idt_89hpesx: Support both ACPI and OF probing")
Cc: Huy Duong <qhuyduong@hotmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20210607221757.81465-1-andy.shevchenko@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/idt_89hpesx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 34a5a41578d7..b972b5425654 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1165,6 +1165,7 @@ static void idt_get_fw_data(struct idt_89hpesx_dev *pdev)
 	else /* if (!fwnode_property_read_bool(node, "read-only")) */
 		pdev->eero = false;
 
+	fwnode_handle_put(fwnode);
 	dev_info(dev, "EEPROM of %d bytes found by 0x%x",
 		pdev->eesize, pdev->eeaddr);
 }
-- 
2.30.2



