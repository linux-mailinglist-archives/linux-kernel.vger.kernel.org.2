Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9B3305DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhCHCZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:25:45 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:46056 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230046AbhCHCZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:25:28 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-03 (Coremail) with SMTP id rQCowAD3_0f+ikVgNHPHAQ--.53308S2;
        Mon, 08 Mar 2021 10:25:03 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     rostedt@goodmis.org, Viktor.Rosendahl@bmw.de,
        colin.king@canonical.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/tools: Remove unneeded semicolon
Date:   Mon,  8 Mar 2021 02:24:59 +0000
Message-Id: <20210308022459.59881-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAD3_0f+ikVgNHPHAQ--.53308S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UGFW5tF43AF45tw17Awb_yoWDtwbEkw
        13ta17tF98Krnakrs7tF43Xry8uw17XFs7GanrtFZrXryrX3s8JFyYv3yDur47urZFv3Wa
        k3ZxC3WIkr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbw8YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQcOA102Z+9G-wAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix semicolon.cocci warning:
tools/tracing/latency/latency-collector.c:1021:2-3: Unneeded semicolon

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
Changes since v2:
- Fix another instance of superfluous semicolon.
---
 tools/tracing/latency/latency-collector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index b69de9263ee6..3a2e6bb781a8 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1018,7 +1018,7 @@ static long go_to_sleep(const struct entry *req)
 		cond_timedwait(&printstate.cond, &printstate.mutex, &future);
 		if (time_has_passed(&future))
 			break;
-	};
+	}
 
 	if (printstate_has_new_req_arrived(req))
 		delay = -1;
@@ -1941,7 +1941,7 @@ static void scan_arguments(int argc, char *argv[])
 			if (value < 0) {
 				warnx("TIME must be >= 0\n");
 				show_usage();
-				;
+				exit(0);
 			}
 			trace_enable = true;
 			use_random_sleep = true;
-- 
2.17.1

