Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE93191DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhBKSHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhBKRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F024C061788
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=c5eDeaEzOP+WG0Ctb4XPSANbAX0sYc0t2PZc69VzguQ=; b=Juq8GUHl6SgzNYIElhc8RZwTgo
        DP25LHl6fQ1E237XDKE7XJiFFtZsNPiFy1QMensxBWqsjSyyVZDp4MtUo/l4/x+VXa7aQKxbatFxW
        B1bmNCkjSNJ9sb0TqFy87nP+KozxzmKg9NDPtKUKoKwhP5Tu2LcvG1Iq4qjayqa2xFSQUvDYSFTQd
        +LaxW3+KpSHVQy6aEdyyNudBdwJCzMFOt53iJ2AKLALedi6RAUEEVmsf/nMS5Kum4/Ysh8f79vYRo
        daeNf+ukPln6zyZVcpqy0dR2QrjBnUxHi7EveMq3MewkXiC/tWZ4tJT6okB4sg8m+4nnAylQJzjcF
        vnZbl2IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFxO-0005bw-Bn; Thu, 11 Feb 2021 17:40:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 111563050F0;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F03C12BCDFC77; Thu, 11 Feb 2021 18:40:44 +0100 (CET)
Message-ID: <20210211173627.033720313@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 2/7] objtool,x86: Renumber CFI_reg
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make them match the instruction encoding numbering.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/include/arch/cfi_regs.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/include/arch/cfi_regs.h
+++ b/tools/objtool/arch/x86/include/arch/cfi_regs.h
@@ -4,13 +4,13 @@
 #define _OBJTOOL_CFI_REGS_H
 
 #define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
+#define CFI_CX			1
+#define CFI_DX			2
 #define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
+#define CFI_SP			4
+#define CFI_BP			5
+#define CFI_SI			6
+#define CFI_DI			7
 #define CFI_R8			8
 #define CFI_R9			9
 #define CFI_R10			10


