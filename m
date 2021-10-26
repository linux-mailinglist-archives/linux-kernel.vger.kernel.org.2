Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175AF43B711
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhJZQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhJZQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CAF61078;
        Tue, 26 Oct 2021 16:23:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEr-000qSI-5x;
        Tue, 26 Oct 2021 12:23:49 -0400
Message-ID: <20211026162349.024933855@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [for-next][PATCH 09/12] tracing/hwlat: Make some internal symbols static
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang ShaoBo <bobo.shaobowang@huawei.com>

The sparse tool complains as follows:

kernel/trace/trace_hwlat.c:82:27: warning: symbol 'hwlat_single_cpu_data' was not declared. Should it be static?
kernel/trace/trace_hwlat.c:83:1: warning: symbol '__pcpu_scope_hwlat_per_cpu_data' was not declared. Should it be static?

This symbol is not used outside of trace_hwlat.c, so this commit
marks it static.

Link: https://lkml.kernel.org/r/20211021035225.1050685-1-bobo.shaobowang@huawei.com

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d0a730d99a33..56bb7b890578 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -79,8 +79,8 @@ struct hwlat_kthread_data {
 	int			nmi_cpu;
 };
 
-struct hwlat_kthread_data hwlat_single_cpu_data;
-DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
+static struct hwlat_kthread_data hwlat_single_cpu_data;
+static DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
 
 /* Tells NMIs to call back to the hwlat tracer to record timestamps */
 bool trace_hwlat_callback_enabled;
-- 
2.33.0
