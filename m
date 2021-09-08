Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F06403FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbhIHTV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIHTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3D861104;
        Wed,  8 Sep 2021 19:20:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36x-0014be-4K; Wed, 08 Sep 2021 15:19:55 -0400
Message-ID: <20210908191954.969241352@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:19:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 10/12] tracing: synth events: increase max fields count
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Sometimes it is useful to construct larger synthetic trace events. Increase
'SYNTH_FIELDS_MAX' (maximum number of fields in a synthetic event) from 32 to
64.

Link: https://lkml.kernel.org/r/20210901135513.3087062-1-dedekind1@gmail.com

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_synth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 4007fe95cf42..b29595fe3ac5 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -5,7 +5,7 @@
 #include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
-#define SYNTH_FIELDS_MAX	32
+#define SYNTH_FIELDS_MAX	64
 
 #define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */
 
-- 
2.32.0
