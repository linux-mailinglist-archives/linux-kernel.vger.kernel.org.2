Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1784162AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbhIWQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:06:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbhIWQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:05:55 -0400
Message-ID: <20210923153339.499688771@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sbBPXL20B3WWl40L5vogsyQFErqzfiWcUOeM305JGdE=;
        b=jDe9+BmR+YJQYutVYfh3RwJdxUJQ6XmaSv4ZoSKtRszcqLvxDW9yuv0QSHdiRdR2QZKhfC
        OLn/LktqjcTv8L6lqkSORohdGs47GzCUCybyGxZkZm/U+nYblBlI8FDHdyhNigN9L4CWju
        Y8R3YdOb0Zvy26u/9oFA5+lr5DMJSMpQax3XbKszi2dXotKFXveLHfrwraP5gSLLtToJdf
        kDY9Jr3q+4nD/+UBWl+Wl/zIj7FSFsq5L29JEYKjgY6r/tcaE8SVLEv+LiY1cduIArUb1O
        dWcE/Ygmqx/HMpZvh2WoAEQwtBQkBmo8nLKDjjfGvls7aqaXGc6mApON+FmGPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sbBPXL20B3WWl40L5vogsyQFErqzfiWcUOeM305JGdE=;
        b=gW6FbrkvaIIfAks4rj5PIqn3U/pAOjMCyBnNM75IkMjxuy1E//zyY9mqSzH5ZAs2KWiqp5
        X3SVq3/Qq3qYwJBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [patch 02/11] mac80211-hwsim: Fix late beacon hrtimer handling
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Thomas explained in https://lore.kernel.org/r/87mtoeb4hb.ffs@tglx
that our handling of the hrtimer here is wrong: If the timer fires
late (e.g. due to vCPU scheduling, as reported by Dmitry/syzbot)
then it tries to actually rearm the timer at the next deadline,
which might be in the past already:

 1          2          3          N          N+1
 |          |          |   ...    |          |

 ^ intended to fire here (1)
            ^ next deadline here (2)
                                      ^ actually fired here

The next time it fires, it's later, but will still try to schedule
for the next deadline (now 3), etc. until it catches up with N,
but that might take a long time, causing stalls etc.

Now, all of this is simulation, so we just have to fix it, but
note that the behaviour is wrong even per spec, since there's no
value then in sending all those beacons unaligned - they should be
aligned to the TBTT (1, 2, 3, ... in the picture), and if we're a
bit (or a lot) late, then just resume at that point.

Therefore, change the code to use hrtimer_forward_now() which will
ensure that the next firing of the timer would be at N+1 (in the
picture), i.e. the next interval point after the current time.

Fixes: 01e59e467ecf ("mac80211_hwsim: hrtimer beacon")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

---

Note: This patch has already been applied in the wireless tree. It's just
carried here for completeness sake so that the confinement of
hrtimer_forward() in the last patch works.

v2: add fixes tag - it's kind of old and the patch won't apply,
    but even the original hrtimer code here had this problem
---
 drivers/net/wireless/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ffa894f7312a..0adae76eb8df 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1867,8 +1867,8 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		bcn_int -= data->bcn_delta;
 		data->bcn_delta = 0;
 	}
-	hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
-			ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	hrtimer_forward_now(&data->beacon_timer,
+			    ns_to_ktime(bcn_int * NSEC_PER_USEC));
 	return HRTIMER_RESTART;
 }
 
-- 
2.31.1


