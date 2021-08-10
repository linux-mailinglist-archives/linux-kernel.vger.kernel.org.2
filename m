Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B413E55D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHJItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236844AbhHJIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWWfZfczx65IParlduf54SQJn/f7jfyxJXfN8MyeRwI=;
        b=X+gcnDxbEtivWjzPSrBUNjHhTGuxuiUh5A8qUZfKozXJ+pRStw1EsWOQ5pgGeF9p23i7DF
        ru7GzqdIIR5jb77lIeOqTaguVUii/BEiy4DY1YkS8ATdfsJXMlGpgQjLxth3UKND31SK1g
        5skF+KwYXzsk9kSNidQm4wgpnT8rvCE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-a6G3ROQZM1GhlKghC2WELg-1; Tue, 10 Aug 2021 04:48:29 -0400
X-MC-Unique: a6G3ROQZM1GhlKghC2WELg-1
Received: by mail-ej1-f72.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so1600341ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWWfZfczx65IParlduf54SQJn/f7jfyxJXfN8MyeRwI=;
        b=hv7m8pTZYy+nSsiFYqTVOwUMrrySS0E3aIvwr3bg6i4eoTWiNuP87VU5GX9s4O04Za
         HAEY4SU7qmba6urswgmiIEH7HT533EpZ1o/1dI9TxHFqwQl3IcdQRyPr1WwGg+BzJ4YJ
         ARP5dx4r5Wbg07ln6AcJ7ULGiGQ0VkGnH/2/gBz2i0eA002WDDl1MFKW0LHfD+Uai3fs
         23POWOzazFalS1vrCmG7uUtSg7MqwaG1KWtPh57AZcCjj5ZQfbQ7zHZ5fd0cVENL25YP
         7TQ9zf1Qk3v1FgVxQ9ZQSLUBXhVCnjImLceE7llaieAOTIH9FS+oq6XIL0WCoNMQo9Zx
         b9EQ==
X-Gm-Message-State: AOAM532M0B0UCW4QZJfvMjLpmav9PnblFQn8toq9bO1zKOtt/3yVQbfC
        eHGl7gf8RPQT31AnUbRUzWSSNvkBdJ0hCdXeyYFceFA8gOPTnv6ObKn8gwa0f+U5xdh9nFpL9xO
        vW70AnIv78ERBXDMpKl4CELaR
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr26785997ejz.510.1628585308627;
        Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn80ECnujwqU7hjqyUptCj/nIeG0tDzxXAB3iqy+3raekA06q/d65FphjKgOD6D/7OJW+HXg==
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr26785981ejz.510.1628585308409;
        Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:27 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 1/2] rcu: Make rcu_normal_after_boot writable again
Date:   Tue, 10 Aug 2021 10:48:15 +0200
Message-Id: <20210810084816.155203-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
References: <20210810084816.155203-1-juri.lelli@redhat.com>
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

Make rcupdate.rcu_normal_after_boot= again writeable on RT (if NO_HZ_
FULL is defined), but keep its default value to 1 (enabled) to avoid
regressions. Users who need synchronize_rcu_expedited() will boot with
rcupdate.rcu_normal_after_ boot=0 in the kernel cmdline.

Reflect the change in synchronize_rcu_expedited_wait() by removing the
WARN related to CONFIG_PREEMPT_RT.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/tree_exp.h | 1 -
 kernel/rcu/update.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2796084ef85a..d9e4f8eb9ae2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -512,7 +512,6 @@ static void synchronize_rcu_expedited_wait(void)
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
 			return;
-		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
 	}
 
 	for (;;) {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..bd551134e2f4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -57,7 +57,7 @@
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
-#ifndef CONFIG_PREEMPT_RT
+#if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
 module_param(rcu_normal_after_boot, int, 0);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
-- 
2.31.1

