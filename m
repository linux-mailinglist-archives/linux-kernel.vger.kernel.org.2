Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4633FB3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhH3Kph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:45:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbhH3Kpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0O/cxzQqIWW2V4zMi7JgjVhn3wBXj+r8nEpQGXjMEWg=;
        b=Fr3/H0mq0rXUsvOF4tgJJMyulWP5N6OUvEpE5M3r6F1QvhS85Xvz7dA+aKy2D9QZ+Wu+VN
        C0UCcHbIKvvmfpTuwt7db91LU6pfE0ebuGmADlSBzmgmlhdewPluHHNkFOAPQY1zB/soOh
        sZsK1fT5doXiIb3yI16Ik9SL6LJZkeuJqWoKx5A5rrmVZD/RoF+p3MfWwA/wdfdKRYCDUW
        dod4U/NuDPLKoEYEn57aPuanD+2fHUDYFM9Sq9+9DZpsfRx2T57Ukz79EjR12gqUYBCM/i
        NHnBTwzhKg0EA3+xxK5434ZvQkYC6yyLCfZIYc/ouT+QjFmEGDm9I2YvglqGcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0O/cxzQqIWW2V4zMi7JgjVhn3wBXj+r8nEpQGXjMEWg=;
        b=wnv1StFfbE3jn/pQH8lRF/2Wkqz6YlCB3U9hL2tynsUOuoaPBU5ez1pWFpPVnlMBf0S60h
        Ufnc1vjp6XvPwoAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v5.15-rc1
Message-ID: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:41 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2021-08-30

up to:  4bedcc28469a: debugobjects: Make them PREEMPT_RT aware


A single commit for debugobjects to make them work on PREEMPT_RT by
preventing object pool refill in atomic contexts.


Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      debugobjects: Make them PREEMPT_RT aware


 lib/debugobjects.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 9e14ae02306b..6946f8e204e3 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -557,7 +557,12 @@ __debug_object_init(void *addr, const struct debug_obj_d=
escr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
=20
-	fill_pool();
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
=20
 	db =3D get_bucket((unsigned long) addr);
=20

