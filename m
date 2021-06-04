Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A639BA29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFDNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFDNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:50:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE05C061789;
        Fri,  4 Jun 2021 06:48:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m18so9400778wrv.2;
        Fri, 04 Jun 2021 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hblWKhhVFj2BU43fxgvQPVXjbtJ6ZeAeWI+WSD8RhA=;
        b=u7ST3EdEgOaOIXWFvUof1gorxmA3TYZ/mgsKTduDOVlRZXjTEThZG0k/1Buh2C7a1+
         KufeqTJhSLIJD5YlfWbrDm52LwUVlqAnuGpMy9fIEHvTNQ/8pmYBCMnWihNPvAVHn+DN
         BfpH8suKSHb3gFUrbJVAo9Pq+fHZuVc/gAvQ4GhAT03Yen7OCMuJoPvmiYWXrhAxZ5yD
         vf3s1yjQzAF2KLwugFX7mCd8+cNard654K2AqyuYnXAk29dfXaPCZBO6cgnzCRWXIhG6
         kLN5+gmweacY7yZbTbGAEiRZiJWCyVkhNI/HyhlmdaFEBVj+JrQn1S2lJD0y+TC+gM/+
         V3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hblWKhhVFj2BU43fxgvQPVXjbtJ6ZeAeWI+WSD8RhA=;
        b=hmPUYds/yGIWftTeMrnUdc/m72dkTiBPkLwQTXduq3aZkRxTNgqrTbd64d3OuJJw3Z
         l0dMIAgnmz3eRmwUCy/5Iea4FXj/KjgNXO+JwKvL3OApL4rq0S3kgFySnYitt3/I9lRd
         FpC4moj0Kh4yUj0zvVDN3bcfAmOI7HRf1+1yWQrKH7PUNyG+XRcMmr4nhqfDeP7YpZ9C
         pRyrapJBhO+vWCO4fNp45fCVfaGopsn+QcQMdkJjlgFM7b+SCw0aidvtGCUAihRXK/gg
         zhi6yLsDHMaOzDAbHZSZVdo5S2JvWqRfBN304FBoseN/+ecEUSoYz9o1dBlfzaKvgISj
         vC1w==
X-Gm-Message-State: AOAM533opuM7PCguvcTDOkUJ3VKTrEuX0PHErAj+3sQr4/pLpMQUnbaS
        Y/dZbeOZGChPqPiQeflpO+A=
X-Google-Smtp-Source: ABdhPJwYwkQQL+v1anJK+ywKT4dJxqIye3itLfWqmMOGam6q54ZtNaBdTvaE2uD8+I/vbiE6b74YPg==
X-Received: by 2002:a5d:5243:: with SMTP id k3mr4102693wrc.19.1622814503396;
        Fri, 04 Jun 2021 06:48:23 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:22 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] platform/surface: aggregator_cdev: Allow enabling of events from user-space
Date:   Fri,  4 Jun 2021 15:47:53 +0200
Message-Id: <20210604134755.535590-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While events can already be enabled and disabled via the generic request
IOCTL, this bypasses the internal reference counting mechanism of the
controller. Due to that, disabling an event will turn it off regardless
of any other client having requested said event, which may break
functionality of that client.

To solve this, add IOCTLs wrapping the ssam_controller_event_enable()
and ssam_controller_event_disable() functions, which have been
previously introduced for this specific purpose.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v2:
 - None

---
 .../surface/surface_aggregator_cdev.c         | 58 +++++++++++++++++++
 include/uapi/linux/surface_aggregator/cdev.h  | 32 ++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index dcda377896b7..7b86b36eaaa0 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -387,6 +387,58 @@ static long ssam_cdev_notif_unregister(struct ssam_cdev_client *client,
 	return ssam_cdev_notifier_unregister(client, desc.target_category);
 }
 
+static long ssam_cdev_event_enable(struct ssam_cdev_client *client,
+				   const struct ssam_cdev_event_desc __user *d)
+{
+	struct ssam_cdev_event_desc desc;
+	struct ssam_event_registry reg;
+	struct ssam_event_id id;
+	long ret;
+
+	/* Read descriptor from user-space. */
+	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
+	if (ret)
+		return ret;
+
+	/* Translate descriptor. */
+	reg.target_category = desc.reg.target_category;
+	reg.target_id = desc.reg.target_id;
+	reg.cid_enable = desc.reg.cid_enable;
+	reg.cid_disable = desc.reg.cid_disable;
+
+	id.target_category = desc.id.target_category;
+	id.instance = desc.id.instance;
+
+	/* Disable event. */
+	return ssam_controller_event_enable(client->cdev->ctrl, reg, id, desc.flags);
+}
+
+static long ssam_cdev_event_disable(struct ssam_cdev_client *client,
+				    const struct ssam_cdev_event_desc __user *d)
+{
+	struct ssam_cdev_event_desc desc;
+	struct ssam_event_registry reg;
+	struct ssam_event_id id;
+	long ret;
+
+	/* Read descriptor from user-space. */
+	ret = copy_struct_from_user(&desc, sizeof(desc), d, sizeof(*d));
+	if (ret)
+		return ret;
+
+	/* Translate descriptor. */
+	reg.target_category = desc.reg.target_category;
+	reg.target_id = desc.reg.target_id;
+	reg.cid_enable = desc.reg.cid_enable;
+	reg.cid_disable = desc.reg.cid_disable;
+
+	id.target_category = desc.id.target_category;
+	id.instance = desc.id.instance;
+
+	/* Disable event. */
+	return ssam_controller_event_disable(client->cdev->ctrl, reg, id, desc.flags);
+}
+
 
 /* -- File operations. ------------------------------------------------------ */
 
@@ -473,6 +525,12 @@ static long __ssam_cdev_device_ioctl(struct ssam_cdev_client *client, unsigned i
 		return ssam_cdev_notif_unregister(client,
 						  (struct ssam_cdev_notifier_desc __user *)arg);
 
+	case SSAM_CDEV_EVENT_ENABLE:
+		return ssam_cdev_event_enable(client, (struct ssam_cdev_event_desc __user *)arg);
+
+	case SSAM_CDEV_EVENT_DISABLE:
+		return ssam_cdev_event_disable(client, (struct ssam_cdev_event_desc __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/surface_aggregator/cdev.h b/include/uapi/linux/surface_aggregator/cdev.h
index 4f393fafc235..08f46b60b151 100644
--- a/include/uapi/linux/surface_aggregator/cdev.h
+++ b/include/uapi/linux/surface_aggregator/cdev.h
@@ -90,6 +90,36 @@ struct ssam_cdev_notifier_desc {
 	__u8 target_category;
 } __attribute__((__packed__));
 
+/**
+ * struct ssam_cdev_event_desc - Event descriptor.
+ * @reg:                 Registry via which the event will be enabled/disabled.
+ * @reg.target_category: Target category for the event registry requests.
+ * @reg.target_id:       Target ID for the event registry requests.
+ * @reg.cid_enable:      Command ID for the event-enable request.
+ * @reg.cid_disable:     Command ID for the event-disable request.
+ * @id:                  ID specifying the event.
+ * @id.target_category:  Target category of the event source.
+ * @id.instance:         Instance ID of the event source.
+ * @flags:               Flags used for enabling the event.
+ *
+ * Specifies which event should be enabled/disabled and how to do that.
+ */
+struct ssam_cdev_event_desc {
+	struct {
+		__u8 target_category;
+		__u8 target_id;
+		__u8 cid_enable;
+		__u8 cid_disable;
+	} reg;
+
+	struct {
+		__u8 target_category;
+		__u8 instance;
+	} id;
+
+	__u8 flags;
+} __attribute__((__packed__));
+
 /**
  * struct ssam_cdev_event - SSAM event sent by the EC.
  * @target_category: Target category of the event source. See &enum ssam_ssh_tc.
@@ -111,5 +141,7 @@ struct ssam_cdev_event {
 #define SSAM_CDEV_REQUEST		_IOWR(0xA5, 1, struct ssam_cdev_request)
 #define SSAM_CDEV_NOTIF_REGISTER	_IOW(0xA5, 2, struct ssam_cdev_notifier_desc)
 #define SSAM_CDEV_NOTIF_UNREGISTER	_IOW(0xA5, 3, struct ssam_cdev_notifier_desc)
+#define SSAM_CDEV_EVENT_ENABLE		_IOW(0xA5, 4, struct ssam_cdev_event_desc)
+#define SSAM_CDEV_EVENT_DISABLE		_IOW(0xA5, 5, struct ssam_cdev_event_desc)
 
 #endif /* _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H */
-- 
2.31.1

