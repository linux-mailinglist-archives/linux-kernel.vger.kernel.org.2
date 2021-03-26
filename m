Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18F34AB3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCZPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhCZPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7DC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qggCA0PdIgJHgEVfFMNcM2DrIYdXnta85dNhqCFZepg=; b=XnDvgU3XIJbkcWwmYVFYaloSN0
        ofZ4gWkzloWXFtB+FksA0cl2LUal5QAZ5HHz+HTtOOz1vEfstX1KE/rJoX7tX2JIcoq0qrccoSsOg
        aQZlsC9SlHYq4kithGoK8dU/BijTPgFIGDKpIFyWq19owCzSgUgR2lk0aDaYlxzuWtHKuY6SkBbmD
        V4/RIiqSnjuZTfml5dj+7W54kmPWgNcHSaxYYSXls7Aj+dM7GbRZ8+l4l6PK/osFjoPV59pkblM0J
        0LBiisC9co/p4Ph+3CzNqO1hDhW2X1I9i55IJVc5EFNbKDbiLa9NMtKZK4aiKSxkv60W69YTn51Gh
        3SelqDSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Z-00F0oZ-3v; Fri, 26 Mar 2021 15:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B32633079D2;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 877192BD9434A; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151300.259429287@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 15/16] objtool: Skip magical retpoline .altinstr_replacement
References: <20210326151159.128534163@infradead.org>
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


