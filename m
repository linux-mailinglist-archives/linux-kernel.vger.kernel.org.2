Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E091639F4A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhFHLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:09:38 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:34425 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFHLJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:09:36 -0400
Received: by mail-pf1-f179.google.com with SMTP id g6so15441713pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agz9CSylDXq5In5z8KQvrOkrG9eT9u+AOTvuu0ZY5Nc=;
        b=kGJnoao0/Q/HCganKG1fHKbr1Rvvy+ZswfjL1itdz2Fa3nj6p0fdUcUGr9zmUrRqh3
         i+EaiDMe2/M8vkPY13QjEDQDK04NGqhOr1bzlDllU0QlBDpYJaO4bE4DuYMY1sbkQLsy
         q61tkrjOHNH1WfEYj6pgQ4UrB8wObwr9PCvR8TZobNvIy2cZp0uJjDmHEyBLvdB74UZi
         4haMcQI5taiEdShso56uQeGBHkg1S4gjWzKzSDMQ0GCc8qF9J2JYuG5dBPnml6u8PUt9
         Ln6S5lxSWmgLYzvv/F2qKIfEsk5f8apHSuxrNTdXyih+OHNHW8vnJ9tiUHWJeJ6+j1cv
         7p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agz9CSylDXq5In5z8KQvrOkrG9eT9u+AOTvuu0ZY5Nc=;
        b=afshtwUWHdNNXbeDgV9Wrn1md/s+XwS32NNBadR+cZEfK4+oWgs4qxpBqy26XVLFar
         NfRbcN3t/tTJrSI/1mT05jhpg48wrNPEIT8to6ESojPfLIbMGi8/zYF1LeBCRk8NGHKd
         lI4qHUV5D1W4irphJFTTr1zsa/eLBalBPDSOgm37jSE90zQ5eKAp6DExoIOeO8MU6odY
         YOOrew69mtFU4I9dJfNpkVQ3LdCDUZm7/jfBq9BMmgr9QM2xySJG8DcBXURuRZ1bEszk
         ldkXONjvylLbd5lQR3W4u8jX1zV1y2OHUQUl51v117bllpQxXUz4a7Zm+zaf3qUFaKtX
         voOQ==
X-Gm-Message-State: AOAM531d9VBDLhO0/ByYtTmoy1CfRD73/8TRf8XTkuhK43vSP07ipJa5
        SDW9BTB6JVcYOfDCN97EHC0=
X-Google-Smtp-Source: ABdhPJw+2vg8VRQZjpROEMosr54/72J0JLFObMsUY2RUtiQT6wgQDH+LwDd8IMe+yGnWjpe5wSHOag==
X-Received: by 2002:a63:954e:: with SMTP id t14mr22339484pgn.427.1623150403690;
        Tue, 08 Jun 2021 04:06:43 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id a9sm10264209pfo.69.2021.06.08.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:06:43 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+c3a706cec1ea99e1c693@syzkaller.appspotmail.com
Subject: [PATCH] drm: Fix use-after-free read in drm_getunique()
Date:   Tue,  8 Jun 2021 19:04:36 +0800
Message-Id: <20210608110436.239583-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a time-of-check-to-time-of-use error in drm_getunique() due
to retrieving file_priv->master prior to locking the device's master
mutex.

An example can be seen in the crash report of the use-after-free error
found by Syzbot:
https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803

In the report, the master pointer was used after being freed. This is
because another process had acquired the device's master mutex in
drm_setmaster_ioctl(), then overwrote fpriv->master in
drm_new_set_master(). The old value of fpriv->master was subsequently
freed before the mutex was unlocked.

To fix this, we lock the device's master mutex before retrieving the
pointer from from fpriv->master. This patch passes the Syzbot
reproducer test.

Reported-by: syzbot+c3a706cec1ea99e1c693@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---

In this patch, I made the assumption that dev and file_priv->master->dev refer to the same struct drm_device*, and from my test runs this seemed to be the case. If this was a wrong assumption to make, please let me know.

 drivers/gpu/drm/drm_ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index d273d1a8603a..495a4767a443 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -118,17 +118,18 @@ int drm_getunique(struct drm_device *dev, void *data,
 		  struct drm_file *file_priv)
 {
 	struct drm_unique *u = data;
-	struct drm_master *master = file_priv->master;
+	struct drm_master *master;
 
-	mutex_lock(&master->dev->master_mutex);
+	mutex_lock(&dev->master_mutex);
+	master = file_priv->master;
 	if (u->unique_len >= master->unique_len) {
 		if (copy_to_user(u->unique, master->unique, master->unique_len)) {
-			mutex_unlock(&master->dev->master_mutex);
+			mutex_unlock(&dev->master_mutex);
 			return -EFAULT;
 		}
 	}
 	u->unique_len = master->unique_len;
-	mutex_unlock(&master->dev->master_mutex);
+	mutex_unlock(&dev->master_mutex);
 
 	return 0;
 }
-- 
2.25.1

