Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9534F770
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhCaDZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbhCaDYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:24:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D9FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s11so7491188pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=D8cI9p8duSAuwc0HuZGq6ac3QTWtYsZEHTOhpxbujwY=;
        b=mguRI6SAeZVTDBtkNW0rWIlZOEBVWPrQfG+9QviPTCMDUN9l4BmS98rYzrmfWYzX4g
         /jzOLMaFX9Lo65Pirk1QoGDj9czZfCNIOJ44ojv8f/gX3xFpXTHFcMhp7ss1OoQv/1XT
         fN+cRf905dQFCsDDnFR73NlD49jBTnBVpJ4w3sOgoPte288vYQT/1vNboTorBQxV5TF+
         n4pqheY1agqEOmHIncsE3QeqGpoXAyHuRWmFT12RmEnCHUdyi2ZpiVUM3W6KJysoyVdb
         pUwSplVopduOrMW3a+vV5TJlKhFvCwTIxlKNotLEHgJwQjywfaoXcr+QZG7ZP7McSpli
         fVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D8cI9p8duSAuwc0HuZGq6ac3QTWtYsZEHTOhpxbujwY=;
        b=tRKF+tFzSS13WlnSfwXtw/7VrEV36ALaA++R8YsA6lzP6gX7SYakHcN3Aw/5jG+RBA
         ErUgjb7O490uZ+KiZvewzXcp626jxssiOtgL2YFKaLWR3ZqBw7RtyBBhCQbozXw9QivN
         RwOAeDXU/CP99n5J+oiH5XF+KFtO7JAsnnGAbRY3FAAAiDkWCszLHeRMkq+NiNgTbqfi
         cNkQALlLbuqhsBLqAtl21WNccxgQeQlLZYSC1md17HR1CcausL0lsIjZCDjklzUFFHW6
         U4GSIA0pPeJ4LCiZw+HjUOEtWpMGzm4g1vrkYToysWDHOD9DK0OU//YwUDoZtJK6GV5s
         4gvQ==
X-Gm-Message-State: AOAM5321AKbM7oDytsSY5fUNpNjaEw6EhL68A2rFMTull/ajLg6/2oMH
        FefE3WVMIitlBJHQLeQJTaM=
X-Google-Smtp-Source: ABdhPJyhNDYSataJn7DbwvuOAVmVCwKhEI0DfzyaFso8xDz0h24LwnLS+mDMUfVmWY5JF8F9tKDVRQ==
X-Received: by 2002:a62:68c4:0:b029:226:5dc5:4082 with SMTP id d187-20020a6268c40000b02902265dc54082mr957849pfc.48.1617161089369;
        Tue, 30 Mar 2021 20:24:49 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id v13sm401196pfu.54.2021.03.30.20.24.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 20:24:48 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cgroup: use tsk->in_iowait instead of delayacct_is_task_waiting_on_io()
Date:   Wed, 31 Mar 2021 11:24:41 +0800
Message-Id: <72b22d2cbebb8eb03c3048fc4c2ff03a90992697.1617160582.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
References: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
In-Reply-To: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
References: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

If delayacct is disabled, then delayacct_is_task_waiting_on_io()
always returns false, which causes the statistical value to be
wrong. Perhaps tsk->in_iowait is better.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 32596fd..91991e2 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -727,7 +727,7 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 			stats->nr_stopped++;
 			break;
 		default:
-			if (delayacct_is_task_waiting_on_io(tsk))
+			if (tsk->in_iowait)
 				stats->nr_io_wait++;
 			break;
 		}
-- 
1.8.3.1

