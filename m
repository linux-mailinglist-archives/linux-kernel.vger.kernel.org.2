Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D94541EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhKQHhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhKQHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:37:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C43C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:34:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x75-20020a25ce4e000000b005c5d04a1d52so2556743ybe.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=1Ac3jiUmW8PLHox9OC6Cw7/3lY1oU+JstvFtg2jfLKk=;
        b=ghqdPq2BAgJQ/1htcjsJz2zpImGgVnOr99qxNyzwB3qv5KqDygtSW5Bdk+39vGHjAS
         rPFj/ffpCvnrtCWdY1p4r+ryW/cpkAh59BkznnagmgXQ60b1hdjpsL+oR5XjrcpGHTV5
         7vLolic770ASZgAs0xwb/Iqy7ucozIu6oJmGBlgvuJ9ksC8KGt0RGj1QywUwThE/t4lr
         14DNK219B8d+snzNTuqPC+OZ8CtDMUbXIHTtZQN0Ieii5BcoTQbr7tVb1jFVJOU0z48O
         Dv7HcNgBmWeIabRLa0kqo6Eg+9M6YlYsxK496zFRo6dzdM+sApz9oyG+SYDaAuq2bA01
         /FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=1Ac3jiUmW8PLHox9OC6Cw7/3lY1oU+JstvFtg2jfLKk=;
        b=WXKUi/UoUEhX1cGf+PMTdRs+zN/aXFDIIRodP2jJIvoyJMYcN9Vmmi5Z8i3atEMEC6
         MefDzRhtKNCqH/NSs8fxH9HGN1JSMyCd7/76+z85E8+Iy8bRWvlL/V+P7FBQbhe0pjQK
         G1NJ1opJq7cTTWyO8yyaqfGOZ0kz0vxquqYRKz+3Q8m+HWjL9ufnQ95ZUps+0vYFMFnO
         6kXJOdkCiy7/XzHpu4DSGfA5sD6WsWsBcWJi40SPuiRQBcE9vxhH72QMZ7qw1dXLgYFu
         EJpf04iKsrmMD27oxBN8en8yW6n3Lu+2KbktTjq74heBlgOxeWdVQwVyLpWKn2e0AB0o
         KWTQ==
X-Gm-Message-State: AOAM531A5DQ57AjJq49az/wLZNOAdQZeidg7utelQZcEXE1TOLggd/bG
        GYOlB8jLTxxCMX+SczvLXIBpcXoVyMlQL9MJZA==
X-Google-Smtp-Source: ABdhPJw0S2K4jbmVrAQFNrGc0E5NA8neg/87YXLS+NINP4nbyTtkM/0b8cyKqAVwX8VmiL+uwIqKTAPOMdIuax5JGw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:c20a:7cc8:f6b5:d9cd])
 (user=kaleshsingh job=sendgmr) by 2002:a25:a264:: with SMTP id
 b91mr15564363ybi.58.1637134458779; Tue, 16 Nov 2021 23:34:18 -0800 (PST)
Date:   Tue, 16 Nov 2021 23:34:14 -0800
Message-Id: <20211117073415.2584751-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2] tracing/histogram: Fix UAF in destroy_hist_field()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        zanussi@kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling destroy_hist_field() on an expression will recursively free
any operands associated with the expression. If during expression
parsing the operands of the expression are already set when an error
is encountered, there is no need to explicity free the operands. Doing
so will result in destroy_hist_field() being called twice for the
operands and lead to a use-after-free (UAF) error.

Fix this by only calling destroy_hist_field() for the operands if they
are not associated with the expression hist_field.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
Reported-by: kernel test robot <oliver.sang@intel.com>
---

Changes in v2:
  - Handle all freeing logic in one place so we don't need to worry
    about where to free what, per Steve

 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ea2c9ec54a6..b53ee8d566f6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2717,8 +2717,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	return expr;
 free:
-	destroy_hist_field(operand1, 0);
-	destroy_hist_field(operand2, 0);
+	if (!expr || expr->operands[0] != operand1)
+		destroy_hist_field(operand1, 0);
+	if (!expr || expr->operands[1] != operand2)
+		destroy_hist_field(operand2, 0);
 	destroy_hist_field(expr, 0);
 
 	return ERR_PTR(ret);

base-commit: 8ab774587903771821b59471cc723bba6d893942
-- 
2.34.0.rc1.387.gb447b232ab-goog

