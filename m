Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361645D0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbhKXXRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbhKXXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:17:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:14:03 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g18so4087975pfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+U5SGOWryCFsIXc1FRU37Odr/vxnrrGVzlEIkyDYMM=;
        b=RkqLqi5X48t2gyoiWTDVOTX0uqmzLpSN1ZxHRwxnjvrU13N+E1TbvrOGpnx+MZ5yZn
         FgiWfqJBe3s66EQrJewh5mIfREL4qivKJCjo3tKD7yjV+AziYYRVTKIb555MC7NwJxzK
         fi3cDpi0RWibTKK8DzcbBKDSTHs7YLdh5kCTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+U5SGOWryCFsIXc1FRU37Odr/vxnrrGVzlEIkyDYMM=;
        b=Umyfqzdup5xzWzWLi+/B7V2wwwdwKyBNZVmVw4QiuC9pmI6llSZvLLophowrvqx/Dv
         nV2S2JaLTqRNRMqY7/1fIbQB3yg7fXvwz36I9iYYSi16U5H/hgo9baB85AVvmQ046d2p
         NxSVImChUJHKklKuba+ZbJnmJJVSOJZZzEhyOUd/694YOGOwkMaPR168wvOM5xlMa3uM
         SaVq4BpyGpa4/5H87JYqTA6l4zN050GwxNCmCeO7NxET+KilVp+gCJotK7byQNBJ37Db
         jCLz2MP0YgBr7YATIIDokPejDfcVlzA9Eto19VLnPOc+M/CZlOhs5jna9XDYXQiG6pSB
         R1JQ==
X-Gm-Message-State: AOAM533lypEFeZP9zFaIZdBA9W+ai6BhyOGlfJ4C0ANekbjNx4NfvkAm
        Rfndcw4yGEQAaLHIkAuKpZyK0+IrV8wFlA==
X-Google-Smtp-Source: ABdhPJzhRfP74wbcFqjtZ97Uq9fzfvncJBvUhnd8kKdjYwn68j4g5nYZ6AufpOFut2igocB20dVotQ==
X-Received: by 2002:a65:648b:: with SMTP id e11mr12997512pgv.138.1637795643090;
        Wed, 24 Nov 2021 15:14:03 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6bc9:896a:9df2:5d61])
        by smtp.gmail.com with ESMTPSA id nn15sm5783296pjb.11.2021.11.24.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:14:02 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     wonchung@google.com, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 4/4] Revert "usb: Iterator for ports"
Date:   Wed, 24 Nov 2021 15:10:14 -0800
Message-Id: <20211124231028.696982-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211124231028.696982-1-pmalani@chromium.org>
References: <20211124231028.696982-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b433c4c789d612cf58739a772bbddbd949bafd20.

We no longer use typec_link_ports() to link a newly registered Type C
port to pre-existing USB ports, so we don't need this iterator anymore.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/core/usb.c | 46 ------------------------------------------
 include/linux/usb.h    |  9 ---------
 2 files changed, 55 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62368c4ed37a..2ce3667ec6fa 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -398,52 +398,6 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
 }
 EXPORT_SYMBOL_GPL(usb_for_each_dev);
 
-struct each_hub_arg {
-	void *data;
-	int (*fn)(struct device *, void *);
-};
-
-static int __each_hub(struct usb_device *hdev, void *data)
-{
-	struct each_hub_arg *arg = (struct each_hub_arg *)data;
-	struct usb_hub *hub;
-	int ret = 0;
-	int i;
-
-	hub = usb_hub_to_struct_hub(hdev);
-	if (!hub)
-		return 0;
-
-	mutex_lock(&usb_port_peer_mutex);
-
-	for (i = 0; i < hdev->maxchild; i++) {
-		ret = arg->fn(&hub->ports[i]->dev, arg->data);
-		if (ret)
-			break;
-	}
-
-	mutex_unlock(&usb_port_peer_mutex);
-
-	return ret;
-}
-
-/**
- * usb_for_each_port - interate over all USB ports in the system
- * @data: data pointer that will be handed to the callback function
- * @fn: callback function to be called for each USB port
- *
- * Iterate over all USB ports and call @fn for each, passing it @data. If it
- * returns anything other than 0, we break the iteration prematurely and return
- * that value.
- */
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	struct each_hub_arg arg = {data, fn};
-
-	return usb_for_each_dev(&arg, __each_hub);
-}
-EXPORT_SYMBOL_GPL(usb_for_each_port);
-
 /**
  * usb_release_dev - free a usb device structure when all users of it are finished.
  * @dev: device that's been disconnected
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7ccaa76a9a96..200b7b79acb5 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -875,15 +875,6 @@ extern struct usb_host_interface *usb_find_alt_setting(
 		unsigned int iface_num,
 		unsigned int alt_num);
 
-#if IS_REACHABLE(CONFIG_USB)
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
-#else
-static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	return 0;
-}
-#endif
-
 /* port claiming functions */
 int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
-- 
2.34.0.rc2.393.gf8c9666880-goog

