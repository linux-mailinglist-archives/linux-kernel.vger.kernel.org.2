Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55CD3B1B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFWNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:45:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59880 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFWNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:45:40 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lw3A1-0007JT-PM
        for linux-kernel@vger.kernel.org; Wed, 23 Jun 2021 13:43:21 +0000
Received: by mail-wm1-f71.google.com with SMTP id o3-20020a05600c5103b02901aeb7a4ac06so1620530wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yubxi2qbuY0f26nH+TCC7V2Gu19HEDSoQcEIu557Wn0=;
        b=kmcmwJHQDrz7TRv9KUuiWGovvsvMrsIOiaggJVlypvcUkeBnqR0lyfxOib6EUKagPL
         8onfR6Q3Jb83qJrsr3b6X8NiOWnoxSF+MOMGcc6UjM++qmASFSj+UNcUklrn1M02Q0yT
         KNpuJFwxHr88NN3V+v37G/242CuJjJkBhCvAXECemib7y5TJwEeQaSA+C24/EBzc+Jjn
         F0pkEu7yXMbazTwoO3HWu9ycIrqGRZV2bgBLOn1wvAlGXHBK82014psIUkbMWSVWi5Zo
         ffrd75i/q0qCkBKp7JzZRoVXSnPlA0BiGzWFHgFdZVrDFSsPbbEVgcrxzVR8qrfe81mt
         mL0g==
X-Gm-Message-State: AOAM532JJfT5gvBdVBCcvHLVusnmeoeFsfGzWLo7LTNSXQssN3hM1DQy
        5Xi+594wWn1wXjmL2f4pVOwnQybEZdYeI0cHqjExtS9Y98SXd+sRvDQIpMHW9eZpOByRIYd0M4o
        n5h7MZTzkzxaO+tpC/ky8j1WpRdTP00MM9TVGJViiTA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr10758137wmj.72.1624455801591;
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNOn5MnmPCceGWkw5/wLdC+SG1xM2rIUPM/8N6mKYN/v/4zXCzfb61gwE5zQeig6N4a7DZEA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr10758116wmj.72.1624455801401;
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id w13sm94341wrc.31.2021.06.23.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:43:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: fix event-no-pid on 1-core machine
Date:   Wed, 23 Jun 2021 15:43:15 +0200
Message-Id: <20210623134315.77472-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running event-no-pid test on small machines (e.g. cloud 1-core
instance), other events might not happen:

    + cat trace
    + cnt=0
    + [ 0 -eq 0 ]
    + fail No other events were recorded
    [15] event tracing - restricts events based on pid notrace filtering [FAIL]

Schedule a simple sleep task to be sure that some other process events
get recorded.

Fixes: ebed9628f5c2 ("selftests/ftrace: Add test to test new set_event_notrace_pid file")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---

Changes since v1:
1. Correct spelling in commit msg.
2. Add Steven's ack.
---
 .../testing/selftests/ftrace/test.d/event/event-no-pid.tc  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index e6eb78f0b954..9933ed24f901 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -57,6 +57,10 @@ enable_events() {
     echo 1 > tracing_on
 }
 
+other_task() {
+    sleep .001 || usleep 1 || sleep 1
+}
+
 echo 0 > options/event-fork
 
 do_reset
@@ -94,6 +98,9 @@ child=$!
 echo "child = $child"
 wait $child
 
+# Be sure some other events will happen for small systems (e.g. 1 core)
+other_task
+
 echo 0 > tracing_on
 
 cnt=`count_pid $mypid`
-- 
2.27.0

