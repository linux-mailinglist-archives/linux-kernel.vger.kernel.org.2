Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2080B4201BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJCNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:35:42 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:58370 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhJCNfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:35:39 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3C059C1D331;
        Sun,  3 Oct 2021 15:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633268031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pvs0gicvaFyjP0hgJFa4i9LD8zRmZXhHgPSJ+metaAA=;
        b=qnlJoFp1jMQf9wtsbzgdJNsdwr4ft+1mmVuJBbcAVgj4g8ipd69gOVCqEOGbve2+0Isgzd
        5Q1crBrU7yFgqpsSyYXNXUM3sx8T2mHEAgK9TioGuIAbrUwUzGYqUe/af97g50X5bt2XIe
        3qrAH/UG71ajpOp89NxLS1zIxZfN8jA=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (asus_wmi_sensors) add Pro WS X570-ACE
Date:   Sun,  3 Oct 2021 15:33:44 +0200
Message-Id: <20211003133344.9036-4-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003133344.9036-1-oleksandr@natalenko.name>
References: <20211003133344.9036-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS Pro WS X570-ACE also supports accessing sensor information from the
embedded controller via BREC WMI method. Hence, add it to the list.

Note `T_Sensor` is not supported by this board.

Tested by me on this hardware:

```
Base Board Information
    Manufacturer: ASUSTeK COMPUTER INC.
    Product Name: Pro WS X570-ACE

BIOS Information
    Vendor: American Megatrends Inc.
    Version: 3801
    Release Date: 07/30/2021
```

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/hwmon/asus_wmi_sensors.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 98e761861601..319c879624b2 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -35,6 +35,7 @@
 #define ASUS_EC_KNOWN_EC_REGISTERS 14
 
 enum asus_wmi_ec_board {
+	BOARD_PW_X570_A, // Pro WS X570-ACE
 	BOARD_R_C8H, // ROG Crosshair VIII Hero
 	BOARD_R_C8DH, // ROG Crosshair VIII Dark Hero
 	BOARD_R_C8F, // ROG Crosshair VIII Formula
@@ -44,6 +45,7 @@ enum asus_wmi_ec_board {
 
 /* boards with EC support */
 static const char *const asus_wmi_ec_boards_names[] = {
+	[BOARD_PW_X570_A] = "Pro WS X570-ACE",
 	[BOARD_R_C8H] = "ROG CROSSHAIR VIII HERO",
 	[BOARD_R_C8DH] = "ROG CROSSHAIR VIII DARK HERO",
 	[BOARD_R_C8F] = "ROG CROSSHAIR VIII FORMULA",
@@ -130,6 +132,7 @@ static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int boar
 	ec->nr_registers = 0;
 
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_B550_E_G:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
@@ -161,6 +164,7 @@ static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int boar
 	}
 
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
 	case BOARD_R_C8DH:
@@ -174,6 +178,7 @@ static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int boar
 	}
 
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
 	case BOARD_R_C8F:
-- 
2.33.0

