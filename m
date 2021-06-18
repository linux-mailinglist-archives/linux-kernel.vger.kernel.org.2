Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8ED3AD0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhFRREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhFRREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:04:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b14so8993087ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iw5bM1oWSVgU2E0qpCpapukI6tZeaIAQEfdVoRxxe+U=;
        b=HSvqD37VA3IlhlWhCnUah6hPnJedzYXIzunNPYQLx8TPc/ZKLlzCew98F3FfX7aGgh
         kD9VkbEyp3QDSlHp7qhLVUcYnHS+4F9BhxDwJsBVwbX/+OxiI1SASVv7NM5Oa+vz6w6S
         4+ToGV4QQJCMYrGB4q29bY5ESXRPJDbJI030jTK4gGHCWEXrlwrEIUGNrFyiO3wcX8yk
         EoWAMJ56QSlX+xqhavoTv0bSHE0YNaA0DSDKie5F0E0NyFBcAwwRLlqGV9NSXiqIY9uM
         rBPG3KKuM8ZjUJPo+WB9mKBPpfRKEjTa5DKawHuLmAK341jYWLFewdNRGDf6NeV6zrMl
         bTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iw5bM1oWSVgU2E0qpCpapukI6tZeaIAQEfdVoRxxe+U=;
        b=jDWaZzcXs97M0fOH4JUxuJ6LANpXwXnTYZk9wsrifuSpKvnBecKbzGhhOD2AQEhjL4
         8GieD7JZFPCFfdD/6Rfs3gARIGALO0f17gC/Pc29wOjSoHLKHTsV+ltSl7QR6YYSfdnR
         qeTSFksCBR79OsHbsCLh5QV4dxrKKxyIdnZ4ReZPCdHZukh7vpvgZ5z6JQwyaUoW8Dx5
         3yWUY6o0w2sV0oc2xvM1PFug5PAlcVmt7axEW1qHAL0dfNCpB22OdckgvHKlbQesVHXq
         osa4yKKMPtb1RfgbKsgGLOBjAfoe0KTUZnhqwPAdxL3SO2O/hV6V+5Tgr9Q0vxtCcX3T
         DJ4Q==
X-Gm-Message-State: AOAM530AlftqDUHK5Xyji1Y2jBMJUHKxllV6gSy2TaRWWYkMInY1DxeQ
        eWuRv3xJMErsQnEuH+/doQI=
X-Google-Smtp-Source: ABdhPJy4idYNPz4DyOm3g0ENJMxtKcA0JrxS+opyVBfuTzW+NA13kj4tDySOIg/IZIM3GQ9lGVL7sA==
X-Received: by 2002:a05:6e02:612:: with SMTP id t18mr8375035ils.261.1624035709187;
        Fri, 18 Jun 2021 10:01:49 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y4sm416122iop.54.2021.06.18.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:01:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9D27827C0054;
        Fri, 18 Jun 2021 13:01:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 18 Jun 2021 13:01:44 -0400
X-ME-Sender: <xms:eNHMYGnsKGZtB10UBL55MAotXOti1h8r7dNT0m2hDzS_y7p-AqWraA>
    <xme:eNHMYN0alYqE2UF9T09slgIJvJwArB_Oy8662zFypl3V_cn6FWIQ8UrZUFK9CD6-9
    KhU37Ier-fvnhuuLw>
X-ME-Received: <xmr:eNHMYEpWu1ii3n-CzBLhjEeWsCKTnXktjPaMbJYTc4I4X98d2AVqODH5MCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:eNHMYKmlZRQ4ywQrcX_U9s28ME2_8tnR2NY9cihIprK4TfZwyIwr3w>
    <xmx:eNHMYE0jLYQTcNpLLTjt4i1rPpqLO1SfSf0r-sTq_q9HCN3XpENY_w>
    <xmx:eNHMYBvS0aaXdqHOJAaGwawFe_KBDD6PL6VS8gNyACQckcdBKXLT8Q>
    <xmx:eNHMYI92nazHw0sgWjwVqOuFmQqXtMRZqisRFmfb6UyB8PbFd8Cl0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 13:01:44 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/4] lockding/lockdep: Avoid to find wrong lock dep path in check_irq_usage()
Date:   Sat, 19 Jun 2021 01:01:09 +0800
Message-Id: <20210618170110.3699115-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618170110.3699115-1-boqun.feng@gmail.com>
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the step #3 of check_irq_usage(), we seach backwards to find a lock
whose usage conflicts the usage of @target_entry1 on safe/unsafe.
However, we should only keep the irq-unsafe usage of @target_entry1 into
consideration, because it could be a case where a lock is hardirq-unsafe
but soft-safe, and in check_irq_usage() we find it because its
hardirq-unsafe could result into a hardirq-safe-unsafe deadlock, but
currently since we don't filter out the other usage bits, so we may find
a lock dependency path softirq-unsafe -> softirq-safe, which in fact
doesn't cause a deadlock. And this may cause misleading lockdep splats.

Fix this by only keeping LOCKF_ENABLED_IRQ_ALL bits when we try the
backwards search.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 74d084a398be..6ff1e8405a83 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2768,8 +2768,18 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 3: we found a bad match! Now retrieve a lock from the backward
 	 * list whose usage mask matches the exclusive usage mask from the
 	 * lock found on the forward list.
+	 *
+	 * Note, we should only keep the LOCKF_ENABLED_IRQ_ALL bits, considering
+	 * the follow case:
+	 *
+	 * When trying to add A -> B to the graph, we find that there is a
+	 * hardirq-safe L, that L -> ... -> A, and another hardirq-unsafe M,
+	 * that B -> ... -> M. However M is **softirq-safe**, if we use exact
+	 * invert bits of M's usage_mask, we will find another lock N that is
+	 * **softirq-unsafe** and N -> ... -> A, however N -> .. -> M will not
+	 * cause a inversion deadlock.
 	 */
-	backward_mask = original_mask(target_entry1->class->usage_mask);
+	backward_mask = original_mask(target_entry1->class->usage_mask & LOCKF_ENABLED_IRQ_ALL);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
 	if (bfs_error(ret)) {
-- 
2.30.2

