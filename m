Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9358C3B2BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhFXJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhFXJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z9wMLcQku/1YYhiNNwVfe5Aq/rs1BorVlMXx1tBpaoA=; b=CTUjDEN1JWnIJW9g5jpqRFZ/TO
        eWzyCFSqB1nFBW4irVMRoMjwSW83yDgJSHlIZWjJhs48FvWsCxZgc0K7QkwqK9XCL0vFXWaQdDy0e
        vfLp7A0Ao2hjFQ2gwVR9pSOkcX9dIrehzdwaV4Z5CG9zih2t7cQJSZTXo5hSJeHQyOQ1A9L8+IDQs
        kMvZMal9OrrzZ9HMPfb069AwJB5AKolAMGE9lc4k3qA1qXTfz0enwy3Den6ZVqcS8jsnZqlZ6fD+P
        p6godsu2ZaJfYbCaVHKT1PpDRi6HJWTOI9pTQaq655XNHBJdSmnwbY3NZZVerH/SQMMXbvUWOcsON
        0hKq1Kzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM3u-00BCCz-2c; Thu, 24 Jun 2021 09:54:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D88B53002D3;
        Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B5682016D6C3; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095147.693801717@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as dead_end_function
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm_cpu_bringup_and_idle() function is required to push the return
value on the stack in order to make ORC happy, but the only reason
objtool doesn't complain is because of a happy accident.

The thing is that asm_cpu_bringup_and_idle() doesn't return, so
validate_branch() never terminates and falls through to the next
function, which in the normal case is the hypercall_page. And that, as
it happens, is 4095 NOPs and a RET.

Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
function it calls as a dead-end. This way we no longer rely on what
code happens to come after.

Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reliable")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -177,6 +177,7 @@ static bool __dead_end_function(struct o
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
+		"cpu_bringup_and_idle",
 	};
 
 	if (!func)


