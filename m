Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E148447DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhKHKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbhKHKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F1C0613B9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:26 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5F751EC0512;
        Mon,  8 Nov 2021 11:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsTDYXG+v5hhPMnmRg9TduaPXosuJr3o/692DyLaWe4=;
        b=nKVAoOqArxTd9eNlc15GoKXKFEtlvlVU5qRmJCeTzgQ9RnumWDj8qNjyVkPBQZlRa9gZRC
        t8KzKBUGXcK18fiH8mAlba7UbSmuGpOBgeYIBJ9JUSuWW/z84VhQJbj0L3GRjWvgLW6hGC
        ywZG6v2GExcT9ij1ZUvjpd6jugjwVFc=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v0 21/42] tracing: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:36 +0100
Message-Id: <20211108101157.15189-22-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9139dc1262c..87fd6f1fa407 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10064,8 +10064,8 @@ __init static int tracer_alloc_buffers(void)
 	/* All seems OK, enable tracing */
 	tracing_disabled = 0;
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &trace_panic_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &trace_panic_notifier))
+		pr_warn("Trace panic notifier already registered\n");
 
 	register_die_notifier(&trace_die_notifier);
 
-- 
2.29.2

