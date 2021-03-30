Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDEA34EE53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhC3Qqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhC3Qp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so16871523wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Hq9pyShwqk3aVu8T4UMcQUMVd+iCa+2JYczX4QC4e0=;
        b=HpLrvgthcz399Wo2MCuhSfHNFz7BzM0kk80Jgu14MSml3x044yxa6uBLdruT43zW9A
         arFt7UVkbnWM5mEBuWj6gF/PvEn63aD4IF4fboenFYiEsmV0s4/7bz26qeAKU4LLe+cd
         67u2fVGeFMk20YSqAl52U5BuLr5CG049ZUEJzfSqrcySiom6AT7DkpY6Tg/iCv5Sm0x5
         5cgN0SyFK/zeknSwtFK44wLz4z1GvmEuf0wk3Kd2npKTNmlRW/rdmA0/nyKRS38JdyyY
         Ai0oZIhkgofdNMH1YaeOIbRRQdjQqcPAzIg3m+74acIYigW0aYk5GtfpBqdz0WqVHzVR
         j6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Hq9pyShwqk3aVu8T4UMcQUMVd+iCa+2JYczX4QC4e0=;
        b=i+zi+lXKutB43fkWBicu8jQBw+hqFY+ul+Sgvyo5pjqRxJQ35N3jDZ6VSeT4+thdIa
         Mu9ni2OIj+iDn9FHG7mP9xXMx340u5ZFj2gVV0nMqMQyOA5kkldoUMCozlH6zpqxlxll
         ET9Gi20BTdaTsEL6/B8uIdua0Lj0VcYL7p5R+jsVCltjex9KKltByY2WGGwt/PJA/xAA
         Hk1FpTjhQjgyS3RlScRcY6jc3G+Z3vl7rvcCKqD2LYfaO0gBoMQMXNpc4Tg1AM86Vtba
         sxD3c7OsLgA4V0/F+6BEz4kxmrjB4A4OP1mtVtiEbDqo+62hPkvmeKLDnWrTwO/b2ubz
         gKPg==
X-Gm-Message-State: AOAM530cQHWEcfJZ8aN9sMpuju1NFrIRETSyi8OmZiSNpLNNKtHMJ81D
        vPOLuiVXIcznCdLe8gJLDLeHbQ==
X-Google-Smtp-Source: ABdhPJzpPeRwgzFeqGfKoardYK8CWO2XpYQ38weBk2G89qmtOYKUC0TNWpuBM95b5xR/4Tp6Y+OOiQ==
X-Received: by 2002:adf:f704:: with SMTP id r4mr34726452wrp.158.1617122726361;
        Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael A. Halcrow" <mhalcrow@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 25/31] fs: ecryptfs: messaging: Add missing param descriptions and demote abuses
Date:   Tue, 30 Mar 2021 17:44:52 +0100
Message-Id: <20210330164458.1625478-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/messaging.c:15: warning: Function parameter or member 'ecryptfs_msg_ctx_free_list' not described in 'LIST_HEAD'
 fs/ecryptfs/messaging.c:15: warning: expecting prototype for eCryptfs(). Prototype was for LIST_HEAD() instead
 fs/ecryptfs/messaging.c:157: warning: Function parameter or member 'daemon' not described in 'ecryptfs_exorcise_daemon'
 fs/ecryptfs/messaging.c:207: warning: Function parameter or member 'daemon' not described in 'ecryptfs_process_response'
 fs/ecryptfs/messaging.c:207: warning: expecting prototype for ecryptfs_process_reponse(). Prototype was for ecryptfs_process_response() instead
 fs/ecryptfs/messaging.c:262: warning: Function parameter or member 'msg_type' not described in 'ecryptfs_send_message_locked'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/messaging.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index c0dfd9647627a..b38bd742fd973 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2004-2008 International Business Machines Corp.
@@ -147,7 +147,7 @@ ecryptfs_spawn_daemon(struct ecryptfs_daemon **daemon, struct file *file)
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_exorcise_daemon - Destroy the daemon struct
  *
  * Must be called ceremoniously while in possession of
@@ -181,7 +181,8 @@ int ecryptfs_exorcise_daemon(struct ecryptfs_daemon *daemon)
 }
 
 /**
- * ecryptfs_process_reponse
+ * ecryptfs_process_response
+ * @daemon: eCryptfs daemon object
  * @msg: The ecryptfs message received; the caller should sanity check
  *       msg->data_len and free the memory
  * @seq: The sequence number of the message; must match the sequence
@@ -250,6 +251,7 @@ int ecryptfs_process_response(struct ecryptfs_daemon *daemon,
  * ecryptfs_send_message_locked
  * @data: The data to send
  * @data_len: The length of data
+ * @msg_type: Type of message
  * @msg_ctx: The message context allocated for the send
  *
  * Must be called with ecryptfs_daemon_hash_mux held.
-- 
2.27.0

