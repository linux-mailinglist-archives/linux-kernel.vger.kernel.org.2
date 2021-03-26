Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43A34AB31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCZPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhCZPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA7C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qKtksJwUQflwycPOCISs6b5+16gGpbLe17fgrm0sb28=; b=qj2tF6PR/lLxD19wn6uwad2De/
        JcWoqnvGTy3T2zv+UW2y7Ou8x1wFb/t0ZDbr/4JtIol2oFQag2eVe5EqnEbWL0LyfoRn+PDA9yrgn
        zQ1ZkjdcZyBHrl2UbTrtfCGBE2uLoOTBXf0e4VeB6Q9fOH8utKqkPJ+xCyip43VQdpx1s8VNegaFw
        8AMxPOX17r1N4RTQHqhEi1njmhg39VYb/TOklgTsbfy5Tc9yn390J1UdFNTwzyCQwDMGSphQXIeg1
        wpOoQ6eXj3aqy86WfiBGdt1OiAhVABO0bcig6238Bg6Q9HEht5WzwFwatM3DVMPcNHvQIZok9qA4V
        K/PQwmbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9X-003s0A-Ry; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1854307967;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 47C0E2BD73394; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151259.630296706@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 05/16] objtool: Per arch retpoline naming
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __x86_indirect_ naming is obviously not generic. Shorten to allow
matching some additional magic names later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |    5 +++++
 tools/objtool/check.c                |    9 +++++++--
 tools/objtool/include/objtool/arch.h |    2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -692,3 +692,8 @@ int arch_decode_hint_reg(struct instruct
 
 	return 0;
 }
+
+bool arch_is_retpoline(struct symbol *sym)
+{
+	return !strncmp(sym->name, "__x86_indirect_", 15);
+}
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -850,6 +850,11 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+__weak bool arch_is_retpoline(struct symbol *sym)
+{
+	return false;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -872,7 +877,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1026,7 +1031,7 @@ static int add_call_destinations(struct
 				return -1;
 			}
 
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -85,4 +85,6 @@ const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
+bool arch_is_retpoline(struct symbol *sym);
+
 #endif /* _ARCH_H */


