Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B003116C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhBEXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhBEOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:32:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8E2C061223
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xmMvhqZUQ27b/b3Jk1/md0ZnUqghgPS0fl8J1sNpi9s=; b=Nhr0ZFAIBVV99nRqxGlmsHDWCB
        wprAVgTl7wMJbil+L/TuuR2eHFJ1pFMa/1YkWR/U3PXefBbKqBl6YvzJTymh5aawd7wvN0xZk1r1M
        sLUJNANh3PAqdwMURt4NuyDbNt/szLLxjCCFInrO94sYx67kYEOGlxNT61QV17ytV6vYPP+lvi/T2
        z5v9cZaqiMBEq+u6QdlAgLaoBi5Kill84pAei3SgyIlp7qOi2dRWlGpGHCeXSCpcS2kGyp/pW6s/L
        G4/7lVkeM1eFbMEGN77pDyq61MMQoULJH5I/g/8B1CkujbDwWI3SL9VMBWVymvQe0AV3+0PQM3VD0
        NyG+rm8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l82w4-0006yH-PD; Fri, 05 Feb 2021 15:22:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3ECC30066E;
        Fri,  5 Feb 2021 16:22:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FBFF20A0D644; Fri,  5 Feb 2021 16:22:12 +0100 (CET)
Date:   Fri, 5 Feb 2021 16:22:12 +0100
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
Message-ID: <YB1ipIoAXLPP1fvU@hirez.programming.kicks-ass.net>
References: <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
 <20210127231837.ifddpn7rhwdaepiu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127231837.ifddpn7rhwdaepiu@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:18:37PM -0600, Josh Poimboeuf wrote:

> +static struct static_call_tramp_key *tramp_key_lookup(unsigned long addr)
> +{
> +	struct static_call_tramp_key *start = __start_static_call_tramp_key;
> +	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
> +	struct static_call_tramp_key *tramp_key;
> +
> +	for (tramp_key = start; tramp_key != stop; tramp_key++) {
> +		unsigned long tramp;
> +
> +		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
> +		if (tramp == addr)
> +			return tramp_key;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int static_call_add_module(struct module *mod)
>  {
> -	return __static_call_init(mod, mod->static_call_sites,
> -				  mod->static_call_sites + mod->num_static_call_sites);
> +	struct static_call_site *start = mod->static_call_sites;
> +	struct static_call_site *stop = start + mod->num_static_call_sites;
> +	struct static_call_site *site;
> +
> +	for (site = start; site != stop; site++) {
> +		unsigned long addr = (unsigned long)static_call_key(site);
> +		struct static_call_tramp_key *tramp_key;
> +
> +		/*
> +		 * Is the key is exported, 'addr' points to the key, which
> +		 * means modules are allowed to call static_call_update() on
> +		 * it.
> +		 *
> +		 * Otherwise, the key isn't exported, and 'addr' points to the
> +		 * trampoline so we need to lookup the key.
> +		 *
> +		 * We go through this dance to prevent crazy modules from
> +		 * abusing sensitive static calls.
> +		 */
> +		if (!kernel_text_address(addr))
> +			continue;
> +
> +		tramp_key = tramp_key_lookup(addr);
> +		if (!tramp_key) {
> +			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> +				static_call_addr(site));
> +			return -EINVAL;
> +		}
> +
> +		site->key = ((long)tramp_key->key - (long)&tramp_key->key) |
> +			    (site->key & STATIC_CALL_SITE_FLAGS);
> +	}
> +
> +	return __static_call_init(mod, start, stop);
>  }

I find it works better with this on..

---
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 5e6f567976c1..6906c6ec4c97 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -325,7 +325,7 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 	return ret;
 }
 
-static struct static_call_tramp_key *tramp_key_lookup(unsigned long addr)
+static unsigned long tramp_key_lookup(unsigned long addr)
 {
 	struct static_call_tramp_key *start = __start_static_call_tramp_key;
 	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
@@ -336,10 +336,10 @@ static struct static_call_tramp_key *tramp_key_lookup(unsigned long addr)
 
 		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
 		if (tramp == addr)
-			return tramp_key;
+			return (long)tramp_key->key + (long)&tramp_key->key;
 	}
 
-	return NULL;
+	return 0;
 }
 
 static int static_call_add_module(struct module *mod)
@@ -350,7 +350,7 @@ static int static_call_add_module(struct module *mod)
 
 	for (site = start; site != stop; site++) {
 		unsigned long addr = (unsigned long)static_call_key(site);
-		struct static_call_tramp_key *tramp_key;
+		unsigned long key;
 
 		/*
 		 * Is the key is exported, 'addr' points to the key, which
@@ -366,14 +366,14 @@ static int static_call_add_module(struct module *mod)
 		if (!kernel_text_address(addr))
 			continue;
 
-		tramp_key = tramp_key_lookup(addr);
-		if (!tramp_key) {
+		key = tramp_key_lookup(addr);
+		if (!key) {
 			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
 				static_call_addr(site));
 			return -EINVAL;
 		}
 
-		site->key = ((long)tramp_key->key - (long)&tramp_key->key) |
+		site->key = (key - (long)&site->key) |
 			    (site->key & STATIC_CALL_SITE_FLAGS);
 	}
 
