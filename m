Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9499A40D455
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhIPIOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:14:38 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44070
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhIPIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:14:36 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 098E83F045;
        Thu, 16 Sep 2021 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631779995;
        bh=7G1LzZqDywSBFjqaKTOSvBQIcHl8kqxKpUEtrX69ypc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=X7k65UOn7es9rdKT1/jeK6PyuYC7KiTZp5Bjf7fFaaalNqQpU0FS45PUPw2HwmVna
         RiUnq2M6LdqQCRs67YO9Tp0hn63JQB1vaGqcaFKevQNSxUtDBOq/rMUOKwczhj8y8I
         vIDcabVdgNxbR9xjPq4vhZeP6Mun5ebH8X9o6k51CTWygOPkszqkcGMAslvpJ6td5r
         xwRHrEM5xT4rlbFdGFJgD3lloZ6ZA8hS5fEs9QpoJpFHTTesjQIV1l+rGJuZvHW8iY
         KshXOmx6lDyu52sTgzEwtX6M+/9nnocEj5SCC7PYaAAymGICNFC/FyluIzpGC5REmj
         nX6EhXjXxrnKw==
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events: Fix spelling mistake "icach" -> "icache"
Date:   Thu, 16 Sep 2021 09:13:14 +0100
Message-Id: <20210916081314.41751-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the description text, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/other.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 84a0cedf1fd9..f1f2965f6775 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -1046,7 +1046,7 @@
   {
     "EventCode": "0x4e010",
     "EventName": "PM_GCT_NOSLOT_IC_L3MISS",
-    "BriefDescription": "Gct empty for this thread due to icach l3 miss",
+    "BriefDescription": "Gct empty for this thread due to icache l3 miss",
     "PublicDescription": ""
   },
   {
-- 
2.32.0

