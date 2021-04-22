Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD7367AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhDVHWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDVHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:22:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6QV4LSrgZeosQFabgU3Wteeb82I5vZcJQajRe5K1xHs=; b=pM9xRJ2pgl8n/WkF5uwNvNyR7x
        74EUSrsqX1TA4uTUatmWOArsEdQFfPfHE6CC+i72s1MiHTWjK9c8t6BPbaoZiMYI70YDOvw3gjfiz
        ffjT9GALCf5v8EUS9EAi+YuQ9l12yJnqSowv5P6n4wdHnAo98kOHQ9n2RxbPOgAk3i/6elmBvsvT6
        8zpXYHLchktYb3/FTq9cYFTdjtSyVwKxQN40t6zwIn2g/comrIZO5ZyQdp/BlHTbMJA/ViWJ4RZDH
        0kwAxPhYDap3Y7tkAAwva3nvPQQeW2BATcdf/uWsJpUUah5aF6KkV5t1CtDgr9IEu7Ev+5dB+M/zC
        A+Zk/GpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZTdH-00Ha46-0y; Thu, 22 Apr 2021 07:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 870513001D0;
        Thu, 22 Apr 2021 09:20:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 618F32B7FBDBF; Thu, 22 Apr 2021 09:20:13 +0200 (CEST)
Date:   Thu, 22 Apr 2021 09:20:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Fix unused variable warning
Message-ID: <YIEjrb7uO1KLgf3y@hirez.programming.kicks-ass.net>
References: <20210422003334.139452-1-linux@roeck-us.net>
 <20210421204139.669f5c22@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421204139.669f5c22@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 08:41:39PM -0400, Steven Rostedt wrote:
> 
> Second patch with the exact same update. Perhaps we should take one
> before we get more of them ;-)
> 

I thought we already fixed that...

---
commit 7d95f22798ecea513f37b792b39fec4bcf20fec3
Author: Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri Mar 26 11:50:23 2021 +0100

    static_call: Fix unused variable warn w/o MODULE
    
    Here is the warning converted as error and reported by GCC:
    
      kernel/static_call.c: In function ‘__static_call_update’:
      kernel/static_call.c:153:18: error: unused variable ‘mod’ [-Werror=unused-variable]
        153 |   struct module *mod = site_mod->mod;
            |                  ^~~
      cc1: all warnings being treated as errors
      make[1]: *** [scripts/Makefile.build:271: kernel/static_call.o] Error 1
    
    This is simply because since recently, we no longer use 'mod' variable
    elsewhere if MODULE is unset.
    
    When using 'make tinyconfig' to generate the default kconfig, MODULE is
    unset.
    
    There are different ways to fix this warning. Here I tried to minimised
    the number of modified lines and not add more #ifdef. We could also move
    the declaration of the 'mod' variable inside the if-statement or
    directly use site_mod->mod.
    
    Fixes: 698bacefe993 ("static_call: Align static_call_is_init() patching condition")
    Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lkml.kernel.org/r/20210326105023.2058860-1-matthieu.baerts@tessares.net

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 2c5950b0b90e..723fcc9d20db 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -165,13 +165,13 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 
 		stop = __stop_static_call_sites;
 
-#ifdef CONFIG_MODULES
 		if (mod) {
+#ifdef CONFIG_MODULES
 			stop = mod->static_call_sites +
 			       mod->num_static_call_sites;
 			init = mod->state == MODULE_STATE_COMING;
-		}
 #endif
+		}
 
 		for (site = site_mod->sites;
 		     site < stop && static_call_key(site) == key; site++) {
