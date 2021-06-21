Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9693AE8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFUMGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFUMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PDlGxNdOLkQWqQwFHTXo6kbEGz9HT8kDERsuFlZm2vA=; b=U9FQmBHO13z8XCzZYW7XmgQ880
        +1AVBrHGEftiYXMRNjyOVQDmTEU/4bn0WQpxJoSxFh7VEe3FTHwYhs8DCPpUaav7WaQaHgiQ3lF44
        7nc/ZD2hydOORx7CQlm2w0VLT+EhQvWvvcNxkd+z1YAYS93mZZIguzY9nPJBCO9t2aAU1ZZn1ULsk
        31oujWs98qsM6EiosMixKGaQ8HkUUlesiBc7nE728kn0eGu1HzBz8RbPdLy1XPCQiW2ShTHuhXJln
        v0bnYjjvKyUzlR85ZA/+6AuP/bYngKle/vcNGbdyQSoiqyfZEgxkaNt+Mb5lLgxZ+sERTH5c+4Pmi
        LZGzyP4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdV-00D3ht-24; Mon, 21 Jun 2021 12:02:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3097C300233;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF382235EE381; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621120120.606560778@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [PATCH 03/18] x86/xen: Fix noinstr fail in exc_xen_unknown_trap()
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_xen_unknown_trap()+0x7: call to printk() leaves .noinstr.text section

Fixes: 2e92493637a0 ("x86/xen: avoid warning in Xen pv guest with CONFIG_AMD_MEM_ENCRYPT enabled")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/enlighten_pv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -592,8 +592,10 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
 DEFINE_IDTENTRY_RAW(exc_xen_unknown_trap)
 {
 	/* This should never happen and there is no way to handle it. */
+	instrumentation_begin();
 	pr_err("Unknown trap in Xen PV mode.");
 	BUG();
+	instrumentation_end();
 }
 
 #ifdef CONFIG_X86_MCE


