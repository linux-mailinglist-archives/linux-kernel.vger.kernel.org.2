Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608243B2BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhFXJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhFXJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aCeK4Tvb/Fd9t+ZwRJP+EBeMY8MfdOsBwJkr8pPy8rk=; b=QUoPP+6UMIV4FWiuoz0wY8BuAh
        aL4eSra1dTjuvu6d9jFYod7DnJkOMWvnO+GtvYe9ZF5vcpCX4Sp+1n+2MwLWTcUcLOvueiqubZJFN
        PIQXqHzkdt+6Ymfraax0aT8QrEFFIloWuLkT+3nkwQcLgRp4ZosPtiYTZsN/Tu+7bU7ot3T6JuM6g
        ckWc+gXxyRIWKJphl1MYns1buVtQqQ0E7bcxw6LV9RHPQ8RvDVGh9vAklwCo0m9Iq2ETDV3jBXBHP
        1njXUe/JKNHGquRRzbeoEuxZ4X5AupQJ/oWdrFfHUcFJi4OP0FMtREWhZVuR/0vKKd+uPhxw3GCr8
        17+cNwXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM3u-00BCD2-Lp; Thu, 24 Jun 2021 09:54:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F9FD300332;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C289D2BC05F2F; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.126956644@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 08/24] x86/kvm: Always inline evmcs_write64()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: vmx_update_host_rsp()+0x64: call to evmcs_write64() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/vmx/evmcs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -97,7 +97,7 @@ static __always_inline int get_evmcs_off
 
 #undef ROL16
 
-static inline void evmcs_write64(unsigned long field, u64 value)
+static __always_inline void evmcs_write64(unsigned long field, u64 value)
 {
 	u16 clean_field;
 	int offset = get_evmcs_offset(field, &clean_field);
@@ -187,7 +187,7 @@ static inline void evmcs_load(u64 phys_a
 
 __init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
-static inline void evmcs_write64(unsigned long field, u64 value) {}
+static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
 static inline void evmcs_write16(unsigned long field, u16 value) {}
 static inline u64 evmcs_read64(unsigned long field) { return 0; }


