Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50AE3B2BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhFXJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhFXJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pAJ3Uhy5Ex8bY7tG7ccIs5V1qcvL6s3KUHco0jc9BGw=; b=YnjM/S8y/s7fN4xdsoK+NQ9Ehe
        snIPpxTPRAzqvty44rx8HZ+2xbh1DsUZGj2Rr9tB+iVymz3IQfsKWGzK/oSN1zLsC9bC2Ho/FDbSW
        YRYJIe5+BlWlzDixl0w++6tIvOp9NR2F6jH0aAOBgsl8ufoNR5rJ4l9e5f3q9M3NZ6ZNyyT4ZSxH6
        4GJ3jKP9mrmmFhZHEbezXzad2iMon62ECyT7mKPi41rrCW+sgfD7W4IGXlLUp4ODi99F7flNCHZex
        e0tMOVmxCTWLX1CweR0QuY7StChjy6nQ6lDWGAYjfO62V7H+bFiYnVQ5MAdgKwlYMwFAmZKCreCyA
        gGREFO7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM3v-00BCD4-Ae; Thu, 24 Jun 2021 09:54:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F9BF300325;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD5722BC05F30; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095147.942250748@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 05/24] x86/kvm: Always inline vmload() / vmsave()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0xea: call to vmload() leaves .noinstr.text section
vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x133: call to vmsave() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/svm/svm_ops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -56,12 +56,12 @@ static inline void invlpga(unsigned long
  * VMSAVE, VMLOAD, etc... is still controlled by the effective address size,
  * hence 'unsigned long' instead of 'hpa_t'.
  */
-static inline void vmsave(unsigned long pa)
+static __always_inline void vmsave(unsigned long pa)
 {
 	svm_asm1(vmsave, "a" (pa), "memory");
 }
 
-static inline void vmload(unsigned long pa)
+static __always_inline void vmload(unsigned long pa)
 {
 	svm_asm1(vmload, "a" (pa), "memory");
 }


