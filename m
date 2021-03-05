Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368A32EF29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCEPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:40:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:28436 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCEPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614958444; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NCb6Eb5skoDeaV7EGHekrACuOaCGfT1SGlpd/j3IWv36qHt3L5xhNtZdShO79kB6iA
    0v3fc+w0odtGJJ6puR8VTiNm5/bitaAmbLLeK92/uuUgre2Q+up3AIYgIuBL6kyUg9wf
    vzSz3D7DAyZglpl1KeQKzUPbokGBTrYyaPJ976TwvUEk5g/R8w6PkarPTqMQSfjKIG1d
    fY9VaWYsYI7ALlhTzUOJ+pU/0pD0nzVAeu7Fz76ahVO+NVHotWcAt1khY9OLl6OQq2TY
    i+T4FEORTs51p9UebY/XtFHNCp4NgL78PZqy9OjQ9M8Ew/sLzTU3LupXcANlSwIFeABr
    hDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1614958444;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=0kAX5Uvl1Kt2XqcpwIJ75LAHYcnTKNSYe2VlZsDsh/c=;
    b=Tak7poHV88GzJmtzKEimtSiqLzMFdkK9yK4ihE6KbVtpOEsPTzi1pqlSQjGOPCeKfQ
    YVA1J5k0rWZxJDnAd3+yl4zknFe/AIe6jjbHSymz3oj/CGNqP8ymgREbt03ySn9tomn2
    U3hXUf5mQDd7KIJQQnhsHgUH9MjoSXoEm7Cvi2Supc0k21Y6wVgYNgyD+Y46SdtYK5A2
    hykDlambCT4lyVBrA/A94vlrK9hCkH0KqEaDZqv+V6K059eeaRBU1+74i0BUp4xqqdd1
    I9ZWZ5FBdRyZPEjN5dhPLWQclb0LI3yQC3EUdogcZl4zNFclwIhkNMBSGTXhl5fy31Ry
    St9g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1614958444;
    s=strato-dkim-0002; d=schoebel-theuer.de;
    h=Message-Id:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=0kAX5Uvl1Kt2XqcpwIJ75LAHYcnTKNSYe2VlZsDsh/c=;
    b=dKDLeZc8PNXm1PZcdSrsEJLMQ0DaddPMM9b9HCzCh74/QIhb5GAvfWHyC3pPwpI1Zs
    86GJ/Gp9SvYCXZERrM1UDADQ59EXO1by2vU5jCRMofRKm+Ij/G0foex9XH0H7Nr1x7Oe
    Hpn/WkhEJU0GCgyz13cRTUYuCxMRKNe5b30VZafVrY6kp2+hKxIwTFJWjJJ2QrANHIe0
    lro3KsIXXeOSXzP3XujEIybCL8PSMTuWHiNwyOgf1tWzpNYM48FfGx+OT94yp9K/C3hZ
    j+4tHLHdPB3RE94yBypgz1q4MTPL9H+lqzZQCkBfyEMKCQvwgEe72xK4rFX3x/HS5k+w
    do/A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8SjapJoMy/ngEsCKWYHf7tw4FryMmnohon9SYQ="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 47.20.3 DYNA|AUTH)
    with ESMTPSA id 6007d4x25FY35Wu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Mar 2021 16:34:03 +0100 (CET)
From:   Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
To:     tst@schoebel-theuer.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Schoebel-Theuer <tst@1und1.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH STABLE 4.4] futex: fix spin_lock() / spin_unlock_irq() imbalance
Date:   Fri,  5 Mar 2021 16:33:42 +0100
Message-Id: <20210305153342.25248-1-tst@schoebel-theuer.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Schoebel-Theuer <tst@1und1.de>

The following is obviously incorrect:

static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
             struct futex_hash_bucket *hb)
{
[...]
	raw_spin_lock(&pi_state->pi_mutex.wait_lock);
[...]
	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
[...]
}

The 4.4-specific fix should probably go into the direction of
b4abf91047c.

Probably, backporting of b4abf91047c
to 4.4 LTS could be another good idea.

However, this might involve some more 4.4-specific work and
require thorough testing:

> git log --oneline v4.4..b4abf91047c -- kernel/futex.c kernel/locking/rtmutex.c | wc -l
10

So this patch is just an obvious quickfix for now.

Signed-off-by: Thomas Schoebel-Theuer <tst@1und1.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 394fc498142
Fixes: 6510e4a2d04
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 70ad21bbb1d5..4a707bc7cceb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1406,7 +1406,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	if (pi_state->owner != current)
 		return -EINVAL;
 
-	raw_spin_lock(&pi_state->pi_mutex.wait_lock);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
 
 	/*
-- 
2.26.2

