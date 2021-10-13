Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAB42C03C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhJMMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhJMMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:42:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1365DC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7cf9h23TD3nPfQF5SaN1Z4UwfMkhhq2LV+J3X/o4Dq8=; b=SfSH1xztOHnG6KZ4+tCsT9Gp4w
        MvQlWNtMaWUXhFPJIwCXzEl5Ha+BNMcrO/Z3KMumRX9JqtOajb899GKycWSD9p+7PMRZ7Bxk5Cc6V
        K6EvFgI5u7u6LP15sR5QczT5ujj6d17ttmpFHnUBixsmcExrJ99h7PRCmIGCII5oRvi69MeGAWrSE
        oxEAa2ib6YtBC4ZBV3kQ9P1wcvz8CIzpaZ6OZaaSlNGx2/pa+CSgdednFlioSSU9s2pxa3BfyBGPy
        pq5x459lFum9hau3VAR8yEeKNscqJzUS0QcJ/F2ik5VknvurQZwqYbOq8FpaUi49+uNT1bE0azedt
        6JhAbd9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYN-009bnv-4O; Wed, 13 Oct 2021 12:40:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21830300EAF;
        Wed, 13 Oct 2021 14:40:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CCFAC20D89510; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013123645.565700874@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 8/9] x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
References: <20211013122217.304265366@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Linux prevents usage of retpoline,amd on !AMD hardware, this
is unfriendly and gets in the way of testing. Remove this restriction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -882,13 +882,6 @@ static enum spectre_v2_mitigation_cmd __
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
 	spec_v2_print_cond(mitigation_options[i].option,
 			   mitigation_options[i].secure);
 	return cmd;


