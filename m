Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF033D235D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhGVLw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:52:28 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21358 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGVLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626957177; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=N8+s10UUCPrRTIHdZ7+OXEAAsibFuDaBZwR9+CkOhjV3SfkXgJRMR+RQfw5uwN6ADhVzQ3c0DwBoaTA4/JU5rT1hXE8u7rEI6A9QEcyvNWwhZ05Wu3WXT2ZgYoIO5ZYfCGkX1hltn6UK/MAtOklGbvOLBWdT1aSYbLAekMnYWuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626957177; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8n8UvWi3wpZJmjoxSKsVTa3O3ZF6lWqEJEHCJt2hUds=; 
        b=iqAwkD9Zuzy28JOqN3DKQN7063Pk6FOJFPJJe4yXH2GhHmYOfGLo7obb6jkSut0aXeveu2F2NnG5iGyytxxHPQlYQlFIdzJ4jd537khQV19sY/Sh2fFJGMXFhEI9zoQN0UVYMid6PiqLWlFKklsXHmEyAvAwFkPelSr+d+prXzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626957177;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=8n8UvWi3wpZJmjoxSKsVTa3O3ZF6lWqEJEHCJt2hUds=;
        b=RwrPsltVo5Od/zPEBzcTzBBFderlhEGYB6BY407iMEdhpe4GkmCFyI0YQaYsc/rY
        xGsqL5w6Aggt5v//6i9lktlkkyETy6X/Y//EnaMVQiu0EYD1eaQTMfa8zTAL+GPh3c6
        eiT+5I7cZEJOrUywunIZFnpRpEMf4PonjQl2Z6rY=
Received: from localhost.localdomain (49.207.63.174 [49.207.63.174]) by mx.zohomail.com
        with SMTPS id 1626957174048539.5192747039472; Thu, 22 Jul 2021 05:32:54 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v6 1/2] firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
Date:   Thu, 22 Jul 2021 18:02:28 +0530
Message-Id: <20210722123229.8731-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210722123229.8731-1-mail@anirudhrb.com>
References: <20210722123229.8731-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
("firmware loader: Fix _request_firmware_load() return val for fw load
abort") was to distinguish the error from -ENOMEM, and so there is no
real reason in keeping it. Keeping -ETIMEDOU is much telling of what the
reason for a failure is, so just use that.

The rest is just trying to document a bit more of the motivations for the
error codes, as otherwise we'd lose this information easily.

Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/base/firmware_loader/fallback.c | 34 +++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..1db94165feaf 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -70,7 +70,29 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
 
 static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
 {
-	return __fw_state_wait_common(fw_priv, timeout);
+	int ret = __fw_state_wait_common(fw_priv, timeout);
+
+	/*
+	 * A signal could be sent to abort a wait. Consider Android's init
+	 * gettting a SIGCHLD, which in turn was the same process issuing the
+	 * sysfs store call for the fallback. In such cases we want to be able
+	 * to tell apart in userspace when a signal caused a failure on the
+	 * wait. In such cases we'd get -ERESTARTSYS.
+	 *
+	 * Likewise though another race can happen and abort the load earlier.
+	 *
+	 * In either case the situation is interrupted so we just inform
+	 * userspace of that and we end things right away.
+	 *
+	 * When we really time out just tell userspace it should try again,
+	 * perhaps later.
+	 */
+	if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
+		ret = -EINTR;
+	else if (fw_priv->is_paged_buf && !fw_priv->data)
+		ret = -ENOMEM;
+
+	return ret;
 }
 
 struct fw_sysfs {
@@ -526,20 +548,12 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
-	if (retval < 0 && retval != -ENOENT) {
+	if (retval < 0) {
 		mutex_lock(&fw_lock);
 		fw_load_abort(fw_sysfs);
 		mutex_unlock(&fw_lock);
 	}
 
-	if (fw_state_is_aborted(fw_priv)) {
-		if (retval == -ERESTARTSYS)
-			retval = -EINTR;
-		else
-			retval = -EAGAIN;
-	} else if (fw_priv->is_paged_buf && !fw_priv->data)
-		retval = -ENOMEM;
-
 	device_del(f_dev);
 err_put_dev:
 	put_device(f_dev);
-- 
2.26.2

