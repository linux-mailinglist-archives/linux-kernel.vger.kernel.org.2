Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C623D16C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbhGUSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:20:45 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21339 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhGUSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626894077; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Zt29QNsrd/Cyu+GKxaqvM+RxAf8Sd3ZCghN1vA1aEIF/lq9fOiMzZlRsoQRaa2tlzRJ7z51DSjDVIM1Fy/7/Vc3htGxfu1ujo3wSaFqDZWxgTY5oN/Jp6xw92RuCYobg/goPDGQNULdEZ/dDyBinHP44I3f6hL/W13I1RCSNFUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626894077; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=z8ZOwcikWFEYMFY9UGmXKicog7SwNAM7o+3jP8nfT4g=; 
        b=e/awZ7NsBRLrz9x+6Mj4Q+Hxiq7pscU4EiJHmn+HS0bxlDm75b2REnaJZh/e3qyh7rGwx7m02vq85LamSmUuwGvu+mBfYkBmPLnliJintUXupS5VcdfAOmigL48duPq1jcFGZTb11Y/Nf6aKbYY8Q5Nre/qVztgw2ooqPfFfW38=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626894077;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=z8ZOwcikWFEYMFY9UGmXKicog7SwNAM7o+3jP8nfT4g=;
        b=SUyzuHG22vHly+klOmVlgdrDVZSeTbTZFGjCFVqZSjEx1AAJR8fMKpd4JN4UqSut
        IwRVkA4F4/AbD78DmODtJNz9BRAaMtYxixDDsxNGvu0VFbrvjz9lxLJ3Fhm/2hGwqAy
        VU+fyzceJhNEg4kJrw17JyasTluzCc8WUrEJLM3w=
Received: from localhost.localdomain (106.51.105.64 [106.51.105.64]) by mx.zohomail.com
        with SMTPS id 1626894073236259.3075252573017; Wed, 21 Jul 2021 12:01:13 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5 1/2] firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
Date:   Thu, 22 Jul 2021 00:30:13 +0530
Message-Id: <20210721190014.2313-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721190014.2313-1-mail@anirudhrb.com>
References: <20210721190014.2313-1-mail@anirudhrb.com>
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
 drivers/base/firmware_loader/fallback.c | 36 ++++++++++++++++++-------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..bc25bb5d1ed6 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -70,7 +70,31 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
 
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
+	else if (ret == -ETIMEDOUT)
+		ret = -EAGAIN;
+	else if (fw_priv->is_paged_buf && !fw_priv->data)
+		ret = -ENOMEM;
+
+	return ret;
 }
 
 struct fw_sysfs {
@@ -526,20 +550,12 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
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

