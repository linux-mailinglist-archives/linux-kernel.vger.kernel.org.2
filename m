Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7241F553
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbhJATCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355964AbhJATCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:02:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F14C06177F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 12:00:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id c2-20020a63d5020000b029023ae853b72cso6773595pgg.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=oA4D6jdogE7b/uxQa2O7tT0f2ZE2oMjI4z42jgRtcc8=;
        b=CwC2586zm2KkYzc/zO4TibKRvuGJhARCs0kdLQas3WOjM5X9DtAUcCSoLuF/k0hEsf
         Qud32VB81TbVE69nvAZnu/lgmWXRqUHZu/l5m1DD8yVCvRg2BkOk8Lh03i7d4azOgwpb
         k24FlBtLBbtPAiKELRevmpnJJOM0fSEVyyEu714vSz7JBVobN4ZXo0ibB2fuHo0v+1zE
         qkOw61zTfTidMcwKd8zyQSdHVPDEe23/Ls5YK2dVGWsVoV5I6WEIKNQ5M6ko8dRb/Qy8
         kzC1BhoUajYaJ6MPwXM67juENfPQvzXTiRCBlfmuSt9qn+6M4EVnyaPf5aYX2hBpKhaX
         aqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=oA4D6jdogE7b/uxQa2O7tT0f2ZE2oMjI4z42jgRtcc8=;
        b=CRUmhZ33FupoRW+mpU0YXttXVqAemDxU+sf49hHyxVVvWof1LCU8SdoRzM1RcmRnL9
         11Co8RpS8wvrX7E5wDbPFq21MkyeUSInGs7cVIbsnR++3xmwqjTRDRS8nD369V3yvEdV
         jZ1CHkgKKeZi6v+S/aymKnR8r2UgBBtXhJnDPWyqPCeaLVJALKKSWOssQ2cVt7xb7fds
         ax2gQ8F+5Czs1GM2tKk5sYMwxoTZj/YaypvSJ82XtYHIhmbm0qTGkw7VzYcz44Wi4caG
         x0blxZeuPKQa89bltBGITZeAKJszOXxZ9hN0CuybiDnPGfpqzOKI/0giPZ2rggCS0/qY
         apmQ==
X-Gm-Message-State: AOAM531QaQjXWgmsMU09Vwrd+Lfp5SmdSEcYXFNM+VsJBh1n/LnvVo65
        AcplN+qRdPpqzwRTKgkDtAcgdkVqzhv85g==
X-Google-Smtp-Source: ABdhPJwPCkuJXkhCP4l5CIoXIN1d+5YKvrNGYw0bdo919HksBNmuVFGnfbbFfUCgWYWvrM3bDJKTfBFFUUIeiw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:af1a:f1cd:5283:aa67])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:4ac1:: with SMTP id
 mh1mr21669147pjb.238.1633114858394; Fri, 01 Oct 2021 12:00:58 -0700 (PDT)
Date:   Fri,  1 Oct 2021 12:00:40 -0700
In-Reply-To: <20211001190040.48086-1-shakeelb@google.com>
Message-Id: <20211001190040.48086-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20211001190040.48086-1-shakeelb@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 2/2] memcg: unify memcg stat flushing
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg stats can be flushed in multiple context and potentially in
parallel too.  For example multiple parallel user space readers for memcg
stats will contend on the rstat locks with each other.  There is no need
for that.  We just need one flusher and everyone else can benefit.  In
addition after aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
the kernel periodically flush the memcg stats from the root, so, the other
flushers will potentially have much less work to do.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changelog since v1:
- N/A

 mm/memcontrol.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25f55636ca37..22d905f30a30 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -638,12 +638,14 @@ static inline void memcg_rstat_updated(struct mem_cgr=
oup *memcg)
=20
 static void __mem_cgroup_flush_stats(void)
 {
-	if (!spin_trylock(&stats_flush_lock))
+	unsigned long flag;
+
+	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
 		return;
=20
 	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock(&stats_flush_lock);
+	spin_unlock_irqrestore(&stats_flush_lock, flag);
 }
=20
 void mem_cgroup_flush_stats(void)
@@ -1462,7 +1464,7 @@ static char *memory_stat_format(struct mem_cgroup *me=
mcg)
 	 *
 	 * Current memory state:
 	 */
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
=20
 	for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -3566,8 +3568,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgro=
up *memcg, bool swap)
 	unsigned long val;
=20
 	if (mem_cgroup_is_root(memcg)) {
-		/* mem_cgroup_threshold() calls here from irqsafe context */
-		cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
+		mem_cgroup_flush_stats();
 		val =3D memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
@@ -3948,7 +3949,7 @@ static int memcg_numa_stat_show(struct seq_file *m, v=
oid *v)
 	int nid;
 	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
=20
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
=20
 	for (stat =3D stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=3D%lu", stat->name,
@@ -4020,7 +4021,7 @@ static int memcg_stat_show(struct seq_file *m, void *=
v)
=20
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) !=3D ARRAY_SIZE(memcg1_stats))=
;
=20
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
=20
 	for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4523,7 +4524,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, un=
signed long *pfilepages,
 	struct mem_cgroup *memcg =3D mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
=20
-	cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
=20
 	*pdirty =3D memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback =3D memcg_page_state(memcg, NR_WRITEBACK);
@@ -6408,7 +6409,7 @@ static int memory_numa_stat_show(struct seq_file *m, =
void *v)
 	int i;
 	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
=20
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
=20
 	for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
--=20
2.33.0.800.g4c38ced690-goog

