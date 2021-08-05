Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038043E0FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbhHEICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239180AbhHEIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628150504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2ghss8N4x5+qkA+P5j44zXDC0+0LL6Ii3eIbL81nCo=;
        b=RhYuf7WGRwH2LeAcDTkSwR6MRMb3FeFRGs5M7lD/VqWFjl987/i9qkfwuMOlYrkuq/TDNg
        ezG+t9sdXAlpcQBPir6nSCU9lhUeFpHs27TX3kSQ4jzwPy4+enKqGrQpUqcsP/ICXmMu9+
        ZRT7dC6oz2JOX0rVUmqQPbJlnGD12/Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-0cJ2gaTLOzm0ibyUsH7_4w-1; Thu, 05 Aug 2021 04:01:43 -0400
X-MC-Unique: 0cJ2gaTLOzm0ibyUsH7_4w-1
Received: by mail-ed1-f72.google.com with SMTP id de5-20020a0564023085b02903bb92fd182eso2772237edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2ghss8N4x5+qkA+P5j44zXDC0+0LL6Ii3eIbL81nCo=;
        b=HX9kHGjKID1IOgTm6C32oEv0Ap2pha8noLhwEPhQtHFyezFlUmsWLw4s3+PZfa7Fhf
         1f/fn5T479NMe/QodfE62aVcfcRm7YrYVp1YTWJmL/mCqQQRRPGCU9ViRuuU6E9tOcp0
         9928nYE0Pj5Q5YFg9BB6/Jqro7cnFcZ0hrgGKWfTqW53NHpC0WhQkJE+VHNsHHTW+poR
         jvtJQjEyiUffyy+utdNOO+o6xglvyBq83RHzAKSDA7TIyHyweLG9jNqZUq1kKg4+woQk
         VmvN/ToH0FDmteZLufkZ7Vpwv7BFGsrER/I1Ro6pNmCk5/TCb+Kf0rZiAk6/d+pBN7wH
         cbgw==
X-Gm-Message-State: AOAM530w46pT8RDEh/OJPWtqQeYuNWCDTJ9Of7fYuaQiIjvTHbr2dqr0
        fSpoNcpsIR/ox9A4VV/uHgbsQoeNgLF8/RJct+A+YQL0VqM52CJRxQ2Xy7NTJfcGBK9n63h0XAp
        bTgFfj/nSJrXTS9u0iTew99DY
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr3653494ejy.46.1628150502341;
        Thu, 05 Aug 2021 01:01:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRZM+Kqhl+Aet0UV2RVMRB/Uaogk6zdAX2mcOhTRyejWYvAHB4AjPVaC92ipDE99MWEylOig==
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr3653470ejy.46.1628150502187;
        Thu, 05 Aug 2021 01:01:42 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id n15sm1925851edw.70.2021.08.05.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:01:41 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Date:   Thu,  5 Aug 2021 10:01:23 +0200
Message-Id: <20210805080123.16320-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain configurations (e.g., systems that make heavy use of netns)
need to use synchronize_rcu_expedited() to service RCU grace periods
even after boot.

Even though synchronize_rcu_expedited() has been traditionally
considered harmful for RT for the heavy use of IPIs, it is perfectly
usable under certain conditions (e.g. nohz_full).

Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
its default value to 1 (enabled) to avoid regressions. Users who need
synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
boot=0 in the kernel cmdline.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/update.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..0fdbf937edac 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -57,9 +57,7 @@
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
-#ifndef CONFIG_PREEMPT_RT
 module_param(rcu_normal_after_boot, int, 0);
-#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.31.1

