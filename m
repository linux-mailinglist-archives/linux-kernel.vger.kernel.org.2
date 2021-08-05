Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF33E184E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhHEPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:41:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbhHEPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:29 -0400
Message-ID: <20210805153953.212032325@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=tvLhX+kdd0bjImwhUzhPNl6YpjO+IOKyt8HOTmcXAuzF4bwHQu8mB25PdTTVIoh6nDSxU6
        +P5E2i+p15woMSvhw5Ld/q2FoBCXVtQT9FImMwL558nSToxyZHbdY6g3QWoyvbEiGgTQUu
        aASGf7P7Tl7g8l008k0ddkxYkMgqQMxo+YjwQMdyiC1stZBbBaUlyMMPgZOqDOUACM8jEO
        Shdi3PuOsyBrnPz8YaNndsojAqhggftDyNmSo313m+MycXP4tDlUYzA85RTXgjtCEJtFOe
        HUmoh6Xi0gXBIY6Acy8UXrJsNiEaZ0Ikm/qF0NxpOSHyUi0JhHBATNQwE5FC8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=oV4+W0Uf8nsOgAxauTicnDP9q33UPJwekqP+NR0V6c2saxKta6A6uy4NKX43uq/mCUy1KT
        4n9F/lpT2UfxzxBg==
Date:   Thu, 05 Aug 2021 17:13:07 +0200
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
Subject: [patch V3 07/64] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The RT specific spin/rwlock implementation requires special handling of the
to be woken waiters. Provide a WAKE_Q_HEAD_INITIALIZER which can be used by
the rtmutex code to implement a RT aware wake_q derivative.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/wake_q.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -42,8 +42,11 @@ struct wake_q_head {
 
 #define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
 
-#define DEFINE_WAKE_Q(name)				\
-	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
+#define WAKE_Q_HEAD_INITIALIZER(name)				\
+	{ WAKE_Q_TAIL, &name.first }
+
+#define DEFINE_WAKE_Q(name)					\
+	struct wake_q_head name = WAKE_Q_HEAD_INITIALIZER(name)
 
 static inline void wake_q_init(struct wake_q_head *head)
 {

