Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5507A360459
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhDOIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:35:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:35:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FLXd81H2yzPpfJ;
        Thu, 15 Apr 2021 16:31:56 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 16:34:44 +0800
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
Subject: [PATCH 1/1] perf data: Fix error return code in perf_data__create_dir()
Date:   Thu, 15 Apr 2021 16:34:16 +0800
Message-ID: <20210415083417.3740-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although 'ret' has been initialized to -1, but it will be reassigned by
the "ret = open(...)" statement in the for loop. So that, the value of
'ret' is unknown when asprintf() failed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 tools/perf/util/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f29af4fc3d09390..8fca4779ae6a8e9 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -35,7 +35,7 @@ void perf_data__close_dir(struct perf_data *data)
 int perf_data__create_dir(struct perf_data *data, int nr)
 {
 	struct perf_data_file *files = NULL;
-	int i, ret = -1;
+	int i, ret;
 
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
@@ -51,7 +51,8 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
 
-		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
+		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
+		if (ret < 0)
 			goto out_err;
 
 		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
-- 
2.26.0.106.g9fadedd


