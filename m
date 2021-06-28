Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9603B5D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhF1Lec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhF1Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:34:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B64C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=E+oSSCUULm6xRkHHI2Ewic3maFKOXJIkLCNenjhVfQ4=; b=AaPQyl6Aq87/nX9DfJl+X9daIE
        zDQx7KgUXFo5vRpaIdlQk+7VrmxR6af+aOd9dEYr/2YDmQnjNErruQKIyYqZbm8KQ+Dt9l+AJaIyT
        iQNSl0fcoTvG2uxCh4dOfwxEa1v6QKbhImFUV7CiTngcjLREzs0GS11GXZlA8zvPQvpSIjcngQmqE
        gHP/dE/Z+/TRrcKN7MXC5geCG/Dug865OHhq2Mf0ejq+Yt3CYseZMO6ulRr8wzaXSHO7ZH/I8X3eO
        RuNlFtmp5K1Lcdy3D0H9oMV2gHJqYg8A9FDUuqCQJ+obhZPvkltcmZbDPnUTfkdC2cSMA1o1q0lO7
        2bqbF4ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpUD-00CXqk-4s; Mon, 28 Jun 2021 11:31:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F6943002D3;
        Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FCF82BF0CB39; Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Message-ID: <20210628113045.167127609@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Jun 2021 13:24:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/3] kprobe/static_call: Restore missing static_call_text_reserved()
References: <20210628112409.233121975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
kprobes on inline static_call()s") that went walkabout.

Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kprobes.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/static_call.h>
 #include <linux/perf_event.h>
 
 #include <asm/sections.h>
@@ -1551,6 +1552,7 @@ static int check_kprobe_address_safe(str
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
+	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;


