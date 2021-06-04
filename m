Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1639BA3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFDNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:51:23 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:46059 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhFDNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:51:20 -0400
Received: by mail-wm1-f43.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so1385295wmg.4;
        Fri, 04 Jun 2021 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+j7xPh36RHrF3IBVvuTQ/zEy/iKAdtrHI17EQxJYRo=;
        b=EB0x89s2Z0E41XJWL3SfZu8ewJKbK4DxcphdKJZskytUjMsUA4K8xVsbrz9xeKwyiU
         90Fy/XLMqB9DE2ZxguX8S83Vfofr+MdT/s/Hk5G/UWGcGL79usm4uMYiI+XI8AnxKVmp
         T3bvhfQqyZiN0UgLvDGkU4SOfhEpaScdV+PZt4EMYlYpXTvhIJWxv7uVGgWI6+pEEKDW
         /dqq2B63PG6ifvVdGNC+ifLXRkmYkG5oFZRc8tv6CF2fXb8TghhtomGSV2yY8441+q51
         e2ysc7OKxQxb5mVhcGFk/YIavQk5M3GI2zwWL4EynriorSRvt04Q0V7mErE2QHNY0Fj5
         w5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+j7xPh36RHrF3IBVvuTQ/zEy/iKAdtrHI17EQxJYRo=;
        b=GGGwQr48xFhPMy8N3/gioBlZ/WXFl/jUMoVm9gXyKWJozTWdKkypGpl6LKBZqfqV9d
         snyHJd2tEdIdCquXGh/IlfeDcyTJ/K0aMFEpJzqpvzJnK0w04iUMlTMQLRXn9OJSDCzV
         G2c3ZN3ljns6MOzkEtMJMgQnpgE/jVJizOkN400lx+UGUh5NaTXEmq2oS/o9HSOpM9+Z
         ICLbbLobApObRFgK+aOBHds5ci77Tlebu0Pe3Yul5ekXgaQvdkTbzhCFnVfrsbXFvTF0
         nCeP2BPCK2cWWXRg5bJ6AnsdeQx0XkxeNWeEsbbssmLVALbWadfKa8KDgkSzHaSQRnLr
         rnIA==
X-Gm-Message-State: AOAM533cFLEn7PVUiNchulvi/3xB56otuIBRziQuXXBgoaTh+6OiaSRe
        NC3WUWPVXXAx5bW8xS4Y2fE=
X-Google-Smtp-Source: ABdhPJyaUo5gTrCuRZs6OO9gx6CoesqMOGQtzdBiwj8o/aYuQPotct6ICXexQ9qkJBRIkO1lKaQ3eQ==
X-Received: by 2002:a05:600c:3789:: with SMTP id o9mr3866409wmr.78.1622814504376;
        Fri, 04 Jun 2021 06:48:24 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:23 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] platform/surface: aggregator_cdev: Add lockdep support
Date:   Fri,  4 Jun 2021 15:47:54 +0200
Message-Id: <20210604134755.535590-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark functions with locking requirements via the corresponding lockdep
calls for debugging and documentary purposes.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v2:
 - None

---
 .../platform/surface/surface_aggregator_cdev.c   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 7b86b36eaaa0..30fb50fde450 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -139,6 +139,8 @@ static int ssam_cdev_notifier_register(struct ssam_cdev_client *client, u8 tc, i
 	struct ssam_cdev_notifier *nf;
 	int status;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	/* Validate notifier target category. */
 	if (!ssh_rqid_is_event(rqid))
 		return -EINVAL;
@@ -188,6 +190,8 @@ static int ssam_cdev_notifier_unregister(struct ssam_cdev_client *client, u8 tc)
 	const u16 event = ssh_rqid_to_event(rqid);
 	int status;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	/* Validate notifier target category. */
 	if (!ssh_rqid_is_event(rqid))
 		return -EINVAL;
@@ -257,6 +261,8 @@ static long ssam_cdev_request(struct ssam_cdev_client *client, struct ssam_cdev_
 	void __user *rspdata;
 	int status = 0, ret = 0, tmp;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
 	if (ret)
 		goto out;
@@ -367,6 +373,8 @@ static long ssam_cdev_notif_register(struct ssam_cdev_client *client,
 	struct ssam_cdev_notifier_desc desc;
 	long ret;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
 	if (ret)
 		return ret;
@@ -380,6 +388,8 @@ static long ssam_cdev_notif_unregister(struct ssam_cdev_client *client,
 	struct ssam_cdev_notifier_desc desc;
 	long ret;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
 	if (ret)
 		return ret;
@@ -395,6 +405,8 @@ static long ssam_cdev_event_enable(struct ssam_cdev_client *client,
 	struct ssam_event_id id;
 	long ret;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	/* Read descriptor from user-space. */
 	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
 	if (ret)
@@ -421,6 +433,8 @@ static long ssam_cdev_event_disable(struct ssam_cdev_client *client,
 	struct ssam_event_id id;
 	long ret;
 
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	/* Read descriptor from user-space. */
 	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
 	if (ret)
@@ -513,6 +527,8 @@ static int ssam_cdev_device_release(struct inode *inode, struct file *filp)
 static long __ssam_cdev_device_ioctl(struct ssam_cdev_client *client, unsigned int cmd,
 				     unsigned long arg)
 {
+	lockdep_assert_held_read(&client->cdev->lock);
+
 	switch (cmd) {
 	case SSAM_CDEV_REQUEST:
 		return ssam_cdev_request(client, (struct ssam_cdev_request __user *)arg);
-- 
2.31.1

