Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED470325024
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBYNDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBYNCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C613E64EB7;
        Thu, 25 Feb 2021 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614258120;
        bh=PvX5dmmBsTW093x53ljxPIF2OTzA4gnnv39U7laJlSs=;
        h=From:To:Cc:Subject:Date:From;
        b=msjS1O0NTP2jqCCeyN31Lm569hVmeQ+AidoaMN/95QeR2o/SsUiLu6KSfs4SiDnRK
         agrrBQ1Xz2uX9ViIzikOB7qWhMHvOTsUUwwvmj73YDF+WNajMpdMMgeILCLYYl6cUO
         +ykB/fL50QR8o5WqK+ClllIqLcTFfqRl0jN9TCz1bAljrguYSTJ+IZyeKvVwcKU44P
         z1fQkZC6YlKZJ/Ih+KqYP2PRAiZeNQ2rshtgwFpspfjGdOsHk8rmGVYksL3JiTpz5e
         iphb7SPRfTHRQNPaIqEenN5eduBKSYCUjQljj4EjxiNQk087gKefKUticswmbLU08L
         fAJYsc8njiPMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] stop_machine: mark helpers __always_inline
Date:   Thu, 25 Feb 2021 14:01:46 +0100
Message-Id: <20210225130153.1956990-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With clang-13, some functions only get partially inlined, with
a specialized version referring to a global variable. This
triggers a harmless build-time check for the intel-rng driver:

WARNING: modpost: drivers/char/hw_random/intel-rng.o(.text+0xe): Section mismatch in reference from the function stop_machine() to the function .init.text:intel_rng_hw_init()
The function stop_machine() references
the function __init intel_rng_hw_init().
This is often because stop_machine lacks a __init
annotation or the annotation of intel_rng_hw_init is wrong.

In this instance, an easy workaround is to force the stop_machine()
function to be inline, along with related interfaces that did not
show the same behavior at the moment, but theoretically could.

The combination of the two patches listed below triggers the
behavior in clang-13, but individually these commits are correct.

Fixes: fe5595c07400 ("stop_machine: Provide stop_machine_cpuslocked()")
Fixes: ee527cd3a20c ("Use stop_machine_run in the Intel RNG driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/stop_machine.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 30577c3aecf8..46fb3ebdd16e 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -128,7 +128,7 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 				   const struct cpumask *cpus);
 #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
 
-static inline int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
+static __always_inline int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 					  const struct cpumask *cpus)
 {
 	unsigned long flags;
@@ -139,14 +139,15 @@ static inline int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 	return ret;
 }
 
-static inline int stop_machine(cpu_stop_fn_t fn, void *data,
-			       const struct cpumask *cpus)
+static __always_inline int
+stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 {
 	return stop_machine_cpuslocked(fn, data, cpus);
 }
 
-static inline int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
-						 const struct cpumask *cpus)
+static __always_inline int
+stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
+			       const struct cpumask *cpus)
 {
 	return stop_machine(fn, data, cpus);
 }
-- 
2.29.2

