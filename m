Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF28340BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhCRRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhCRRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F369C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qggCA0PdIgJHgEVfFMNcM2DrIYdXnta85dNhqCFZepg=; b=f9AodiOkTU+1uHUvHdtR3wnhxo
        iRrrpeY5PWES9Tt4wkPr/6secsCTLpM97EPujrpIz4zA4i+dyTSTfDJSpThZdYc/ApYt7k3m1NWvx
        6tE8qmMUTmRBlbRMsOn/gZk5g266PVCqmbFtthO4t4g/8FGRTp6BYdxDtoK+6ZsF1ljdGtLTlIQBL
        ySYI7ojf2AnfJgqlAdfJJmqJnEILrTtMLbqbHFTUStmThCCulPcN96+kOpjpDIys+HJF2F3K5CJsS
        u2RBu9ZLE4LyBr02YeOUnhw//jMZod0uDXEfc+Eb8iH7GjwVOxj6jDqRgigFPHNOBfJAOasMre/xs
        gY+LuEtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-005kF4-Lq; Thu, 18 Mar 2021 17:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F2E8307975;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FDAD213C0F59; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171920.191767166@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 13/14] objtool: Skip magical retpoline .altinstr_replacement
References: <20210318171103.577093939@infradead.org>
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


