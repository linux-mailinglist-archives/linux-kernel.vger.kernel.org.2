Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CA3A4058
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFKKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:43:34 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:37878 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKKnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:43:31 -0400
Received: by mail-pf1-f180.google.com with SMTP id y15so4116374pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jF0DjW57bAOD/0YmfuBLvPkXVJhUHdVnKVV/fEMWkE=;
        b=aQpvuz1I+5LZaO2OyFWgtOJpW7ykEzEaGhbhIDlJEpn2eXGlc7BrpGlobjVGSggFkQ
         4oTKxZeRJg7jnL2HZCLCzpE/V2pqWraeWtFRZVhXDj0C/pgmZdSt0XYl+KjZ2TyZoL+5
         TzhyKt9NJnuYZidxxOwK2M+z5QYiYWomPvUX9QHitDbbAsNGxspbidlY65qrtSpU0ibn
         WQyHBDtZwRID7IhAQzSS0/Y6wEkJXX2JCvN3YBVBUDZWDBx/9YiRZrt7tlZ5NBxCiNXI
         q5YeNqetBfT25qtZz4WfrPSRoSMb0RCq7UUWvUaduEd56EiOyB10Yg+8i0X3IS+CLrH2
         R8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jF0DjW57bAOD/0YmfuBLvPkXVJhUHdVnKVV/fEMWkE=;
        b=Xw6DtXwE+HeoGTR1K86g5XHTyJgJlc9yBBRJQIhKaC3jH+6lkcOra1ZetIB3DpERo7
         J4+2KHsbO7mKT53truqJX2a5lwkqnU6mSC3GK+jIlM/ymw8Gx0xsRhEmYmUuyrPfYcsZ
         hy9jEIxEmAvp0IAmSjLo6dQqXXTTq7eichIrwFORaUEGYebcJcId/Qka0od3dAJ9nxkO
         oeTXavczBDEZ28j2yfZXfg0GIg5//Po2UDNRyBOOnzFOkYJFxs6NB2CkdijI1WGxs7CA
         oQwQKdCEfY23XyKL/Ha26p8AJ2p9XxU0s1xHuiltLyHpQNz7F4JPkb6/4UAcjhW0x8j9
         4Xtw==
X-Gm-Message-State: AOAM530pQ0vFYthY9GzyblEzS8zqDPWuuiRzIGMrPXD2ppOeXGuA0g8c
        vjGtMYE2o6GUzutQEDE1dMyHNuVjrhSsbw==
X-Google-Smtp-Source: ABdhPJyvLozE1EoV03P0Gi8CP7fGirt0cJv9IZF7gdXKuLyTDJQx6S3ZTwu78kAXPZBPqOsKA/gArA==
X-Received: by 2002:a63:c112:: with SMTP id w18mr2958740pgf.375.1623408017578;
        Fri, 11 Jun 2021 03:40:17 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.148.101])
        by smtp.googlemail.com with ESMTPSA id iq15sm9755553pjb.53.2021.06.11.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 03:40:17 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] Add missing kernel log when enabling NO_HZ_FULL is not possible
Date:   Fri, 11 Jun 2021 16:09:37 +0530
Message-Id: <20210611103937.827565-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
dependency mask model") had also removed the kernel warning
message informing the user that it was not possible to turn
on NO_HZ_FULL. Adding back that log message here. It is
unhelpful when the kernel turns off NO_HZ_FULL silently
without informing anyone.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 kernel/time/tick-sched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..a82480c036e2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -937,10 +937,18 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
-	if (can_stop_full_tick(cpu, ts))
+	if (can_stop_full_tick(cpu, ts)) {
 		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+	} else {
+		/*
+		 * Don't allow the user to think they can get
+		 * full NO_HZ with this machine.
+		 */
+		WARN_ONCE(tick_nohz_full_running,
+			  "NO_HZ_FULL will not work with current sched clock");
+		if (ts->tick_stopped)
+			tick_nohz_restart_sched_tick(ts, ktime_get());
+	}
 #endif
 }
 
-- 
2.25.1

