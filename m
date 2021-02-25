Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25C6325938
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhBYWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBYWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:04:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40033C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1Ft9fTKk6nbWlpAb3J7lEuAxbMocVw2RdI/+bVWD/s=; b=UJ9lwbOq5fxB/Wa57PStkSQLn4
        caIE3pmlGRvNsJZHlzCD3Q0R3zh1/opV7ute83jT/p6mgrCOGf1CKsyxiCTGzsYrp8t/T4aXaZ5No
        9R8KqzaUU0629glRgC7Nd4dZGSs40hW1JcAvkxurwVzsay1ZSKZ3N9/x3PH/fG2OPbtyPvVMaJhWl
        lCiqQneytl0hxR5isynJe9G8kJQsGFHwGWz2Gd9LIwL3yeoq1WsjjA3uyQQ4UwDzUEIOK4BHDaUjY
        4Ngh6rq8R+PKkWastbZn5ykVEBZWCakaMjDTPiE5xPGy2ZWJ/Q6hKwO18DUSFFKxw+UgFCaKxMN8G
        IzDUA7Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFOjm-00BEMi-6R; Thu, 25 Feb 2021 22:03:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FA709864D3; Thu, 25 Feb 2021 23:03:51 +0100 (CET)
Date:   Thu, 25 Feb 2021 23:03:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] static_call: Fix the module key fixup
Message-ID: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
References: <20210225131221.11dab26e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225131221.11dab26e@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: static_call: Fix the module key fixup

Provided the target address of a R_X86_64_PC32 relocation is aligned,
the low two bits should be invariant between the relative and absolute
value.

Turns out the address is not aligned and things go sideways, ensure we
transfer the bits in the absolute form when fixing up the key address.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/static_call.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 6906c6ec4c97..ae825295cf68 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -349,7 +349,8 @@ static int static_call_add_module(struct module *mod)
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long addr = (unsigned long)static_call_key(site);
+		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 
 		/*
@@ -373,8 +374,8 @@ static int static_call_add_module(struct module *mod)
 			return -EINVAL;
 		}
 
-		site->key = (key - (long)&site->key) |
-			    (site->key & STATIC_CALL_SITE_FLAGS);
+		key |= s_key & STATIC_CALL_SITE_FLAGS;
+		site->key = key - (long)&site->key;
 	}
 
 	return __static_call_init(mod, start, stop);
