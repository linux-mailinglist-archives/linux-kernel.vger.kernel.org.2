Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648DF4203D8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhJCUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJCUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:03:10 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17155C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:01:23 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id o204so6719383vko.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSkH/ZagQntPkG0C2DpHNBonj7Wo9RInBQiBWcy5XFE=;
        b=FSO1rIOGJgjGiv0ApTs5p11TPMuTpriYaPVgrHJ3Ymoy4Vmr4Mj1Iv+ZJ08WnQQ36M
         oFKPlsXpEsA7zdaSMkxh+eXEPtBVTvQ42QMZaGizQ2zDiIYghKJFs7rvufnuH6uHqgEw
         5t1wuryuuIyReaU9YGRcPdrtP9PdpycpZIX/xk2214nQNa5Hcs78RBMT4qFsdy5QmpR6
         g51yVi5hsXjkkqiuLWGS3yMOnZrnbk/aoYn7ZM6UFPPWqXOnyEel9h31qlWqDpw83SQi
         /GCUwj2gMtOyK+ngDLMus1oGLT80ovzWGh8izppnMoeK25xeqBByhZ0RTFHE/AGqOKD3
         mbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSkH/ZagQntPkG0C2DpHNBonj7Wo9RInBQiBWcy5XFE=;
        b=FcKus7mZBBHu/e1x+dYSojOiveAeMKkzMGk2weVRk2FpZsiXKxwFXk9mHMgAj+iK3l
         aw22F9BVrFDHh93G9NAk122YaBdi3m8wVdliGq+uK0BQiLmm8/QtPdgHnZs5tYQS9BGi
         jpE0sFD2dr9HVnI9fVJqzKlEkpzszzgZt8cuE4CrqcBr8lJMFjl4e6zu5XV6zZkEWP3f
         gL8dUNVfJvsr+tqtb27zQc19Q3AC+R1flru7X0sFaEzI6Tqdc7jaQVHf6YclQWJ+lMOU
         I91DzBihIVGlg6j9X4D6XogciFTrqR4DbKq1juC2jm9xkALPGJ8g/rJnc9SJ3rs6ojjE
         tf7A==
X-Gm-Message-State: AOAM532jHix7As+yE9NQdZpu9mGBK/mzGDyYRD2IEgLol6bbS5bU5KbW
        1ZUHPPmUyCURbsA6DqKk5hk=
X-Google-Smtp-Source: ABdhPJzU68BmIDYtHfc0+zSQmhGaxNeqKRjgG2+yjrVl4QCsdCZRiqlgrdrml8y6cL4VTEDQDqInGA==
X-Received: by 2002:a1f:c602:: with SMTP id w2mr13384373vkf.26.1633291282261;
        Sun, 03 Oct 2021 13:01:22 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:01:21 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 5/9] staging: vchiq: drop trailing semicolon in macro definition
Date:   Sun,  3 Oct 2021 16:57:58 -0300
Message-Id: <20211003195758.36572-6-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl, macro should not use a trailing semicolon.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 +++---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h  | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index fcff2e5bd73f..08c03acd8592 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -930,7 +930,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	struct vchiq_completion_data_kernel *completion;
 	int insert;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 
 	insert = instance->completion_insert;
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
@@ -998,7 +998,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	struct vchiq_instance *instance;
 	bool skip_completion = false;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e327393800da..026c7c775e40 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1585,7 +1585,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 	unsigned int localport, remoteport;
 	int msgid, size, type, ret = -EINVAL;
 
-	DEBUG_INITIALISE(state->local)
+	DEBUG_INITIALISE(state->local);
 
 	DEBUG_VALUE(PARSE_HEADER, (int)(long)header);
 	msgid = header->msgid;
@@ -1856,7 +1856,7 @@ parse_rx_slots(struct vchiq_state *state)
 	struct vchiq_shared_state *remote = state->remote;
 	int tx_pos;
 
-	DEBUG_INITIALISE(state->local)
+	DEBUG_INITIALISE(state->local);
 
 	tx_pos = remote->tx_pos;
 
@@ -1961,7 +1961,7 @@ slot_handler_func(void *v)
 	struct vchiq_state *state = v;
 	struct vchiq_shared_state *local = state->local;
 
-	DEBUG_INITIALISE(local)
+	DEBUG_INITIALISE(local);
 
 	while (1) {
 		DEBUG_COUNT(SLOT_HANDLER_COUNT);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index a107c72ce3a6..e54e9d80bd7f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -104,7 +104,7 @@ enum {
 
 #if VCHIQ_ENABLE_DEBUG
 
-#define DEBUG_INITIALISE(local) int *debug_ptr = (local)->debug;
+#define DEBUG_INITIALISE(local) int *debug_ptr = (local)->debug
 #define DEBUG_TRACE(d) \
 	do { debug_ptr[DEBUG_ ## d] = __LINE__; dsb(sy); } while (0)
 #define DEBUG_VALUE(d, v) \
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 32aa1e62450d..2325844b0880 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -210,7 +210,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 	struct vchiq_header *header;
 	int ret;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 	service = find_service_for_instance(instance, args->handle);
 	if (!service)
@@ -439,7 +439,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 	int remove;
 	int ret;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 
 	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 	if (!instance->connected)
-- 
2.33.0

