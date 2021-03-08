Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5018A330CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhCHMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCHMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:00:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B0C06175F;
        Mon,  8 Mar 2021 04:00:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so3982602pjb.1;
        Mon, 08 Mar 2021 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7aU87TbOL7pa/4cYXaJm7aQaYa0MM5avjjv9F0ZkTmY=;
        b=dYtvszeRqI7T2FE/C3qFppUXDuCb7TMCBlM9TqdHbR38e19zwlqSpW62ROXQd/TwXc
         QVEDLWSR2c16Doax47Fnkv+l61iFzX8SOIHjlI5eQldKFsaj1WqDQ+B1IEuRDEz50J84
         DVhxn4yo1gdG+8CMuVQz/SIA6lC1fzGwr9OnvR9P/rcjeWurz400cypgySNgc2+kL1bJ
         n2SOD9WVNfVRHYtQBSqAdp43+Ai+Tv2fGtemXFTgQF1liLg7s/WmABJU389gBbMrNsy4
         gAYe+/PfHVZ3QO+i0DG1QEDR4lTEz+RhwRAQHCA5TdpHJocPi7hbEULVwLUWZ1WNM03K
         axqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7aU87TbOL7pa/4cYXaJm7aQaYa0MM5avjjv9F0ZkTmY=;
        b=HCRGsQrEVGZ9/5xEXEn++DQCc9cxlM0SJnQMUsTWdkOyLD+B+6bkWEfCIzIfqkLiNN
         L3CweosrXBmvHWd+ZC9OFhL2XZaai1WU5U/AWYVuXv4USIaeAcZ+YSZGZQd3+rGBNfR3
         YtJYcVxaLnFhin3WTrUWBqg1ueTlD7TbBHxBHShOl3QQIkAqlgA7lSH7g8AIf+qw8yUE
         PcbtIAc1eCToDtYm4pn2e1omf9ncJzOOrGdjfS4e7Dlw03ti4vu3h4TKcdhjl/RBa4d8
         KUDM76r+shWZj16QJ0vO85PPWUKbdz8+0sSBz0f+1UCmSHf/aFEB4GHfYwDeUFyJZX9q
         QSvQ==
X-Gm-Message-State: AOAM531UQqHr0h/lJUHXycOszzQMPSFfNvv7K0VLq5JaUO81Me4ESkv+
        1DUavW+MJlfAMdMBm2Pboj9gJ7EHrAlXgh/s/kk=
X-Google-Smtp-Source: ABdhPJwVyJlN5EiFFr8No42fqA4UwXxFQ1osqtjP3zsGAN/iyxBdgZwUpHx96WgVrXgZ7RFyGtw7pg==
X-Received: by 2002:a17:90a:f296:: with SMTP id fs22mr23776777pjb.17.1615204825908;
        Mon, 08 Mar 2021 04:00:25 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:25 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper method
Date:   Mon,  8 Mar 2021 20:00:14 +0800
Message-Id: <59c86d37fef3075827b0884ec3dbdc56d527366a.1615203034.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

From: Chunguang Xu <brookxu@tencent.com>

Introduce bfq_entity_to_bfqg() to make it easier to obtain the
bfq_group corresponding to the entity.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  |  6 ++----
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b791e2041e49..a5f544acaa61 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *group_entity = bfqq->entity.parent;
 
-	return group_entity ? container_of(group_entity, struct bfq_group,
-					   entity) :
+	return group_entity ? bfq_entity_to_bfqg(group_entity) :
 			      bfqq->bfqd->root_group;
 }
 
@@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	 */
 	entity = &bfqg->entity;
 	for_each_entity(entity) {
-		struct bfq_group *curr_bfqg = container_of(entity,
-						struct bfq_group, entity);
+		struct bfq_group *curr_bfqg = bfq_entity_to_bfqg(entity);
 		if (curr_bfqg != bfqd->root_group) {
 			parent = bfqg_parent(curr_bfqg);
 			if (!parent)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index b8e793c34ff1..a6f98e9e14b5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -941,6 +941,7 @@ struct bfq_group {
 #endif
 
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
 
 /* --------------- main algorithm interface ----------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 070e34a7feb1..5ff0028920a2 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 	if (!group_entity)
 		group_entity = &bfqq->bfqd->root_group->entity;
 
-	return container_of(group_entity, struct bfq_group, entity);
+	return bfq_entity_to_bfqg(group_entity);
 }
 
 /*
@@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	if (bfq_entity_to_bfqq(entity))
 		return true;
 
-	bfqg = container_of(entity, struct bfq_group, entity);
+	bfqg = bfq_entity_to_bfqg(entity);
 
 	/*
 	 * The field active_entities does not always contain the
@@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
 	return bfqq;
 }
 
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
+{
+	struct bfq_group *bfqg = NULL;
+
+	if (entity->my_sched_data)
+		bfqg = container_of(entity, struct bfq_group, entity);
+
+	return bfqg;
+}
 
 /**
  * bfq_delta - map service into the virtual time domain.
@@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
+		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
 
 		if (!entity->in_groups_with_pending_reqs) {
-- 
2.30.0

