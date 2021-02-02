Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8701630B5B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhBBDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:12:36 -0500
Received: from m12-13.163.com ([220.181.12.13]:52247 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhBBDMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Cji7oSzyKe67daVk01
        PEDpKLrCo8AcrW98u7b54FyH4=; b=bwxuRgEvQxt+Fa8HJ2tDDSa/vrr1xuXOnj
        u1dcNOwz0J658M3fs7fYkLXg/nUdN22YqRTpv6pfmLKfKDAa0Wbu5nUowdUdDU5h
        jD6/cdGeyI488vaGb+M5D+3CuLiXNgYHdLEcm1byw35yuWykSuMTWVHNZONSrZQV
        g7P9JRum8=
Received: from zhongjupeng.ccdomain.com (unknown [119.137.52.221])
        by smtp9 (Coremail) with SMTP id DcCowADXxCnltxhgREHedQ--.124S2;
        Tue, 02 Feb 2021 10:24:39 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Subject: [PATCH v2] Bluetooth: btusb: Fix typo and correct the log print
Date:   Tue,  2 Feb 2021 10:24:43 +0800
Message-Id: <20210202022443.33228-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: DcCowADXxCnltxhgREHedQ--.124S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1ktry7tw1xuF1UKr15Arb_yoWkWrg_u3
        48ur1xXFy8CF1kCF12gwsFgry0k345ZFn7ur12q345uryqgr47AryUu3sYqFsxu3ZY9F92
        kw15Wrs2kw1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0YsjUUUUUU==
X-Originating-IP: [119.137.52.221]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/1tbiWActFFuHvbQ46wAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jupeng Zhong <zhongjupeng@yulong.com>

Change "deivice" to "device"

Correct "Unsupported support hardware variant (%08x)" to
"Unsupported hardware variant (%08x)"

Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bc5abaa00be5..e1dbbed2230d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3465,7 +3465,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
-		/* Tell deivice the position in sequence */
+		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
 			flag = 3;
 		else if (fw_size < fw->size - 30)
@@ -3589,7 +3589,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		fwname = FIRMWARE_MT7668;
 		break;
 	default:
-		bt_dev_err(hdev, "Unsupported support hardware variant (%08x)",
+		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
 			   dev_id);
 		return -ENODEV;
 	}
-- 
1.9.1


