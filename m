Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58C442B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKBKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKBKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:08:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC7C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pfITbUW7BK/9jsSc/LFkNWLfMqDm0biQuCkMFm8jx0M=; b=Qc1ePlZ6ZG8aqHABSElBRiZfuM
        DsqT23hJvPro6AOz6rJdQWIdcX2mbYayuatZrrdDtR9zM6i6ckjHQ6P+PXF4lkvN/53BkRba/qMrC
        6VZdM7strYGzh7zKm7WEHrXZzpb7t8tgF3pvn7ZHJ1c5aq+m6QpSg+Ce6meaId0Cy7CuKJSLxHa76
        2zOeZ7dvp1O8+EOlHwInDOuRWpjJbl6I2InPirzFtK4M4qu9WP3bc4Z2Obq8RLmNR00E+MEwActqe
        Ub9Y4Ghc8Ugwrfdrz9rBvrCd86lJpcFxuz+w/6oksZD4YZIgPQh/XbAJh0dWP3mxZwCyYcdE93jVx
        YHC9BPIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhqdt-004QGl-Ax; Tue, 02 Nov 2021 10:04:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46A04300130;
        Tue,  2 Nov 2021 11:03:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35C33286DB58E; Tue,  2 Nov 2021 11:03:44 +0100 (CET)
Date:   Tue, 2 Nov 2021 11:03:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
Message-ID: <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
 <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 10:05:50AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 02, 2021 at 09:00:36AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 01, 2021 at 01:44:39PM -0700, Linus Torvalds wrote:
> 
> > >     do_machine_check()+0x27: call to stackleak_track_stack ...
> > >     do_syscall_64()+0x9: call to stackleak_track_stack ...
> > >     do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
> > >     exc_general_protection()+0x22: call to stackleak_track_stack ...
> > >     fixup_bad_iret()+0x20: call to stackleak_track_stack ...
> > >     .entry.text+0x10e6: call to stackleak_erase ...
> > >     .entry.text+0x143: call to stackleak_erase ...
> > >     .entry.text+0x17d9: call to stackleak_erase ...
> > > 
> > > most seem to be about the stackleak thing,
> > 
> > Right, I recently ran into this and hacen't yet had time to look into
> > it. I suspect my normal build box doesn't have the GCC plugin crud
> > enabled or somesuch.
> > 
> > I think the GCC stackleak plugin needs fixing, specifically it needs a
> > function attribute such that it will not emit instrumentation in noinstr
> > functions. I'll go chase down the developer of that thing.
> 
> Alexander, is there any way to make this plugin grow a function
> attribute which we can add to noinstr ? There's a strict requirement the
> compiler doesn't add extra code to noinstr functions these days.
> 
> We'll 'soon' be running noinstr C code before switching to kernel page
> tables even.

Using my pre-release GCC-12 compiler (the only one I have with plugin
crud enabled apparently), the below seems to work.

Having the plugin gate on section name seems a lot hacky, but given it's
already doing that, one more doesn't hurt.

---
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ce161a8e8d97..135866ca8878 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -48,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
-asmlinkage void notrace stackleak_erase(void)
+asmlinkage noinstr void stackleak_erase(void)
 {
 	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
 	unsigned long kstack_ptr = current->lowest_stack;
@@ -102,7 +102,6 @@ asmlinkage void notrace stackleak_erase(void)
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
-NOKPROBE_SYMBOL(stackleak_erase);
 
 void __used __no_caller_saved_registers notrace stackleak_track_stack(void)
 {
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index e9db7dcb3e5f..07688a1c686b 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -446,6 +446,8 @@ static bool stackleak_gate(void)
 			return false;
 		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
 			return false;
+		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
+			return false;
 	}
 
 	return track_frame_size >= 0;
