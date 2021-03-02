Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D932A0D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576715AbhCBEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443746AbhCBCgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:36:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559CC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 18:35:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n22so935874wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHGDVsiyTsA6DF1ecftcK5dyYlXaVZKVulssJgFfiKI=;
        b=emGI1AdpwcPQ1t6mgydrDfQlJHF7SRMWZOF04hpmcxJCRDqYhzXYbCwH6igKTeXJJj
         Ao0yQd+eIykWvxsMd9L8NOkDrq02y2Guo8mg4zY3JZahy4LK8DeczHi68NK+W+tyZ+OA
         4xk8lDLKiXHsrz3I9jaYW3OnDzSgZoSxFBjg3jPFEEmQaoR9Xmh2q+xuJRU1zuq8rEN6
         D8moemGtlQg/Q3+UZ+1agznqfP10ZVnv0xgeWEd3f+39ijgOIJLNjMl6d+OvIraOKdTj
         Tw0JPeIlVx7eFPu8UurJHritoK8UYWuvOug70Or2PyhMKVHVUuz/JT+LyCchtfm6S3xI
         VR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHGDVsiyTsA6DF1ecftcK5dyYlXaVZKVulssJgFfiKI=;
        b=C2AGd/XIA6fXmi+b0C6Y0d3YxQOE9+ld9DI2+wZG7za0onFbjKXvL8vk726VtDqSjj
         /FM+2Dss5Ihq4GK0LqhABKzUtWplugnr1h0QweY+YEYC1oeFJiRLjmorVosv35ePfWQ7
         iV6Bsqgi967Q8Y+lmSBTOYbc6/1ZhhL8B42zjHGhBTSh5rRtI7wbHmYAp4T6nGCglQfS
         kTd/on0Bn7N2+TsQF+1/cOO8jUrsAN7VroxXSkB70YcJ+FTB24yWTk8HbPbOk8RjC5+w
         mZbKf9QGt2rOryemq+FbnCe2pPOYHPJ5RCYxHL7NohB4gUFyg1kaqvGtfc1/E8fTiVZg
         4g/w==
X-Gm-Message-State: AOAM531vgDdHXVSBFVZmL52Ex0g9iMn4plAP4hkc6ZcI5Ch6ms1PEFl5
        zIS5uwW11LRNaOPfo01vKQXM2HZXRqLX4bSZ
X-Google-Smtp-Source: ABdhPJzv1ZFqTHlc2amjCso3PGMVl7yeRYvIW6AYKgzpxd9QEzkqmxm1aSkX/zrJYOIujglSLyyAOA==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr1649980wmq.2.1614652535381;
        Mon, 01 Mar 2021 18:35:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l6sm9993382wrm.71.2021.03.01.18.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 18:35:35 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf diff: Don't crash on freeing errno-session
Date:   Tue,  2 Mar 2021 02:35:33 +0000
Message-Id: <20210302023533.1572231-1-dima@arista.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__cmd_diff() sets result of perf_session__new() to d->session.
In case of failure, it's errno and perf-diff may crash with:
failed to open perf.data: Permission denied
Failed to open perf.data
Segmentation fault (core dumped)

From the coredump:
0  0x00005569a62b5955 in auxtrace__free (session=0xffffffffffffffff)
    at util/auxtrace.c:2681
1  0x00005569a626b37d in perf_session__delete (session=0xffffffffffffffff)
    at util/session.c:295
2  perf_session__delete (session=0xffffffffffffffff) at util/session.c:291
3  0x00005569a618008a in __cmd_diff () at builtin-diff.c:1239
4  cmd_diff (argc=<optimized out>, argv=<optimized out>) at builtin-diff.c:2011
[..]

Funny enough, it won't always crash. For me it crashes only if failed
file is second in cmd-line: the reason is that cmd_diff() check files for
branch-stacks [in check_file_brstack()] and if the first file doesn't
have brstacks, it doesn't proceed to try open other files from cmd-line.

Check d->session before calling perf_session__delete().

Another solution would be assigning to temporary variable, checking it,
but I find it easier to follow with IS_ERR() check in the same function.
After some time it's still obvious why the check is needed, and with
temp variable it's possible to make the same mistake.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/perf/builtin-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index cefc71506409..b0c57e55052d 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1236,7 +1236,8 @@ static int __cmd_diff(void)
 
  out_delete:
 	data__for_each_file(i, d) {
-		perf_session__delete(d->session);
+		if (!IS_ERR(d->session))
+			perf_session__delete(d->session);
 		data__free(d);
 	}
 
-- 
2.30.1

