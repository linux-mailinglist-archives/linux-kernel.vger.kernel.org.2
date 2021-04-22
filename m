Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE48B3685AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhDVRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:18:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC364C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:18:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a252f420000b02904ecfc17c803so9603165ybv.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ceNNIt0toACUZ6hPWo/h5uWqhVdPCc0ReJ6Q5pwq5Ak=;
        b=buRWJQbkifbcZCqnQh43B9eKhqL1ASVyKu88du/n/bk/B70T2S/U1yk16GHd+Yf362
         UC+39vZTN/0PoPS1RFQNJMWOH3DPtj/t3jSDukycpXZAfw0MHsQ00pUJU6P0AedmwadB
         hJSjfM8CzHA4oHINyWhcslNaVrrhvnyRrdF6g6pP9SsJIC4Jf+MXAwUQpAAAInUyvWhg
         F8cP2awTRXkbwcRiBAVMWQeQJDGJPNKKZ7yII/Vk2fRhRMVi2n+4MXoEzC57HoeFAl51
         oBVf6eFc6cKu5Ta2B4VFYTM4yZYrgSJRKPat6PWvRMuSFyZwqNh2Lew4qsOjxus6Eapk
         5CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ceNNIt0toACUZ6hPWo/h5uWqhVdPCc0ReJ6Q5pwq5Ak=;
        b=EmGVwXWZn0ikD/mYebR6jc1ouFZoV+w+tnfv8DdSaWvrzO1+/IrmizgOBXmcR+H96F
         kS1S4sPJcW4xGxzbw6JH9P7J0b/IBobW8Ijxa2SktX1Gih+CvCnH9hXbvHeXXIW0wd4A
         jm6IQ1BUg/+Bt+nl2R7WBYuXbD+bYmOb6XK07eX9f4Au+sdkL9BlG2D1Ps/GmaV373CF
         Ro0HtXvTY4dV2PVOJkhf29KgZ0++/dN7RgqMek7jDMdCI0pPpt8PhDIKch3aHwgI+/ie
         J2BxYCIwz4TJ8ilrsNDBSCM+JLFxotNIIaMy6FbRYsxx5PFdx+mNfedkGb1AcTw6dq5o
         yxhQ==
X-Gm-Message-State: AOAM533Q6jh5dnAloFJGJkhwnGbOSOX0pkc+E1GGedFZo93uPGHJuHy+
        jfDAkLmeDqIjejSyWhhjBaxfpo3mjMowoA==
X-Google-Smtp-Source: ABdhPJzaT75VXKKRmwcscRGaTf+mEVxHomDHDMYlXFBZ60+GAlmSG0kUwt4/f5sTYQ+4airpcnbwUEI0EFAgGg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cc:f48d:f53c:5718])
 (user=mmandlik job=sendgmr) by 2002:a25:b68a:: with SMTP id
 s10mr6461442ybj.121.1619111893854; Thu, 22 Apr 2021 10:18:13 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:17:53 -0700
Message-Id: <20210422101657.v3.1.I14da3750a343d8d48921fffb7c6561337b6e6082@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v3] Bluetooth: Add ncmd=0 recovery handling
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During command status or command complete event, the controller may set
ncmd=0 indicating that it is not accepting any more commands. In such a
case, host holds off sending any more commands to the controller. If the
controller doesn't recover from such condition, host will wait forever,
until the user decides that the Bluetooth is broken and may power cycles
the Bluetooth.

This patch triggers the hardware error to reset the controller and
driver when it gets into such state as there is no other wat out.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v3:
- Restructure ncmd_timer scheduling in hci_event.c
- Cancel delayed work in hci_dev_do_close
- Do not inject hw error during HCI_INIT
- Update comment, add log message while injecting hw error

Changes in v2:
- Emit the hardware error when ncmd=0 occurs

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 22 ++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 22 ++++++++++++++++++----
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ea4ae551c426..c4b0650fb9ae 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -339,6 +339,7 @@ enum {
 #define HCI_PAIRING_TIMEOUT	msecs_to_jiffies(60000)	/* 60 seconds */
 #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebdd4afe30d2..f14692b39fd5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -470,6 +470,7 @@ struct hci_dev {
 	struct delayed_work	service_cache;
 
 	struct delayed_work	cmd_timer;
+	struct delayed_work	ncmd_timer;
 
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0d9c36acc03..37789c5d0579 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1723,6 +1723,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	}
 
 	cancel_delayed_work(&hdev->power_off);
+	cancel_delayed_work(&hdev->ncmd_timer);
 
 	hci_request_cancel_all(hdev);
 	hci_req_sync_lock(hdev);
@@ -2769,6 +2770,24 @@ static void hci_cmd_timeout(struct work_struct *work)
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
+/* HCI ncmd timer function */
+static void hci_ncmd_timeout(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    ncmd_timer.work);
+
+	bt_dev_err(hdev, "Controller not accepting commands anymore: ncmd = 0");
+
+	/* No hardware error event needs to be injected if the ncmd timer
+	 * triggers during HCI_INIT.
+	 */
+	if (test_bit(HCI_INIT, &hdev->flags))
+		return;
+
+	/* This is an irrecoverable state, inject hardware error event */
+	hci_reset_dev(hdev);
+}
+
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 bdaddr_type)
 {
@@ -3831,6 +3850,7 @@ struct hci_dev *hci_alloc_dev(void)
 	init_waitqueue_head(&hdev->suspend_wait_q);
 
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
+	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
 
 	hci_request_setup(hdev);
 
@@ -4068,6 +4088,8 @@ int hci_reset_dev(struct hci_dev *hdev)
 	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 	skb_put_data(skb, hw_err, 3);
 
+	bt_dev_err(hdev, "Injecting HCI hardware error event");
+
 	/* Send Hardware Error to upper stack */
 	return hci_recv_frame(hdev, skb);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf2f4a0abdbd..8cd4bcf5dd00 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3635,8 +3635,15 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
-	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
-		atomic_set(&hdev->cmd_cnt, 1);
+	if (!test_bit(HCI_RESET, &hdev->flags)) {
+		if (ev->ncmd) {
+			cancel_delayed_work(&hdev->ncmd_timer);
+			atomic_set(&hdev->cmd_cnt, 1);
+		} else {
+			schedule_delayed_work(&hdev->ncmd_timer,
+					      HCI_NCMD_TIMEOUT);
+		}
+	}
 
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
@@ -3740,8 +3747,15 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
-	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
-		atomic_set(&hdev->cmd_cnt, 1);
+	if (!test_bit(HCI_RESET, &hdev->flags)) {
+		if (ev->ncmd) {
+			cancel_delayed_work(&hdev->ncmd_timer);
+			atomic_set(&hdev->cmd_cnt, 1);
+		} else {
+			schedule_delayed_work(&hdev->ncmd_timer,
+					      HCI_NCMD_TIMEOUT);
+		}
+	}
 
 	/* Indicate request completion if the command failed. Also, if
 	 * we're not waiting for a special event and we get a success
-- 
2.31.1.498.g6c1eba8ee3d-goog

