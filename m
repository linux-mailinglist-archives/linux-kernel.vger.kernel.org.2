Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF06A3ABC48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhFQTGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhFQTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:06:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vVaHhLYxwi6Ws7Ki0VW+OefW3LQYYuxxKswRFgEbC7Y=; b=YKvv/p/NKK47uxKXdxKdKqHvz0
        GxubdRA+qtvrgBDD0O21j12AUdUVzZal91EFdaT3EFEwiM0v4Rjg0Vu2HgjqOIS7bwOgzV7fOIqJY
        a1XcKuvpNAbcNwGsFsh6gZqfkHlN4WVUM+MndiD6h5p2biwp9DcVoL/5ILqovRJnqPuG4nA+Y37OV
        e8mBApm9EMN+n0AnE4FSeE+5jCs8zQypGgjY/ROpJHHR/z/yrZ8lSe7zNLQDN/R2qOpp62S7zgeXq
        95nvslsB4Zv2t3v6OuqAViXWsSfNgrMIadkpzpbIw1eRhZbpiR4k3iEgzaWjkNlvB+EwsGshMpkGz
        guksz24w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltxIa-008uZb-78; Thu, 17 Jun 2021 19:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76A9E300306;
        Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 56A6220244CE2; Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Message-ID: <20210617190313.256987481@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Jun 2021 20:57:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, bp@alien8.de, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 1/3] lockdep: Fix wait-type for empty stack
References: <20210617185717.486456641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even the very first lock can violate the wait-context check, consider
the various IRQ contexts.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4577,7 +4577,7 @@ static int check_wait_context(struct tas
 	u8 curr_inner;
 	int depth;
 
-	if (!curr->lockdep_depth || !next_inner || next->trylock)
+	if (!next_inner || next->trylock)
 		return 0;
 
 	if (!next_outer)


