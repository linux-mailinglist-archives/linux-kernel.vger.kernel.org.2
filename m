Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF60382EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhEQOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbhEQOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:08:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27983C061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:06:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ot16so1804514pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCfxgtTocXOIkhpjfBP1nEiJRlCbOrh5ypBqbHLD0SA=;
        b=VhB8CFYGESpFRNLErk+cZZI1wrelHsQsyt3cUnD/Z2C4lYOVmjySMoZmr4YKsErZXb
         zbKaGRggV3D+gkF59VT7UdDgzzEf0R3j2CPcrUpAyVTZiq41Cf7fYSZdvgiwLUcLj+Aa
         JlgD2/lsaczaR0cUJz8k2J9NaHRRmh/vqch6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCfxgtTocXOIkhpjfBP1nEiJRlCbOrh5ypBqbHLD0SA=;
        b=ruHbNpt700y1Gxw20asbAsjL/5AsKGrtgKBaG3a3cckPcf/ucBJJ5qHLYWiWHh8mUX
         VH/kyU0qsmalHg+LqVb+KksjGym7vdxELObGGJcbWOTUw+IU1/k06S39WjIdp/CjXvMH
         yauNL5MpQlH4+moUtuCKS1qxFeAsemS/wmbqiEIBumnaXq2/22M1U3QSlusYvlpjNp2h
         AjipgCPmda7Tm0fVmtDQJm92epJm5uzSTqbBmXzTFa5s/jmXAzDAhDlB12fOyEHTvMiQ
         itHe906jQ8yYdEOXZG8tNZHieEE0QoNeRj6aGtwQqEJF3Yje4dGm6q47AYfQE6aDHoWo
         5mIg==
X-Gm-Message-State: AOAM532KzDQFsD1QzvEZpqStXGmfCxuAnnED2YELpvxVSWyEPb57opDP
        tfOcbG+soAQ8fgHKT1E7ZzPs8rS4Sti7nA==
X-Google-Smtp-Source: ABdhPJwl8Gm2I5Qt56QHUlU5HxCvevxDrk0adUSHDWu3/+7d1cGbfm8tHCcfcz8zOAUXQXDh3CXXzg==
X-Received: by 2002:a17:90a:4a89:: with SMTP id f9mr136945pjh.50.1621260377646;
        Mon, 17 May 2021 07:06:17 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:fd1c:fd10:fe98:9d9f])
        by smtp.gmail.com with ESMTPSA id m5sm3545662pgl.75.2021.05.17.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:06:17 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] watchdog: revert cleanup handling of false positives
Date:   Mon, 17 May 2021 23:06:12 +0900
Message-Id: <20210517140612.222750-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9bf3bc949f8aeefeacea4b1198db833b722a8e27.

I can reproduce the case when resumed VCPU starts to execute
is_softlockup() with PVCLOCK_GUEST_STOPPED set on this VCPU:

	watchdog_timer_fn()
	{
		...

		kvm_check_and_clear_guest_paused();

		...

		duration = is_softlockup(touch_ts, period_ts);
		if (unlikely(duration)) {
			....
		}
	}

Which means that guest VCPU has been suspended between
kvm_check_and_clear_guest_paused() and is_softlockup(),
and jiffies (clock) thus shifted forward.

VCPU can be preempted anywhere, so we want to do
kvm_check_and_clear_guest_paused() at the very last
moment: when we are in the soft-lockup branch but
then we figure out that it's false positive and we
need to bail out.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/watchdog.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7c397907d0e9..8cf0678378d2 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -376,14 +376,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	/*
-	 * If a virtual machine is stopped by the host it can look to
-	 * the watchdog like a soft lockup. Check to see if the host
-	 * stopped the vm before we process the timestamps.
-	 */
-	kvm_check_and_clear_guest_paused();
-
-	/* Reset the interval when touched by known problematic code. */
+	/* Reset the interval when touched externally by a known slow code. */
 	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
@@ -394,7 +387,10 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			sched_clock_tick();
 		}
 
+		/* Clear the guest paused flag on watchdog reset */
+		kvm_check_and_clear_guest_paused();
 		update_report_ts();
+
 		return HRTIMER_RESTART;
 	}
 
@@ -406,6 +402,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	duration = is_softlockup(touch_ts, period_ts);
 	if (unlikely(duration)) {
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like a soft lockup, check to see if the host
+		 * stopped the vm before we issue the warning
+		 */
+		if (kvm_check_and_clear_guest_paused())
+			return HRTIMER_RESTART;
+
 		/*
 		 * Prevent multiple soft-lockup reports if one cpu is already
 		 * engaged in dumping all cpu back traces.
-- 
2.31.1.751.gd2f1c929bd-goog

