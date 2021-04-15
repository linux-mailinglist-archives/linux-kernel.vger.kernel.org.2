Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485A23605B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhDOJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:30:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16466 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhDOJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:30:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FLYsW01wPzwRyL;
        Thu, 15 Apr 2021 17:27:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 17:29:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] perf map: Fix error return code in maps__clone()
Date:   Thu, 15 Apr 2021 17:27:44 +0800
Message-ID: <20210415092744.3793-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although 'err' has been initialized to -ENOMEM, but it will be reassigned
by the "err = unwind__prepare_access(...)" statement in the for loop. So
that, the value of 'err' is unknown when map__clone() failed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 tools/perf/util/map.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbc40a2c17d4dca..8af693d9678cefe 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -840,15 +840,18 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 int maps__clone(struct thread *thread, struct maps *parent)
 {
 	struct maps *maps = thread->maps;
-	int err = -ENOMEM;
+	int err;
 	struct map *map;
 
 	down_read(&parent->lock);
 
 	maps__for_each_entry(parent, map) {
 		struct map *new = map__clone(map);
-		if (new == NULL)
+
+		if (new == NULL) {
+			err = -ENOMEM;
 			goto out_unlock;
+		}
 
 		err = unwind__prepare_access(maps, new, NULL);
 		if (err)
-- 
2.26.0.106.g9fadedd


