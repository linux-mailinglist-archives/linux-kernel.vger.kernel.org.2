Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4893DEFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhHCORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhHCORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:17 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sm/mbbSEULPCMgAW2owXXRPFYMbLoPd9z3ObO+na4Bc=;
        b=WLFcDdUBRry0Kl0oTRwemr+vQgzdfmVCevWPzRa9VV/uysZEU0FsxfqooOtTA9Fae2w44V
        YfrywOLT4NJTKGFJZ+WY+xKRX/BdlEVFyVw37DENRB/ew5xXD/RXwqtSt79e0KqwCfyST8
        7FchLj+9FMCL7k08kkcZDjXSGCNBUECe/hxRC37LH/bx8qoNTYuP8tK5uobWqyVq8R9mWt
        jcQE6zFTRZkpB+xwE4YfkIyEEnMs8W/WcsxqYhVmvKLQYGn2GEwQNe0mPyMippJJ5ujVQt
        PR4gpdfUt54AQcQ8cqRjY0jNVrgInluQVUKrgU871rM1R52ECtAAT/NRLV9Oyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sm/mbbSEULPCMgAW2owXXRPFYMbLoPd9z3ObO+na4Bc=;
        b=2QBFhOXmEGXvtEsKlKb2jIqGDA/Wpn+GLCwAnnyrVRFbu9drTk47NxdKhl0zzNRujDC3Fn
        aJF/ckL1Uem0GdDA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH 01/38] Documentation: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:44 +0200
Message-Id: <20210803141621.780504-2-bigeasy@linutronix.de>
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

Update the documentation accordingly.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/core-api/cpu_hotplug.rst | 2 +-
 Documentation/trace/ftrace.rst         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-ap=
i/cpu_hotplug.rst
index a2c96bec5ee8d..1122cd3044c0e 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -220,7 +220,7 @@ goes online (offline) and during initial setup (shutdow=
n) of the driver. However
 each registration and removal function is also available with a ``_nocalls=
``
 suffix which does not invoke the provided callbacks if the invocation of t=
he
 callbacks is not desired. During the manual setup (or teardown) the functi=
ons
-``get_online_cpus()`` and ``put_online_cpus()`` should be used to inhibit =
CPU
+``cpus_read_lock()`` and ``cpus_read_unlock()`` should be used to inhibit =
CPU
 hotplug operations.
=20
=20
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index cfc81e98e0b8a..4e5b26f03d5b1 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2762,7 +2762,7 @@ A list of available functions that you can add to the=
se files is
   put_prev_task_idle
   kmem_cache_create
   pick_next_task_rt
-  get_online_cpus
+  cpus_read_lock
   pick_next_task_fair
   mutex_lock
   [...]
--=20
2.32.0

