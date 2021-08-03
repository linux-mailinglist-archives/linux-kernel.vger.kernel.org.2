Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0963DF01D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhHCOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhHCORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78842C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjP7tmenYzop5aMsEYg7IPJtZnVDOfd9/exYkliB++A=;
        b=gsKjlyd+KL/h0Z19pycXFAyYfzlxT32M86/ou3XJ6wmx+Vq1mOFKrboFw+ilI10+LV5ZxT
        +i6CYJ1m8W/Y/Az3lzZ7cKHidbWujRojvU7VIFFUp5wp6RRVjdSKFkOTr4rshLcBBf5Hnc
        y8cpFVEESTsYyQayKybt1GA/TSsszioU9fav6CY5bxdycVcwVEqQrddDol3qk4cpWGf5rm
        TI4a6aKgM7V+6tpF6ZyfwG8ekQ4UHuZIGOQITphjqXRli9WMkifQi17g90ee1RKpPUR1MD
        VgMJBWhOrpZ/s/KTlIVzFKnuv+ZgX5e79nuWX+gg4VD87v4kvpVVMW/To8Bi0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjP7tmenYzop5aMsEYg7IPJtZnVDOfd9/exYkliB++A=;
        b=gFjNgbbYh1z7oLBxa8KwC/vKv4Gt5NEagKZK+sZkglNjw9MEX6aggIeTOTQmVIR7WzgzFR
        RPFjF0lA0CoqpaCA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 33/38] smpboot: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:16 +0200
Message-Id: <20210803141621.780504-34-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smpboot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index cf6acab785384..f6bc0bc8a2aab 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -291,7 +291,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_t=
hread *plug_thread)
 	unsigned int cpu;
 	int ret =3D 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret =3D __smpboot_create_thread(plug_thread, cpu);
@@ -304,7 +304,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_t=
hread *plug_thread)
 	list_add(&plug_thread->list, &hotplug_threads);
 out:
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
@@ -317,12 +317,12 @@ EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
  */
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thre=
ad)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	list_del(&plug_thread->list);
 	smpboot_destroy_threads(plug_thread);
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
=20
--=20
2.32.0

