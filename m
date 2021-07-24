Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519553D478C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhGXLbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:31:49 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21343 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhGXLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627128729; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TkxNcp33Qo1o3YkgRHVXXEd38wAoht58fEHJ8D/pzVNjQqpUcI6Tsa8BwsQbcLTwdeEN4y8SfwIhA9XbrCTGepgiqoDnKTuUrvkAOci3P9mbKDHoIfKzvKk5kpjruPq4PrSBmE2RHjt/J+X7JP96pc/fX67Ue16rEx/0cvvXZHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627128729; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=s1ZOElL5PlMQFAPT7sSIX4ZWmY/6kPRg9rJaNGhBYQo=; 
        b=blLcQRmMbyNk9VonNF0RYZ9fI26op/u7NQ/0JaM3JA/DBskLH+EdpDuUnbBIhzX+4G5WXkQvHS/7KzlYahuOFvkZ5ckasFTYDHeaSxjMmseRI/Z5wCvutwCTtz1+OHYhOXjTQA507UCwjHBWYhoxaMIF2H50+vzza3znnL5pjXw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627128729;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=s1ZOElL5PlMQFAPT7sSIX4ZWmY/6kPRg9rJaNGhBYQo=;
        b=VlPDXasVXBAJXBvDxFVETsz/5C6Hb3LKP0n+uYjx7283rn8t2I+cNoHsmBWTnD9a
        z4TwF7rEcGjM+lv9WRwyuqvy3jrKfuDpGN2FrCBT617ioALcdCgu1uddYaReJUt+Bu7
        SexO9CIEsqOV0KSBWCc5Y8xZQvFyig2AkDsol5ng=
Received: from localhost.localdomain (106.51.107.3 [106.51.107.3]) by mx.zohomail.com
        with SMTPS id 1627128726692612.8318474852274; Sat, 24 Jul 2021 05:12:06 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Subject: [PATCH v7 2/2] firmware_loader: fix use-after-free in firmware_fallback_sysfs
Date:   Sat, 24 Jul 2021 17:41:34 +0530
Message-Id: <20210724121134.6364-3-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210724121134.6364-1-mail@anirudhrb.com>
References: <20210724121134.6364-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use-after-free happens when a fw_priv object has been freed but
hasn't been removed from the pending list (pending_fw_head). The next
time fw_load_sysfs_fallback tries to insert into the list, it ends up
accessing the pending_list member of the previoiusly freed fw_priv.

The root cause here is that all code paths that abort the fw load
don't delete it from the pending list. For example:

	_request_firmware()
	  -> fw_abort_batch_reqs()
	      -> fw_state_aborted()

To fix this, delete the fw_priv from the list in __fw_set_state() if
the new state is DONE or ABORTED. This way, all aborts will remove
the fw_priv from the list. Accordingly, remove calls to list_del_init
that were being made before calling fw_state_(aborted|done).

Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
list if it is already aborted. Instead, just jump out and return early.

Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/base/firmware_loader/fallback.c | 10 +++++++---
 drivers/base/firmware_loader/firmware.h |  6 +++++-
 drivers/base/firmware_loader/main.c     |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 1a48be0a030e..5d9f372fc9e7 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -91,10 +91,9 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
 	 * There is a small window in which user can write to 'loading'
 	 * between loading done and disappearance of 'loading'
 	 */
-	if (fw_sysfs_done(fw_priv))
+	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
 		return;
 
-	list_del_init(&fw_priv->pending_list);
 	fw_state_aborted(fw_priv);
 }
 
@@ -280,7 +279,6 @@ static ssize_t firmware_loading_store(struct device *dev,
 			 * Same logic as fw_load_abort, only the DONE bit
 			 * is ignored and we set ABORT only on failure.
 			 */
-			list_del_init(&fw_priv->pending_list);
 			if (rc) {
 				fw_state_aborted(fw_priv);
 				written = rc;
@@ -513,6 +511,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
+	if (fw_state_is_aborted(fw_priv)) {
+		mutex_unlock(&fw_lock);
+		retval = -EINTR;
+		goto out;
+	}
 	list_add(&fw_priv->pending_list, &pending_fw_head);
 	mutex_unlock(&fw_lock);
 
@@ -538,6 +541,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	} else if (fw_priv->is_paged_buf && !fw_priv->data)
 		retval = -ENOMEM;
 
+out:
 	device_del(f_dev);
 err_put_dev:
 	put_device(f_dev);
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 63bd29fdcb9c..36bdb413c998 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -117,8 +117,12 @@ static inline void __fw_state_set(struct fw_priv *fw_priv,
 
 	WRITE_ONCE(fw_st->status, status);
 
-	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
+	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED) {
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+		list_del_init(&fw_priv->pending_list);
+#endif
 		complete_all(&fw_st->completion);
+	}
 }
 
 static inline void fw_state_aborted(struct fw_priv *fw_priv)
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 4fdb8219cd08..68c549d71230 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -783,8 +783,10 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 		return;
 
 	fw_priv = fw->priv;
+	mutex_lock(&fw_lock);
 	if (!fw_state_is_aborted(fw_priv))
 		fw_state_aborted(fw_priv);
+	mutex_unlock(&fw_lock);
 }
 
 /* called from request_firmware() and request_firmware_work_func() */
-- 
2.26.2

