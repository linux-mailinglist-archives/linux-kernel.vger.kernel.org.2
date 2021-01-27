Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D74305A00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhA0Liq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbhA0LcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:32:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA40C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0IDs0bv6jJHYevR4e4sryGAFj1EtpYsKEeFuim9Ci+Q=; b=hkq409egsWtb3AVd4pXJcjveF9
        iNe48lMsyAvyxcpOwF+EHwtAvnkV49ng+X+cSsdA+wlkiz2SkW4jI+FKX7TLOYOqACQjOJVZSMJ4+
        6TeS0CeJY10c5RKgimYLKnFjDzvjgZrzrb/n/YhjtE8z3jVFO3azlHmCaHM09G6T6Wl42rizvrKYm
        HXMX+NmY3NfNzE0/ikmuGj0e2ziPa5jDJlyHylQkbuqtYn2DTTiWxh3PZ8iErbIEj5/9yARIM6GBM
        11QVQtjYlsobqsOIrPUeLJW0ELmTM3hbUOSnXfdhzLtGtEoas4FLubAdf+OnDjonME1pbqxIDWbmU
        AHCsvv9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4iyd-006xue-4P; Wed, 27 Jan 2021 11:27:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D19A3010C8;
        Wed, 27 Jan 2021 12:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D9612C539F6A; Wed, 27 Jan 2021 12:27:09 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:27:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:13:47AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2021 at 05:57:30PM -0600, Josh Poimboeuf wrote:

> > Well, I hate it, but I'm not sure I have any better ideas.  It should be
> > possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
> > sure about the performance impact though.  Might be a good reason to
> > speed up kallsyms!
> 
> Oh right, let me see if I can make that work.

Something like so compiles.. but it does make the whole thing depend on
KALLSYMS_ALL, which is somewhat yuck.

Also, kallsyms_lookup_name() is horrible, but not trivial to fix because
of that compression scheme used.

---
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/processor.h>
+#include <linux/kallsyms.h>
 #include <asm/sections.h>
 
 extern struct static_call_site __start_static_call_sites[],
@@ -325,8 +326,66 @@ static int __static_call_mod_text_reserv
 
 static int static_call_add_module(struct module *mod)
 {
-	return __static_call_init(mod, mod->static_call_sites,
-				  mod->static_call_sites + mod->num_static_call_sites);
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = start + mod->num_static_call_sites;
+	struct static_call_site *site;
+
+	struct {
+		unsigned long tramp;
+		unsigned long key;
+	} cache[8] = { { 0, 0}, };
+	int idx = 0;
+
+	for (site = start; site != stop; site++) {
+		unsigned long key, addr = (unsigned long)static_call_key(site);
+		unsigned long sym_size, sym_offset;
+		char sym_name[KSYM_NAME_LEN];
+		const char *name;
+		int i;
+
+		if (!kernel_text_address(addr))
+			continue;
+
+		/*
+		 * Gotta fix up the keys that point to the trampoline.
+		 */
+
+		/* Simple cache to avoid kallsyms */
+		for (i = 0; i < ARRAY_SIZE(cache); i++) {
+			if (cache[i].tramp == addr) {
+				key = cache[i].key;
+				goto got_key;
+			}
+		}
+
+		name = kallsyms_lookup(addr, &sym_size, &sym_offset, NULL, sym_name);
+		if (!name)
+			goto fail;
+
+		if (name != sym_name)
+			strcpy(sym_name, name);
+		memcpy(sym_name, STATIC_CALL_KEY_PREFIX_STR, STATIC_CALL_KEY_PREFIX_LEN);
+		key = kallsyms_lookup_name(sym_name);
+		if (!key)
+			goto fail;
+
+		/* Remember for next time.. */
+		cache[idx].tramp = addr;
+		cache[idx].key = key;
+		idx++;
+		idx %= ARRAY_SIZE(cache);
+
+got_key:
+		site->key = (key - (unsigned long)&site->key) |
+			    (site->key & STATIC_CALL_SITE_FLAGS);
+	}
+
+	return __static_call_init(mod, start, stop);
+
+fail:
+	pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+		static_call_addr(site));
+	return -EINVAL;
 }
 
 static void static_call_del_module(struct module *mod)
