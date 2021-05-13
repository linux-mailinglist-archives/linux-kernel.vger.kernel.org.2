Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C037F98C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhEMOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhEMOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:19:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1685C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rZD5Uo1Pin2ssu2K+K34nWRWWOWQMiv60MRiNrm081E=; b=LjnPTAjxtpIT5flS8mawI77rDE
        2w85BC8rdEYrAd2zEwaC2qc8mHz2gBfYstKK1U5wboN+bIuKfkmDfBFZAvkcudIymslt1l8Q76wPL
        rEfsQyu2QzNhNCA+xeC95dSZIsVeVBqx43Jpn8431ld5CJrKGMRVUIIw6T/GebSp12sYgEQjlH8dQ
        H0ZxMnZF9B6t0628Dv9fwn0kCd+Vo3JoDUEZV/mig7BRC0QnUsi5yI9aT1o5IK7fHpheIjkAPfeJw
        qhdWsi7qGYoLtqHscQIkfiew58cangGzn/dMfAxVii4WiXXajuoGFiQeVhbQfGUXnhUmmh3Bki8Dy
        C3VTz2ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhC8t-009V4y-KT; Thu, 13 May 2021 14:16:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 479083001E1;
        Thu, 13 May 2021 16:16:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 385592D99D99B; Thu, 13 May 2021 16:16:47 +0200 (CEST)
Date:   Thu, 13 May 2021 16:16:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07.5/13] jump_label,x86: Remove unused JUMP_LABEL_NOP_SIZE
Message-ID: <YJ00zxsvocDV5vLU@hirez.programming.kicks-ass.net>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.846870383@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506194157.846870383@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: jump_label,x86: Remove unused JUMP_LABEL_NOP_SIZE
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu May 13 13:53:16 CEST 2021

JUMP_LABEL_NOP_SIZE is now unused, remove it.

Fixes: 001951bea748 ("jump_label, x86: Add variable length patching support")
Reported-by: Miroslav Benes <mbenes@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/jump_label.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -17,8 +17,6 @@
 #include <asm/text-patching.h>
 #include <asm/insn.h>
 
-#define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
-
 int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
