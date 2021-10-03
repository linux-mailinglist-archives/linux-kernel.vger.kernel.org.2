Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27774203D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhJCUDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJCUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:03:13 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A408C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:01:25 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id u66so946467vku.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2/W18IRRr+MCGYPxXwCA4Xe9jbsY9mJx5CTn4+TVlk=;
        b=Bgare4OzVdITE+F0Xw0Dp+o+LtUtRbqhCKt+JbGEtlOyOu45qgaHqH+OvTpG1Hu2OF
         3UgqmG5McaQn87E6H9W2oQb1XDEszt6APSHvn5uk45a3wN2/dlVCa+eI32VA/9WN0lWy
         Vm9U42Ty0WdmS0wtEuB4aNe/tU7KwVIVQIKY0ydWx0zW0sdnAEVECGUrnx/mrQYlUH/4
         1D2XFfZKK2kqTqAHeB3TvVIkltBTmfClS3kB+9nqwg1ZOBD+ggdS7ulwmmy+Y6vLheoa
         3EvWoRCWKtZoIrUmy0GDSpwPi55zgNv5aiTO5SJesX9MfiClq/H/Z5Hz5J+sNfIWILq/
         wSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2/W18IRRr+MCGYPxXwCA4Xe9jbsY9mJx5CTn4+TVlk=;
        b=YtoEh8kzrGB4ymo4TNbgveODnYmfTH8oK44NnRZdU9rVndaFq31GG2ynTKOuA/le9s
         W2AO5nEkJFEQGBCvsyUmgwI7T5CXgaz11QH5k7OlfJiT8lnnJjkovbI0YNdzlHHNubyx
         huf7Mu4Yl0DhFrDGVtYKgwfU4djx+lq7KF+EN9kxqQpBEE9sw683zHMrnNYO98bcfJ2D
         iQHTCZSxmVIxrMHnlZziLpT0YLqeunabUk00u9hOjSLmTVddfUZZ2i9D2ynX0+cEdn1v
         W256foIbLLbmD7EuAtgMw5wH6985gePOCknfdzQG2Yge1NZi7wyy7l3dwfY9XrSXYmih
         7uRA==
X-Gm-Message-State: AOAM53355Ag871DBWMspo+lHnyQlst4us8qJwjwKTuLGy9VYDFCTvs3t
        qXxo73GzubReWI4ckb+iWjY=
X-Google-Smtp-Source: ABdhPJwVtM/uMninbsURZpUiTRrMK9ZrsH0TH4Cj4HNHt2DZefpLEd3TuXCeredbiXXXLuFvPymoiw==
X-Received: by 2002:ac5:cbd5:: with SMTP id h21mr14355711vkn.1.1633291284689;
        Sun, 03 Oct 2021 13:01:24 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:01:24 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 6/9] staging: vchiq_core: drop extern prefix in function declarations
Date:   Sun,  3 Oct 2021 16:57:59 -0300
Message-Id: <20211003195758.36572-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary extern prefix in function declarations.

While at it, remove a now outdated comment and realign the function
declarations in order to improve readability.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../interface/vchiq_arm/vchiq_core.h          | 76 ++++++-------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index e54e9d80bd7f..3e50910ecba3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -559,79 +559,53 @@ vchiq_queue_message(unsigned int handle,
 		    void *context,
 		    size_t size);
 
-/*
- * The following functions are called from vchiq_core, and external
- * implementations must be provided.
- */
+int vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset, void __user *uoffset,
+			    int size, int dir);
 
-extern int
-vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset,
-			void __user *uoffset, int size, int dir);
+void vchiq_complete_bulk(struct vchiq_bulk *bulk);
 
-extern void
-vchiq_complete_bulk(struct vchiq_bulk *bulk);
+void remote_event_signal(struct remote_event *event);
 
-extern void
-remote_event_signal(struct remote_event *event);
+int vchiq_dump(void *dump_context, const char *str, int len);
 
-extern int
-vchiq_dump(void *dump_context, const char *str, int len);
+int vchiq_dump_platform_state(void *dump_context);
 
-extern int
-vchiq_dump_platform_state(void *dump_context);
+int vchiq_dump_platform_instances(void *dump_context);
 
-extern int
-vchiq_dump_platform_instances(void *dump_context);
+int vchiq_dump_platform_service_state(void *dump_context, struct vchiq_service *service);
 
-extern int
-vchiq_dump_platform_service_state(void *dump_context, struct vchiq_service *service);
+int vchiq_use_service_internal(struct vchiq_service *service);
 
-extern int
-vchiq_use_service_internal(struct vchiq_service *service);
+int vchiq_release_service_internal(struct vchiq_service *service);
 
-extern int
-vchiq_release_service_internal(struct vchiq_service *service);
+void vchiq_on_remote_use(struct vchiq_state *state);
 
-extern void
-vchiq_on_remote_use(struct vchiq_state *state);
+void vchiq_on_remote_release(struct vchiq_state *state);
 
-extern void
-vchiq_on_remote_release(struct vchiq_state *state);
+int vchiq_platform_init_state(struct vchiq_state *state);
 
-extern int
-vchiq_platform_init_state(struct vchiq_state *state);
+enum vchiq_status vchiq_check_service(struct vchiq_service *service);
 
-extern enum vchiq_status
-vchiq_check_service(struct vchiq_service *service);
+void vchiq_on_remote_use_active(struct vchiq_state *state);
 
-extern void
-vchiq_on_remote_use_active(struct vchiq_state *state);
+enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state);
 
-extern enum vchiq_status
-vchiq_send_remote_use(struct vchiq_state *state);
+enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state);
 
-extern enum vchiq_status
-vchiq_send_remote_use_active(struct vchiq_state *state);
-
-extern void
-vchiq_platform_conn_state_changed(struct vchiq_state *state,
-				  enum vchiq_connstate oldstate,
+void vchiq_platform_conn_state_changed(struct vchiq_state *state,
+				       enum vchiq_connstate oldstate,
 				  enum vchiq_connstate newstate);
 
-extern void
-vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
+void vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
-extern void
-vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
+void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
 
-extern enum vchiq_status vchiq_remove_service(unsigned int service);
+enum vchiq_status vchiq_remove_service(unsigned int service);
 
-extern int vchiq_get_client_id(unsigned int service);
+int vchiq_get_client_id(unsigned int service);
 
-extern void vchiq_get_config(struct vchiq_config *config);
+void vchiq_get_config(struct vchiq_config *config);
 
-extern int
-vchiq_set_service_option(unsigned int service, enum vchiq_service_option option,
-			 int value);
+int vchiq_set_service_option(unsigned int service, enum vchiq_service_option option, int value);
 
 #endif
-- 
2.33.0

