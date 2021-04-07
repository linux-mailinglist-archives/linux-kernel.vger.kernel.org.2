Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D235685A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbhDGJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:49:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15943 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhDGJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:49:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFfgk3tPkzyNcy;
        Wed,  7 Apr 2021 17:47:14 +0800 (CST)
Received: from huawei.com (10.67.174.142) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 17:49:16 +0800
From:   <johnny.chenyi@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
        <heying24@huawei.com>
Subject: [PATCH-next] perf daemon: Remove duplicate header file
Date:   Wed, 7 Apr 2021 17:49:02 +0800
Message-ID: <20210407094902.2020105-1-johnny.chenyi@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.142]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yi <johnny.chenyi@huawei.com>

Delete one of the header files <linux/string.h> that are included twice.

Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
---
 tools/perf/builtin-daemon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 7c4a9d424a64..be1a13d06b9c 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -6,7 +6,6 @@
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <linux/limits.h>
-#include <linux/string.h>
 #include <string.h>
 #include <sys/file.h>
 #include <signal.h>
-- 
2.31.0

