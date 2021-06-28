Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A063B5C31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhF1KNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhF1KNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86880C061767
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8x1CSLT4gdK7t3KQv3Bp585p+hjgcJ70ztQ2B+mbbI=; b=F9N7FhckCb/N+1T2jIMwfxzv8R
        IiFXqa/PuRBc+pyqp40JsSdf+QXEMDZQC3V+tNmOhDhTUZYcXjv0HD3V6vwKmVrA4x3zdNyy6GJ1o
        vmZYGkkInQ4s5S6pQLlyUCPxXiPW2grLF+HHn13JX/HS11r6mQ5FxkFtIZ5bsfo/ovdKHacjvsB3y
        VABN2/0t322luvL5mlAm8Uaxogpz8BBfVrYTWF0KDlV/vSh7a54vpZCki99WViFbUzagD16z8DttJ
        9qU94EKoBRnEepwaEQ0elbeBhYsR0ShPoOTcF/e7jjS5zSmShpFIyybNhfRwoSQUfxV34uRJuJMl7
        yGCYJt5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxoBk-002pgC-AR; Mon, 28 Jun 2021 10:08:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F846300204;
        Mon, 28 Jun 2021 12:08:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 472432028DBF4; Mon, 28 Jun 2021 12:08:22 +0200 (CEST)
Date:   Mon, 28 Jun 2021 12:08:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YNmflj/WpFG5Ivmb@hirez.programming.kicks-ass.net>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
 <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
 <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
 <YNmUzDjX6sECp37P@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNmUzDjX6sECp37P@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:22:20AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 24, 2021 at 06:32:25AM +0000, Liu, Yujie wrote:
> > > > [  222.094341] BUG: unable to handle page fault for address:
> > > > ffffffff83ccffe0
> > > 
> > > I *think* the below might help, can you try?
> > 
> > Hi Peter Z,
> > 
> > We try to apply the patch on commit e7bf1ba97afdd (jump_label, x86: Emit short JMP)
> > A new BUG appeared before reaching the BUG reported in previous mail.
> > Full dmesg in attachment.
> 
> > > @@ -555,6 +558,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
> > >  	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
> > >  	if (!try_module_get(mod))
> > >  		mod = NULL;
> > > +	init = mod->state == MODULE_STATE_COMING;
> > >  	preempt_enable();
> > > 
> > >  	if (!mod)
> 
> *groan*, I'm an idiot... There's an obvious NULL pointer deref right
> there.
> 
> Let me try locally first before I send yet another dud.

OK, the below seems to work. Your report might've been easier to parse
if it had told me the failing test was:

  tools/testing/selftests/ftrace/ftracetest

And that test would've been easier to use if it would just say wth was
missing from the .config :/

Let me go write up a proper patch and do the same for static_call.

---
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index ba39fbb1f8e7..af520ca26360 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -316,14 +316,16 @@ static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 }
 
 static int __jump_label_text_reserved(struct jump_entry *iter_start,
-		struct jump_entry *iter_stop, void *start, void *end)
+		struct jump_entry *iter_stop, void *start, void *end, bool init)
 {
 	struct jump_entry *iter;
 
 	iter = iter_start;
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !jump_entry_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -561,7 +563,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 
 	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
-				start, end);
+				start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -786,8 +788,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+			__stop___jump_table, start, end, init);
 
 	if (ret)
 		return ret;
