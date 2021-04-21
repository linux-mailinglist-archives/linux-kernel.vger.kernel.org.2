Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA3366ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhDUPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243868AbhDUPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:09:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE503C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u15so13261726plf.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Po+qU5dt1Yy0qa7l0uLxYfVEa6vaR5MZXziHwyuHotE=;
        b=PjBH4jQpqFomkLLvOghdtR74zlVVWCzB2L0YShXJND9ZnlX8hieIAcB+2yTU3uQivD
         kQLlukUypPVt0QqJcSXSvMMHHLPjc96l/C18P0yw6q2L4jgDBdDDpMzmEzGxYtVNniTr
         /6Npjz1b5YyeGLTBqOVPNxLtW2VoUWjEHE0I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Po+qU5dt1Yy0qa7l0uLxYfVEa6vaR5MZXziHwyuHotE=;
        b=l3iY2mRWLmCSlyhuv5tgCXHsretNaIEA6s8xUaqq2z/OeRwvS8l/Trsr7aJ/ozUDZv
         AdKRfbr+LZGk4SQqjSLW9i8NwfKuOElbCSKfld8XJ1gtrFCZKM9WBpLRMjqdcHl6NMpy
         208tv4NPx3qHWddwJR/bjSDoxslARkyKpfkW3dUAa1hgxut2PoFj1UHgIhpJpjFVRteC
         et3ZzQKSZp4RjNFrCDPbC+zCOcJI2YgKHYMRIaJdh1Y5EAY58AizIu48eKreTaC/Gguo
         EwtxEEoJwoE0fIbgLzd6LkBGwtFjbNyleyIfvn+AS9PVNkNPEqeNOncrUq9qfp0fc5nn
         dkaA==
X-Gm-Message-State: AOAM5339f3M0ZvKcA+1+bZfLCYEEk+yFyJiyYUxXIqxaOumCYrD1/Jdy
        DOBQG/a+xkZl0GODdHvS0LIkHg==
X-Google-Smtp-Source: ABdhPJxO2nklRU+cnCq7i+1CU3Nv+qx5VABYKq49QlAFdEnVK8MK/+u8WDfFC8K14cmZdzkD5yGiLQ==
X-Received: by 2002:a17:902:9685:b029:e9:abc1:7226 with SMTP id n5-20020a1709029685b02900e9abc17226mr34832987plp.64.1619017723394;
        Wed, 21 Apr 2021 08:08:43 -0700 (PDT)
Received: from haraichi.dnlocal (113x36x239x145.ap113.ftth.ucom.ne.jp. [113.36.239.145])
        by smtp.googlemail.com with ESMTPSA id f3sm5432553pjo.3.2021.04.21.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:08:42 -0700 (PDT)
From:   Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pl@sslab.ics.keio.ac.jp,
        kono@sslab.ics.keio.ac.jp,
        Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
Subject: [RFC PATCH 1/2] Prevent CFS from ignoring boost requests from KVM
Date:   Thu, 22 Apr 2021 00:08:30 +0900
Message-Id: <20210421150831.60133-2-kentaishiguro@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
References: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit increases the vruntime of yielded vCPU to boost a vCPU instead
of the yielded vCPU when two vCPUs are in the same VM. This change avoids
the situation where scheduling the boosted vCPU is too unfair.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..2908da3f4c77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7204,9 +7204,36 @@ static void yield_task_fair(struct rq *rq)
 	set_skip_buddy(se);
 }
 
+static void deboost_yield_task_vruntime(struct sched_entity *next_se, struct sched_entity *yield_se)
+{
+	if (wakeup_preempt_entity(next_se, yield_se) < 1)
+		return;
+	yield_se->vruntime = next_se->vruntime - wakeup_gran(yield_se);
+}
+
+static void deboost_yield_task(struct sched_entity *next_se, struct sched_entity *yield_se)
+{
+	struct sched_entity *next_se_base = next_se;
+
+	if (rq_of(cfs_rq_of(yield_se)) != rq_of(cfs_rq_of(next_se)))
+		return;
+
+	for_each_sched_entity(yield_se) {
+		next_se = next_se_base;
+		for_each_sched_entity(next_se) {
+			if (cfs_rq_of(yield_se) == cfs_rq_of(next_se)) {
+				deboost_yield_task_vruntime(next_se, yield_se);
+				return;
+			}
+		}
+	}
+}
+
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
+	struct task_struct *curr;
+	struct sched_entity *yield_se;
 
 	/* throttled hierarchies are not runnable */
 	if (!se->on_rq || throttled_hierarchy(cfs_rq_of(se)))
@@ -7215,6 +7242,10 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	/* Tell the scheduler that we'd really like pse to run next. */
 	set_next_buddy(se);
 
+	curr = rq->curr;
+	yield_se = &curr->se;
+	deboost_yield_task(se, yield_se);
+
 	yield_task_fair(rq);
 
 	return true;
-- 
2.30.2

