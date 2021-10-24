Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D6438C20
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJXV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhJXV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:19 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CFC061224
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:55 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id o12so14158708uap.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wY2nDclaLgOKVb3wF2iM6yH+HK65pZ+hsDlb1ZpHiao=;
        b=eEG+LojCcslFHQf9iugJoCrICaZoeRodDnaYqj7KCp5S086utIChtfXmxUDp8z/Kcb
         bbw3nyaSIj19kACxCe+awkpcYlbC21Ds7xH93J0we6UBpAKPwtbmGfSKtkoSTsQEw2BE
         x02iaydXb09w4u4QL312fE0EtwXjXtPsnVYKtwrtppjKJDFrBrrOLXOF15yXF+xrr6rX
         uSnSsWDWrPyEIiaAB1mTlCXyfYFODJ4RA64j876q8Xqw0HBUeooFXSrBfAaL7ZgEYLmW
         LBl30izeWZyzKCgT2MgVyApZywaxSSH7/iHz9DJTcKJ12kff3tts8xn6hCD61g86BvGy
         qUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wY2nDclaLgOKVb3wF2iM6yH+HK65pZ+hsDlb1ZpHiao=;
        b=524Zdf8Zrsy+k182jCpFgGKxAvVsm8fww+0whVOprMa9f4+p1GsKtwqbt/C+YF9An+
         NIYpwPTbgr6RxcyjCYvqYyKmQCDnXxkkwpBfFAZANl4a3+Vmo+OR1FepaLoClQ+oF1PI
         03EM8kNZUPrNVI8JHHZ2rjU0n3TnbCthHJ9ONi3ffcuB0fk5UNaQuKsm9H2Mm5X+aZfW
         RvM0hMqeAhzqUC+tGFZuLXq2BrlD55G2YuVIQiHZBZVN5dwRbN9Mbn2XfSCEK28IJD9U
         W2yRWqJFjjD/rRAuSe7YVPLKrXpzdlYjEpNHIt+yPjtTqEXzShJ4B+D+Sc/bofaAk0YC
         SjkA==
X-Gm-Message-State: AOAM530+ewbPr+NW8cRYOKRu9Hcc7XgObVCFbeO7mj7RCLDxr7/73QEi
        mwcZb6ZdOJ9H27mcr9slj+M=
X-Google-Smtp-Source: ABdhPJwo7pa5FDNVmAAzL9vvajkYDwrBsn4NR3XSiB3WmgCUDTO7UMQgoxuUDMUB3LJBawJ/AtJpbA==
X-Received: by 2002:a05:6102:304e:: with SMTP id w14mr11429886vsa.52.1635110755219;
        Sun, 24 Oct 2021 14:25:55 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:54 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 5/8] staging: vchiq: drop trailing semicolon in macro definition
Date:   Sun, 24 Oct 2021 18:25:21 -0300
Message-Id: <20211024212524.370078-6-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212524.370078-1-gascoar@gmail.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl, macro definitions should not use a trailing
semicolon.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 +++---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h  | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6fbafdfe340f..d27c5191fbd2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -986,7 +986,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	struct vchiq_completion_data_kernel *completion;
 	int insert;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 
 	insert = instance->completion_insert;
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
@@ -1054,7 +1054,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	struct vchiq_instance *instance;
 	bool skip_completion = false;
 
-	DEBUG_INITIALISE(g_state.local)
+	DEBUG_INITIALISE(g_state.local);
 
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index d64d6a0427eb..22d0e706b2dc 100644
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
2.33.1

