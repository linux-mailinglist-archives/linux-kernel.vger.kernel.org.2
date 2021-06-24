Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0436B3B2BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhFXJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhFXJ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A84C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=C5VHBCy+lz0omv2rSNouf2o5sxcp3gBXQhRid3xvQhQ=; b=hOIouiSPmC4Ju5tTpPibMJOEv2
        DP2qo/ulUioN0pWpmHnar4WTscrw1wgNiwWWPS09eOfut0dRleRt6ieBW1lO01y6lvkjOBupRiWEk
        VQQcjT0QsxItdiz1XgU0yVn0a9yCb3/+66uu7UbOZQHIhmqRzh3Otc6SiYENcErXf99/r6z21REwZ
        M/y/oUg/DnPQdBl7sM/8SjllJLJyLk4GQtvRE6AqhMbhtyANnqLe4wU7rrWJEsoDS8WKOEgiXH5Wp
        e/pMtqM5tO8fgdjZLaeonxUL5LToYf95Nynw3DH/8dFRG8NWPNfUxcd3CIzBE1MzmEoX3ZiR4OSy6
        inPcfwXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM40-00GQOW-Sf; Thu, 24 Jun 2021 09:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6734300258;
        Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A5F462BC05F2C; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095147.880513802@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 04/24] x86/kvm: Always inline sev_*guest()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x4d: call to sev_es_guest() leaves .noinstr.text section
vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x50: call to sev_guest() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/svm/svm.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -204,12 +204,12 @@ DECLARE_PER_CPU(struct svm_cpu_data *, s
 
 void recalc_intercepts(struct vcpu_svm *svm);
 
-static inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
+static __always_inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_svm, kvm);
 }
 
-static inline bool sev_guest(struct kvm *kvm)
+static __always_inline bool sev_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
@@ -220,7 +220,7 @@ static inline bool sev_guest(struct kvm
 #endif
 }
 
-static inline bool sev_es_guest(struct kvm *kvm)
+static __always_inline bool sev_es_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;


