Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12654395A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhEaM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:26:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:24:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f12so14785209ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5fvqFTRPpxVQWhJsuDY6GA7XdfgvLDTB5Muui5R4sc=;
        b=eJF242mB5AndVCjHvS4JQARLqxgPTVICpNtWtO3MkAAAmdPG/hIf4lu05E0U/ft2rq
         MIOJ1R6vczTze4QPg8uCiBNRx1JEI8t/QXAgt9ClX60p2C0ZBaepaF/U2C+0Ku3ZpNLQ
         YW9RzyrQJAA1O6Ifzf0h2LhFCbfA87+kjHm3PSYFBBe72CADKd1TbeFHQKYdpSAijHgI
         3c2R51SGS8fw3kA7SmlqZlyLKXv0f3Hk6lCUKy6fQ3sThRtYJhgowxJ7sQ14jmVqxzCu
         GyS6j5JUBTR+va03GTNCbqWpAZ435zrx1Bi3UJq0E6xbpNoChk7qYX5leF/7vNLxBJTY
         a7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5fvqFTRPpxVQWhJsuDY6GA7XdfgvLDTB5Muui5R4sc=;
        b=kdNnqkGL4TeQ1Pa+8Cj+hNI5e6qXJXZZSJ825ykYKjy9NP7qKHgi8VQTDxDTjhWzda
         OeIlsDM4+RGsykSpUAaK1EhHynKLOkH0niE366KxmNo5YKn76MmwDqeQXvRFvwXlodhx
         5R3zLffunCijca1DDikImdqOoF18ZseQyQkHDMK5ZxILSyVROub5qfmlVw6TXF0DkcIP
         nby0m3J9J6EzTWOFLb1eDRWAnV0/fTWdAfk0oR0v1W5gQo004+Z/kMWS45UkaMR2Hq79
         eQW3sHe2RydJUDyWE/ZBw9hrjYRAhhtS72MLNkgdxEeoB88eJ34EQAO6gzg3dTvGRyC4
         d6uA==
X-Gm-Message-State: AOAM531dlDg2QIZquknAtM9dpUHRhAL/MQj531LdYoraXfkeaO+LRP/4
        Y/Kdjuu3T4XdEf8H+pIIIqluH3NosKrY7A==
X-Google-Smtp-Source: ABdhPJxvuP3tuckLOMaFd3GAkQqVd4RwPfkJEHCV+jwrGsyMnq8liEbfbGlpm7G1XhVXfQetvQiUXA==
X-Received: by 2002:a2e:94e:: with SMTP id 75mr9475872ljj.258.1622463875148;
        Mon, 31 May 2021 05:24:35 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id d20sm1328345lfm.175.2021.05.31.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:24:34 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        grzegorz.jaszczyk@linaro.org
Subject: [PATCH] usb: phy: introduce usb_phy device type with its own uevent handler
Date:   Mon, 31 May 2021 14:22:22 +0200
Message-Id: <20210531122222.453628-1-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB charger type and status was already propagated to userspace
through kobject_uevent_env during charger notify work. Nevertheless the
uevent could be lost e.g. because it could be fired at an early kernel
boot stage, way before udev daemon or any other user-space app was able
to catch it. Registering uevent hook for introduced usb_phy_dev_type
will allow to query sysfs 'uevent' file to restore that information at
any time.

Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/usb/phy/phy.c | 55 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index b47285f023cf..83ed5089475a 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -42,6 +42,12 @@ static const char *const usb_chger_type[] = {
 	[ACA_TYPE]			= "USB_CHARGER_ACA_TYPE",
 };
 
+static const char *const usb_chger_state[] = {
+	[USB_CHARGER_DEFAULT]	= "USB_CHARGER_DEFAULT",
+	[USB_CHARGER_PRESENT]	= "USB_CHARGER_PRESENT",
+	[USB_CHARGER_ABSENT]	= "USB_CHARGER_ABSENT",
+};
+
 static struct usb_phy *__usb_find_phy(struct list_head *list,
 	enum usb_phy_type type)
 {
@@ -74,6 +80,18 @@ static struct usb_phy *__of_usb_find_phy(struct device_node *node)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct usb_phy *__device_to_usb_phy(struct device *dev)
+{
+	struct usb_phy *usb_phy;
+
+	list_for_each_entry(usb_phy, &phy_list, head) {
+		if (usb_phy->dev == dev)
+			break;
+	}
+
+	return usb_phy;
+}
+
 static void usb_phy_set_default_current(struct usb_phy *usb_phy)
 {
 	usb_phy->chg_cur.sdp_min = DEFAULT_SDP_CUR_MIN;
@@ -105,9 +123,6 @@ static void usb_phy_set_default_current(struct usb_phy *usb_phy)
 static void usb_phy_notify_charger_work(struct work_struct *work)
 {
 	struct usb_phy *usb_phy = container_of(work, struct usb_phy, chg_work);
-	char uchger_state[50] = { 0 };
-	char uchger_type[50] = { 0 };
-	char *envp[] = { uchger_state, uchger_type, NULL };
 	unsigned int min, max;
 
 	switch (usb_phy->chg_state) {
@@ -115,15 +130,11 @@ static void usb_phy_notify_charger_work(struct work_struct *work)
 		usb_phy_get_charger_current(usb_phy, &min, &max);
 
 		atomic_notifier_call_chain(&usb_phy->notifier, max, usb_phy);
-		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
-			 "USB_CHARGER_STATE=%s", "USB_CHARGER_PRESENT");
 		break;
 	case USB_CHARGER_ABSENT:
 		usb_phy_set_default_current(usb_phy);
 
 		atomic_notifier_call_chain(&usb_phy->notifier, 0, usb_phy);
-		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
-			 "USB_CHARGER_STATE=%s", "USB_CHARGER_ABSENT");
 		break;
 	default:
 		dev_warn(usb_phy->dev, "Unknown USB charger state: %d\n",
@@ -131,9 +142,30 @@ static void usb_phy_notify_charger_work(struct work_struct *work)
 		return;
 	}
 
+	kobject_uevent(&usb_phy->dev->kobj, KOBJ_CHANGE);
+}
+
+static int usb_phy_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct usb_phy *usb_phy;
+	char uchger_state[50] = { 0 };
+	char uchger_type[50] = { 0 };
+
+	usb_phy = __device_to_usb_phy(dev);
+
+	snprintf(uchger_state, ARRAY_SIZE(uchger_state),
+		 "USB_CHARGER_STATE=%s", usb_chger_state[usb_phy->chg_state]);
+
 	snprintf(uchger_type, ARRAY_SIZE(uchger_type),
 		 "USB_CHARGER_TYPE=%s", usb_chger_type[usb_phy->chg_type]);
-	kobject_uevent_env(&usb_phy->dev->kobj, KOBJ_CHANGE, envp);
+
+	if (add_uevent_var(env, uchger_state))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, uchger_type))
+		return -ENOMEM;
+
+	return 0;
 }
 
 static void __usb_phy_get_charger_type(struct usb_phy *usb_phy)
@@ -661,6 +693,11 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 }
 EXPORT_SYMBOL_GPL(usb_add_phy);
 
+static struct device_type usb_phy_dev_type = {
+	.name = "usb_phy",
+	.uevent = usb_phy_uevent,
+};
+
 /**
  * usb_add_phy_dev - declare the USB PHY
  * @x: the USB phy to be used; or NULL
@@ -684,6 +721,8 @@ int usb_add_phy_dev(struct usb_phy *x)
 	if (ret)
 		return ret;
 
+	x->dev->type = &usb_phy_dev_type;
+
 	ATOMIC_INIT_NOTIFIER_HEAD(&x->notifier);
 
 	spin_lock_irqsave(&phy_lock, flags);
-- 
2.29.0

