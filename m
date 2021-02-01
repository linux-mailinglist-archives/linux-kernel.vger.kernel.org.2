Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFA30B0E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhBATzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhBATu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:50:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E4D764EC9;
        Mon,  1 Feb 2021 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612208909;
        bh=Rsolv4KdEYj4ujTQyobUo1FspLsrRH9/cauERyP2Qnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nwGLZnA9TQ9wsthjDc/wVK7pjS+iaIwKZL5TwEsMK+CQa0pusPqEqZxp3Mdt+86zq
         iMgVXe4aPUBuN7vQntk2QIhqtdVi7pO165Ydmr4vOZ3/lqvLMV6KKy3Y/ODtwGNEVP
         P8oZpSeFg7zzraZza7HxcAzno2MyEcXRw9dpK3zdGDroRy0zkviaFtusC08rbbfsvf
         51rO7hOu1gXS7U938JXXaor2r2nqMCSHYcf/aLjU9uUEUBWLgMXCd00Ju1hjP3fLS1
         jIsT66g7RW2p+PRvBJxE2RlODVINyeunGomltVF1mNhHeSlD3x15bjASJ84ClpeLso
         kbBuo6eRcQ6Ow==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] selftests/ftrace: Add '!event' synthetic event syntax check
Date:   Mon,  1 Feb 2021 13:48:16 -0600
Message-Id: <1dff3f03d18542cece08c10d6323d8a8dba11e42.1612208610.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check confirming that '!event' alone will remove a synthetic
event.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger/inter-event/trigger-synthetic-event-syntax.tc     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 59216f3cfb12..2968cdc7df30 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -32,6 +32,10 @@ grep "myevent[[:space:]]u64 var1" synthetic_events
 # it is not possible to add same name event
 ! echo "myevent u64 var2" >> synthetic_events
 
+# make sure !synthetic event doesn't require a field
+echo "!myevent" >> synthetic_events
+echo "myevent u64 var1" >> synthetic_events
+
 # Non-append open will cleanup all events and add new one
 echo "myevent u64 var2" > synthetic_events
 
-- 
2.17.1

