Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91138712B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbhERFWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbhERFWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:22:04 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D861C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 22:20:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id q6so4378653qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zuo1N8XV6TdRGkjocXxo/YpuVD4EcncgHjz+dnX06QM=;
        b=USmkD/2ylWqoxaCBZVF9o0XfVYOWy7CTtJduVaEzyEjD6aGjJ23hWe2cDHegonD1rv
         1aP/8DJIOQHSWwQaTTE4vBeFEjamJBd4xHzYvNwVojFfPzPTGt5zRegaL+ByRrrtJ+fi
         eDYvdfIb95Xkj/A5i0a4Q/18wf5jWXlQyHad1OUcd/XkQmiVa5ePA6C8x9IAfYupH0F+
         dg1+OwOZFfYVyNsH5t1MX56VEGq8uWlNBXJOLNDHcR6X6ALXREMelaWABxd15h37zfvV
         WOvd03ZPpH6p3MM6yhOqtIzb9izf/YGDYpEDC4Xy/mhpvjzxg/QjXUkb1wTi2/VT/IWS
         p0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zuo1N8XV6TdRGkjocXxo/YpuVD4EcncgHjz+dnX06QM=;
        b=CJE06dfRjzAUEJlpzhqwUv0Fh8FxCKvIJKcV4+1CTtwCvL+AwEGGRRi3k2cjySBWSB
         L8rutBYQR6ZWkTdEyHAewBi/YlUE8cfG4MsGuQvuD1CgL9isz7xE6EOCEVHGG7aYBB76
         1ooHD70UQF6Pry+T6JoeTdJ5hRbJGQFqYzw+Cv55YBez5ph/NuUmdVcXodjjXkvhkYcl
         6aN5zL6dHKUt7J64RTPqWhmHWhyhaKVHWPEmdF3r/ymUBF+1GcD5RXk4ReNeWWgUDIrk
         wDNBP3PPMFV1h+9HCvHPKFudb5kzx1Cn3WhN1t2Kr+LeiST0W4Nbdt3pbmp9J4NG4l3A
         xaQQ==
X-Gm-Message-State: AOAM531U8DfG0HyhHqeN5ODneTiFY23vzt023gCYQCPo9LPztrGY3+IY
        tdIufroU/3KN5RJi+c7Xp29d9g==
X-Google-Smtp-Source: ABdhPJyOr+9Z8TFB0MpAeVdIe0ZN0W5ysHO6sg2jDOnApdqud5lwUmvia0lleB+VjVUDTKzUJB8Hkw==
X-Received: by 2002:a0c:99e2:: with SMTP id y34mr3807826qve.29.1621315245655;
        Mon, 17 May 2021 22:20:45 -0700 (PDT)
Received: from bunsen3.telenet.unc.edu (bunsen3.telenet.unc.edu. [204.85.191.47])
        by smtp.googlemail.com with ESMTPSA id d16sm12087772qtw.23.2021.05.17.22.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:20:45 -0700 (PDT)
From:   wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     wenhui@gwmail.gwu.edu, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memcontrol: use flexible-array member 
Date:   Tue, 18 May 2021 01:20:36 -0400
Message-Id: <20210518052038.491-1-wenhui@gwmail.gwu.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Change depracated zero-length-and-one-element-arrays into flexible 
array member.
Zero-length and one-element arrays detected by Lukas's CodeChecker.
Zero/one element arrays causes undefined behaviours if sizeof() used.

https://www.kernel.org/doc/html/latest/processd/deprecated.html


Signed-off-by: wenhuizhang<wenhui@gwmail.gwu.edu>
---
 include/linux/memcontrol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ce97eff79e2..f879efb1bc6e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -190,7 +190,7 @@ enum memcg_kmem_state {
 
 #if defined(CONFIG_SMP)
 struct memcg_padding {
-	char x[0];
+	char x[];
 } ____cacheline_internodealigned_in_smp;
 #define MEMCG_PADDING(name)      struct memcg_padding name;
 #else
@@ -349,7 +349,7 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
-	struct mem_cgroup_per_node *nodeinfo[0];
+	struct mem_cgroup_per_node *nodeinfo[];
 	/* WARNING: nodeinfo must be the last member here */
 };
 
-- 
2.17.1

