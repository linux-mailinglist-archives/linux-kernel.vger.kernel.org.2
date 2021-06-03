Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE139AEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFCXst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:48:49 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39927 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhFCXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:48:48 -0400
Received: by mail-wr1-f52.google.com with SMTP id l2so7486961wrw.6;
        Thu, 03 Jun 2021 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+4tVIHgjtiD7zpIPHC41efEy59vHCwGq9x9fWYbAw4=;
        b=ZsX9ZsQorLDF63ZXy5f5ZVLHy3r6XlbE2ZuQXtDpS+tANbxNXwvIGtTxYhg2xXJnMp
         i5KdYXJwPa4VFBaBzV7UsXk3vJJWnoIm+JuZR6+1Brs7gxCvElLDKDPqhnSqTZlyB2Ui
         wp83uydfNV8nzwOMCwLwVx3xzGkASjOT9j3VK8GumwQy13dvT44cTX4fDs90P2h4ienK
         DjYQWCxTl1NB+hN4VDYZVmJczOBnfWul67mKBaUVmpj6idNYnwiDUIEUMbJRbJiydk4x
         JeqsSVOp26PUJ4wMXnglxiR63RN8AJjQQg2G3aVD5temsKBblvzYYy1LgdLsZRYWPpoq
         LF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+4tVIHgjtiD7zpIPHC41efEy59vHCwGq9x9fWYbAw4=;
        b=YZK6h63SHTVBlkmXZtQYLgCyi1AoU0TLcBWTM5WGQkB9G+/3LD3FGbrZkaXzpMxMM7
         1wcvdh/XNeAYSPfadYiKrPAfYYNR3tuHEvyNPuuNkSuFELDV2Nrm5dgF6yM3sLQUWzSV
         GxR7K8nDV7d9TANODMI0ACnLgVRi1aVrZaBgY5wqGDDp5dSaBCrxSy8nJvxkz564Oeil
         wHm9LuvnOmSIwYIS/Dv2j9/qDIjYcbCu1gYD+jUJElWMJweeGcDToeuqLSmDSTdi7xF3
         /GwWIMg/SpZyB08fu2xCcSHMPh4P9CkiOKf9djACaAwwMHdjRzI8ey5qAQDC+RdzZjYU
         PPLw==
X-Gm-Message-State: AOAM531jrY3BLEZvq28K+045exvqjeoe0fN1Opb3gy+ffk61hKhLuwC9
        q5Y2wlxaSN/Uc4iPqOXtu64=
X-Google-Smtp-Source: ABdhPJxCb5UO5XxtOtL2TColYdqLS6aAGxDGP73s8L3jDyZPDZQGmVDk1SvEU+CRzOuBFu2pHCs/8w==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr783242wrq.323.1622763949466;
        Thu, 03 Jun 2021 16:45:49 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:48 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] platform/surface: aggregator_cdev: Add lockdep support
Date:   Fri,  4 Jun 2021 01:45:25 +0200
Message-Id: <20210603234526.2503590-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark functions with locking requirements via the corresponding lockdep
calls for debugging and documentary purposes.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../platform/surface/surface_aggregator_cdev.c   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index e0f3c437b8ee..f3247cd15f6d 100644
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
@@ -510,6 +524,8 @@ static int ssam_cdev_device_release(struct inode *inode, struct file *filp)
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

