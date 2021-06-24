Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F43B2BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhFXJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhFXJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lQfFlCgkE6l1bv3XTjlrWHnVfGWhQN5K3kqRQldXYvU=; b=pP9/GJuFy90kGourndmvop0jyr
        shXj1D4fyvHh2XRx9//FGfItca1DiGP3QHCSxsA030pynpgUa5ta0dQ1W5pj6/uUFDb6XvRBY6nH3
        3Senl2M/4p1cP8PEsgr7q51KDjzLUARR1L1AaDEK1aY7izyBj68/+TcedfhdXc+NsSsUrjsh9KmJZ
        lYh/Cu7k5JAwsf+rv1Gy4D42tIDbvEH26aEmYSMHYP874w9dhN5Fmad6k1G6POm3uiIuS5/NNzpWf
        poGqBxVijCFFHFyHZ56NpD9ygJ9IHXpiaqkmCvuuGfOVNLJBl5DCOVr3CrsV+evkEt2DSC3si/S4Q
        tc6UG8Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4C-00BCEL-GN; Thu, 24 Jun 2021 09:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A72863005E4;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 27AA12BC1D0C1; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.810950584@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 19/24] x86/xen: Make hypercall_page noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: xen_set_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_get_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_irq_enable()+0x24: call to hypercall_page() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/xen-head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -64,7 +64,7 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
-.pushsection .text
+.pushsection .noinstr.text, "ax"
 	.balign PAGE_SIZE
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)


