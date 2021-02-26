Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B106325FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBZJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBZJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:18:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613FFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127so9419782ybc.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iUHJ4YRRisIbzj/gPDQEXxkcbY1C4+1mIu/PFaLnQog=;
        b=eVtjykQX7a3iQvYl2bryk72OmiRH+ix56YgMq3gp+OyFVrGHnyNBRWN7vpKH6aO4nA
         tC4Jj8ZX/96l5YY5non2b8713wHBOP28FSZzrVgbw99Z3VG1r7rDcdA2CCSmY4zSDmjI
         4In7oI7MfV8pipMsksdREMEb5Y+ctolmwIMeV2PAvbobF/7bO2nxJS3pIlWrhQLt/mJT
         s2ptlYRPfHgch0+FY3IrtUqEYMlFEKDF/QApTNeJjc+idJmwxlLU8NU93WtADCOpLGzs
         upCIfBcgLrZyKK9sCdcLizsbifzXZumDN5hK01kv+cwnMHp4t2oHFMZksRFIAVhto66V
         HN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iUHJ4YRRisIbzj/gPDQEXxkcbY1C4+1mIu/PFaLnQog=;
        b=fRsyYRz1SXTI5kAkA2IAsK7g6yr+yvuj7wcTUiaqxjlyDAEY3eQ7xtXkE6a3MjuhZq
         4CO9h3S4GGRmiM/0guKdRCIj+JiARCFTBE3D3Z1TxcEZdOWHJB5FLuoI8z1bkCXYAbVH
         N1yGFnH2KahzEHJLnQROG0Sx0J/kIzvTSfPgKEjCFlEBmilxEs8ytmTpEIjy2qfSZzB1
         xWy4xehpcTKl1lHNCXEAvbNTO9GBwIijKB2pF6t4oBO6qrrl/mvIxGyhtvfy7iXZu/pd
         CqgK+qZD6iO0sGq2TSTidR388EGleq5rpL8MThbtshWIRSJwfRlD/IxLkYI5JpWDx65X
         BnIg==
X-Gm-Message-State: AOAM531kqlXhr9Cg9nwhUj6FU5v8+eiTTOT2UCOXn+UuUKy0zblPNGYZ
        3T6RUcs34Y6leC8oNSSam0ffb5/DlcHmCg==
X-Google-Smtp-Source: ABdhPJytZ18QpC2AWlBHthypibLz2u/M0bX/RCMi3QsWmxODseYTeUPwkrdiZEDkWozlw050dv53yYiotb+pfQ==
Sender: "rickyniu via sendgmr" <rickyniu@rickyniu.ntc.corp.google.com>
X-Received: from rickyniu.ntc.corp.google.com ([2401:fa00:fc:202:31d4:be2d:8e3e:f8d3])
 (user=rickyniu job=sendgmr) by 2002:a25:ca8f:: with SMTP id
 a137mr3118930ybg.228.1614331043606; Fri, 26 Feb 2021 01:17:23 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:16:12 +0800
Message-Id: <20210226091612.508639-1-rickyniu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over 6
From:   Ricky Niu <rickyniu@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        erosca@de.adit-jv.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, rickyniu@google.com, oneukum@suse.com,
        kyletso@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the topology of the nested hubs are over 6 layers
Send uevent to user space when USB TOPO layer over 6.
Let end user more understand what happened.

Signed-off-by: Ricky Niu <rickyniu@google.com>
---
 drivers/usb/core/hub.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7f71218cc1e5..e5e924526822 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -55,6 +55,10 @@ static DEFINE_SPINLOCK(device_state_lock);
 static struct workqueue_struct *hub_wq;
 static void hub_event(struct work_struct *work);
 
+/* struct to notify userspace of hub events */
+static struct class *hub_class;
+static struct device *hub_device;
+
 /* synchronize hub-port add/remove and peering operations */
 DEFINE_MUTEX(usb_port_peer_mutex);
 
@@ -1764,6 +1768,13 @@ static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
         return true;
 }
 
+static void hub_over_tier(void)
+{
+	char *envp[2] = { "HUB=OVERTIER", NULL };
+
+	kobject_uevent_env(&hub_device->kobj, KOBJ_CHANGE, envp);
+}
+
 static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_host_interface *desc;
@@ -1831,6 +1842,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (hdev->level == MAX_TOPO_LEVEL) {
 		dev_err(&intf->dev,
 			"Unsupported bus topology: hub nested too deep\n");
+		hub_over_tier();
 		return -E2BIG;
 	}
 
@@ -5680,6 +5692,13 @@ int usb_hub_init(void)
 		return -1;
 	}
 
+	hub_class = class_create(THIS_MODULE, "usb_hub");
+	if (IS_ERR(hub_class))
+		return PTR_ERR(hub_class);
+
+	hub_device =
+		device_create(hub_class, NULL, MKDEV(0, 0), NULL, "usb_hub");
+
 	/*
 	 * The workqueue needs to be freezable to avoid interfering with
 	 * USB-PERSIST port handover. Otherwise it might see that a full-speed
@@ -5699,6 +5718,9 @@ int usb_hub_init(void)
 
 void usb_hub_cleanup(void)
 {
+	if (!IS_ERR(hub_class))
+		class_destroy(hub_class);
+
 	destroy_workqueue(hub_wq);
 
 	/*
-- 
2.30.1.766.gb4fecdf3b7-goog

