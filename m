Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63999437454
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhJVJIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhJVJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:08:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECDC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:06:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2553702pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FBZ5zW0rY+BvBWQlkPkLubp0yeIPHgHZfbSMEO9yj0=;
        b=lqAt/aC0gTQhLy8a7kKOedb72eUYXiAXDCcXTmlJ+rPwTFqsim+00kjfBT8KDPFIeh
         aR3vXFx9vZ1hpV87m2zwQkKZzpT1G1desoBNWD4ogrnsUBnLzx7BwJPn4O2Yfdys9q/O
         m1nLF5+UgZufvCkjeH45FzwZ0YVsuu3N8j3MebHOCaK0KlwGslvombakhhqdkQlkUzX/
         EPMwH0qJLtZ3yG/JZapE/YVNxPm5dIzv3tLGcRoY/bcVukmohJzaUw7dLcVETySd3KFe
         1qnyiZmKW6yg11Os1JsAsnCVgFWR+KUMsPd/v35Riw1T0jJCVyNLsOxxg229q4Kaef0U
         TPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FBZ5zW0rY+BvBWQlkPkLubp0yeIPHgHZfbSMEO9yj0=;
        b=q/pMhTR6IAMEDNJYa7kYCqojeFYuI744UODYud0kGaOdzCUzIvTEEYbE1TpZgLPd9E
         0JCPIh5aHUtw8wC+d2fBt8s+HTBQVF7/0qxDqUYRs2sV9vL3reEfgPBY803Utpy0LXbT
         GY6kr5jIorWH/dw8d3GiF7lxCaa6HOkkgQXQKH9mOk3k4XEYf0Ti+G5nTLGK/PeaHWl7
         4swK8vco7Svnjhq7bWDBol67w7DZNRe63IjKdrVQRgVwHR1/ZmiUFkGrzchoiNvxRECB
         T5D1o+1Isf+pk3YfDSLHgOGe6hr/AN+YciZpM0VYwq+8arJuLR4xiWijbcp0wUitOb8V
         W5UA==
X-Gm-Message-State: AOAM531DizNM9iIgMISzGWIrqAWtoJI81vY99bsGKwJtBFT77CZHPK9E
        Vi4Q6bifheT84WXV833HFas=
X-Google-Smtp-Source: ABdhPJzDvvI8Z7kqGg7QKu2BEi+J/kPe5KpFbToHFJ35tmPusGxdNmJBoUVCQcDG2lMXAKU1uhq7/w==
X-Received: by 2002:a17:90a:6542:: with SMTP id f2mr12863703pjs.159.1634893571593;
        Fri, 22 Oct 2021 02:06:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c205sm8522785pfc.43.2021.10.22.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:06:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] misc: enclosure: replace snprintf in show functions with sysfs_emit
Date:   Fri, 22 Oct 2021 09:06:04 +0000
Message-Id: <20211022090604.1065367-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/misc/enclosure.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index f950d0155876..1b010d9267c9 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -426,7 +426,7 @@ static ssize_t components_show(struct device *cdev,
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev);
 
-	return snprintf(buf, 40, "%d\n", edev->components);
+	return sysfs_emit(buf, "%d\n", edev->components);
 }
 static DEVICE_ATTR_RO(components);
 
@@ -481,7 +481,7 @@ static ssize_t get_component_fault(struct device *cdev,
 
 	if (edev->cb->get_fault)
 		edev->cb->get_fault(edev, ecomp);
-	return snprintf(buf, 40, "%d\n", ecomp->fault);
+	return sysfs_emit(buf, "%d\n", ecomp->fault);
 }
 
 static ssize_t set_component_fault(struct device *cdev,
@@ -505,7 +505,7 @@ static ssize_t get_component_status(struct device *cdev,
 
 	if (edev->cb->get_status)
 		edev->cb->get_status(edev, ecomp);
-	return snprintf(buf, 40, "%s\n", enclosure_status[ecomp->status]);
+	return sysfs_emit(buf, "%s\n", enclosure_status[ecomp->status]);
 }
 
 static ssize_t set_component_status(struct device *cdev,
@@ -539,7 +539,7 @@ static ssize_t get_component_active(struct device *cdev,
 
 	if (edev->cb->get_active)
 		edev->cb->get_active(edev, ecomp);
-	return snprintf(buf, 40, "%d\n", ecomp->active);
+	return sysfs_emit(buf, "%d\n", ecomp->active);
 }
 
 static ssize_t set_component_active(struct device *cdev,
@@ -563,7 +563,7 @@ static ssize_t get_component_locate(struct device *cdev,
 
 	if (edev->cb->get_locate)
 		edev->cb->get_locate(edev, ecomp);
-	return snprintf(buf, 40, "%d\n", ecomp->locate);
+	return sysfs_emit(buf, "%d\n", ecomp->locate);
 }
 
 static ssize_t set_component_locate(struct device *cdev,
@@ -593,7 +593,7 @@ static ssize_t get_component_power_status(struct device *cdev,
 	if (ecomp->power_status == -1)
 		return (edev->cb->get_power_status) ? -EIO : -ENOTTY;
 
-	return snprintf(buf, 40, "%s\n", ecomp->power_status ? "on" : "off");
+	return sysfs_emit(buf, "%s\n", ecomp->power_status ? "on" : "off");
 }
 
 static ssize_t set_component_power_status(struct device *cdev,
@@ -623,7 +623,7 @@ static ssize_t get_component_type(struct device *cdev,
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
-	return snprintf(buf, 40, "%s\n", enclosure_type[ecomp->type]);
+	return sysfs_emit(buf, "%s\n", enclosure_type[ecomp->type]);
 }
 
 static ssize_t get_component_slot(struct device *cdev,
@@ -638,7 +638,7 @@ static ssize_t get_component_slot(struct device *cdev,
 	else
 		slot = ecomp->number;
 
-	return snprintf(buf, 40, "%d\n", slot);
+	return sysfs_emit(buf, "%d\n", slot);
 }
 
 static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
-- 
2.25.1

