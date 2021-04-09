Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED09359905
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhDIJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:22:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A923C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mosm8KM7imMlq14PmGksE2MTFNgfJh8FoVTdkWZ+E9s=; b=bOcD/UMaU8sKoc5D8i7JejxjjH
        Sy3ws10gEEOmUPEh2SEUKmxD2Bw7jCyA1vGruYp73Owe48CvDeYdV78KBi24iTXF0gEAeLQKTBEtG
        XKkWJWMUpTkOKYxNZODoCK7yrL+Qs3SeRqfGRohsjxiUq8lo7DgQZ+5drOvfwIQFJDeonvZ62a9dC
        FWjboLV35dNiVBR/lBMiihHI4MSyfPae1ujb5puK1M9Z1fNY6wgUFTYzWAlmrelchNZ/mRdnfJJLY
        a5cknpEDzDXCnWkR/9jv/cpyYhrzgoVIMSrKU3M00H6qOHAW7WeWxvsMaQQfJx77BsgDL7QqB9OYv
        Hy5R1n7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUnKw-000Daf-E8; Fri, 09 Apr 2021 09:21:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F4AE300033;
        Fri,  9 Apr 2021 11:21:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C2FC20CBFFE0; Fri,  9 Apr 2021 11:21:56 +0200 (CEST)
Date:   Fri, 9 Apr 2021 11:21:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V5 21/25] perf: Introduce PERF_TYPE_HARDWARE_PMU and
 PERF_TYPE_HW_CACHE_PMU
Message-ID: <YHActB+bkgBesWM3@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-22-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617635467-181510-22-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:11:03AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current Hardware events and Hardware cache events have special perf
> types, PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. The two types don't
> pass the PMU type in the user interface. For a hybrid system, the perf
> subsystem doesn't know which PMU the events belong to. The first capable
> PMU will always be assigned to the events. The events never get a chance
> to run on the other capable PMUs.
> 
> Add a PMU aware version PERF_TYPE_HARDWARE_PMU and
> PERF_TYPE_HW_CACHE_PMU. The PMU type ID is stored at attr.config[40:32].
> Support the new types for X86.

Obviously ARM would need the same, but also, I don't think I see the
need to introduce new types. AFAICT there is nothing that stops this
scheme from working for the existing types.

Also, pmu type is 32bit, not 8bit.

So how about something like this?

---
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f7f89ea5e51..074c7687d466 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -260,15 +260,16 @@ struct perf_event;
 /**
  * pmu::capabilities flags
  */
-#define PERF_PMU_CAP_NO_INTERRUPT		0x01
-#define PERF_PMU_CAP_NO_NMI			0x02
-#define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_EXTENDED_REGS		0x08
-#define PERF_PMU_CAP_EXCLUSIVE			0x10
-#define PERF_PMU_CAP_ITRACE			0x20
-#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
-#define PERF_PMU_CAP_NO_EXCLUDE			0x80
-#define PERF_PMU_CAP_AUX_OUTPUT			0x100
+#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
+#define PERF_PMU_CAP_NO_NMI			0x0002
+#define PERF_PMU_CAP_AUX_NO_SG			0x0004
+#define PERF_PMU_CAP_EXTENDED_REGS		0x0008
+#define PERF_PMU_CAP_EXCLUSIVE			0x0010
+#define PERF_PMU_CAP_ITRACE			0x0020
+#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
+#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
+#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
 
 struct perf_output_handle;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f07943183041..910a0666ebfe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11113,14 +11113,21 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	 * are often aliases for PERF_TYPE_RAW.
 	 */
 	type = event->attr.type;
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
-		type = PERF_TYPE_RAW;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		type = event->attr.config >> 32;
+		if (!type)
+			type = PERF_TYPE_RAW;
+	}
 
 again:
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
+
 		ret = perf_try_init_event(pmu, event);
 		if (ret == -ENOENT && event->attr.type != type) {
 			type = event->attr.type;
@@ -11143,6 +11150,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto unlock;
 		}
 	}
+fail:
 	pmu = ERR_PTR(-ENOENT);
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
