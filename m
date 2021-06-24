Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBA3B2BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFXJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhFXJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A666C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JJH+iGYKrPetDAhiWuvWE6KUZAXKDw2nlZDCz7W9sEM=; b=KD4n0bWfs58iFnIGHRkDD+UyMW
        6963IC6WZeUDAkmV9K2MbpHo2v4dKgvjCXVgNQAAQGYZvF3BQoXOuXQ3h3oG0bcEIJzavpGL1x1yK
        xjtHvtj++UkW39mLzjQ5ixQWYDquJRBKqrRS9XOJFbXF4pWI8aDRa98d+JylBvJQ9KcAkfwXSJZV4
        aBzT5XgOcaML59h+AwXem+Ns/gesBiYa1FMEQ6CZpawityHjMACe3+A56Xvzh8T6A+RijGjbdMUpK
        MWpD2GQnyKFrHduGhcwjiUOJ/06J1HE/eNEyG3tw2VQgMPZBNtWR/LX6yuHMOaY5f2u/wiTjv9lYz
        8fuocmxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM41-00GQOZ-Eg; Thu, 24 Jun 2021 09:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ECF730031E;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BDAA02BC05F32; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.066347165@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 07/24] x86/kvm: Always inline to_svm()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x13: call to to_svm() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/svm/svm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -252,7 +252,7 @@ static inline bool vmcb_is_dirty(struct
         return !test_bit(bit, (unsigned long *)&vmcb->control.clean);
 }
 
-static inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
+static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
 }


