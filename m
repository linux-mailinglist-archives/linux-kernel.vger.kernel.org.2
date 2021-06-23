Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A243B1583
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFWIQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:16:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aZ70KUQ4xiGy7D3iEcm7dM1Y7L3xe9MZS7AxOrnXEE8=; b=Rp0CfGKlRuOJz2UJeuEbGk3W2f
        dzbwtVebQF8+rRKK1GM5hHX3e+RrI+1Jg3DdOtBfG9F769QXEInTgvI7AUGrUr0OVdydwT/Au5k9E
        SshOz5TfKpn2NyxeDF+X/FoX0VGvYRANaaQ0T+iX0tcpBlB/SiV4dKnmdQxcpDQwrdlwpS+ySsdyx
        YQkJ/5XURrAzwHDb0u6Qs/fkjiDtwaTJBtM7yu76ZG5nhe4cANvcI58WTsqNn7/bkSzhQLd8pEvhj
        gK49QEBs3ecde76xufnD288cQfpZFUlQD9xluozd1vWZB8VBxp10llKSNIea5px9hQ+7AhPKUrpDS
        RFvwK9YA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy1D-00ArtO-2v; Wed, 23 Jun 2021 08:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FD43300204;
        Wed, 23 Jun 2021 10:14:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E236220F6EB8; Wed, 23 Jun 2021 10:14:00 +0200 (CEST)
Date:   Wed, 23 Jun 2021 10:14:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623022826.GA20282@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:28:26AM +0800, kernel test robot wrote:

> [  222.094341] BUG: unable to handle page fault for address: ffffffff83ccffe0

> [  222.283298] insn_decode (kbuild/src/consumer/arch/x86/lib/insn.c:747) 
> [  222.286668] arch_jump_entry_size (kbuild/src/consumer/arch/x86/kernel/jump_label.c:27) 
> [  222.303592] jump_label_text_reserved (kbuild/src/consumer/kernel/jump_label.c:312 kbuild/src/consumer/kernel/jump_label.c:325 kbuild/src/consumer/kernel/jump_label.c:791) 
> [  222.308170] register_kprobe (kbuild/src/consumer/kernel/kprobes.c:2052) 

(FWIW, maybe you can run s'kbuild/src/consumer/''g on the thing before
sending)

I *think* the below might help, can you try?

---
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bdb0681bece8..c44381dcf25b 100644
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
 
@@ -548,6 +550,7 @@ static void static_key_set_mod(struct static_key *key,
 static int __jump_label_mod_text_reserved(void *start, void *end)
 {
 	struct module *mod;
+	bool init;
 	int ret;
 
 	preempt_disable();
@@ -555,6 +558,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
 	if (!try_module_get(mod))
 		mod = NULL;
+	init = mod->state == MODULE_STATE_COMING;
 	preempt_enable();
 
 	if (!mod)
@@ -562,7 +566,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 
 	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
-				start, end);
+				start, end, init);
 
 	module_put(mod);
 
@@ -788,8 +792,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+			__stop___jump_table, start, end, init);
 
 	if (ret)
 		return ret;
