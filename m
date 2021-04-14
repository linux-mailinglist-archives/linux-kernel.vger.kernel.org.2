Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF835F032
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhDNI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:57:27 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21378 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhDNI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618390615; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bMUx/A/kUlwgCyUPSy4Ho88R4JFA/QzVjCDV0j/EiGWBDSNZVzAIUO3lWO5ZFJ711w7C3y/7QEPCN4BzDqvshu4FSz4snQiw5XlwDwLcRiyLObqUHNpPPMgvwB+S6Ud7yPpoUuSrwLLrupmxY9QAkojQerC7pMuDYhQm61Shvt8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618390615; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=olVU/cxS9e+IukR6nNhPDZKEZL23u7UepX1VMbr2NRg=; 
        b=lNjo0CRUivU3ukSRLgLGWd/ek4uRzziCYD9bxmxyTReJcyQQz3aG93RhwCMqEL6XEel4mgvovR8J0Bdc2BCNkB0dC7IlZjVnBxc9d+21C7XK6DTgFzKNQDYJWcsCqQfapjZrN6FpE0st+MWQNYzjxFwZjNwaPzpg6ur0/t81Q64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618390615;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=olVU/cxS9e+IukR6nNhPDZKEZL23u7UepX1VMbr2NRg=;
        b=eNi8ySCjN+cFWfN+vAhDqxzgOw/Np6VwbY3LCqD5N7NP2V6KKP1bQufs1vJsVzZr
        V3CIYns8VXrzIS/YQdpt7TMIQWrBirpN0EENIpp/XaTT73hetAEJFdNLIRJ62KFCN1V
        ym8u3Bmdo94geaLLCK2bczpqVwtUsCcvDvs6P+/A=
Received: from localhost.localdomain (49.207.201.215 [49.207.201.215]) by mx.zohomail.com
        with SMTPS id 1618390613494448.2878525995242; Wed, 14 Apr 2021 01:56:53 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] firmware_loader: fix use-after-free in firmware_fallback_sysfs
Date:   Wed, 14 Apr 2021 14:24:05 +0530
Message-Id: <20210414085406.1842-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
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

Changes in v3:
Modified the patch to incorporate suggestions by Luis Chamberlain in
order to fix the root cause instead of applying a "band-aid" kind of
fix.
https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/

Changes in v2:
1. Fixed 1 error and 1 warning (in the commit message) reported by
checkpatch.pl. The error was regarding the format for referring to
another commit "commit <sha> ("oneline")". The warning was for line
longer than 75 chars. 

---
 drivers/base/firmware_loader/fallback.c | 8 ++++++--
 drivers/base/firmware_loader/firmware.h | 6 +++++-
 drivers/base/firmware_loader/main.c     | 2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..73581b6998b4 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -94,7 +94,6 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
 	if (fw_sysfs_done(fw_priv))
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
+		retval = -EAGAIN;
+		goto out;
+	}
 	list_add(&fw_priv->pending_list, &pending_fw_head);
 	mutex_unlock(&fw_lock);
 
@@ -540,6 +543,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
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

