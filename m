Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06544F348
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhKMNRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMNQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:16:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400DA60FBF;
        Sat, 13 Nov 2021 13:14:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mlsr7-000RmY-Ju;
        Sat, 13 Nov 2021 08:14:05 -0500
Message-ID: <20211113131405.448928696@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 13 Nov 2021 08:13:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 1/3] tracing/osnoise: Make osnoise_instances static
References: <20211113131340.640683117@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Make the struct list_head osnoise_instances definition static.

Link: https://lore.kernel.org/all/202111120052.ZuikQSJi-lkp@intel.com/
Link: https://lkml.kernel.org/r/d001f0eeac66e2b2eeec7d2a15e9e7abede0453a.1636667971.git.bristot@kernel.org

Cc: Ingo Molnar <mingo@redhat.com>
Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 3e4a1651e329..7520d43aed55 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -55,7 +55,8 @@ struct osnoise_instance {
 	struct list_head	list;
 	struct trace_array	*tr;
 };
-struct list_head osnoise_instances;
+
+static struct list_head osnoise_instances;
 
 static bool osnoise_has_registered_instances(void)
 {
-- 
2.33.0
