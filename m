Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E379A33490D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCJUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhCJUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:41:27 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:27 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b15so13604446qvz.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=olgDNThU3Gi1qEGHEgliM8s73SM6b44MNPtrpvNjnMY=;
        b=Uy08lqnM701KIBp5IehqUikZPbohigqlYMLTf+HXv9DA44ndE8qzbjFq4d+PVWfbi0
         GsdmMXD6/UbUxOhBOGKHX4kOzcvjLMhF7k922iMPU4nrqjGxn5Sp9+AKLh4VMPzaJtKZ
         BNW/PzSvllZ5/VRlM+J2SBbkEcUR7yT3QQtEO9KzApMsx5CaupMk38JHg1TOuzicZ91q
         zn7A7d9HX99AAWWUNirqqHDsF5ahe8BZUdmq2BkR30kE4Y6dp3ZZR0U2AQAutvgdWEZz
         1oB09SQLPJ1oWmZOlmaSGx9i6eU5TtxWutE0gj0FB44rwaTj1zxTvXJfOun1R0uXAMgq
         tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=olgDNThU3Gi1qEGHEgliM8s73SM6b44MNPtrpvNjnMY=;
        b=cr8eCWhkuX5T1OG28HQCcpptdtCyOpn+s2Pt7EDyySVlBUH+K/hxKGw0uMrR5cl+ae
         defgruEiNIneVizYxgnAus+75b4qFB9IixDUteLLzaVrbnjxC/fPyMdyuNKo6kwDYN9Y
         RzL0Tnd9cO6ugoUg1op+HSQZmzhKyNPo84vKmwkGS8v02soGlhUIJywE0eNthk+Pzvli
         rOKNwWDg1GZEpQLOOLLWYdgyMEpL8NOMDG0iEAKDUhiuhJ4qz4pogCpR7aeaYmpokhKi
         FAGfu3wGbuO3pzZqGOfBoyhGqTMo0wUx+GP2+v8uGfQ3dk8bHK/0tGq2On/QuL07SOBA
         ygGQ==
X-Gm-Message-State: AOAM531NAJ+fGbhmg4vgehl709rdcYlhtOiyZ3zzF/iFqnK3M/v/ckUh
        CPqiXakLCEImRdcxFvMdA9fi40tV0FpX
X-Google-Smtp-Source: ABdhPJzv+44pu5ytJgXrdfJznreaPuUG/WeOYMDmyXBfKIo44ENL++EBkFaT7w4my+X06rj7pVIbuVnN9nye
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f1bc:db2b:fff2:533])
 (user=irogers job=sendgmr) by 2002:a05:6214:15d1:: with SMTP id
 p17mr4651906qvz.28.1615408886915; Wed, 10 Mar 2021 12:41:26 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:41:18 -0800
In-Reply-To: <20210310204118.711514-1-irogers@google.com>
Message-Id: <20210310204118.711514-3-irogers@google.com>
Mime-Version: 1.0
References: <20210310204118.711514-1-irogers@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 3/3] perf test: Add 30s timeout for wait for daemon start.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retry the ping loop upto 600 times, or approximately 30 seconds, to make
sure the test does hang at start up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/daemon.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index a02cedc76de6..cb831ff2c185 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -127,9 +127,16 @@ daemon_start()
 
 	# wait for the session to ping
 	local state="FAIL"
+	local retries=0
 	while [ "${state}" != "OK" ]; do
 		state=`perf daemon ping --config ${config} --session ${session} | awk '{ print $1 }'`
 		sleep 0.05
+		retries=$((${retries} +1))
+		if [ ${retries} -ge 600 ]; then
+			echo "Timeout waiting for daemon to ping"
+			daemon_exit ${config}
+			exit 62
+		fi
 	done
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

