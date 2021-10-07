Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16377425EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhJGV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbhJGV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:29:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ECAC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IQqOSE5vPHdOcx5X8yMzuOd2At96LXK9BBhYsOqYMLM=; b=RMcoezTY5Rm8ZE0dR2D323SeKx
        gCHWwpP5Yy0D0At4ZZ8gw62zwvK2gwhE9yVBCAzQedpIOsxtwp29IcXRquiEc/ad7VJ0yQFFSKQbw
        sbKrdXbQDnh2SqPoj+tUs+ARkOvNZ4GEWbWIophDxJJZ3u06SVOc9BcQfL5MhHW1iY1edU+y7HVpW
        VgT0xk61seMU0985XNz24DyFTulI+74DxqIyEuM9zFZcczRH1YXOvUGWNBlfdWdoR3zC+gKkOViPw
        BYEWSYOdhywPC0+H+l30KxywoxEgW3T4VmT46RcLdnwTAzYcBhEkXUlWHtRN07pOoYnhs+xZr+P2b
        4zdaYNUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYav2-008YHZ-0n; Thu, 07 Oct 2021 21:27:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAA3730077A;
        Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9E3772D188969; Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Message-ID: <20211007212627.008917519@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 23:22:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: [PATCH 2/2] objtool: Optimize/fix retpoline alternative generation
References: <20211007212211.366874577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When re-running objtool it will generate alterantives for all
retpoline hunks, even if they are already present.

Discard the retpoline alternatives later so we can mark the
instructions as already having alternatives and subsequently skip
generating them. Use ->ignore_alts for this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |    3 +++
 tools/objtool/check.c           |    8 ++++++++
 tools/objtool/special.c         |    8 --------
 3 files changed, 11 insertions(+), 8 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -806,6 +806,9 @@ int arch_rewrite_retpolines(struct objto
 		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
 			continue;
 
+		if (insn->ignore_alts)
+			continue;
+
 		reloc = insn->reloc;
 
 		sprintf(name, "__x86_indirect_alt_%s_%s",
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1468,6 +1468,14 @@ static int add_special_section_alts(stru
 				ret = -1;
 				goto out;
 			}
+			/*
+			 * Skip (but mark) the retpoline alternatives so that we
+			 * don't generate them again.
+			 */
+			if (new_insn->func && arch_is_retpoline(new_insn->func)) {
+				orig_insn->ignore_alts = true;
+				continue;
+			}
 		}
 
 		if (special_alt->group) {
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -109,14 +109,6 @@ static int get_alt_entry(struct elf *elf
 			return -1;
 		}
 
-		/*
-		 * Skip retpoline .altinstr_replacement... we already rewrite the
-		 * instructions for retpolines anyway, see arch_is_retpoline()
-		 * usage in add_{call,jump}_destinations().
-		 */
-		if (arch_is_retpoline(new_reloc->sym))
-			return 1;
-
 		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */


