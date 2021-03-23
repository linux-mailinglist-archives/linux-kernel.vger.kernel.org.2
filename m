Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB5345712
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWFCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:02:20 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:41728 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWFBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:01:49 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id B0D3598039A;
        Tue, 23 Mar 2021 13:01:46 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] tools: perf: Remove duplicate includes
Date:   Tue, 23 Mar 2021 13:01:39 +0800
Message-Id: <20210323050139.287461-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSB9PQ05DHR1KTR8YVkpNSk1PTE5MS0xLSUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006TCo5DT8THjouIRctHzYp
        SBhPCS9VSlVKTUpNT0xOTEtMT0tDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSkxKNwY+
X-HM-Tid: 0a785d75d62fd992kuwsb0d3598039a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys/stat.h has been included at line 23, so remove the
duplicate one at line 27.
linux/string.h has been included at line 7, so remove the
duplicate one at line 9.
time.h has been included at line 14, so remove the
duplicate one at line 28.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/builtin-daemon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index ace8772a4f03..632ecd010a4f 100644
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
@@ -24,8 +23,6 @@
 #include <sys/signalfd.h>
 #include <sys/wait.h>
 #include <poll.h>
-#include <sys/stat.h>
-#include <time.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
-- 
2.25.1

