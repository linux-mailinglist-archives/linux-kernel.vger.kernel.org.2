Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F41442C89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKBLa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:30:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:27:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso30024783ybr.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5sNj/QMNumolMMKBSDqH1xGPUsCbMl4BcAinNLIbYXg=;
        b=VcO4Edxounpwoi+o3qO80QAHh3/I9FHDEEh2AYQDpy3BjUxtS6wbaU7yV+FC2T6bUA
         r/mEmzTMWXobeOCey3elwWdyP/W9dAvytqbEbMeBaykIb6Zpzz73sjPcgkocA0mVzR9h
         O8LXHV03WuWqYlxwu4HuyJpl6UMozUM1MGRmMOvNuPgZTtiiiwbuX8EuixDIu8uKa2em
         Lkm+E9Qv/N7phZYkwrMnUrrGmrM4rX8bt1GcB1JFE43+Y4s5K60vfqsJSl8eahy4e2SJ
         LY/AynJERtWfXG3STizwLCao8yQCVXJDqPHOrJxXf5z29N8rkaNgRDCd22+6oR2VA0AX
         bldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5sNj/QMNumolMMKBSDqH1xGPUsCbMl4BcAinNLIbYXg=;
        b=gvxPtGQ1Yne1K5FQh43xEk1TJxIE+bg33fyHl/7/IE8H7BvHZb2n6anMuLIbkGMHCS
         51tcjKdZG0Z5eu7V3JAG/FhftHfFbRPWeuIYOMpiQGYIXotMBma5VkTIS/fI2iTpiaIr
         iC06ExEUK9tZ7niL4pbpeZnsVdPFV/PDHKfwIwNXAhxizMixnjpbJlByG++9VZO5nGD2
         87RZBN/667mjFVxywpvc1nwE/Oyz4LNc1f+wm0kKxBsEL1aHftmuntFC4Cqkk/5dZBHb
         bcbat7WpUSZLpASVHr7m13zDUsYpOreB8iZ9aZABUA5LzQD3HPdhNR5qyqkMilDHZ/8C
         EMqg==
X-Gm-Message-State: AOAM530cokznQWgnd6bh7PYbmTaU1vQ2bTP0Kd0sz2GdjTYHvbOey7tf
        9CVnF0fhePAfbgGhuoH3W8VnONK02Pes
X-Google-Smtp-Source: ABdhPJyyBzQNUjoWuSZ3gyw7veG9oOSrnNzZtUmfTxbYxxCAoNEAILEzxY31ZTBCTXC7pnCkdJW78OTX/qIW
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:e184:a33f:252b:7530])
 (user=apusaka job=sendgmr) by 2002:a25:ada5:: with SMTP id
 z37mr7407492ybi.93.1635852470289; Tue, 02 Nov 2021 04:27:50 -0700 (PDT)
Date:   Tue,  2 Nov 2021 19:27:44 +0800
Message-Id: <20211102192742.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] Bluetooth: Fix receiving HCI_LE_Advertising_Set_Terminated event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This event is received when the controller stops advertising,
specifically for these three reasons:
(a) Connection is successfully created (success).
(b) Timeout is reached (error).
(c) Number of advertising events is reached (error).
(*) This event is NOT generated when the host stops the advertisement.
Refer to the BT spec ver 5.3 vol 4 part E sec 7.7.65.18. Note that the
section was revised from BT spec ver 5.0 vol 2 part E sec 7.7.65.18
which was ambiguous about (*).

Some chips (e.g. RTL8822CE) send this event when the host stops the
advertisement with status = HCI_ERROR_CANCELLED_BY_HOST (due to (*)
above). This is treated as an error and the advertisement will be
removed and userspace will be informed via MGMT event.

On suspend, we are supposed to temporarily disable advertisements,
and continue advertising on resume. However, due to the behavior
above, the advertisements are removed instead.

This patch returns early if HCI_ERROR_CANCELLED_BY_HOST is received.

Additionally, this patch also clear HCI_LE_ADV if there are no more
advertising instances after receiving other errors.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..84db6b275231 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -566,6 +566,7 @@ enum {
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
+#define HCI_ERROR_CANCELLED_BY_HOST	0x44
 
 /* Flow control modes */
 #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b75a6cfeee..150b50677790 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5538,6 +5538,14 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	adv = hci_find_adv_instance(hdev, ev->handle);
 
+	/* Some chips (e.g. RTL8822CE) emit HCI_ERROR_CANCELLED_BY_HOST. This
+	 * event is being fired as a result of a hci_cp_le_set_ext_adv_enable
+	 * disable request, which will have its own callback and cleanup via
+	 * the hci_cc_le_set_ext_adv_enable path.
+	 */
+	if (ev->status == HCI_ERROR_CANCELLED_BY_HOST)
+		return;
+
 	if (ev->status) {
 		if (!adv)
 			return;
@@ -5546,6 +5554,10 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remove_adv_instance(hdev, ev->handle);
 		mgmt_advertising_removed(NULL, hdev, ev->handle);
 
+		/* If we are no longer advertising, clear HCI_LE_ADV */
+		if (list_empty(&hdev->adv_instances))
+			hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
 		return;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

