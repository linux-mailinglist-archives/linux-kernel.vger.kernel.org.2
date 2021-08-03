Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739C13DF004
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhHCORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbhHCORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:20 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In25PvR/N4psHOiD+yXJd6IQe1XcdpDASEt9mnWN6io=;
        b=NBOUNDcO33bFFy8tdfRdXLPeszUBXIHCjdhVtmjcDi2Z/zP0kX0kq2QYecjTKDjXslzfqZ
        /0aptHDkrSdVO9VqUkudiAYfKYbt0QNqdgZMdS1J7SpzvU+ZQ+5XMgTS25OXJVNHLZO0wn
        g0XAoC7XrH8O27yV8YP35heZ1EVrfkL/GsIyu6DXYJ4OMrt9PwLxPaUUEAUrTuJWiM7V/s
        iT9FHdTk2KNVEW63mue0EqTellEZ1BHa9+gZzDIT9m1OLstjGaqgn9Am4uvdDQqWtkSO3u
        Qy/njcITNewauyt/e0bcvDb/cBZ/ilNAcU3/PupVFEPoy4hw76/CZCDq0dkO5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In25PvR/N4psHOiD+yXJd6IQe1XcdpDASEt9mnWN6io=;
        b=tbVY8BJ8F0+v/UCD4qToX1ebu/WI89Rzv2fzTiMLgAgTHAnsoRC4RSuk80w+LC7NVdTzf8
        2a2NTrtXnmedcFCA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 13/38] hwmon: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:56 +0200
Message-Id: <20210803141621.780504-14-bigeasy@linutronix.de>
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

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hwmon/dell-smm-hwmon.c | 4 ++--
 drivers/hwmon/fam15h_power.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index f2221ca0aa7be..c3600266e0e91 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -228,9 +228,9 @@ static int i8k_smm(struct smm_regs *regs)
 {
 	int ret;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	ret =3D smp_call_on_cpu(0, i8k_smm_func, regs, true);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 29f5fed28c2a7..521534d5c1e5f 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -166,7 +166,7 @@ static int read_registers(struct fam15h_power_data *dat=
a)
=20
 	memset(data->cu_on, 0, sizeof(int) * MAX_CUS);
=20
-	get_online_cpus();
+	cpus_read_lock();
=20
 	/*
 	 * Choose the first online core of each compute unit, and then
@@ -190,7 +190,7 @@ static int read_registers(struct fam15h_power_data *dat=
a)
=20
 	on_each_cpu_mask(mask, do_read_registers_on_cu, data, true);
=20
-	put_online_cpus();
+	cpus_read_unlock();
 	free_cpumask_var(mask);
=20
 	return 0;
--=20
2.32.0

