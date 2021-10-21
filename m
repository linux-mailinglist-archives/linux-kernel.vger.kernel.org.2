Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB6435CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJUIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:25:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67075C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:23:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y4so18032983plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bhVPp8wZkFflzsOYrs4ZmR9mph7dV4qhoVW0vkuPclQ=;
        b=al/lRetaj7Ezklfil8AU/I948Wl2fypE7KOugYFcwao3cNvV+bvilcrEEsgPbOhW06
         fo5TimxrYTb6I9/BLLY1mS7e1vAF+RAjH6xVdh2+xFICvgZj5ZetX3KyX7Z+cLz9cgS8
         kONWT3DgHwg98nXdBjBXNkBXARWWpz0wBCCa9uyPi9ArsARC9Pxlb5u3wxcYITddsFJV
         TGjusMLKud5tObeBj4x39KWZAPmqJueh4k2nWwQfZAAwJ89qAn3RaG6qD6JpGR0HBxWm
         0q29h9iR6giYFzgiH+28c0+fV/URWv+F2TvcYqnkLTSchsOo6ZGGiI3TC7zY6Qgpo3PJ
         HBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bhVPp8wZkFflzsOYrs4ZmR9mph7dV4qhoVW0vkuPclQ=;
        b=dxUj5707eBzojZRf6N1ZPY7tqTN5Gq298KdWebvwsbRSWOGrlHXKk5iC+jBA8CGCqB
         yZ0b+Z/9/CA4VyJr424fB/h9o9tAjkmz7kdzpVLMstoIjifOhxQPriUUBjKZeIDuDHoZ
         gU5RwFa665nyt9oSjCIUtvaiZ53opNVhf2MeVID+EJT1ucIjhkT36USmrPBULd3l0uVx
         EeNV0J8JkL6QMZZnvm6I17LHlwPFS0PML+e7LWUnZF/xWEzsFJZFkSZLUe2R4/kxZb8I
         7ttWpPW9kylRtd1rgYBtTtek1SLCTaBjuSSaohdHJvanbReROWVIzngHMQL+ObVq+3Jf
         UjIQ==
X-Gm-Message-State: AOAM533fQ2szrmHFWBGmeSEmARUjfthHOX6jRK8YdGUVCY3mRcLdoxr8
        m0MIsmZAOqZX1CyQ4quJj8M=
X-Google-Smtp-Source: ABdhPJxLRle/VeqymgwdGz2gu5ywHmyk81psg0eH+K4IW0Zq3huoKRCMsxYBZBeVr6JKQs1Ybv22pw==
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr5036758pjb.115.1634804597934;
        Thu, 21 Oct 2021 01:23:17 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id l11sm8376075pjg.22.2021.10.21.01.23.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:23:17 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched/fair: use max_spare_cap_cpu if it is more energy efficient
Date:   Thu, 21 Oct 2021 16:23:14 +0800
Message-Id: <1634804594-4163-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When debugging EAS, I found that if the task is migrated to
max_spare_cap_cpu, even if the power consumption of pd is lower,
we still put the task on prev_cpu. Maybe we should fix it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..2ae7e03de6d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6867,8 +6867,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy_pd) {
+				target = max_spare_cap_cpu;
 				goto unlock;
+			}
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
-- 
2.30.0

