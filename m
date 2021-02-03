Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4F30D9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhBCMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:25:10 -0500
Received: from m12-14.163.com ([220.181.12.14]:49415 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbhBCMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZLt9b9zzfdToiBJj1R
        McWWmiemK2CuOhUaWdJukRiwM=; b=lOaluIUhjO3hlqtzAom2yBwCPvSssIDZw5
        JI2fN1TQcHQr0h1jbsAMRc1PsLqa8QTv1QAcd7IPcNFKYHGQcRsN08lIkHuKmOPF
        OzWq/M/h6rziYC6x3HgbEkIxt6RmrVna7FKMbroAGNSpKiI782LGxpdMxzUC0G79
        xrAvkKvaM=
Received: from zhongjupeng.ccdomain.com (unknown [119.137.55.230])
        by smtp10 (Coremail) with SMTP id DsCowACntYlrWRpgzhK0jA--.60S2;
        Wed, 03 Feb 2021 16:06:06 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Subject: [PATCH v3] Bluetooth: btusb: Fix typo and correct the log print
Date:   Wed,  3 Feb 2021 16:06:12 +0800
Message-Id: <20210203080612.36904-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: DsCowACntYlrWRpgzhK0jA--.60S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1ktrWUtr4kXrW3Kr45ZFb_yoW8JF1rpF
        ZxCFy5Cry3JF47KF17J3yvyrW5Jan8ua42kFWUA3s8ZFW5t3y8CFn5JFZ8W34I9FZxWaya
        ya1DXrW8Ka1kJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf0eQUUUUU=
X-Originating-IP: [119.137.55.230]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/xtbBog8uFFaD+u63FgAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jupeng Zhong <zhongjupeng@yulong.com>

Change "deivice" to "device"

Correct "Unsupported support hardware variant (%08x)" to
"Unsupported hardware variant (%08x)"

Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
---
v3: update bluetooth-next tree and regenerate the patch
v2: correct the log print and update the patch From: and Signed-off-by:
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b14102fba601..5064b1d79c79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3466,7 +3466,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
-		/* Tell deivice the position in sequence */
+		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
 			flag = 3;
 		else if (fw_size < fw->size - 30)
@@ -3590,7 +3590,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
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


