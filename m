Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C645D518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353159AbhKYHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349264AbhKYHID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:03 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:04:53 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id bp17-20020a05620a459100b0045e893f2ed8so5315998qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LOjoYmrd2S6QYfeGuru3HSevSjNWgVFTXSpO3QT/YXg=;
        b=FGL2CkoLOg+R2jSXT1T3bOqmdf3/3Y8avkIV20Y8yUu4PUzZ7ij1opTrjlAAfVYjRK
         07oX0qAi45Oitv5n3nYLPThHHtpAfIBnXzVXYBOpjuhu0BOvD+WAqxC3vgYgXFQyliEV
         JM+rlMrqyfyCW1BsiXD6hqe1QlsL7wqb2Imgzk595dwCUPC73ZsTBTspbZEEGVnQicAw
         /DZ1qu1DDcV2IShuNlHi4HMDRM12kleg357yihx68lKsNTzAR+g1aKUCOTcEiqR7U4Uq
         iLqEyRoCEOJEasMSAtp1x3D9d405S3LtQB8YsuxzraWTtf5UtgLW3a7hBOsyF7DHbXtR
         65hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LOjoYmrd2S6QYfeGuru3HSevSjNWgVFTXSpO3QT/YXg=;
        b=cnwVck7p7Z4VeqGWrPVzSSjZ0HrC7TCHnHLoJhk/kof8ZOqoui0MvsZ6uRdLAthIus
         7jP174HeA6w0j5+EL1ZqlLKmO6HI8HsAy+9PvdsAnQkBU4T5eYDQX8jmJeuGWLeSQaS3
         yMeVGapLMqI11uv2mSMbEKzzYEg51NrxL2HpjYH4TjZDLic3sStCYwREhGUI7U+GeLq9
         UtKV/XK1MAEJncYVDXhFjsIE7tTISOrsr7BclJhYU7ZSrGCHfUOM6ewheNek6dqQN/h7
         QilvPJmaZkklAT+D8wiGzgYENBof1SJL9SQ4kFRIwO9OAEXP32qOmbPk4dA2nzh8HoKa
         hClA==
X-Gm-Message-State: AOAM532zAyig4FEDWbxlQfnvzojL69GP2jbUcD1jlED4aBu36+1p5Q+Z
        Al0F6bjtQKD9MyDJpbAKEuG7HV2CG10F
X-Google-Smtp-Source: ABdhPJxrZkvFBF8UzSG087ddSILKyfHI0bTUOavkbLwrv0kJQXY20qxGd/pf3GIjeaM25NHjRTGxvQoMMq9M
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:ac8:5b90:: with SMTP id
 a16mr14348096qta.300.1637823892177; Wed, 24 Nov 2021 23:04:52 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:04:37 +0800
In-Reply-To: <20211125150430.v3.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
Message-Id: <20211125150430.v3.2.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid>
Mime-Version: 1.0
References: <20211125150430.v3.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 2/2] Bluetooth: Limit duration of Remote Name Resolve
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When doing remote name request, we cannot scan. In the normal case it's
OK since we can expect it to finish within a short amount of time.
However, there is a possibility to scan lots of devices that
(1) requires Remote Name Resolve
(2) is unresponsive to Remote Name Resolve
When this happens, we are stuck to do Remote Name Resolve until all is
done before continue scanning.

This patch adds a time limit to stop us spending too long on remote
name request.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v3:
* Add units in comment
* change debug log to warn

 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_event.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2560cfe80db8..742cde106ae3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -88,6 +88,7 @@ struct discovery_state {
 	u8			(*uuids)[16];
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
+	unsigned long		name_resolve_timeout;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -1759,6 +1760,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_FAST_ADV_INT_MIN	0x00A0	/* 100 msec */
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
 
+#define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* 10.24 sec */
+
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb4c04aecccf..779c70b21039 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2129,6 +2129,12 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
 	if (list_empty(&discov->resolve))
 		return false;
 
+	/* We should stop if we already spent too much time resolving names. */
+	if (time_after(jiffies, discov->name_resolve_timeout)) {
+		bt_dev_warn_ratelimited(hdev, "Name resolve takes too long.");
+		return false;
+	}
+
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
 	if (!e)
 		return false;
@@ -2716,6 +2722,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (e && hci_resolve_name(hdev, e) == 0) {
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
+		discov->name_resolve_timeout = jiffies + NAME_RESOLVE_DURATION;
 	} else {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-- 
2.34.0.rc2.393.gf8c9666880-goog

