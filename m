Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B960E3426B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:16:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8EC061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:16:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id md1so13999700pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FUzDMOWW+Puyz+SzWC3asQVTMfryGObB0RiZstJMIBU=;
        b=sgWArQyN8QTzOSH9Gn+mPcH7CA0wlJw0WRwg9RtaZL0CGmB6vEB9B2qBK8dOqOBLrE
         3skODy2P8GXExoLvB11OLR8A9a9eFvmvUgfIWgqOGkbPRcOq6aSrF7bZIfbZffKqVe8X
         MV4r8sCleN+ffkVmElatTuxHqSKkCUVAChZjtZsZZPXL3GCY9/tvXL48MpImdKC2Rr8F
         fX7klLvLWWY2wpI6/HQj7ic0UPyHbIl3YWo9eZkxmyAdXeE9wAE8Mi2Ob/b3DF8bWm+A
         4+ByZfFIYh5/mdGmcierXQVxk+lJB640s3qszj3uMFrNqG+5AKak7AwLddg7rIY5JaJv
         vVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FUzDMOWW+Puyz+SzWC3asQVTMfryGObB0RiZstJMIBU=;
        b=WAdF3rnPQ5QafmAVapmEPJ2KfPYU8BYv0wPi3nhey7nw0DqHHwNm58PwFHvSRe5lHi
         5yPlUMdGONZkvSaz6TRG+UmyLvORXp2SP61tUtFoVjlk290L6aer79H06v1r7d3YCUHQ
         CWmUjBnhWe1nBuClKG7SudcXcXw+gB44mPAg1BLxRomRFUKkFKQP+aXLdEGHyzIeuaLJ
         V7VJGALAp+3t3ostRRlQncjbZ/NFuXLsZExDe6OdyFSOijkh13CNJld/fBPOrrCwYlG+
         swJ3sDIST4ogHoRyiVZZ3khShAsudOeAVnhhBOb7vh3eyKcPQjPbiPIvnJiRzfias+ba
         krcg==
X-Gm-Message-State: AOAM531Q+SDjZqkj9cHFNuRyCw0tTw6aadLeeL/gyCpe1eGdCcem2lei
        N6QenzbDbuCY8QpQxVOqa+TBtI1sFjqAaQ==
X-Google-Smtp-Source: ABdhPJykgo0zi/4qXykDAAUNOjL3usMtXpHDx4UnroLaxR58IPx0WFL9INya2Ev6KCQndsb9j63LruS1nXJlbg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:fc1f:aed6:24c0:a9b0])
 (user=mmandlik job=sendgmr) by 2002:a17:902:c589:b029:e6:3a39:d4a0 with SMTP
 id p9-20020a170902c589b02900e63a39d4a0mr16153501plx.76.1616184989509; Fri, 19
 Mar 2021 13:16:29 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:16:05 -0700
Message-Id: <20210319131533.v1.1.I14da3750a343d8d48921fffb7c6561337b6e6082@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v1] Bluetooth: Add ncmd=0 recovery handling
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During command status or command complete event, the controller may set
ncmd=3D0 indicating that it is not accepting any more commands. In such a
case, host holds off sending any more commands to the controller. If the
controller doesn't recover from such condition, host will wait forever.

This patch adds a timer when controller gets into such condition and
resets the controller if controller doesn't recover within the timeout
period.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---
Hello Maintainers,

We noticed that during suspend, sometimes the controller firmware gets
into a state where it is not accepting any more commands (it returns
ncmd=3D0 in Command Status):

< HCI Command: Disconnect (0x01|0x0006) plen 3 =C2=A0#398 [hci0] 83.760502
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Handle: 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Reason: Remote Device Terminated due to Power O=
ff (0x15)
> HCI Event: Command Status (0x0f) plen 4 =C2=A0 =C2=A0 =C2=A0 #399 [hci0] =
83.761694
=C2=A0 =C2=A0 =C2=A0 Disconnect (0x01|0x0006) ncmd 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)

In such a case, the host holds off sending any more packets to the
controller until it is ready to accept more commands.=C2=A0If the controlle=
r
doesn't recover from such a condition, Command Timeout does not get
triggered as Command Timeout is queued only once the packet is sent to
the controller; hence,=C2=A0the host will wait forever.=C2=A0

This patch adds a timer to recover from this condition. Since the
suspend timeout is 2 seconds, I'm using 4 seconds timeout to recover
from ncmd=3D0. This should give ample amount of time for recovery and
should not create any race conditions with the suspend. Once we resume
from the suspend normally, the timer would expire and reset the
controller. I have verified this patch locally and able to connect to
peer device after resume from suspend. Please let me know your thoughts
on this.

Thanks,
Manish.

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/hci_event.c        | 10 ++++++++++
 4 files changed, 27 insertions(+)

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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index ebdd4afe30d2..f14692b39fd5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -470,6 +470,7 @@ struct hci_dev {
 	struct delayed_work	service_cache;
=20
 	struct delayed_work	cmd_timer;
+	struct delayed_work	ncmd_timer;
=20
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0d9c36acc03..5ee1609456bd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2769,6 +2769,20 @@ static void hci_cmd_timeout(struct work_struct *work=
)
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
=20
+/* HCI ncmd timer function */
+static void hci_ncmd_timeout(struct work_struct *work)
+{
+	struct hci_dev *hdev =3D container_of(work, struct hci_dev,
+					    ncmd_timer.work);
+
+	bt_dev_err(hdev, "ncmd timeout");
+
+	if (hci_dev_do_close(hdev))
+		return;
+
+	hci_dev_do_open(hdev);
+}
+
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 bdaddr_type)
 {
@@ -3831,6 +3845,7 @@ struct hci_dev *hci_alloc_dev(void)
 	init_waitqueue_head(&hdev->suspend_wait_q);
=20
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
+	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
=20
 	hci_request_setup(hdev);
=20
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf2f4a0abdbd..114a9170d809 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3635,6 +3635,11 @@ static void hci_cmd_complete_evt(struct hci_dev *hde=
v, struct sk_buff *skb,
 	if (*opcode !=3D HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
=20
+	if (!ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		schedule_delayed_work(&hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
+	else
+		cancel_delayed_work(&hdev->ncmd_timer);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
 		atomic_set(&hdev->cmd_cnt, 1);
=20
@@ -3740,6 +3745,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev,=
 struct sk_buff *skb,
 	if (*opcode !=3D HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
=20
+	if (!ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		schedule_delayed_work(&hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
+	else
+		cancel_delayed_work(&hdev->ncmd_timer);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
 		atomic_set(&hdev->cmd_cnt, 1);
=20
--=20
2.31.0.rc2.261.g7f71774620-goog

