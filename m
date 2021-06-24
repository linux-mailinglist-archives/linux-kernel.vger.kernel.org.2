Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39773B2BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhFXJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhFXJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3708CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AZsczpNKe3s2AIrQx4lgMaDSZl5jAeuYL6dnkuID4jE=; b=GVW6j+1isBugSwc+/bvPKx3VUH
        1wdvU6K0O4+9eUzQyNdFPVYAVr/VEYFszxQiR/cRk69eaUxE/iji/Drld5bnx/xSQknWFKzKTYhFn
        xoqs4HYJdGtkXvjTOBvmZjnp8HsaCnPyHFljU/tEipAXMlhX4ousRG+9J2xAwSCVCAIB/B410HTfA
        1USlHMK6gMZt+BDzDfJgZLeBBG8iEd4cRjNuCq8O+lkeAnWyj2cO+8MV8KioCsvRqS6W2DTQDRxeB
        Hr64YLXxWutVjyKvQodqQNrDmJvrp1uh9du0wYCjRuwenwt+mPTIM7qIJqG2Xrx/YbK/9qZcseDR6
        v5DuSYwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM3v-00BCD7-UI; Thu, 24 Jun 2021 09:54:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9498A3005A3;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D3A462BC05F37; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095148.250770465@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 10/24] x86/sev: Fix noinstr for vc_ghcb_invalidate()
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: __sev_put_ghcb()+0x88: call to __memset() leaves .noinstr.text section
vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x39: call to __memset() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/sev-shared.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -64,7 +64,7 @@ static bool sev_es_negotiate_protocol(vo
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	ghcb->save.sw_exit_code = 0;
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
 static bool vc_decoding_needed(unsigned long exit_code)


