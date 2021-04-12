Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E335C278
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhDLJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:44:58 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:57308 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhDLJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:21:24 -0400
Received: from wanjb-KLV-WX9.. (unknown [123.131.141.119])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 1E4F94001AC;
        Mon, 12 Apr 2021 17:21:03 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] perf: bench: Remove unneeded variable
Date:   Mon, 12 Apr 2021 17:20:48 +0800
Message-Id: <20210412092054.28117-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxhCQ1YdTUIfHR8fTU9OS0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Lzo5Aj8LSx8iMSsoFzMP
        OBpPFBhVSlVKTUpDSUpCSU1PSEpCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        SUhVSkhKVUpPSlVKSkJZV1kIAVlBSUlNTjcG
X-HM-Tid: 0a78c5626628d991kuws1e4f94001ac
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

tools/perf/bench/find-bit-bench.c:123:5-8:
Unneeded variable: "err". Return "0" on line 134

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/bench/find-bit-bench.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 73b5bcc5946a..7e748a56a8ba 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -120,7 +120,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
 
 int bench_mem_find_bit(int argc, const char **argv)
 {
-	int err = 0, i;
+	int i;
 
 	argc = parse_options(argc, argv, options, bench_usage, 0);
 	if (argc) {
@@ -131,5 +131,5 @@ int bench_mem_find_bit(int argc, const char **argv)
 	for (i = 1; i <= 2048; i <<= 1)
 		do_for_each_set_bit(i);
 
-	return err;
+	return 0;
 }
-- 
2.30.2

