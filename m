Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4E447A73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 07:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhKHGZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 01:25:38 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:47594 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKHGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 01:25:36 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 01:25:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FEoyF
        yK0Y2A2s0C+O2tVCVwylGBDl+boBfszJIYTpLo=; b=mtmO2uSUsoLFzUDJaIAiN
        vhwBvXEE4sABszhX7dmNx+xoNpzF3Dhr1OgJNFld43AFxsOJwL8yHPh3Ej05xJdL
        ExR7LAURpYrB0DcVxbiEkpMixuTDqlv4dTGmea74qWZq00sFTweCdoxAr0qRmRd1
        gfZGGe6pDzVY0wnmty2xfY=
Received: from localhost.localdomain (unknown [112.97.49.251])
        by smtp4 (Coremail) with SMTP id HNxpCgD389R8vohhcXoPKw--.42409S2;
        Mon, 08 Nov 2021 14:06:54 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     hmh@hmh.eng.br, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     markpearson@lenovo.com, njoshi1@lenovo.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v3] Fix WWAN device disabled issue after S3 deep
Date:   Mon,  8 Nov 2021 14:06:48 +0800
Message-Id: <20211108060648.8212-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD389R8vohhcXoPKw--.42409S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUuF17Gr1rJFWxury7trb_yoW8ZFWkpF
        ZIkayIy3WDKw40qF1ayw4Uu3y3Cw4YkrW2gFZFk3WrXFWYgryrJ348tayfJF4UAry5JFsF
        vw18t3y8Aa90va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHVb9UUUUU=
X-Originating-IP: [112.97.49.251]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrR9FZF75cQVKwAAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When WWAN device wake from S3 deep, under thinkpad platform,
WWAN would be disabled. This disable status could be checked
by command 'nmcli r wwan' or 'rfkill list'.

Issue analysis as below:
  When host resume from S3 deep, thinkpad_acpi driver would
call hotkey_resume() function. Finnaly, it will use
wan_get_status to check the current status of WWAN device.
During this resume progress, wan_get_status would always
return off even WWAN boot up completely.
  In patch V2, Hans said 'sw_state should be unchanged
after a suspend/resume. It's better to drop the
tpacpi_rfk_update_swstate call all together from the
resume path'.
  And it's confimed by Lenovo that GWAN is no longer
 available from WHL generation because the design does not
 match with current pin control.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 50ff04c84650..f1cbd27282e1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1178,15 +1178,6 @@ static int tpacpi_rfk_update_swstate(const struct tpacpi_rfk *tp_rfk)
 	return status;
 }
 
-/* Query FW and update rfkill sw state for all rfkill switches */
-static void tpacpi_rfk_update_swstate_all(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < TPACPI_RFK_SW_MAX; i++)
-		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
-}
-
 /*
  * Sync the HW-blocking state of all rfkill switches,
  * do notice it causes the rfkill core to schedule uevents
@@ -3129,9 +3120,6 @@ static void tpacpi_send_radiosw_update(void)
 	if (wlsw == TPACPI_RFK_RADIO_OFF)
 		tpacpi_rfk_update_hwblock_state(true);
 
-	/* Sync sw blocking state */
-	tpacpi_rfk_update_swstate_all();
-
 	/* Sync hw blocking state last if it is hw-unblocked */
 	if (wlsw == TPACPI_RFK_RADIO_ON)
 		tpacpi_rfk_update_hwblock_state(false);
-- 
2.25.1

