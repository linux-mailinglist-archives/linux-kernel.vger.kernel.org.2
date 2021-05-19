Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D1389409
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbhESQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbhESQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:46:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D35C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:44:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so18620816ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9GW1oyTjD/RMsVNdKnza5MLgPiZ/BeX1RWS+tpjbiYw=;
        b=BDVB0nUCyWHhJG9O9W1D40kV8iKtFjoFdYa+ougq5w9evBqq/0NdxqL5lC5WbNcCa9
         CN0IM2jshODOAUP9aON/jRZGz7z8OXqxPmRE4CFjU61ofgtLQJ4upO64S4EMICFPrZ9p
         ub+SWWPSKbOo2P0EffglejiaT5xtoLrFhNla5FW2SCXLdG7MiIj2aHaHiSXczfCxhvQh
         i7QJBDu8h87OxtBfQ8LxPYGcAFRu2Tw3fkuIQtMKvXrnvYnDkGCDFiPSNrUKuhExiRIY
         xVOFdhm4gX8BF6fqXqYmDiJWlPPxx075/bql3xJO+YBj3qPGTJyMhDHJdWAKqV0h4fSQ
         bZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9GW1oyTjD/RMsVNdKnza5MLgPiZ/BeX1RWS+tpjbiYw=;
        b=PDRschHgwl/9YucneqEDprx+uefmNGTd4IsztX0MfP1Yp0LZj7S4CJdkXKrFi9NCJr
         B/DLTYXUsLDpegq+EU4DtPabxgga5HG6jGU6mws8hPM4kHGq/fVxWxPAlmzjKNOSknPO
         TGSkzPKk+7js/30tfjaqSG5VIs1KZMA9KTnd2Wuu6hMrnPCN6r8mhjgsI19Y4WX74aYe
         XAMrqvtEJm7vrFFoKQTJwTjjKH1t3MmR8plZe/IFKcXItDMgnZfgxgQNs/GQMdXdaS5k
         rl7qmjwv8nilL4PU7nsH9PBIQzydTBHGTyRYEPEUkSxhccSu5/g6YtHupuVXAWuAS250
         PRXA==
X-Gm-Message-State: AOAM5303NFa0YMHvbY07xkf/Mm2QSG9+BI1bc763RXpKIhdGnK+tiPc5
        uaj3n2jEVdEpTaGmZ7Ku1zmArBQPRH/p
X-Google-Smtp-Source: ABdhPJwmU4oMGnaEsx1vLCYzXTBNQfNfjtpdk2+BGRRV0KGZodP/MA1hPvc7645uVpfpJQcwOWc/S+Ruk8na
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:636:a116:b1fd:c4e8])
 (user=irogers job=sendgmr) by 2002:a25:c646:: with SMTP id
 k67mr597071ybf.137.1621442694952; Wed, 19 May 2021 09:44:54 -0700 (PDT)
Date:   Wed, 19 May 2021 09:44:47 -0700
Message-Id: <20210519164447.2672030-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] perf: Move debug initialization earlier
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids segfaults during option handlers that use pr_err. For
example, "perf --debug nopager list" segfaults before this change.

Fixes: 8abceacff87d (perf debug: Add debug_set_file function)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 20cb91ef06ff..2f6b67189b42 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -443,6 +443,8 @@ int main(int argc, const char **argv)
 	const char *cmd;
 	char sbuf[STRERR_BUFSIZE];
 
+	perf_debug_setup();
+
 	/* libsubcmd init */
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
@@ -531,8 +533,6 @@ int main(int argc, const char **argv)
 	 */
 	pthread__block_sigwinch();
 
-	perf_debug_setup();
-
 	while (1) {
 		static int done_help;
 
-- 
2.31.1.751.gd2f1c929bd-goog

