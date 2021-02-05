Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41D310EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBEPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:50:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233289AbhBEPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612546066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcp9Eqr93Xo6XFmidRYjV1Oz+ChgKiiN3/ZJ2UwlACk=;
        b=hoRb67iREmKM/JCGn5GqUQeGv6me4cucfy4gyfAnBx96ooVyA1cnno/PGyi5SHM4Vxx2Ra
        OBzV+VkIQ4aknrFlXZB/ClzJDJ3QTMyT0PoCsttnfkjEVboe1N/Ir3yhYXnqBYZL/bJdk2
        ATDDXv+j5sUrpFLMviFEdlhOvgDtjoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-0OyopJcBNdiRstKjRwtiVg-1; Fri, 05 Feb 2021 09:24:14 -0500
X-MC-Unique: 0OyopJcBNdiRstKjRwtiVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500CD107ACF3;
        Fri,  5 Feb 2021 14:24:13 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-178.rdu2.redhat.com [10.10.116.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B60565D9CC;
        Fri,  5 Feb 2021 14:24:12 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing ORC data
Date:   Fri,  5 Feb 2021 08:24:03 -0600
Message-Id: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1612534649.git.jpoimboe@redhat.com>
References: <cover.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ORC unwinder attempts to fall back to frame pointers when ORC data
is missing for a given instruction.  It sets state->error, but then
tries to keep going as a best-effort type of thing.  That may result in
further warnings if the unwinder gets lost.

Until we have some way to register generated code with the unwinder,
missing ORC will be expected, and occasionally going off the rails will
also be expected.  So don't warn about it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index c451d5f6422f..027b72b5c9ed 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -13,7 +13,7 @@
 
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task == current)					\
+	if (state->task == current && !state->error)			\
 		orc_warn(args);						\
 })
 
-- 
2.29.2

