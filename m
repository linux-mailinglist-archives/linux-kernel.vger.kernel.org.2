Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768F03B07CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhFVOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232073AbhFVOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9V4odNhyFX2TvRRuUOjoRnqMcZXz21M4FWh3G4T9vMU=;
        b=a3EkjsoANPK6R3Eaptmbm2T7UYq0mnSGQ24CD6RkjGBjvoxpMxzFPRZAgubJpQXgMnuQMb
        gA8lFuYFMDjMaXu/kpa5e+xwkS0JEZ9hO/SXAu9BHy0Ur6n7psh6snBnlPvxm3+/md3uLp
        qr7Z+BjPr8y4JUkIxbcwDKz5byXC06s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-OnQ1gda6NIWz7FO0TLIpIw-1; Tue, 22 Jun 2021 10:44:51 -0400
X-MC-Unique: OnQ1gda6NIWz7FO0TLIpIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74466101F002;
        Tue, 22 Jun 2021 14:44:49 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9045D9CA;
        Tue, 22 Jun 2021 14:44:44 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 12/14] trace: Protect tr->tracing_cpumask with get/put_online_cpus
Date:   Tue, 22 Jun 2021 16:42:30 +0200
Message-Id: <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to the hotplug support on tracers with workload,
protect tr->tracing_cpumask with get/put_online_cpus() to avoid
concurrency with hotplug operations.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 52fc9438b7b4..c14f33db147e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5053,7 +5053,13 @@ int tracing_set_cpumask(struct trace_array *tr,
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 
+	/*
+	 * tracing_cpumask is read by tracers that support CPU
+	 * hotplug.
+	 */
+	get_online_cpus();
 	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
+	put_online_cpus();
 
 	return 0;
 }
-- 
2.31.1

