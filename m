Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5524546AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKQMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhKQMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:54:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8C1461BF5;
        Wed, 17 Nov 2021 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637153505;
        bh=Igyl9RgwqESSqumFc4B4dZ8ol4E3Pz5ijTCBbWixfrY=;
        h=Date:From:To:Cc:Subject:From;
        b=uuNU2kQN4qN2kNncJk1flhZVlcbqyfsggUg/Wq+a6K9YNX4E+D6L3xelGMYEXnpSR
         hULEPMJnhMf3nyoukkMtvLgO83EAYLaRvCtQI3/RBQQ4DcTzGoRniGgm5jy4Rq1ej5
         1d4+IwRtH22RHzAVg6pTY8HZUDJUFayFoqHmWRRs44idFs8DcOls25aZsm6UnjoPwV
         n3HFEThsvmnOfChcOOTWz3OYkBaZ4dLlzyPQE2Vg6rvADraaWljSjB8T99NtP6BUNh
         G5Xgc5/YJbXhcKHDtvO0wT9xLmi7SCzPZfwLiaVSEleodzY7QpvLSYM58wDUZvph6A
         WlPEaYW5iDbQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 178044088E; Wed, 17 Nov 2021 09:51:42 -0300 (-03)
Date:   Wed, 17 Nov 2021 09:51:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI][PATCH 1/1] perf tools: Set COMPAT_NEED_REALLOCARRAY for
 CONFIG_AUXTRACE=1
Message-ID: <YZT63mIc7iY01er3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is being used in tools/perf/arch/arm64/util/arm-spe.c and the
COMPAT_NEED_REALLOCARRAY was only being set when CORESIGHT=1 is set.

Fixes: 56c31cdff7c2a640 ("perf arm-spe: Implement find_snapshot callback")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: German Gomez <german.gomez@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 07e65a061fd3a13b..afd144725a0bf766 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1010,6 +1010,9 @@ ifndef NO_AUXTRACE
   ifndef NO_AUXTRACE
     $(call detected,CONFIG_AUXTRACE)
     CFLAGS += -DHAVE_AUXTRACE_SUPPORT
+    ifeq ($(feature-reallocarray), 0)
+      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
+    endif
   endif
 endif
 
-- 
2.31.1

