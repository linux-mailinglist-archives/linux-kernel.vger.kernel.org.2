Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7443ECB57
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhHOVcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhHOV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73854C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:29:06 -0700 (PDT)
Message-ID: <20210815211305.193767519@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=vu2wylUKuAxM6aB1GxMJlfCv7FYMjaOheH+0qZz2yXu2QZJA6GmyCvCD62YUbJUYnHyBNG
        TFnSXTzcEHU08IZGtJFNRYJFwFngTF51lIm9AWLr/9gVbPKhVxa9BVwJ3NHC/5LJ57kIyn
        6gAkoeFo1eKgqlPHEXwaqKrnUV3uRbWYBT6uhM4JEMwvH/6etxRx73DaIcgMQ3bcm1vyBx
        7Z93XoySugbIFamapLP/BmOwxD11Km5PD3o4y7O/iwvxhifBMwPrDLt4MFbrITzx+nDHqZ
        wvVNorjzyxQoSEX1ata7vuug3nMCBzkRFZP5x4GKahZVoQzOE6vrhiREwzCn7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=/kSvjIYHzC44DBPEQjQxdC5OmFejwXCT9uiKoAwKPl+u1xz4mFSBONoYDMfcC5xhpJ8qCN
        8QkHny0+xVAlLTDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 57/72] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:04 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The loop in futex_requeue() has a sanity check for the waiter which is
missing in futex_proxy_trylock_atomic(). In theory the key2 check is
sufficient, but futexes are cursed so add it for completeness and paranoia
sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |    7 +++++++
 1 file changed, 7 insertions(+)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1879,6 +1879,13 @@ futex_proxy_trylock_atomic(u32 __user *p
 	if (!top_waiter)
 		return 0;
 
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		ret = -EINVAL;
+
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;

