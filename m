Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE43354693
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhDESJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:09:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:44452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233232AbhDESJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:06 -0400
IronPort-SDR: n5r1S/4C2Y6TE8ZLyMc0xX2RIHnuVnBOTs+lliqE7yDahz4fND+oLEhPbMb1CCAIe3v0TnrXmj
 VsGHJvCqhIvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010911"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010911"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:00 -0700
IronPort-SDR: +HUey/5dlE1yomxaN4NZGyrmKeFWrxhZy1afGwPD497QiQPpdG0WuCOHBvsRGzWRXKSVEtNmzP
 cDI92OwtOb+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153881"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:08:59 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 02/11] mm: Add soft memory limit for mem cgroup
Date:   Mon,  5 Apr 2021 10:08:26 -0700
Message-Id: <96026428f135c1199a3216fde6e48317fc45486f.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each memory cgroup, define a soft memory limit on
its top tier memory consumption.  Memory cgroups exceeding
their top tier limit will be selected for demotion of
their top tier memory to lower tier under memory pressure.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index eeb0b52203e9..25d8b9acec7c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -230,6 +230,7 @@ struct mem_cgroup {
 	struct work_struct high_work;
 
 	unsigned long soft_limit;
+	unsigned long toptier_soft_limit;
 
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 41a3f22b6639..9a9d677a6654 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3603,6 +3603,7 @@ enum {
 	RES_MAX_USAGE,
 	RES_FAILCNT,
 	RES_SOFT_LIMIT,
+	RES_TOPTIER_SOFT_LIMIT,
 };
 
 static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
@@ -3643,6 +3644,8 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 		return counter->failcnt;
 	case RES_SOFT_LIMIT:
 		return (u64)memcg->soft_limit * PAGE_SIZE;
+	case RES_TOPTIER_SOFT_LIMIT:
+		return (u64)memcg->toptier_soft_limit * PAGE_SIZE;
 	default:
 		BUG();
 	}
@@ -3881,6 +3884,14 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		memcg->soft_limit = nr_pages;
 		ret = 0;
 		break;
+	case RES_TOPTIER_SOFT_LIMIT:
+		if (mem_cgroup_is_root(memcg)) { /* Can't set limit on root */
+			ret = -EINVAL;
+			break;
+		}
+		memcg->toptier_soft_limit = nr_pages;
+		ret = 0;
+		break;
 	}
 	return ret ?: nbytes;
 }
@@ -5029,6 +5040,12 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+	{
+		.name = "toptier_soft_limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_TOPTIER_SOFT_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
 	{
 		.name = "failcnt",
 		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
@@ -5365,6 +5382,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	memcg->toptier_soft_limit = PAGE_COUNTER_MAX;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
-- 
2.20.1

