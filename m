Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF938924F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhESPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhESPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:13:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:12:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so10053797qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oO5AKNsRSSnrJptTZQeQrJnBbvbH66aYrmljzYTwDeI=;
        b=tCLCiIrH8w8VmA+arhHU+ywzOryvrr+CesPIkyIa1DbBDY4l7ECqELkC3a/R0GCkgn
         oswgIt9bgSOYmog9+Ru2dxq+QEZ0QlLgdW/izDaTHQ6+OdorG9TCpXRG6rruxGsl1klc
         SuolBqr71uYITu+hACVPX8+MDqpM/zrMs0U4rkMUbCGdmIOklzcvF9iuPiCyyPnqVMVS
         yI9240QC28FiCnKPk2lkU2BRgcyOb6Wtp9m+TJoTd/Ab/0zUqnxhzV3CgfReePDy+xWL
         3IfO5lUoZHaRXJt055x/z8QJ2WHwlcQIoVKnvBO7yKLMAeRoY4Qv51+HbakH+udR15LR
         7Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oO5AKNsRSSnrJptTZQeQrJnBbvbH66aYrmljzYTwDeI=;
        b=Js4wqyYJtx4WhkhfCeG3KgritOQnfdWaPoyQHY/TuO6uT2+otcyvpa5JGC9wKTwcBT
         zXTnSsodDhyeF8kFU34pf4WWoLtRjUG4pHBKYdIXdpKlHfBTGNdPvrEPzZ6MKpWMmH61
         1XdztbltjqJR88YSTe0YfRmh2sVZppl+y2WVd4ZBHrC7yt7G/e9H2klc11I08ZywhPi/
         I9uBKxm/hBW1of+BXKpbYb286Yk1UG4G+QLli8B4pQDNYAvtv2ka4/u4RxGZ8n2buKnf
         cMLPUPK3cWwMWuJbQ+w7e9sJrW8N6Z4huVdwUpAuUc9lJN59rodM+zdJRsosDShkPOdE
         2p7Q==
X-Gm-Message-State: AOAM533KBpHHKuVemNj2vVmvy08z1zzyRwW0H4DBTH/tiV0q7BF62XoN
        1cRXTA4o3gQcWkOQ/g4249xf7uW5Vfvm
X-Google-Smtp-Source: ABdhPJzA/kKG/MEzQLWxdX0i5sLjbYnvy9r6NmZGAqzO2NWb0EEu69DIMNoUCj2Q9OY9vkinfT9OrWVh8tdd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:636:a116:b1fd:c4e8])
 (user=irogers job=sendgmr) by 2002:a0c:e601:: with SMTP id
 z1mr14019739qvm.62.1621437139616; Wed, 19 May 2021 08:12:19 -0700 (PDT)
Date:   Wed, 19 May 2021 08:12:13 -0700
Message-Id: <20210519151213.2643570-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] perf test: Test 2 libpfm4 error cases
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proposed in:
https://lore.kernel.org/lkml/20210517140931.2559364-1-tmricht@linux.ibm.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pfm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index d4b0ef74defc..acd50944f6af 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -155,6 +155,16 @@ static int test__pfm_group(void)
 			.nr_events = 3,
 			.nr_groups = 1,
 		},
+		{
+			.events = "instructions}",
+			.nr_events = 1,
+			.nr_groups = 0,
+		},
+		{
+			.events = "{{instructions}}",
+			.nr_events = 0,
+			.nr_groups = 0,
+		},
 	};
 
 	for (i = 0; i < ARRAY_SIZE(table); i++) {
-- 
2.31.1.751.gd2f1c929bd-goog

