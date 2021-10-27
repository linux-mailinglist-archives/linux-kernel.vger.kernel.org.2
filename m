Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394E343D364
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbhJ0VCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244149AbhJ0VCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:02:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B61C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:00:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id n9-20020a63e049000000b002951886c1c5so2180269pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HUT1jrky2QfADSJBqDyxkAfRQl5Gv0by2m5wgHaMIGI=;
        b=mzwlor0IxbDrHZ832vmIGDKIRLJHzHXUSJ+qdT2DtWDviVCexFW2Qe8impwSet4coq
         S4aBLll36JwfUZ0gqCf5lbUBGExW7TtD/lNHf6y0uehgpOWapnxLldAKOjCrcOePTkm/
         mDL4xvBzxSu+0wFXm6YAi8zdjwMxqyhAQLYU35M4Be/Vmq0iVgdyPxtL6QT4WK/WoyBM
         fs1S5OL+TRwbXL5B71gULUE004KsnUgIC9LhxuM1/IYIu/iBAllYQcad9ifv0hbLwTSJ
         zqGvmhEGGDsWWeG1s+Wp2Slb9lC8V1rxGDo9GPrrnUuTJv6tA+Ts2ht8U7FSzyyTxwx3
         g5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HUT1jrky2QfADSJBqDyxkAfRQl5Gv0by2m5wgHaMIGI=;
        b=5ZylzvZwFWbCZu77zxx9pR/C+z5+ZR56lSdb+ZhaqeskO/5rTDoo51SQnxMNSmFq1Q
         F66zytWspCK4iJCD7dLq6JUi4SGl7YuJjBWn1jjMvyg57mhzXjoVAKDUmNMz2Aaww3p9
         c7THHme+w+MDvp7SUOkEhXe4d2y56+G8ajjFwlMhXbxnebpdQ51BJIYdnpULRB+XQ5F0
         UWHII+nktPjtlS3r3SO0ETCLrwlVQbGt3Ie5u0EiAHzogDwe7JvQW4jnsdxl3Fy/c16N
         1xpfyYUurJAm/RI1CV5AFbncxUhL+BZaBZPWH9cQnUFtvKdMgCRGuk8YuwPMIzfTqQLb
         qbag==
X-Gm-Message-State: AOAM531ageYWAL4i9+i5Nmj5plybOVGLl3t9IbbflcMCsHC0XjzTapUj
        NzpusqvupLEVjmilNgkJQ1UTkYwtsapfkVXZhg==
X-Google-Smtp-Source: ABdhPJyt1iASH+IucgMJThPeB51NN/4FBps+l+So2s0vMdIMzts3wP5OX9ju5lRJ6tRUzwOJXqQYArg5WvNtJO4qjg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:2387:b0:47c:134e:4848 with
 SMTP id f7-20020a056a00238700b0047c134e4848mr37555pfc.74.1635368412797; Wed,
 27 Oct 2021 14:00:12 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:59:09 -0700
In-Reply-To: <20211027205919.1648553-1-kaleshsingh@google.com>
Message-Id: <20211027205919.1648553-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an event trigger references a variable defined in another trigger, it
has to be removed before the trigger that defines the variable is
removed.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 tools/testing/selftests/ftrace/test.d/functions | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..bd9e85f4d626 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -22,6 +22,15 @@ reset_trigger_file() {
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
+
+    # remove triggers with references next
+    grep -H '\$' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+
     grep -Hv ^# $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
-- 
2.33.0.1079.g6e70778dc9-goog

