Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5945E388114
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbhERULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbhERUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:10:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D81C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:09:22 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t7so8483948qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KeFGs+XgiT4GeNWCCgafjwdeWaSG59cF2HfJOv3nLZw=;
        b=VcWqaHvKphNZDm5r4JxYL5xhI9rymCjHASfBV6erFnoQnaQq2j0okjNNvMIOlf3gUZ
         EJy/T5VLGqIuMyydSGHtmF53CPYT/kWo9i/U54bKJjsNq81jYKeumDk91PtxxFNVbaqA
         iGGJraYKKCfDhsNrtBqJuYRNDqvCCk/FQWtthUGS5hwRgP2S+uw1Y+dpHSdDi2JkKJkx
         GaG2wcHkK+B+mxgJ8MS1FyOHlPTgA/wQ+ORyVXud5miQS6Yx0LZHyAxIG58KrEzCCPJm
         WkRFU785GCK6hV6D66C/VyppwHsI2W765+D2VsQfKdrvcCjNWabsNbh8Ro7dbRwELpET
         ousg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KeFGs+XgiT4GeNWCCgafjwdeWaSG59cF2HfJOv3nLZw=;
        b=F556nSj1vaMmzoFew7R5xBxGpKS5lcAAj8m1IgdP7SJleXHSAzyyWN2aUmRWBMhjtI
         uJGMK8Zbvqlbne1ATkXv1lbUDbet9wlQ04eKs1/3/FXuItI37nmZ6rOse2B30uuZXQGL
         TtFaygE24DkZK1yH201v//d9a9BxBpLuSb/cl7JBQPfgTnym/6XmGrrm9HATgdCyHMRl
         lsxtrEdlzLd/af7N2hGxDh3PVcK+teSt8vNISIt8K+MuE5Y9fy6lcnZmq+RG/SWdcmey
         8djjTWgOR4ImPYgM4mw4vZE7PEUbLgUDXhADblwisd5iBkWudgI0EgrqUJuyoERERWbG
         MHzA==
X-Gm-Message-State: AOAM532B/KELewZ7+C95Szs+St6T08O4AWw207nFzMQ7H40OWoPb2n3Z
        X7fI1ICyzURzuwtZkRX8kDhYlg==
X-Google-Smtp-Source: ABdhPJyTZg/7h6ux+qSVPdgBujgr9LFp57H4rAT7WH4EWdYOJrVyeX5em/IuiWqovWIK2V3VvAv5NA==
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr3038321qtm.225.1621368562028;
        Tue, 18 May 2021 13:09:22 -0700 (PDT)
Received: from bunsen3.telenet.unc.edu (bunsen3.telenet.unc.edu. [204.85.191.47])
        by smtp.googlemail.com with ESMTPSA id h14sm4566128qto.58.2021.05.18.13.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:09:21 -0700 (PDT)
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
Subject: [PATCH v2] memcontrol: use flexible-array member
Date:   Tue, 18 May 2021 16:09:08 -0400
Message-Id: <20210518200910.29912-1-wenhui@gwmail.gwu.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change depracated zero-length-and-one-element-arrays into flexible
array member.Zero-length and one-element arrays detected by Lukas's CodeChecker.
Zero/one element arrays causes undefined behaviours if sizeof() used.

Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>
---
 include/linux/memcontrol.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ce97eff79e2..3cc18c2176e7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -349,8 +349,7 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
-	struct mem_cgroup_per_node *nodeinfo[0];
-	/* WARNING: nodeinfo must be the last member here */
+	struct mem_cgroup_per_node *nodeinfo[];
 };
 
 /*
-- 
2.17.1

