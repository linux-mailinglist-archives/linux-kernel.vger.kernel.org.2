Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55553DF000
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhHCORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhHCORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:18 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHRHPlaEk42GNc2RYDnrYNekDe0XxQImUlitiI8Ix1I=;
        b=KScoC/XGLeSdfhu6HgD+WkDVC+gWdnTQpxObIIR5/ViOahNudkA5vgwTNCcWycC6nyWury
        brSrB9WS4+BtS/wRauCHv//NdJPNqgB9UZL17358P3U5me6SwJA9JyrxueWxkYLsJPJMQD
        WMo9R2lQDIRn9NH1vxZKNOgBT4lAgKcDlwuoCbO9xWKwKR85B/VO9OB67c2aSPXLP671tK
        knNfbnBn+d7OQpcNZcfUDPDGqvLBADGIWelk+e/dA9Ox7EH0lMP7SFZE1Ggdy57wXg8px9
        xawzVxbFrDeiB4YdNKBRWxXvGh8DsThWCafGlXIGWRkA1rU4aN+6PieNYfvYcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHRHPlaEk42GNc2RYDnrYNekDe0XxQImUlitiI8Ix1I=;
        b=jMWMlL+l1L7WIbYPI+c8YwlogCPZORP6c3jt28//kOwM30k7dUPYNa3tdqe+UKlvMdaaqe
        lT/k5YcPnT7f/IAg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 08/38] x86/microcode: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:51 +0200
Message-Id: <20210803141621.780504-9-bigeasy@linutronix.de>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/mic=
rocode/core.c
index 6a6318e9590c8..efb69be41ab18 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -55,7 +55,7 @@ LIST_HEAD(microcode_cache);
  * All non cpu-hotplug-callback call sites use:
  *
  * - microcode_mutex to synchronize with each other;
- * - get/put_online_cpus() to synchronize with
+ * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
@@ -431,7 +431,7 @@ static ssize_t microcode_write(struct file *file, const=
 char __user *buf,
 		return ret;
 	}
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
=20
 	if (do_microcode_update(buf, len) =3D=3D 0)
@@ -441,7 +441,7 @@ static ssize_t microcode_write(struct file *file, const=
 char __user *buf,
 		perf_check_microcode();
=20
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
@@ -629,7 +629,7 @@ static ssize_t reload_store(struct device *dev,
 	if (val !=3D 1)
 		return size;
=20
-	get_online_cpus();
+	cpus_read_lock();
=20
 	ret =3D check_online_cpus();
 	if (ret)
@@ -644,7 +644,7 @@ static ssize_t reload_store(struct device *dev,
 	mutex_unlock(&microcode_mutex);
=20
 put:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (ret =3D=3D 0)
 		ret =3D size;
@@ -853,14 +853,14 @@ static int __init microcode_init(void)
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
=20
 	error =3D subsys_interface_register(&mc_cpu_interface);
 	if (!error)
 		perf_check_microcode();
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (error)
 		goto out_pdev;
@@ -892,13 +892,13 @@ static int __init microcode_init(void)
 			   &cpu_root_microcode_group);
=20
  out_driver:
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
=20
 	subsys_interface_unregister(&mc_cpu_interface);
=20
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
=20
  out_pdev:
 	platform_device_unregister(microcode_pdev);
--=20
2.32.0

