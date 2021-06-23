Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2463B145D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFWHG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:06:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49223 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFWHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:06:53 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvww7-0000eq-A6
        for linux-kernel@vger.kernel.org; Wed, 23 Jun 2021 07:04:35 +0000
Received: by mail-wr1-f72.google.com with SMTP id b3-20020a05600018a3b029011a84f85e1cso698765wri.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH2QL7P4i7gFaUF/ZBeQ7+HlAe6BdfHUYWj4tEHBDgw=;
        b=OgQdqrICLtInYRNq00iFBAsNp7Eo7FskpbroDyWG5iFyks7Ccs0szs5YA349M1M8ne
         HYJXp3mBlBv1nZjdHgaYNafiks4UILK3Dd8+Hq+WM+I7nQ8e6t7ud0isvAlnKv8z1B1v
         RrgF94875SfXiyQyhQGttgKD1mHNxOsOISbF26IDI0vQIaQuuHgqlAoE9Bwa3kM+lx2P
         8uATaG/5dz9PN2FIBPIC494qZbIT2JSx3ofb9s2c9ApVsX8thGNrlVLK6AtnS8QjVgMj
         W8rz1HTP3zZGX8wtt9uag32m4TDXJD3PNdtfJeEqCizB8EIWi+55aC/cQUkZ2T7vSgaJ
         I8Ag==
X-Gm-Message-State: AOAM533XjyP+Y2IkJEBfSyyynKVjNirddw6RBp086v77E/v3iwnL6vXn
        Jn8oiIsREH4yHeL8Yd0pBSnM7tzKkR3QFd006HZZO4efSgxYkp8V9HFG27tqO8wq0ElKoudYCbx
        JzzLw1QgZ0bAn5v5E0sdVQJbyQ3P5OsJcYwD9XQKqtw==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr5042405wrt.273.1624431874982;
        Wed, 23 Jun 2021 00:04:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMQOpl/2xpkgmzgfvqKIMaW6DBY/obT/oN1U9kV+oY949g+Ewlk2Di9BxmoeJI0KvBPAIhAw==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr5042389wrt.273.1624431874854;
        Wed, 23 Jun 2021 00:04:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id q19sm4529407wmc.44.2021.06.23.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 00:04:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: fix event-no-pid on 1-core machine
Date:   Wed, 23 Jun 2021 09:04:31 +0200
Message-Id: <20210623070431.16592-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running event-no-pid test on a small machines (e.g. cloud 1-core
instance), other events might not happen:

    + cat trace
    + cnt=0
    + [ 0 -eq 0 ]
    + fail No other events were recorded
    [15] event tracing - restricts events based on pid notrace filtering [FAIL]

Schedule a simple sleep task to be sure that some other process events
get recorder.

Fixes: ebed9628f5c2 ("selftests/ftrace: Add test to test new set_event_notrace_pid file")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

