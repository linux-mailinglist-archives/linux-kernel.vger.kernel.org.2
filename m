Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756C74349AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhJTLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A5C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7cf9h23TD3nPfQF5SaN1Z4UwfMkhhq2LV+J3X/o4Dq8=; b=Fi2VJPwLc8Rfh5dIv/6543KDd1
        pzykxYAesmQZR3wtm6hII61Zyv9FwmNTrnmZSvu/ndkaMJ18Yl2CAQzutoGQ7cAVFToYJ++Cf2Plz
        LuXp8F98A77wKRLSvmSBmwXh7r+HQNnsLBLICpH8Coy4nBcuiXOYOJoW3gZTeLvDSluoHMvygb9jf
        ZbLOkYlMOn3Zq+d4+0JcK2d1VlP1p46yAXEl8/pw9Z7kfcYXd68765tBCezQ4ENHFvIydw1fgM6s0
        hO4HYFuWotNYAVmfYy+BloZbtZz6qR0cQRVaK/fJzi7U2Lsfp14rP2PVXkJhdKr/XdP+tnUBgUchf
        DNwR4aeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR1D-JA; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 364083011E4;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 23F73201BB3C6; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105843.284284789@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 13/14] x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
References: <20211020104442.021802560@infradead.org>
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


