Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23E447875
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhKHCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:19:11 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:46016 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKHCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:19:10 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Nov 2021 21:19:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7z1K0
        sPc2NW3ADD5fllk4cazdNDAgk9u0Mox0gqXvXI=; b=B3N6oWhMAJSqc6BtcJ5sQ
        zp1W7m8OWMSl8dc3ik7cdzc6IhvO0IWhqvCpnzV05tQSVlTq9+cq7ucHc0wbQiIb
        9hD+PBdhFC59V3c/d/UuKV/JoJrys03KfyzX+5HfIJ5nzZKO9aqqV4HdSNWLjyvG
        N/GIif1A9MUXYECdN0DQOY=
Received: from fedora.lenovo.com (unknown [103.30.235.251])
        by smtp3 (Coremail) with SMTP id G9xpCgD3jVazhIhhPgoJPw--.10083S2;
        Mon, 08 Nov 2021 10:00:21 +0800 (CST)
From:   Jimmy Wang <jimmy221b@163.com>
To:     -Linux-PC-SW@lenovo.com
Cc:     jimmy221b@163.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Add support for dual fan control
Date:   Mon,  8 Nov 2021 10:00:16 +0800
Message-Id: <20211108020016.4508-1-jimmy221b@163.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgD3jVazhIhhPgoJPw--.10083S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFykZF15KFyUXw4UCrW8tFb_yoWDAFc_C3
        Z8WFs2yF95K3909r1UKrnavry2qr9rXw1kGw47Xa43Gr95XF4xZw1jkFyfJFy3ZFnI9a4D
        Zr15XF1jkry5tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRksqtUUUUU==
X-Originating-IP: [103.30.235.251]
X-CM-SenderInfo: 5mlpz5assruqqrwthudrp/xtbBZBNFAlQHPCVR8gAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   This adds dual fan control for P1 / X1 Extreme Gen4

Signed-off-by: Jimmy Wang <jimmy221b@163.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c632df734bb..eb201d001075 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8766,6 +8766,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (1st gen) */
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
 	TPACPI_Q_LNV3('N', '2', 'V', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (3nd gen) */
+	TPACPI_Q_LNV3('N', '4', '0', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (4nd gen) */
 	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
 	TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),	/* X1 Carbon (9th gen) */
 };
-- 
2.31.1

