Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6233EDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhCQKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:03:30 -0400
Received: from m12-18.163.com ([220.181.12.18]:37018 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhCQKDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4IVqN
        wtKiLiWyR0ANej24u825g4yhB6K/L2kUWe+Ojc=; b=JPHmfT1etg3/axMmhgP49
        d3CQJcnWSFACjpg5n0G2uqESBfgElx/IwSNeG5Pu9ZL97V0uqWT1aGddCWQGwRgy
        qw942Ep/3vdTIL/JFjr3FGiToYA0tf7HeW0zRZDxKiGRTGbdt4OvqD+tmTh8SM47
        4y0rpM5Bm2ZKDX/W7jzybo=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAC3tfO601Fgn5EZZQ--.44733S2;
        Wed, 17 Mar 2021 18:02:38 +0800 (CST)
From:   zuoqilin1@163.com
To:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] rtl8821ae: Fix spelling typo
Date:   Wed, 17 Mar 2021 18:02:44 +0800
Message-Id: <20210317100244.1239-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3tfO601Fgn5EZZQ--.44733S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyUtr15GF4UJrWrWry3Jwb_yoWfKrX_W3
        WIqF1jvr1ruFyIyay7AFsxuF1IgF4Y9FWrtrWDW3sxArWrJan5XFZ8CrZ7JF1Yg3WUA34a
        qw1vkw47ur4UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iqXJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiHh5YiVSItTc+uQAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'revsions' to 'revisions'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20effdf..4572aa9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3485,7 +3485,7 @@ static int try_all_file_abis(uint64_t hdr_sz, struct perf_header *ph)
  * between host recording the samples, and host parsing the samples is the
  * same. This is not always the case given that the pipe output may always be
  * redirected into a file and analyzed on a different machine with possibly a
- * different endianness and perf_event ABI revsions in the perf tool itself.
+ * different endianness and perf_event ABI revisions in the perf tool itself.
  */
 static int try_all_pipe_abis(uint64_t hdr_sz, struct perf_header *ph)
 {
-- 
1.9.1


