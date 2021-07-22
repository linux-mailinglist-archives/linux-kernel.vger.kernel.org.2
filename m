Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105AA3D235E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhGVLwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:52:31 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21363 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGVLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:52:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626957183; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gRm5bm2cag8w8OD/e5FJhLJTBQLDcNcg+MqacxTvqhHR99CIp759Xm9CLmoKcAvKT16CQHP3QBmnun88iPxHe2L63qBTL8FbTmXsoxNr0D9NYDvfcpgXKiIWcgsEScXtj0robpgNiHAMPxe9oKKiMlJSFA4nn9cQVO7agBu/Wlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626957183; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Gyg89njZgFgQ1j3+NrNVlyyxcJ1gJLkq604iZkQMAgQ=; 
        b=lsnCx5H6b2igDlPmy1w9c59/9LqH1ZAnwEwuB7RhY1a1PrriQpAbboKgqke6QJltH1ZB2ZQg2eb/6juXq356+Fx7/gkCn6WlqgA6V1mhQX6LNmvGkP5tmkQjhONs5cP4UHgIG24k8bkdUZ5DqbhAVrN8r074a/0K5Pcd+imjGQ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626957183;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=Gyg89njZgFgQ1j3+NrNVlyyxcJ1gJLkq604iZkQMAgQ=;
        b=nDxMhHykSz7Xt5Yk00OjABYfe6DB4WHQcqxNVumV0F9aqyCUJMeBgQjgoT0I4M41
        z2DQP3eAO+Q29kbPh7dp65XTISCwemkNABWhAzLXF/YIbFVoxmJb/jpKdMX838l3m6N
        uSN78vLCa7l072WjFNTekUxREdr2FVfKrLtJyr6I=
Received: from localhost.localdomain (49.207.63.174 [49.207.63.174]) by mx.zohomail.com
        with SMTPS id 1626957178914108.28984328520244; Thu, 22 Jul 2021 05:32:58 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Subject: [PATCH v6 2/2] firmware_loader: fix use-after-free in firmware_fallback_sysfs
Date:   Thu, 22 Jul 2021 18:02:29 +0530
Message-Id: <20210722123229.8731-3-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210722123229.8731-1-mail@anirudhrb.com>
References: <20210722123229.8731-1-mail@anirudhrb.com>
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
index 1db94165feaf..d262332374eb 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -113,10 +113,9 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
 	 * There is a small window in which user can write to 'loading'
 	 * between loading done and disappearance of 'loading'
 	 */
-	if (fw_sysfs_done(fw_priv))
+	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
 		return;
 
-	list_del_init(&fw_priv->pending_list);
 	fw_state_aborted(fw_priv);
 }
 
@@ -302,7 +301,6 @@ static ssize_t firmware_loading_store(struct device *dev,
 			 * Same logic as fw_load_abort, only the DONE bit
 			 * is ignored and we set ABORT only on failure.
 			 */
-			list_del_init(&fw_priv->pending_list);
 			if (rc) {
 				fw_state_aborted(fw_priv);
 				written = rc;
@@ -535,6 +533,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
+	if (fw_state_is_aborted(fw_priv)) {
+		mutex_unlock(&fw_lock);
+		retval = -EINTR;
+		goto out;
+	}
 	list_add(&fw_priv->pending_list, &pending_fw_head);
 	mutex_unlock(&fw_lock);
 
@@ -554,6 +557,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 		mutex_unlock(&fw_lock);
 	}
 
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

