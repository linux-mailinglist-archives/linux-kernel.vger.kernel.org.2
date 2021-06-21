Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C653AE8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFUMGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFUMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04733C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pQl2yh+6pyJV3VV2LohDGaWaBV2tIjTEtliz0OA6/QM=; b=P4TQKbfiIodSpqPBO40FBRXeCH
        BxKClW4SKbXlyBGWz/U2NDxyVFPZn3/d2RFPu5vTX6KsPW/fvRVjTad/aP0w6I9oJLBEmGbatBPgg
        r21Yu1MM/4rV4ZTaOzdiScyIwWPkNvuMAL6ylWGKgAQIrmXT6pE68HbYlxqtnB9lzfD9dJBs2qxoa
        fm9yqw/576XEH/hHRvnOrE6ysKM5UFshTiQSDN78D81LEZ0ggSWjXJfh/GEmfx8g0lI1UewkIe37b
        fRan6pqaXPQG6WzakHY9O13Jwb2fibFAZbj8wjav2XQFWmeEpqRX2VWjIM5fkx89lF4W2/1lPw1pl
        1Dz3gnhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdY-00D3hz-T4; Mon, 21 Jun 2021 12:02:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B89F13005CA;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E2A3235EE38E; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.657369642@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 16/18] x86/xen: Mark xen_force_evtchn_callback() noinstr
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: check_events()+0xd: call to xen_force_evtchn_callback() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/xen/hypercall.h |    2 +-
 arch/x86/xen/irq.c                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -358,7 +358,7 @@ HYPERVISOR_event_channel_op(int cmd, voi
 	return _hypercall2(int, event_channel_op, cmd, arg);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_xen_version(int cmd, void *arg)
 {
 	return _hypercall2(int, xen_version, cmd, arg);
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -19,7 +19,7 @@
  * callback mask. We do this in a very simple manner, by making a call
  * down into Xen. The pending flag will be checked by Xen on return.
  */
-void xen_force_evtchn_callback(void)
+noinstr void xen_force_evtchn_callback(void)
 {
 	(void)HYPERVISOR_xen_version(0, NULL);
 }


