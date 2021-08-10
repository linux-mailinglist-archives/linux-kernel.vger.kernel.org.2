Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868993E55DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbhHJItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237420AbhHJIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=LSRN8HbWQ9gyE7lFu5uFwKZbtFWXIcDagC7LpcfHSzqN0ytZcCO68/lanTWBiek/yxUdaZ
        L+OEeURoLJ1lTQ7uQblnbOfXGbFDSa4OAZEqARcGBo3bIx8u/O2U8EWjHkn3/2EjlZD5jP
        v8SoNLGBm9xizJNc4q//o8AWdU6T9yQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-KDqQqUCTO-6cuoUtzY87PA-1; Tue, 10 Aug 2021 04:48:31 -0400
X-MC-Unique: KDqQqUCTO-6cuoUtzY87PA-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020aa7df010000b02903bb5c6f746eso10375251edy.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=n3ZYNtRTz0RjJQasI+/z6mIEjF496epkdBE6W6mVMkH3QywvFrfAmm9WXkEyZ8DyAP
         fUZ+HwQKIuSHNJal6sCDLLjGVxiJuc3AnEdP9q2IGn4bo+To6LHLWWkQMLaX6WBdWkeF
         qauuRiw0mMH3kaWron8NddZ1ZjIeuit/kPmHjFjKMVoTUyd8PLCVXYJPmWQRrSFmEWRF
         cMJ0EOli+6oouOFD+I+L55t7c9yeW1jBaby7QQHetTR0fDGr+e8zV5JNXk7dtw3sPIpR
         3WwNa+zk+augXYbF9t6x0tw7G1gEa0ccp8VRm/P3tAga07YixL4n+PtAvUQMBbQSniEG
         RUPg==
X-Gm-Message-State: AOAM5302LntF1op43quhgfce8NR15eVRbwCmQzWhUL1kM413peP7WDeh
        rRsge6OhPPmBe94RH2BDebkRkcIcbR/k8TUqMeIpHUi/wCyiSv7qJVaAkNWEfJtc9qlDZ4fF26B
        VuGnVEl5X8l2RYig8velpd1Di
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430800eja.189.1628585310190;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz22EQal9Exqyj7ThilEjaTvbLq4Q2a5syoFgJGe/g8lj7NmDmRexbLX8nYJHLpkiLxzCdkUg==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430786eja.189.1628585310038;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:29 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 2/2] rcu: Make rcu update module parameters world-readable
Date:   Tue, 10 Aug 2021 10:48:16 +0200
Message-Id: <20210810084816.155203-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
References: <20210810084816.155203-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu update module parameters currently don't appear in sysfs and this is
a serviceability issue as it might be needed to access their default
values at runtime.

Fix this issue by changing rcu update module parameters permissions to
world-readable.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index bd551134e2f4..94282dc12bab 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -54,11 +54,11 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-module_param(rcu_expedited, int, 0);
-module_param(rcu_normal, int, 0);
+module_param(rcu_expedited, int, 0444);
+module_param(rcu_normal, int, 0444);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
 #if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
-module_param(rcu_normal_after_boot, int, 0);
+module_param(rcu_normal_after_boot, int, 0444);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.31.1

