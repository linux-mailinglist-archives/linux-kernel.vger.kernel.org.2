Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39631F7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBSLAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhBSK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:57:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BBC061574;
        Fri, 19 Feb 2021 02:57:14 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:57:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613732231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekfeYBpqmIXfkESMDbK1/qTui67rFqm5rY7lQ63c5kw=;
        b=tDLvEjx526ux70nrco1KB1nbFk2GcCs007Rv4Ow0WdzDHY4uBKrCXncG5LxJcXZTTRD+01
        BZ97EnK7IfvOBhBviSlJQrgNvLDl95WHpq396AAFcgDkPXBLjrz/oByHPwUgwClxirLL0E
        RpfSYAPyvMMFM7Hs7lo780l2KFvDjxa8hA52FI/7ueggK0fNnsCYVUxO/9nOPwjlPQoTVa
        7Aap9B7M8NEyxZqYdou44R9raV3qqNlQSWCo+bppOT1Ci1MvCJJbuTIBZOjTlymzmgkce7
        D7siWxe9gOJuwPAQamgCC/65PR03xsZ5hH6w939BZJ5hJPKRiGpFfby/LOsaWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613732231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekfeYBpqmIXfkESMDbK1/qTui67rFqm5rY7lQ63c5kw=;
        b=BDocjH6M8w7etY50jFBg7QKyKyjjGj8iSm5Rh/b42AJNjHm/m4OtP6JvMHNBFOcSNvdtUF
        5rcC9r2ZX6tCjABg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219105710.d626zexj6vzt6k6y@linutronix.de>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219104958.GA34308@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-19 11:49:58 [+0100], Uladzislau Rezki wrote:
> If above fix works, we can initialize rcu_init_tasks_generic() from the
> core_initcall() including selftst. It means that such initialization can
> be done later:

Good. Please let me know once there is something for me to test.
Do I assume correctly that the self-test, I stumbled upon, is v5.12
material?

Sebastian
