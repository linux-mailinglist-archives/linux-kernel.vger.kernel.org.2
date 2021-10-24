Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F3438C1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhJXV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhJXV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:20 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5DC061228
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:58 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u5so18125478uao.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BejNJl14O6aHwjAG+IoiEw5ZBNgGlpDEHfmiIDvF9LI=;
        b=a19DZdYKn6qJjG6mB029RkAM3uANS7xF/XuyYFcsA1nbTX526qilPTwXg4CLoibLoI
         RJr5B9zgndK33T0bNydWSbiqyFSX6n6JB0rz5r07/puCaXtbJ+ubuyUwoT5YlXL/ioRj
         7NSG7h3kumh+tqVt9/VP7kSVQcf0ndY3UoSAkkZlhb8+9FwtXwmOAznhT2m4cci4qj6F
         uQle7LYwTIgsZw5crbY1FPkmJ2kjrrEIna5kJNl21aLkRmE+eRxXOSG6BlcEKv5s7Wtt
         JgG7NME2H0yOEuG0t9h7HazP5Uw6VnHZpr0Ewmx7EA5CpBpYfaAo2lC5uJBJ1B088GKC
         ezaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BejNJl14O6aHwjAG+IoiEw5ZBNgGlpDEHfmiIDvF9LI=;
        b=wBY6gaYdX4KsL74p5N0cbvEFYu7k8H3oOtoRzJcY4pwxbRQh9l3Bh6KbLLYqL8Bb+t
         ur7y3X2/aXa4ziLJs0r7pT257a3M3v1Db3/2GibYPz6C3fvfJVNZsxPi0uAgfZaF7Ajz
         nLhudF8TBzNtkeaVLz7q6JXlpnsjF5qJVqVXLJf4yicUqbu468esR+0pmzvi16yRKoZr
         9ApxFD12DmqKxVNJOrno8PQlQUaTmlgrIUa+u6xho2n91TbaUbr7aqW3c+cbm71PU7Ou
         Zy3ywLopfL2+d43PsMXNgcZZlrmXUu3javw7NAZQWNrTDxOCgpO34rd3onalMTs76xHc
         a2lQ==
X-Gm-Message-State: AOAM530ednAg12pMUgcB1Zc+eYo8xKD6s3bu0f11NT0z0jIqJtyXX5Lr
        MVytAP+N5/CVFhFW5p9cewI=
X-Google-Smtp-Source: ABdhPJznOSLyMtcTR/+jLCQ8ioOfyvwxdVB4py1onqrN9cLcCdIrqqmNJcFRrJ9WJThZBvcRUAclrw==
X-Received: by 2002:a05:6102:5088:: with SMTP id bl8mr11692070vsb.32.1635110757991;
        Sun, 24 Oct 2021 14:25:57 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:57 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 6/8] staging: vchiq_core: drop extern prefix in function declarations
Date:   Sun, 24 Oct 2021 18:25:22 -0300
Message-Id: <20211024212524.370078-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212524.370078-1-gascoar@gmail.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
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
2.33.1

