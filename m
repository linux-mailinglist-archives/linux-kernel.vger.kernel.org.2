Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DE3DF020
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhHCOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbhHCORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC4C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:17 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csCq9j23Wxd8KC2MDOBYTFFugFtiqGlMcYkOtcTApfg=;
        b=pOExrN0ztgsQpqfG8PtQwTgeCFLiY/55C1F+u0mX9aGg66zp/HG/3rvyli0CMAdvwKwQgp
        bq7O8bJo+dwISs0b/KiELLYA5RynopUZGigbwdzcyQjjbYHooc7F/S+uWO5KCcw4rasV8b
        45YYRtacuXq9b6DEglTNMPPfjZnxWwQ5cqCaEtQQxrYFCmJLJMK9oNbmMdn8qgnzrbW66M
        CRNYoZ1ubLm2isUy6K+1vcl+l/mbGisd38+PFp460oUDwq63nYYFgNYXVHL5UjJeVlxa+i
        qW6Lbfji0UxJZ+RsJgLXS2zxIt5GQmloZ4bNUNkHI3btE5BIVczN0uqAxN8aXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csCq9j23Wxd8KC2MDOBYTFFugFtiqGlMcYkOtcTApfg=;
        b=h2s94YYfDA6Lm3SM2byqKPIjGd9n0NIz70m9cVUUN7FspaykHUBCKQGOnvP579SBxrL/dG
        qEiFrjrdI8xA4BCw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 38/38] cpu/hotplug: Remove deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:21 +0200
Message-Id: <20210803141621.780504-39-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users in tree use the deprecated CPU-hotplug functions.

Remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 94a578a962022..9cf51e41e6972 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -143,12 +143,6 @@ static inline int remove_cpu(unsigned int cpu) { retur=
n -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
=20
-/* Wrappers which go away once all code is converted */
-static inline void cpu_hotplug_begin(void) { cpus_write_lock(); }
-static inline void cpu_hotplug_done(void) { cpus_write_unlock(); }
-static inline void get_online_cpus(void) { cpus_read_lock(); }
-static inline void put_online_cpus(void) { cpus_read_unlock(); }
-
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
--=20
2.32.0

