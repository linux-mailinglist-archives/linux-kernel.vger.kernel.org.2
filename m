Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210942F6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhJOPK3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Oct 2021 11:10:29 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:48048 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240730AbhJOPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:10:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-MQD5G6uIOiyv07EamLfiwQ-1; Fri, 15 Oct 2021 11:08:07 -0400
X-MC-Unique: MQD5G6uIOiyv07EamLfiwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECEB71922025;
        Fri, 15 Oct 2021 15:08:05 +0000 (UTC)
Received: from x1.com (unknown [10.22.9.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B48C5F4E7;
        Fri, 15 Oct 2021 15:08:03 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] trace/osnoise: Fix an ifdef comment
Date:   Fri, 15 Oct 2021 17:07:48 +0200
Message-Id: <33924a16f6e5559ce24952ca7d62561604bfd94a.1634308385.git.bristot@kernel.org>
In-Reply-To: <cover.1634308385.git.bristot@kernel.org>
References: <cover.1634308385.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/CONFIG_OSNOISE_TRAECR/CONFIG_OSNOISE_TRACER/

No functional changes.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 arch/x86/kernel/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/trace.c b/arch/x86/kernel/trace.c
index 6b73b6f92ad3..8322e8352777 100644
--- a/arch/x86/kernel/trace.c
+++ b/arch/x86/kernel/trace.c
@@ -231,4 +231,4 @@ void osnoise_arch_unregister(void)
 	unregister_trace_local_timer_exit(trace_intel_irq_exit, "local_timer");
 	unregister_trace_local_timer_entry(trace_intel_irq_entry, NULL);
 }
-#endif /* CONFIG_OSNOISE_TRAECR && CONFIG_X86_LOCAL_APIC */
+#endif /* CONFIG_OSNOISE_TRACER && CONFIG_X86_LOCAL_APIC */
-- 
2.31.1

