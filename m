Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245D035D3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbhDLXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:18:00 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:55184 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbhDLXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:17:59 -0400
Received: from wanjb-KLV-WX9.lan (unknown [60.232.195.58])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id E9FB64000CF;
        Tue, 13 Apr 2021 07:17:37 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] perf: util: Remove unneeded variable
Date:   Tue, 13 Apr 2021 07:16:52 +0800
Message-Id: <20210412231654.42084-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhlLH1YdGUpMQhlOH08aTU5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Ihw4HT8XQx4OKEIDMEkP
        AhcKCQNVSlVKTUpDSU1CT05DQk5MVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlN
        S1VJSElVSkJOVU5DWVdZCAFZQUlJQ0I3Bg++
X-HM-Tid: 0a78c8605098d991kuwse9fb64000cf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

./tools/perf/util/evlist.c:1316:5-8: Unneeded variable: "err". Return "- ENOMEM" on line 1341

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/util/evlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 882cd1f721d9..6c2a271605d5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1313,7 +1313,6 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
-	int err = -ENOMEM;
 
 	/*
 	 * Try reading /sys/devices/system/cpu/online to get
@@ -1338,7 +1337,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 out_put:
 	perf_cpu_map__put(cpus);
 out:
-	return err;
+	return -ENOMEM;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.30.2

