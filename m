Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5C36D051
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhD1BiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhD1BiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:38:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:37:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s22so22512582pgk.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SzD+/k6rA+JOUB658aiLpUQHhdrlTF2H7tv6i/bGzhs=;
        b=LKO9ybR3WXZpW4l4K5jLqcfgE3Fjk4wMHf3VJOD8ONXQ/Q3Nr9RwaOBBbicxNyJi4r
         ZM7AkBLEGz5Lt2S68WUPHYOILVnpPumeOpZi7g2bL1r06nPuBWE5kIENYONRvwr5TqN+
         W5mhrGFgnWiwz2ZsRQh5/W1hGtzbnZ6Tn22RYmQf4FTJ8FOLxnIf9tn7pykHihFMmGju
         zcL3Wdl1na+Mhs1HxYqAM/UC77mePeHRWN0j9lcro4jh+0Ypt6tm0jyaRW5I38kALFLF
         oeVwJwOIQDKWSPdCW34m2H1WzG0Qp4zSBFbEg7p8Gm+l6o3cNSlJWf64JjECTuOfWyO/
         t6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SzD+/k6rA+JOUB658aiLpUQHhdrlTF2H7tv6i/bGzhs=;
        b=VW1xnaFPSkcyUDDjADffCZ1MfjYH4qYf2eE1Fhc65cNf9rX/nJ7YWw4fhDW2QadlgJ
         bUKzXqmVV4WMZhRA+bdHg9/B1I4MLu2CjrLhrXDyIPlUYfw+uyFQ0n+mLIz9VmdA1FIb
         5sh4x1jKN03sYQ4Ncgs6LdYFZsLd/YXo0Kl8fn06wZX2aieZnHcBl6iEqxeWJ6wjN1EB
         DSOCdQYLqlGoi3unVL7ZtEtcM/9axcmb7R0NM+h30hsViD6pfjRilq/ZEJDqqDMyO/kf
         OcWQX48nmVoidWMo8kw8yPcmxNV5f0WNdBCEixL3Pv8Yl28KCm5yf/KZJJh9JLLANKst
         qeZQ==
X-Gm-Message-State: AOAM532MosFvAsi8t7zm2CXMxTaU7Ob7wu+TTiYlJ0/5HXpEkjf376eC
        50tafsvBdJ+IzFfeoC52ReItyQ==
X-Google-Smtp-Source: ABdhPJwHh287a2xHsz+3p+Lqn4sw53twlNkguGUX9tnRKAqE4Yhnk5riqtyW0/z90DQhrs82Wo7lwQ==
X-Received: by 2002:a63:f30b:: with SMTP id l11mr24157262pgh.129.1619573834032;
        Tue, 27 Apr 2021 18:37:14 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id p22sm3216538pjg.39.2021.04.27.18.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 18:37:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFC PATCH] coresight: etm-perf: Correct buffer syncing for snapshot
Date:   Wed, 28 Apr 2021 09:36:59 +0800
Message-Id: <20210428013659.324230-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf tool records the Arm CoreSight trace data with snapshot mode
with the option '-S', when receiving USR2 signal, it is observed the
captured trace data size is very varied: from several MBs to ~20MBs.
This can be reproduced with the command:

  perf record -e cs_etm// -S \
	-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
  PERFPID=$!
  sleep 1
  kill -USR2 $PERFPID

It's different for only specifying option '-S' than options '-a -S'.  If
without option '-a', perf tool creates separate AUX buffers for every
CPU, but the tracer will be enabled only when the profiled program is
scheduled onto the corresponding CPU, this might lead to record very
old trace data when snapshot.

Let's see below diagram:
                                                            snapshot
  CPU0: ______###P1###__________________________________________|
  CPU1: __________________________###P3###____________###P5###__|
  CPU2: ____________________________________###P4###____________|
  CPU3: ________________###P2###________________________________V

In this diagram, the program runs for 5 periods (from P1 to P5), these 5
periods show the task run on different CPUs, e.g. during P1 period the
program runs on CPU0, and during P2 period the program is migrated to
CPU1, and so on.  At the end of P1 period when the program is switched
out from CPU0, the ETR trace data is saved into AUX trace buffer, this
AUX buffer is a dedicated buffer for CPU0's tracer.  With the same
logic, P2's trace data is saved into CPU3's tracer buffer, P4's trace
data is saved into CPU2's buffer, P3 and P5's trace data is saved into
CPU1's.  Therefore, when snapshot, it saves the trace data from all AUX
ring buffers (in this case, it have total 4 AUX ring buffers) into perf
data file.

This is why we can see varied trace data size, it's quite dependent on
the task scheduling on CPUs, if the task is spinned to only one CPU and
without scheduling out, it will only record trace data from only one
AUX trace buffer.  If the task is frequently scheduled in and out, then
it gives more chance to fill trace data into the AUX buffer.

In this example, it also causes the discontinuous trace data.  If P3's
trace data is lost after P5's trace data overwrites the AUX trace data,
thus perf tool fails to record continuous trace data if only have
trace data for P1/P2/P4/P5.

For snapshot mode, usually the user only wants to capture the trace data
for the specific time point and prior to the that point the tracer
should work with free run mode.  This means it's not necessary to
capture trace data for task's scheduling in and out until the perf tool
explicitly disables tracers for snapshot.  This can be fulfilled by
checking the variable "event->ctx->is_active", when the task is
scheduled out this variable is set to zero, and when snapshot this
variable is still non-zero value.  So the driver can only record trace
data only when "event->ctx->is_active" is non-zero.

After applying this change, the perf tool can record the consistent
trace data size for snapshot.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 21 ++++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f603b4094f2..5fceefe9513c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -245,6 +245,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
+	event_data->overwrite = overwrite;
 
 	/* First get the selected sink from user space. */
 	if (event->attr.config2) {
@@ -424,9 +425,23 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		if (!sink_ops(sink)->update_buffer)
 			return;
 
-		size = sink_ops(sink)->update_buffer(sink, handle,
-					      event_data->snk_config);
-		perf_aux_output_end(handle, size);
+		/*
+		 * In the snapshot mode, here should avoid to record trace data
+		 * when the profiled program is scheduled out and only capture
+		 * trace data when the perf tool receives USR2 signal.
+		 *
+		 * This is distinguished by variable "event->ctx->is_active",
+		 * its value is zero for profiled task scheduling out, and it
+		 * is a non-zero value when perf tool invokes ioctl
+		 * PERF_EVENT_IOC_DISABLE.
+		 */
+		if (!event_data->overwrite || event->ctx->is_active) {
+			size = sink_ops(sink)->update_buffer(sink, handle,
+						      event_data->snk_config);
+			perf_aux_output_end(handle, size);
+		} else {
+			perf_aux_output_end(handle, 0);
+		}
 	}
 
 	/* Disabling the path make its elements available to other sessions */
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3e4f2ad5e193..2cc3af05495f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -49,12 +49,14 @@ struct etm_filters {
  * @mask:		Hold the CPU(s) this event was set for.
  * @snk_config:		The sink configuration.
  * @path:		An array of path, each slot for one CPU.
+ * @overwrite:		Flag for snapshot mode.
  */
 struct etm_event_data {
 	struct work_struct work;
 	cpumask_t mask;
 	void *snk_config;
 	struct list_head * __percpu *path;
+	bool overwrite;
 };
 
 #if IS_ENABLED(CONFIG_CORESIGHT)
-- 
2.25.1

