Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E52454C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhKQRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232047AbhKQRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:37:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C6C61221;
        Wed, 17 Nov 2021 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637170456;
        bh=r20T7LV+HUaSF0Dn1BF3aWqv86caf8MokLQAx7gSDLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jxNh3HSfb1y8hZW1NhdBHBdYBOe+l/+3COgf5dxqTexY60CGJniqoBC3q3tuavr4/
         /3r0IbUu5weJGH4vuzj6tzs+YvSV9oZ9cP1dqDhoLGvusA3quHU4EaZQBBMbTVtSj5
         5Trq0tein6sbOLSHITw2slrb32RQV7LJM7O9hbnss2GmyGKvUgJIk6xDryTs0lWXiM
         mztYowx2dA7uLK4eycnc2okSGyu/OD2GtjmilV5KjBcsyN5oMuoQ69AEI5OfkBcJxD
         shaqLY0d+YcanDetD1tjBacvw4DZK3daGVvPz+XHVC/1Lma5Kx+frwL6AKlUJu8grw
         XYj1gTNrBDqnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 491124088E; Wed, 17 Nov 2021 14:34:13 -0300 (-03)
Date:   Wed, 17 Nov 2021 14:34:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Subject: [FYI][PATCH 1/1] tools build: Fix removal of
 feature-sync-compare-and-swap feature detection
Message-ID: <YZU9Fe0sgkHSXeC2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removing the feature-sync-compare-and-swap feature detection
didn't remove the call to main_test_sync_compare_and_swap(), making the
'test-all' case fail an all the feature tests to be performed
individually:

  $ cat /tmp/build/perf/feature/test-all.make.output
  In file included from test-all.c:18:
  test-libpython-version.c:5:10: error: #error
      5 |         #error
        |          ^~~~~
  test-all.c: In function ‘main’:
  test-all.c:203:9: error: implicit declaration of function ‘main_test_sync_compare_and_swap’ [-Werror=implicit-function-declaration]
    203 |         main_test_sync_compare_and_swap(argc, argv);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  $

Fix it, now to figure out what is that test-libpython-version.c
problem...

Fixes: 60fa754b2a5a4e0c ("tools: Remove feature-sync-compare-and-swap feature detection")
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 9204395272912c13..0b243ce842be3383 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -200,7 +200,6 @@ int main(int argc, char *argv[])
 	main_test_timerfd();
 	main_test_stackprotector_all();
 	main_test_libdw_dwarf_unwind();
-	main_test_sync_compare_and_swap(argc, argv);
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
-- 
2.31.1

