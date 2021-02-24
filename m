Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80A3237C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhBXHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:15:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A3BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:14:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kr16so715175pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPYtZhQe3SVJpMbteJaGit0gHTdTQ3qstHzOHTz8EtE=;
        b=MPeW+k89b+SK7BKK2GwKi9RA8c20e/MSGHr5ogGJDzfhh0XJNWmwaawCqnKlXIO9fE
         Tvh6S9JY+m2WXSopmaVXRUeM/u8DIvHia1sin2u302O+uTJw8uN96Nk2P68J/lnW910n
         4mjQxOSmTQHoGZlFTFquzcLPMImDvlHnLTxcI/oFlkCHEvAKh6VIkh1R56YReiW59Vq4
         qfsYeDj1rcryd3L8I0I/Q4TjzclZczp2m15jCZiIp6SquZnxOF0gTwzGrmCsetBCCGis
         T7m9o/xpRGBb3CKEzLvNoKFMX7c9IZ6DZl6oMrTZ/Zy854ZbAZRE8LXVmiqKrXVSsjMy
         NC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qPYtZhQe3SVJpMbteJaGit0gHTdTQ3qstHzOHTz8EtE=;
        b=LLwX4lEv+j5FIPFET7/RLIfXDjyWf1cm5JnHUQkhpKzS0+nv0rKKCR9PAxdyQPRcJf
         ekM6mC4y+UDTE5VUan3LNGpKZ9Q5d1lbWyPDEoq76+Z/iYjH2osfhnkf/5yF3Lp8wNXt
         O/iHmM0IgXW1beJ4lb+ohOIDja9MPOxEbGD4kKWFF9cUNvt9B3fYBSMhVKrhxhGrVf29
         fyHtmh6KElHxlWpm1RPGQUf2RWF/pkUAMlC8nu3qoqL1xGI2GRoqTEXzkBXKmCkxEb3X
         4foRkzgY+ptLBIlaxwZX9s3N8wMHngEuT+arQUbOZypTO10CEE7npxMeK8UERDP0CYoe
         ifjg==
X-Gm-Message-State: AOAM532Bmo+WTjLhKZLgOsbgL76B/MLa39rIzXy8LLvL9zpAXu1Ul61p
        KrUhF0V5EVtrce57EBrD8Eg=
X-Google-Smtp-Source: ABdhPJww536gBql+qDl9DJM98XXdPFIEnf2avDQWQNHel8k8RNaBhNMUynz948z5ad9O7t2oDAngSA==
X-Received: by 2002:a17:90a:4589:: with SMTP id v9mr2941336pjg.113.1614150885107;
        Tue, 23 Feb 2021 23:14:45 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id mp20sm1513441pjb.34.2021.02.23.23.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 23:14:44 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf daemon: Fix compile error with Asan
Date:   Wed, 24 Feb 2021 16:14:38 +0900
Message-Id: <20210224071438.686677-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a build failure when build with address sanitizer.
It seems we could write to the name[100] if the var is longer.

  $ make EXTRA_CFLAGS=-fsanitize=address
  ...
    CC       builtin-daemon.o
  In function ‘get_session_name’,
    inlined from ‘session_config’ at builtin-daemon.c:164:6,
    inlined from ‘server_config’ at builtin-daemon.c:223:10:
  builtin-daemon.c:155:11: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
    155 |  *session = 0;
        |  ~~~~~~~~~^~~
  builtin-daemon.c: In function ‘server_config’:
  builtin-daemon.c:162:7: note: at offset 100 to object ‘name’ with size 100 declared here
    162 |  char name[100];
        |       ^~~~

Fixes: c0666261ff38 ("perf daemon: Add config file support")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 617feaf020f6..8f9fc61691da 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -161,7 +161,7 @@ static int session_config(struct daemon *daemon, const char *var, const char *va
 	struct daemon_session *session;
 	char name[100];
 
-	if (get_session_name(var, name, sizeof(name)))
+	if (get_session_name(var, name, sizeof(name) - 1))
 		return -EINVAL;
 
 	var = strchr(var, '.');
-- 
2.30.0.617.g56c4b15f3c-goog

