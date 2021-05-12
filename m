Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32A37BC46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhELMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhELMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:11:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51079C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:10:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s22so18028354pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqYLtVnXdlsYYPiGkQ2fyTPX9HBvqdSbPzY1pePPvTo=;
        b=JJ3sCBy1NkgnoFAKsCKrghPHg8/R5STtmAdDNRo2RuDbSemS/a8LtBVvIBJj4yhMyt
         F/5YKzOOBWZhuWVuNoeMPQPyM02udP1iJTHyXEWtC9Iocl8G97WE8QYwDWP7aZ2Y/E54
         g7LMLfSBFTgyUr6uCSyw+N9hYxvvI114Fq2/CNVuaFkz2nzgjj8gKH5EstfVDnhQs/JV
         sQErcfZiSi5nL8ATY0w3SGGeuMEM/TfqfOPesMPZaML21s1CvN3ox7pcJc/B5Vti3g5U
         p6RvOX7WdYrKw8vayUkSuFlMxlcvFrhjx9F9nZnDk7Y341T33xCW8t1R7NhrByqRk/5Y
         inbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqYLtVnXdlsYYPiGkQ2fyTPX9HBvqdSbPzY1pePPvTo=;
        b=JoKgXqvs0VUenQ48DvM/NZUEI7HmnZugb1AcecLyisXqn6+XhxD4DOjmfkaDp3ATAx
         iWXzCAq0iWVHSJLujfyI4g3hyXq314zXHO/MVll8P7zh+H4KY5ORzNo5NUoaDoRbXpD3
         wEvdjXtv/d2/4iuSvs8IlwyCHcXOgSF89xGGGzkYlbG+HwJ7AAQxXD8ZuGBNUmyDP/X1
         2pmZWHnd+4u+jo0P4Z939oyiumTwJw1bJ9qaA4G5EduPdV42fE0Po/cyqIc18A4vPz2d
         QyuAtkOnoDNx8TmTFMCctHeU1BxR01GNlZoD3JX3HbFELZ4hbToxBlnz6NPishRVRQIb
         sFgQ==
X-Gm-Message-State: AOAM5321U2pRJfenISGDl2W12+NGq9kLNa54QMbTeDON7JErMrQ7ulx6
        OEuQpPAE2qyRpzGgaTc1RHpWiw==
X-Google-Smtp-Source: ABdhPJxQB5KYO8uFp/pFsRo67J4YbpMzEIVOmzIfj7a/xlHD/2OaGS+PeCJ+AAEL8ibq9f6bEzQD5A==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr36402347pgi.290.1620821424452;
        Wed, 12 May 2021 05:10:24 -0700 (PDT)
Received: from localhost ([103.207.71.84])
        by smtp.gmail.com with ESMTPSA id y64sm15660781pfy.204.2021.05.12.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:10:23 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] locking/lockdep: Correct calling tracepoints
Date:   Wed, 12 May 2021 20:09:37 +0800
Message-Id: <20210512120937.90211-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit eb1f00237aca ("lockdep,trace: Expose tracepoints") reverses
tracepoints for lock_contended() and lock_acquired(), thus the ftrace
log shows the wrong locking sequence that "acquired" event is prior to
"contended" event:

  <idle>-0       [001] d.s3 20803.501685: lock_acquire: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501686: lock_acquired: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501689: lock_contended: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501690: lock_release: 0000000008b91ab4 &sg_policy->update_lock

This patch fixes calling tracepoints for lock_contended() and
lock_acquired().

Fixes: eb1f00237aca ("lockdep,trace: Expose tracepoints")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736aa03b2..7641bd407239 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5736,7 +5736,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_acquired(lock, ip);
+	trace_lock_contended(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
@@ -5754,7 +5754,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_contended(lock, ip);
+	trace_lock_acquired(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
-- 
2.25.1

