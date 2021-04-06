Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBD354D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbhDFGnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:43:00 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:37418 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhDFGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:42:59 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 5622B980148;
        Tue,  6 Apr 2021 14:42:50 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] tools: perf: util: Remove unnecessary struct declaration
Date:   Tue,  6 Apr 2021 14:42:06 +0800
Message-Id: <20210406064214.523650-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEhCTB1CGRkZTksfVkpNSkxNQkpITEtMT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6TCo*Iz8SGi0YHD08MjAh
        MwsaCStVSlVKTUpMTUJKSExKSkNDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJS0pINwY+
X-HM-Tid: 0a78a5eb6495d992kuws5622b980148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct feat_fd is defined at 93rd line.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/util/header.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 2aca71763ecf..3b1d284ee18c 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -149,8 +149,6 @@ bool is_perf_magic(u64 magic);
 
 #define NAME_ALIGN 64
 
-struct feat_fd;
-
 int do_write(struct feat_fd *fd, const void *buf, size_t size);
 
 int write_padded(struct feat_fd *fd, const void *bf,
-- 
2.25.1

