Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3841AACE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhI1IpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhI1Ioy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A822C06176C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fW7iPUpEL4PAZROb3OL+FwAqyhHg9FUDk4c7oK/Gv04=; b=dNucMQKOfNNIS70yupiHCj4+LX
        j39eq+kbA0SpM84S+P2sOChvmSTSBWTlF4AfvV2mm1sim7+AOQTh2ENSST6GLmc770KBFl5ngrel4
        k0TtBKUAVQNqJG5I1pyfztb41Rha/vlUOPIsYBQGLbrMKo7FVWFteyOYZasBsZ8en/II2+UEyx6fC
        /tN305yJSbsVuJJC3ZIB+AMAc/qv/vowMyvOiNtgMoizwYAz4vpuK8OoMtH51F+3fnVJXhYS4ddnD
        ad5q+8Z3CpCmvh+BOmhF0CDZK73M83+6u2zZuuC4O2BFWeOcsdi5O/FTj5Ald+cjZPYc6Q8qp2W9t
        GyFEOn1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV8hW-006S9l-0N; Tue, 28 Sep 2021 08:42:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BE4730029A;
        Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CA96B2C2FF132; Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Message-ID: <20210928084217.987503713@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Sep 2021 10:40:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org, tglx@linutronix.de, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/3] rcu: Fix rcu_dynticks_curr_cpu_in_eqs() vs noinstr
References: <20210928084020.819856223@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  vmlinux.o: warning: objtool: rcu_nmi_enter()+0x36: call to __kasan_check_read() leaves .noinstr.text section

noinstr cannot have atomic_*() functions in because they're explicitly
annotated, use arch_atomic_*().

Fixes: 2be57f732889 ("rcu: Weaken ->dynticks accesses and updates")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -327,7 +327,7 @@ static void rcu_dynticks_eqs_online(void
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(atomic_read(this_cpu_ptr(&rcu_data.dynticks)) & 0x1);
+	return !(arch_atomic_read(this_cpu_ptr(&rcu_data.dynticks)) & 0x1);
 }
 
 /*


