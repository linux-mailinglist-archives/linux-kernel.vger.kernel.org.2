Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DC339488
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhCLRSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhCLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB341C061764
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qggCA0PdIgJHgEVfFMNcM2DrIYdXnta85dNhqCFZepg=; b=pi6FTgaiJVNYFRtJ9kqQiEaL/m
        7O0rhwD+55/ZcYfJ+e/uYYXqKSNKmi0LOzbt/azJNnFTkK+V1kPaPCMOkDFZXkhdSbi/eV/38GCxS
        3IAxFGlQk7O1ol+ycYDjEnVl0GmzVBOGsu+cO0/KfMUAwmtM+SAdGBfQPM+Kc6IbQdMUsqsF5v2wk
        NgtxNbg/C2cuC6ql+LybZ1Tb5AiJOLC1GFb3Vya5D7RJbSQz69RX+qJjERFVLEGzXi6KY8ZIShh4K
        XTFyuYIbBU3CzWv1/HSZOwDR4DES9Ko+qL54DG1Ps9Syttr12ijRUNI+jbKh0ptk4XKZ9Bmz7rzcH
        VCy6VUsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQA-00C53H-NJ; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48AF5307691;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1C06123CC2298; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.832063970@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 8/9] objtool: Skip magical retpoline .altinstr_replacement
References: <20210312171613.533405394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the .altinstr_replacement is a retpoline, skip the alternative.
We already special case retpolines anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/special.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -106,6 +106,14 @@ static int get_alt_entry(struct elf *elf
 			return -1;
 		}
 
+		/*
+		 * Skip retpoline .altinstr_replacement... we already rewrite the
+		 * instructions for retpolines anyway, see arch_is_retpoline()
+		 * usage in add_{call,jump}_destinations().
+		 */
+		if (arch_is_retpoline(new_reloc->sym))
+			return 1;
+
 		alt->new_sec = new_reloc->sym->sec;
 		alt->new_off = (unsigned int)new_reloc->addend;
 
@@ -154,7 +162,9 @@ int special_get_alts(struct elf *elf, st
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret > 0)
+				continue;
+			if (ret < 0)
 				return ret;
 
 			list_add_tail(&alt->list, alts);


