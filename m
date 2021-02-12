Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4879931A0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBLOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:48:08 -0500
Received: from foss.arm.com ([217.140.110.172]:38216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBLOrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:47:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C006C1476;
        Fri, 12 Feb 2021 06:46:02 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0872F3F73D;
        Fri, 12 Feb 2021 06:45:59 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] perf cs-etm: Suppress printing when resetting decoder
Date:   Fri, 12 Feb 2021 16:45:13 +0200
Message-Id: <20210212144513.31765-8-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
References: <20210212144513.31765-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder is quite noisy when being reset. Now that dump-raw-trace
uses a code path that resets the decoder rather than creating a new
one, printing has to be suppressed to not flood the output.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3f4bc4050477..e0d530d94e1e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -32,6 +32,7 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
+	bool suppress_printing;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -71,9 +72,10 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	ocsd_datapath_resp_t dp_ret;
 
 	decoder->prev_return = OCSD_RESP_CONT;
-
+	decoder->suppress_printing = true;
 	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
 				      0, 0, NULL, NULL);
+	decoder->suppress_printing = false;
 	if (OCSD_DATA_RESP_IS_FATAL(dp_ret))
 		return -1;
 
@@ -143,8 +145,10 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
 					 const char *msg,
 					 const int str_len)
 {
-	if (p_context && str_len)
-		((struct cs_etm_decoder *)p_context)->packet_printer(msg);
+	const struct cs_etm_decoder *decoder = p_context;
+
+	if (p_context && str_len && !decoder->suppress_printing)
+		decoder->packet_printer(msg);
 }
 
 static int
-- 
2.28.0

