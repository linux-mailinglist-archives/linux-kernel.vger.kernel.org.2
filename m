Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1195F3DF006
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhHCOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbhHCORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:20 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukfQ/itW8n54fN+jgxjD4o8zeGy/ZlKFFUejHTJbsn0=;
        b=mEthALokmZMcCteDvF09DIiAu1JPAcuV5+J7tg9dttOtDh6jw77AtOaBnqImkqPMyMrmUs
        PeeaRKRb2NZRYn6TMcNApdfqF9RXxv/UxTy+zsdKu5RWbdlSJA3dYeeTF9W5kmaNe38dZy
        mD8Ttlb8RiDXHtQBDaR5uZdSY+w36KM6EeCjFqOClAhkneOjil1w6RJU5xH0QV3q2WKeLL
        EQC9PV887AcptAUgBl/HsfDghcTonF81ftEOXkwJRyUEVW1jk5HAhJuHEGdlG7SUlP34ut
        7MWo/v6oP15qFMfHnQFoo7Vn1nxt91epL/88QsKgFYPwmniK/s1oiO2Mywz/1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukfQ/itW8n54fN+jgxjD4o8zeGy/ZlKFFUejHTJbsn0=;
        b=gwyhrxEueeU6LrsIcsijaBZI6vTZwfluKDVpE9Yej2ErvUyKKB73K9wtb5KO6+1icEms2K
        qrFUV+aWfsW6Q5Bg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/38] coresight: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:57 +0200
Message-Id: <20210803141621.780504-15-bigeasy@linutronix.de>
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

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hw=
tracing/coresight/coresight-cpu-debug.c
index 9731d3a960735..00de46565bc40 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -588,11 +588,11 @@ static int debug_probe(struct amba_device *adev, cons=
t struct amba_id *id)
=20
 	drvdata->base =3D base;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	per_cpu(debug_drvdata, drvdata->cpu) =3D drvdata;
 	ret =3D smp_call_function_single(drvdata->cpu, debug_init_arch_data,
 				       drvdata, 1);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (ret) {
 		dev_err(dev, "CPU%d debug arch init failed\n", drvdata->cpu);
--=20
2.32.0

