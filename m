Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F23A0F89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhFIJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbhFIJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:24:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:22:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o9so16109889pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HdeYeZU8aBbB01u3EptGGzTktTYXaU7YZzov/SDA8I=;
        b=b4EpkScIYTfhDr+1DMH9NGb/JEGCVMC9I0UEyR0v35fGLBQSlI8BS1JDdPwEi26sGQ
         KPb2AUw2GDSNvGJGPErFOeww/av+JYG7UmLiOxZgOlAggtefR5FUeMsoRoDKnhoHtI8u
         0E0v05ydQAErk3dBnyG43LsFRo9bYbJkhu+NdLUfvu+vjlDoM3ZknsyBXJ9NjBDzpAcr
         HLBi/331j1metmaNnix8gGpxm82JMyR1mV18SJZWKZJpLxC2uTO8gup6tbgZ003q4Of5
         MznuY50X/r972sJpUhon8MiAZUcUYmgfQTYatvtdKj6f1XI5znqAeyQ7060yHHdxWgGA
         rSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HdeYeZU8aBbB01u3EptGGzTktTYXaU7YZzov/SDA8I=;
        b=ZRiDyb0/jnHrLplZtwRWMuY5MzvdK29lfDFcTAnSe5kpOK1q96NyMLrG7nO1DI3BcC
         v6tQTdBD9WSrI5SjWjVZR2t9McVeJiOx5S7vOd6O7OIqMjbTIwXlzhS+HGwn6eRbRFCk
         clPE+efZcWi5ZZFt61ZtsUIXlREmKr27UTb1hLnAJySwd1YY5pTms+XhzEIRblD5mZ1a
         2w58jRk0teppcNBnHyZO21I4HrX3+HRV9Bdcm3cF4Q6k2eF1dB2VnkHuVheIzUSQWuXW
         hz3X5Cn64v8Fm3DHHBosQEVq6hEIxRw/iM4TP30RzjnxPaqKiY5Uw1VU1SZxtPReiR66
         r1Mg==
X-Gm-Message-State: AOAM530hU3uR0YhMk8vwnOuSZsKYocLdGtlfdg1GZR/wtEtMl1/gK4bO
        Cp5scliStmKp809KmlsCjdM=
X-Google-Smtp-Source: ABdhPJwJbjQpq27OslPPl05sK51n7VSNJg+Oy499gokZlzfdlXjo0kUTNl8b19jl4Y/n4hNDMlA3Ow==
X-Received: by 2002:a65:4508:: with SMTP id n8mr2895991pgq.120.1623230520212;
        Wed, 09 Jun 2021 02:22:00 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id z22sm13793464pfa.157.2021.06.09.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:21:59 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm: Lock pointer access in drm_master_release()
Date:   Wed,  9 Jun 2021 17:21:19 +0800
Message-Id: <20210609092119.173590-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates the following smatch warning:
drivers/gpu/drm/drm_auth.c:320 drm_master_release() warn: unlocked access 'master' (line 318) expected lock '&dev->master_mutex'

The 'file_priv->master' field should be protected by the mutex lock to
'&dev->master_mutex'. This is because other processes can concurrently
modify this field and free the current 'file_priv->master'
pointer. This could result in a use-after-free error when 'master' is
dereferenced in subsequent function calls to
'drm_legacy_lock_master_cleanup()' or to 'drm_lease_revoke()'.

An example of a scenario that would produce this error can be seen
from a similar bug in 'drm_getunique()' that was reported by Syzbot:
https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803

In the Syzbot report, another process concurrently acquired the
device's master mutex in 'drm_setmaster_ioctl()', then overwrote
'fpriv->master' in 'drm_new_set_master()'. The old value of
'fpriv->master' was subsequently freed before the mutex was unlocked.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/gpu/drm/drm_auth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index f00e5abdbbf4..b59b26a71ad5 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -315,9 +315,10 @@ int drm_master_open(struct drm_file *file_priv)
 void drm_master_release(struct drm_file *file_priv)
 {
 	struct drm_device *dev = file_priv->minor->dev;
-	struct drm_master *master = file_priv->master;
+	struct drm_master *master;
 
 	mutex_lock(&dev->master_mutex);
+	master = file_priv->master;
 	if (file_priv->magic)
 		idr_remove(&file_priv->master->magic_map, file_priv->magic);
 
-- 
2.25.1

