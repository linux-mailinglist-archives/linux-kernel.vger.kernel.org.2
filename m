Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31523167F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBJNY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:24:29 -0500
Received: from foss.arm.com ([217.140.110.172]:37750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBJNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:23:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 439A811D4;
        Wed, 10 Feb 2021 05:22:47 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.16.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 081FD3F73D;
        Wed, 10 Feb 2021 05:22:45 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>
Subject: [PATCH v2 3/4] perf tools: enable dwarf_callchain_users on aarch64
Date:   Wed, 10 Feb 2021 13:22:12 +0000
Message-Id: <20210210132213.8146-3-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210210132213.8146-1-alexandre.truong@arm.com>
References: <20210210132213.8146-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, enable dwarf_callchain_users which will be needed
to do a dwarf unwind in order to get the caller of the leaf frame.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/builtin-report.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..93661a3eaeb1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report *rep)
 
 	callchain_param_setup(sample_type);
 
+	if (callchain_param.record_mode == CALLCHAIN_FP &&
+			strncmp(rep->session->header.env.arch, "aarch64", 7) == 0)
+		dwarf_callchain_users = true;
+
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
 			    "Please apply --call-graph lbr when recording.\n");
-- 
2.23.0

