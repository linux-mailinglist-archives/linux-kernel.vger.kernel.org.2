Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FA3D20E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhGVIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhGVItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:49:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE22C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e14so3774978plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSgVdB0+HpET8iLINuWOoeOWDDxUJjmmluxZNEz35KA=;
        b=o6LJ/myMP6JO8ChH8dYoqq21TZnuVfWqQC7aMNZVbEwvgt/wmupSJe5X7mUycZZ1OP
         wZUOpxPzR0Di4iK476owf2txOnd8aRvZIuWOSyNSQwF8qAfJx1gZjc1rqQNENDcoU4k8
         pWfm16Rm2AyVdjC+e3kTofDMg7W/f1X4eU9NPEhv7mUcvN6ebC/kCdQLgGMJIgNOCd38
         Z79Cpgk8vmBkJLmcW9tTTfCW8TJv/6nRrpzuj2HycvK3LMZlVo0xpmCpHif6k1kmeqBf
         /hzT0Pmizi11dqx4L91lE1OKq6ULDL3w/A5pjP58k83vlOPYfDR9I9UDXt06Iw0JzA4O
         hv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSgVdB0+HpET8iLINuWOoeOWDDxUJjmmluxZNEz35KA=;
        b=kbRH1U9nwf1U1DWF7u1bHeefg5kPHvAo3Uvf2cXwAx+Sh0L5x9WRg8Xq5KbutYjtt0
         Chv2Iu5+9ZQLx3QcZdIo+WiFlM6z3w8UQAj9mdvVJYJ9wahNIXAWEd8SPdKGfG9Ys+7y
         1Tt4xpcHPtI9jtbUo/PkUVkMBLx7cEBFqMhSOVtgSGcFbGYAub/T4+sQ0gHC9uMfsKvj
         PS+CcOWk59vt51+5ciPyzhUMum2M4SVEHuUUC/wPyuxxVTyk7ExZBQwIh3V83XcUB7yM
         hCg/WHcLe35WGbf9eg+7cZi3ljPvf+dD3rf+GQK4Tqc8BAi2K3XAg+3FvaU2HcRLNuBE
         QTYA==
X-Gm-Message-State: AOAM532FOpIITt2YX4M5WE7LC4IHFxd+C+TlyJ3/R/aHpuW+zsFbsETH
        YiQoyr60xnBqhVz5FLiFKDM=
X-Google-Smtp-Source: ABdhPJyscK7c550TzHfpDv1WRnYYvoBsSoBWYdMCW0natilUebpT1uRY7os1lbemOjfZnuzWFb0RqA==
X-Received: by 2002:a05:6a00:2306:b029:331:ebe8:a4b4 with SMTP id h6-20020a056a002306b0290331ebe8a4b4mr39978184pfh.15.1626946211504;
        Thu, 22 Jul 2021 02:30:11 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q5sm1069592pjo.7.2021.07.22.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:30:11 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/3] drm: use the lookup lock in drm_is_current_master
Date:   Thu, 22 Jul 2021 17:29:27 +0800
Message-Id: <20210722092929.244629-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722092929.244629-1-desmondcheongzx@gmail.com>
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside drm_is_current_master, using the outer drm_device.master_mutex
to protect reads of drm_file.master makes the function prone to creating
lock hierarchy inversions. Instead, we can use the
drm_file.master_lookup_lock that sits at the bottom of the lock
hierarchy.

Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/gpu/drm/drm_auth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index f00354bec3fb..9c24b8cc8e36 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -63,8 +63,9 @@
 
 static bool drm_is_current_master_locked(struct drm_file *fpriv)
 {
-	lockdep_assert_held_once(&fpriv->minor->dev->master_mutex);
-
+	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
+	 * should be held here.
+	 */
 	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
 }
 
@@ -82,9 +83,9 @@ bool drm_is_current_master(struct drm_file *fpriv)
 {
 	bool ret;
 
-	mutex_lock(&fpriv->minor->dev->master_mutex);
+	spin_lock(&fpriv->master_lookup_lock);
 	ret = drm_is_current_master_locked(fpriv);
-	mutex_unlock(&fpriv->minor->dev->master_mutex);
+	spin_unlock(&fpriv->master_lookup_lock);
 
 	return ret;
 }
-- 
2.25.1

