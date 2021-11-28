Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66D4607A3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358578AbhK1QlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358322AbhK1QjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:39:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A87C0613F9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:35:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638117318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PVg0/lj64KChOwC0rlHzY8C09+kzY7jC2tsmOmD3byc=;
        b=QAWnVf43idKunZrkqobL73AmD+gOAJJqHTT/zUfiK+REnK2ysPYjn1dxc3628V10YVa9Wj
        ql+HteBK5ZGECuNa/WGEsbs5If3Wk9vX/uNJOMnoo0sBW/ls8eJIbi+16M6cICXY9LvvS/
        K6gR/1Kxj+t1J16ndHCdkZ4cyUAaU3bg6Fp4YNsFj+JWPvSHP4CHwEbY8a8btIWA4TA/kF
        J5GrbwAkneCZITjiSFFVXTWcoV8haintXphuTQ0NVI0tgcVWfwDYXx124VwlHrmToJv5Xv
        OotOsybXlYlp8g/JdKhD5UNEiHZu7DbihZhVsq3nw4r83t6yFNBgxe1GLy7J2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638117318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PVg0/lj64KChOwC0rlHzY8C09+kzY7jC2tsmOmD3byc=;
        b=6jse+unnwQSU+76+uX9ZjjPmWweoiJBVUGVXR/XkAPmEbhjLxSMDfu5rI6iKHemiXrJsGY
        AaCBrplOBt3prtBg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.16-rc3
References: <163811728418.767205.14544746031342483043.tglx@xen13>
Message-ID: <163811728568.767205.16569892085230083687.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 Nov 2021 17:35:18 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021=
-11-28

up to:  73743c3b0922: perf: Ignore sigtrap for tracepoints destined for other=
 tasks


A single fix for perf to prevent that it sends SIGTRAP to another task from
a trace point event as it's not possible to deliver a synchronous signal to
a different task from there.


Thanks,

	tglx

------------------>
Marco Elver (1):
      perf: Ignore sigtrap for tracepoints destined for other tasks


 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a506ee..30d94f68c5bd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9759,6 +9759,9 @@ void perf_tp_event(u16 event_type, u64 count, void *rec=
ord, int entry_size,
 				continue;
 			if (event->attr.config !=3D entry->type)
 				continue;
+			/* Cannot deliver synchronous signal to other task. */
+			if (event->attr.sigtrap)
+				continue;
 			if (perf_tp_event_match(event, &data, regs))
 				perf_swevent_event(event, count, &data, regs);
 		}

