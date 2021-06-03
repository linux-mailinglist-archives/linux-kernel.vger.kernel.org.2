Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C183C39AEDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFCXsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:48:52 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34389 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhFCXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:48:50 -0400
Received: by mail-wr1-f52.google.com with SMTP id q5so7495386wrm.1;
        Thu, 03 Jun 2021 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jQpvGaCiBdiuAbKnU33PQlmCshsXsotPLm5iLgMP/8=;
        b=T6RWuNZjWgBAMFIwcT4gkrRCiPxaqanlKkAgnkvAnay7wPPlu2hT2tBUhlWDt7nOCU
         Qvs6FKun7ykH2Wlo0VI7Fd9gdv2IFi18IvfAsgzRJFSc2pWX+xL1c8jXH0sT652l1jnF
         EF41iY1HRv7nCMb0lmPC2D3X2HWaJjqzyOZtc1gXpSoQpIikCs7NItwVWpaXGKLa7xRA
         tLfFkSq5AmqheVMMWKe5t9seRvuw/++C4KaDE1S0hZrYPcyTSx7SFtFDTPlvcFX1uJMF
         5fL/5KWPpt4AfQNQyymQgpYuQfJAVs76Yo+EeEvQaG/91V6BANqSSmw71ZR/guVLo3Tx
         4d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jQpvGaCiBdiuAbKnU33PQlmCshsXsotPLm5iLgMP/8=;
        b=EsErU1lK/jdZrZU4Ae5VQkmvCgQIVbNOh6G1N8ffjK+gDHhlM4PwmlbArgQ11dqU5h
         SQQIMiPHep3rrlK4mGj9HLEXD773Wob36lN+BdSmuGL8UVfEvKVRdueAjLvsETNnH0Mn
         i/fPleWYa1wKd7LTsRWwTuYqklVJnngMRJeWgo66BPsjLpvUR/MQETumvBpLKjocLyer
         tDVsjfdbvt7jGuw9p9BoeLW5oohC3THz275L3L+Ap6I/dSsB1Sb8PJ8Ztxbx6McVUH2L
         AU8EI5Fw8l5vjWJbUIY7QurLFFomre8a87gXvd+RLkHOIflamrA/qu36MzOdElHVuoBv
         tnHA==
X-Gm-Message-State: AOAM533MRde+Lj1qjOtUcKbv6q7roxxvfkiPvDg//zaW7X+5HCwEw8Yn
        opfS7d2WgDpY+TTnmsEPqis=
X-Google-Smtp-Source: ABdhPJwxkbHwWEKAKVOMFQ96tZwScVfITXBMpWcs88OEEpveZvPZ5FMkYniNbxU5FlHRLGLxQQ4ZsQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr851015wrr.340.1622763948396;
        Thu, 03 Jun 2021 16:45:48 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:47 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] platform/surface: aggregator_cdev: Allow enabling of events from user-space
Date:   Fri,  4 Jun 2021 01:45:24 +0200
Message-Id: <20210603234526.2503590-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
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
---
 .../surface/surface_aggregator_cdev.c         | 58 +++++++++++++++++++
 include/uapi/linux/surface_aggregator/cdev.h  | 32 ++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 807930144039..e0f3c437b8ee 100644
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
 
@@ -470,6 +522,12 @@ static long __ssam_cdev_device_ioctl(struct ssam_cdev_client *client, unsigned i
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

