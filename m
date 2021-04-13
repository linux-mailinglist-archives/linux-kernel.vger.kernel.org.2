Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9235DC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbhDMKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:43:20 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21320 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhDMKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618310573; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Z080RNZtrYvVnPp8IT8dpJAbmV5cEzy/L/cmYBYhSFTuVd0pNGDTnvr0kYpFxkmP83VxeNLrVkmGOClj2s//tPvr+ojPb2zLQNjMazkFzel5UeNKeOEC9wln1zcG+WwlDt0zjCa4jrqiXo0EUGaZUCA3Z+u50glkFVP8VbmajKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618310573; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=va5GINP/dJlv06fIUkjPCNpVZxPPX7MB9GC70Mie3To=; 
        b=bkt1QrFluka83nTc/A0zE5AlK2WDd2IKVqzbxYxFPnUDHR5safm1tqx28Z12FZC3q7lCrFHsSuD2bbPCPN90A8CNUHJ+ivIXFh5XCBv3Zt8+zkNKqVW1sjPzZ2tqiZk7sXPG9JrfZE3ZwpqH/AS42MF9eJfLOGH4M/mVpl8dCzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618310573;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=va5GINP/dJlv06fIUkjPCNpVZxPPX7MB9GC70Mie3To=;
        b=GkixiDHPCLcZ7xACxsH7WttgOdDXSQZW9bOmfk//t4lk0A0GKXc1MliSVVEdRXB7
        Sdb+VgQIaYGHTIKjrOmrRauYngCLRrPmgCLMvGBQM2F0aCw4fjqd+AR9xEN2HHjXTzN
        dADKblsmm+zT0MQy6tvq5aMSUbQeNF2K7hYziecU=
Received: from localhost.localdomain (49.207.222.140 [49.207.222.140]) by mx.zohomail.com
        with SMTPS id 1618310571843275.1191832574465; Tue, 13 Apr 2021 03:42:51 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware_loader: fix use-after-free in firmware_fallback_sysfs
Date:   Tue, 13 Apr 2021 16:12:42 +0530
Message-Id: <20210413104242.31564-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use-after-free happens when a fw_priv object has been freed but
hasn't been removed from the pending list (pending_fw_head). The next
time fw_load_sysfs_fallback tries to insert into the list, it ends up
accessing the pending_list member of the previoiusly freed fw_priv.

In commit bcfbd3523f3c ("firmware: fix a double abort case with
fw_load_sysfs_fallback"), fw_load_abort() is skipped if
fw_sysfs_wait_timeout() returns -ENOENT. This causes the fw_priv to
not be removed from the pending list.

To fix this, delete the fw_priv from the pending list when retval
is -ENOENT instead of skipping the entire block.

Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---

Changes in v2:
1. Fixed 1 error and 1 warning (in the commit message) reported by
   checkpatch.pl. The error was regarding the format for referring to
   another commit "commit <sha> ("oneline")". The warning was for line
   longer than 75 chars.

---
 drivers/base/firmware_loader/fallback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..56ae4ab3199d 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -526,9 +526,14 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
-	if (retval < 0 && retval != -ENOENT) {
+	if (retval < 0) {
 		mutex_lock(&fw_lock);
-		fw_load_abort(fw_sysfs);
+
+		if (retval != -ENOENT)
+			fw_load_abort(fw_sysfs);
+		else
+			list_del_init(&fw_priv->pending_list);
+
 		mutex_unlock(&fw_lock);
 	}
 
-- 
2.26.2

