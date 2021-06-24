Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7A3B2BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFXJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhFXJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37274C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pQl2yh+6pyJV3VV2LohDGaWaBV2tIjTEtliz0OA6/QM=; b=dhyAQL77YXJtoPLRREA3yLdwbB
        KM3vsIkmnNl0dphYyq38UOyFjxP72ViYNi6tofTrct1EWkMC8EQyr4R23BEFNUwxW3D+l3SiE9P+s
        WDfLZA2e6L4TJG8Y5ZAaBh/yxc9pGBTYycEn8rh6U26179r0cOEDrZYj2JSfy1hG1XZm/KU384myv
        ZXsfnk3l+c9Mw6e1lIiVMp4rcKvLY02BFgnJyz5kBRoJrZFUfNLQyGOGYLu7wAZXIU5BWP5ppdR41
        jf9SZzeKdJ/PPUsXIPCML3mhm5DJfHKxBrp7mALEB1LByJIYZh4FtPL5nKddk7f9lXIrj/LyNdvO+
        n/9yUV0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4C-00BCEN-Gu; Thu, 24 Jun 2021 09:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABF623005EF;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3DE1E2BC1D0C4; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.996055323@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 22/24] x86/xen: Mark xen_force_evtchn_callback() noinstr
References: <20210624094059.886075998@infradead.org>
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


