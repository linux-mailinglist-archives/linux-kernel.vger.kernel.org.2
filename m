Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD843DF001
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhHCORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbhHCORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:19 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1I/VHTd4QfiDKFHh1Qdp9KYWrVDsr+mY3A+kIR6Yf0=;
        b=rPAE7cawP1lEnd1Xu02u657GZT986QUAZcYt31/YsXKJjkzHbnMubGQ6Tys5Cy1R7PXlak
        6Ex9V/TEjyH9/apady5ZWgMEtPnrWnaD2AjkuaZkVDLkjgOs0Ic2I2xg5bzKuplWqSsBaa
        iqomj8yahgKYZpIZJV0kxCE9kp6HQtrxNymc0S4H9tsd212VupBQe7QpC00yzb7pVKUqut
        QQKqSWXtS8s1BjMFp1Wm5Qv65eGAa9T6bRyX43D21K/f1uDh23l0o9pAxMb2pLhcl5SV5l
        rHLNNaA88h61E2vITjgZ83gDyfOARE1G+rHC6IQMzePBEyPblbll/YfubJmk+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1I/VHTd4QfiDKFHh1Qdp9KYWrVDsr+mY3A+kIR6Yf0=;
        b=nv0PQVP+wW++6AcPxctDDwSN19rMsS2jwziEg+QcQ0ZH1BxcljMetjmw/4jErgCZjQHz/M
        Wj1oUqlAt5w2EEAw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 11/38] perf/hw_breakpoint: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:54 +0200
Message-Id: <20210803141621.780504-12-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 835973444a1e7..f32320ac02fd8 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -568,7 +568,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *att=
r,
 	if (!cpu_events)
 		return (void __percpu __force *)ERR_PTR(-ENOMEM);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		bp =3D perf_event_create_kernel_counter(attr, cpu, NULL,
 						      triggered, context);
@@ -579,7 +579,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *att=
r,
=20
 		per_cpu(*cpu_events, cpu) =3D bp;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (likely(!err))
 		return cpu_events;
--=20
2.32.0

