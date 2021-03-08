Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33304330CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhCHMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhCHMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:00:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E03C06174A;
        Mon,  8 Mar 2021 04:00:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so2843069pjb.0;
        Mon, 08 Mar 2021 04:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hPWaKTaDcnzsE0zwB2UeV0J2EPW8jgVbhQv8Balc2KE=;
        b=To3fhsHbVbF3EQG563yfHIgfkRT0BFMyBZj/Rq41z+RUmEL/93iik32uDQjkqT2JTj
         b5zECUzVBvDbahGNxtzHdBjQGV7po/Oi9bn4vrKgTEo9jEZX3UzBsqYHHpLMiDR2eybA
         Y+IGWJ9uCdv0DbILozJ99tzmCWJROTqtx2csOhunEGrmgUTC21dZ+BdJ58SwXYQQ29b/
         Ccbx/SanLhwt/fiXGxUaM0xfJstbp1DHnEag4ZkIF150kHcL5z2oeF+SjRh/Ys01Zs8E
         5KV27gVMo8Je6QKwdvy5GJt4NgUiLapvD5qoK3vBm9/jR7s03HongXFb/lnpKLw+YamM
         94mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hPWaKTaDcnzsE0zwB2UeV0J2EPW8jgVbhQv8Balc2KE=;
        b=UoVfqYUMS1v3kwbcA/PV4p/hZSE79RxIWmZjn7KzAIuhKTadi7we5m4w06QDFLpvnN
         VgJkyZMs/8gds3K2Ooghb0jpVJwtPqewpAE8P5ldy+Ez0Jo3Y8zGTbkGkLL3iBcgTSK+
         eftnY3ubHrzv1b+9Dyw9Rhf2yQAvR9Oads19SjTe00oH68TSSlYtx/WtydPkyw+VdORU
         zjCdB97xcAWDwBJzmyhDE9PdQn5wXbBW3+WG71xlj1tojCwPV2i101uGe+GDM/gQeruO
         eQ7vjHf2PIxDTjfFO94Pz8XnwI0GEFlthQTDeddYmmau8YS+6FlanYsLmZAgVoTRS5q1
         zIKQ==
X-Gm-Message-State: AOAM530wJaq+Hm9FIuNdQ3iI59csIUfTK8wm++oShhTH/weYIbUgvBtA
        dw4RiLHU4IllADHhvBYDIjk=
X-Google-Smtp-Source: ABdhPJxP9ccEbmquoKcasw2WIPqWfHkOhlEyqN9L5ZhkKntzaCXCtJK5Er18jBZ0R5PyqXyk6oGJtA==
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr23919419pjb.43.1615204832193;
        Mon, 08 Mar 2021 04:00:32 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:31 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] bfq: introduce bfq.ioprio for cgroup
Date:   Mon,  8 Mar 2021 20:00:18 +0800
Message-Id: <b6f82f51ed1f24bfa180a69f4c06b1150f4f04a3.1615203034.git.brookxu@tencent.com>
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

Tasks in the production environment can be roughly divided into
three categories: emergency tasks, ordinary tasks and offline
tasks. Emergency tasks need to be scheduled in real time, and the
amount of data for such tasks is usually not very large, such as
system agents. Offline tasks do not need to guarantee QoS, but
can improve system resource utilization during system idle
periods, such as various background tasks. The above requirements
need to achieve IO preemption. At present, we can use weights to
simulate IO preemption, but since weights are more of a shared
concept, they cannot be simulated well. For example, the weights
of emergency tasks and ordinary tasks cannot be determined well,
offline tasks (with the same weight) actually occupy different
resources on disks with different performance, and the tail delay
caused by offline tasks cannot be well controlled. Using ioprio's
concept of preemption, we can solve the above problems very well.
Second, we can still use weights to control resource isolation of
the same priority, thereby achieving better IO Qos control.

However, currently implemented by bfq, the class of bfq_group is
always be class, and the ioprio class of the task can only be
reflected in a single cgroup. We cannot guarantee that real-time
tasks in a cgroup are scheduled in time. To this end, we
introduced cgroup ioprio. In this way, we can ensure that the
real-time tasks of a cgroup can be scheduled in time. Similarly,
the processing of offline task groups can also be simpler.

To this end, we have introduced the bfq.ioprio interface for
cgroup v1 and cgroup v2. Users can configure the priority
through this interface, as shown below:

echo "1 2"> blkio.bfq.weight

The above two values respectively represent the values of ioprio
class and ioprio for cgroup. The ioprio of tasks within the cgroup
is uniformly equal to the ioprio of the cgroup. If the ioprio of
the cgroup is disabled, the ioprio of the task remains the same,
usually from io_context.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++-
 block/bfq-iosched.c |  5 +++
 block/bfq-iosched.h |  8 +++++
 block/bfq-wf2q.c    | 30 +++++++++++++---
 4 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a5f544acaa61..0b0a3514a5d2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -489,7 +489,7 @@ static struct bfq_group_data *cpd_to_bfqgd(struct blkcg_policy_data *cpd)
 	return cpd ? container_of(cpd, struct bfq_group_data, pd) : NULL;
 }
 
-static struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
+struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
 {
 	return cpd_to_bfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_bfq));
 }
@@ -553,6 +553,16 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
+
+	bfqg->new_ioprio_class = IOPRIO_PRIO_CLASS(d->ioprio);
+	bfqg->new_ioprio = IOPRIO_PRIO_DATA(d->ioprio);
+	bfqg->ioprio_class = bfqg->new_ioprio_class;
+	bfqg->ioprio = bfqg->new_ioprio;
+
+	if (d->ioprio) {
+		entity->new_weight = bfq_ioprio_to_weight(bfqg->ioprio);
+		entity->weight = entity->new_weight;
+	}
 }
 
 static void bfq_pd_free(struct blkg_policy_data *pd)
@@ -981,6 +991,20 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int bfq_io_show_ioprio(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	unsigned int val = 0;
+
+	if (bfqgd)
+		val = bfqgd->ioprio;
+
+	seq_printf(sf, "%u %lu\n", IOPRIO_PRIO_CLASS(val), IOPRIO_PRIO_DATA(val));
+
+	return 0;
+}
+
 static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_weight)
 {
 	weight = dev_weight ?: weight;
@@ -1098,6 +1122,55 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 	return bfq_io_set_device_weight(of, buf, nbytes, off);
 }
 
+static ssize_t bfq_io_set_ioprio(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	struct blkcg_gq *blkg;
+	unsigned int class, data;
+	char *endp;
+
+	buf = strstrip(buf);
+
+	class = simple_strtoul(buf, &endp, 10);
+	if (*endp != ' ')
+		return -EINVAL;
+	buf = endp + 1;
+
+	data = simple_strtoul(buf, &endp, 10);
+	if ((*endp != ' ') && (*endp != '\0'))
+		return -EINVAL;
+
+	if (class > IOPRIO_CLASS_IDLE || data >= IOPRIO_BE_NR)
+		return -EINVAL;
+
+	spin_lock_irq(&blkcg->lock);
+	bfqgd->ioprio = IOPRIO_PRIO_VALUE(class, data);
+	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+		if (bfqg) {
+			if ((bfqg->ioprio_class != class) ||
+			    (bfqg->ioprio != data)) {
+				unsigned short weight;
+
+				weight = class ? bfq_ioprio_to_weight(data) :
+					BFQ_WEIGHT_LEGACY_DFL;
+
+				bfqg->new_ioprio_class = class;
+				bfqg->new_ioprio = data;
+				bfqg->entity.new_weight = weight;
+				bfqg->entity.prio_changed = 1;
+			}
+		}
+	}
+	spin_unlock_irq(&blkcg->lock);
+
+	return nbytes;
+}
+
 static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
@@ -1264,6 +1337,12 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
+	{
+		.name = "bfq.ioprio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_ioprio,
+		.write = bfq_io_set_ioprio,
+	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
@@ -1384,6 +1463,12 @@ struct cftype bfq_blkg_files[] = {
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
+	{
+		.name = "bfq.ioprio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_ioprio,
+		.write = bfq_io_set_ioprio,
+	},
 	{} /* terminate */
 };
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 223affaa7c92..fe05d73d0fed 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5130,7 +5130,12 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 {
 	struct bfq_data *bfqd = bic_to_bfqd(bic);
 	struct bfq_queue *bfqq;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(__bio_blkcg(bio));
+	int ioprio = bfqgd->ioprio ?: bic->icq.ioc->ioprio;
+#else
 	int ioprio = bic->icq.ioc->ioprio;
+#endif
 
 	/*
 	 * This condition may trigger on a newly created bic, be sure to
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 2fe7456aa7bc..d5c05d5f9714 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -868,6 +868,7 @@ struct bfq_group_data {
 	struct blkcg_policy_data pd;
 
 	unsigned int weight;
+	unsigned short ioprio;
 };
 
 /**
@@ -924,6 +925,11 @@ struct bfq_group {
 
 	int active_entities;
 
+	/* current ioprio and ioprio class */
+	unsigned short ioprio, ioprio_class;
+	/* next ioprio and ioprio class if a change is in progress */
+	unsigned short new_ioprio, new_ioprio_class;
+
 	struct rb_root rq_pos_tree;
 
 	struct bfqg_stats stats;
@@ -992,6 +998,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
 void bfq_end_wr_async(struct bfq_data *bfqd);
+struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg);
 struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 				     struct blkcg *blkcg);
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
@@ -1038,6 +1045,7 @@ extern struct blkcg_policy blkcg_policy_bfq;
 
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+unsigned int bfq_class_idx(struct bfq_entity *entity);
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
 struct bfq_entity *bfq_entity_of(struct rb_node *node);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 0d10eb3ed555..01172202b076 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -27,12 +27,21 @@ static struct bfq_entity *bfq_root_active_entity(struct rb_root *tree)
 	return rb_entry(node, struct bfq_entity, rb_node);
 }
 
-static unsigned int bfq_class_idx(struct bfq_entity *entity)
+unsigned int bfq_class_idx(struct bfq_entity *entity)
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	unsigned short class = BFQ_DEFAULT_GRP_CLASS;
 
-	return bfqq ? bfqq->ioprio_class - 1 :
-		BFQ_DEFAULT_GRP_CLASS - 1;
+	if (bfqq)
+		class = bfqq->ioprio_class;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	else {
+		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
+
+		class = bfqg->ioprio_class ?: BFQ_DEFAULT_GRP_CLASS;
+	}
+#endif
+	return class - 1;
 }
 
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd)
@@ -767,14 +776,25 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 				  bfq_weight_to_ioprio(entity->orig_weight);
 		}
 
-		if (bfqq && update_class_too)
-			bfqq->ioprio_class = bfqq->new_ioprio_class;
+		if (update_class_too) {
+			if (bfqq)
+				bfqq->ioprio_class = bfqq->new_ioprio_class;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+			else
+				bfqg->ioprio_class = bfqg->new_ioprio_class;
+#endif
+		}
 
 		/*
 		 * Reset prio_changed only if the ioprio_class change
 		 * is not pending any longer.
 		 */
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		if ((bfqq && bfqq->ioprio_class == bfqq->new_ioprio_class) ||
+		    (!bfqq && bfqg->ioprio_class == bfqg->new_ioprio_class))
+#else
 		if (!bfqq || bfqq->ioprio_class == bfqq->new_ioprio_class)
+#endif
 			entity->prio_changed = 0;
 
 		/*
-- 
2.30.0

