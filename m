Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED344D371
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhKKIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhKKIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B663C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z65-20020a256544000000b005c21b35717dso8294955ybb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TFQiHjTVOGcdjHIhSjR39qpNKZcBVXpqGCA8SCMSOZ4=;
        b=Y34JSB6eFLir2Z6wgVVh4Wkd3M570kKPGtUjDml0MKr4Na/wR2mgL/5Ty8QLVR4tI5
         lXT/Vt6ZIPdFmNCvLCevqcur0yYh7FMjbW6rGcD4Zuz4ymfAVkrln8O7I5pouzOBg0sy
         jv/0EX3rr1qfkUqntBxhoCe8Zlxcyavm3wdPVhdruiteUKwT60Bgk63MdwdkSpoAGK6H
         sn6gTlerLa+JpUbjeS3W67bxv/Aw/z5VdObXTVKl3WUge5dCWGp7caow4/Ki5PcziKwO
         O6jxTsoHj5q3ctrYeTXufeo8+p/TXCkM7vZCQ7XLa3c502j2tOjynZypi9Y7+ZjDY/G2
         CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TFQiHjTVOGcdjHIhSjR39qpNKZcBVXpqGCA8SCMSOZ4=;
        b=AVfUAz6WeeomksHHcsLYGkux9KXOMtVztG0yb4XCV0ucqMzYcMCcCCFuE26j/twm0g
         Eg82eyk+I53FRm3OzbPZXsfl0F4bpBmAMNusBR+KoUrNmZmgzJcJgnZXRX479SA5VMBj
         mvIDimQX3M6mlB2IfeUZfhibfGhWVXn5fOP+q67pD6Qj4inAcX3H/o3fmkHDWVG/U2c5
         c8cRAmew5lOxnkWEfnQqRcemuRHbKBfpSqMpoGcATB4S4gvu3O34OJYtAtaGeZF4VsoM
         MYWIrSA3ntMBZRPWi98183w/Zem04AVleSm+GJZ/saDrOK8uVmqnStwg2v1mmFCSTNvD
         9OUg==
X-Gm-Message-State: AOAM533gYjG2tnLohR1lZiFKhnYxdZz3NJmacuIccQUYgv/lImlLU4hg
        xeq1mx5FTcj4pQ4L4pamuqlzFy5V/UrAtMNJcx5XNyr6V2f6ZdUHNhlxJ211Uvw44cJ6+3h9zi3
        B+dHd0CD0ZQgTLypmD36ssuzhrTBbb7NdAGxtBsFXfJ7K+/VAf6J5TlpjIH9mt83+3k6Yc8cb
X-Google-Smtp-Source: ABdhPJwrBnLb8prP7PNM62z6h12ZzqVZvGiYOT6j2r2oEXxjgUg6iD4La/HcVemKlgP8w/Uh4epNgcEPK1qm
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a05:6902:72a:: with SMTP id
 l10mr6724169ybt.53.1636620692585; Thu, 11 Nov 2021 00:51:32 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:10 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-9-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 08/13] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add an optional callback needed by some PMU features, e.g., AMD
BRS, to give a chance to the perf_events code to change its state before
going to low power and after coming back.

The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
This flag must be set in arch specific perf_event.h header whenever needed.
When not set, there is no impact of the ACPI code.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 drivers/acpi/acpi_pad.c       | 6 ++++++
 drivers/acpi/processor_idle.c | 5 +++++
 include/linux/perf_event.h    | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index f45979aa2d64..a306a07a60b5 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -164,6 +164,9 @@ static int power_saving_thread(void *data)
 				tsc_marked_unstable = 1;
 			}
 			local_irq_disable();
+
+			perf_lopwr_cb(true);
+
 			tick_broadcast_enable();
 			tick_broadcast_enter();
 			stop_critical_timings();
@@ -172,6 +175,9 @@ static int power_saving_thread(void *data)
 
 			start_critical_timings();
 			tick_broadcast_exit();
+
+			perf_lopwr_cb(false);
+
 			local_irq_enable();
 
 			if (time_before(expire_time, jiffies)) {
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f37fba9e5ba0..d1171c6420d0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -546,6 +547,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -556,6 +559,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		wait_for_freeze();
 	}
+
+	perf_lopwr_cb(false);
 }
 
 /**
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c96448059be..ebef56b552ba 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1654,4 +1654,10 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 					   unsigned int cnt);
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
+#ifndef PERF_NEEDS_LOPWR_CB
+static inline void perf_lopwr_cb(bool mode)
+{
+}
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
2.34.0.rc0.344.g81b53c2807-goog

