Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAC4201BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhJCNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:35:40 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:58370 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhJCNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:35:38 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B3138C1D330;
        Sun,  3 Oct 2021 15:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633268029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQKuABLR4Mn/ar6D6NiB5Z9dVycXSPE1KmvSEI66q50=;
        b=Mw9KgNn5HUX/OLo99e4/BnF6cHKlqjqxB8Ybh3/TOX8sGavjxjgHW00C1xqqT+na6fol6w
        tKUb28qq76cJeKwKKdur48pA9hi0rEmSgFteqy2yxp6fgd1CD2J2I71ubRUdObVjPW9wNE
        p8eA/tIqtEfCKSnD3Hn251mwgjE0AA4=
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
Subject: [PATCH 2/3] hwmon: (asus_wmi_sensors) split out T_Sensor
Date:   Sun,  3 Oct 2021 15:33:43 +0200
Message-Id: <20211003133344.9036-3-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003133344.9036-1-oleksandr@natalenko.name>
References: <20211003133344.9036-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move `T_Sensor` addition into a separate `case` statement in preparation
for the next patch that introduces a board without it.

No functional change.

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/hwmon/asus_wmi_sensors.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 6b04fad18891..98e761861601 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -144,14 +144,22 @@ static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int boar
 		asus_wmi_ec_set_sensor_info(si++, "Motherboard", hwmon_temp,
 					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3C),
 					    &ec->nr_registers);
-		asus_wmi_ec_set_sensor_info(si++, "T_Sensor", hwmon_temp,
-					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3D),
-					    &ec->nr_registers);
 		asus_wmi_ec_set_sensor_info(si++, "VRM", hwmon_temp,
 					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3E),
 					    &ec->nr_registers);
 	}
 
+	switch (board) {
+	case BOARD_RS_B550_E_G:
+	case BOARD_RS_X570_E_G:
+	case BOARD_R_C8H:
+	case BOARD_R_C8DH:
+	case BOARD_R_C8F:
+		asus_wmi_ec_set_sensor_info(si++, "T_Sensor", hwmon_temp,
+					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3D),
+					    &ec->nr_registers);
+	}
+
 	switch (board) {
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
-- 
2.33.0

