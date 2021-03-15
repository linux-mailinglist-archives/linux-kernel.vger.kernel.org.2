Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1533C19B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhCOQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhCOQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E70C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dATR+l/9OxpL8ldkODQxrNOVyD7GPAsYjw7FnqDxdJQ=; b=KD7LoKorI1XcbDqRY3XGRkUMXw
        1rYQN+Nd3STXiXcoT/vw8069YcpVZnCYfFywbY95hvyIwhhl4QCAaxVu1TPMg/ToqqIiAez/q+mZ7
        5AJBTYCAMscP31d9KnaCvwto+l/9jJ+Ks+VYwEq632vu6K4urzY/6tl3LLqXiYVoVAAw6nW6YqW7M
        aIPOkHN75Y3coldiCFAZdzGXK/BUDcvJXNy7l6q3DxSZbeFgbNM+beMu7BiD66qUzbkRGv8Np7Vd5
        u9PpnmqWOhY7Wk1M7FfQ+b1mnee+72eOP3IgMhmb4kuazo35zXTiuxWLHvxkuwIYGnph26upOFdwH
        X5zGVt9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLpzj-000Ql7-SU; Mon, 15 Mar 2021 16:23:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DC93301324;
        Mon, 15 Mar 2021 17:23:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16421202C6091; Mon, 15 Mar 2021 17:23:03 +0100 (CET)
Date:   Mon, 15 Mar 2021 17:23:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86/alternatives: Optimize optimize_nops()
Message-ID: <YE+J56MHUcSOyTTb@hirez.programming.kicks-ass.net>
References: <YE+BFIil8wj+q8Qi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE+BFIil8wj+q8Qi@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:45:24PM +0100, Peter Zijlstra wrote:
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -345,19 +345,39 @@ recompute_jump(struct alt_instr *a, u8 *
>  static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
>  {
>  	unsigned long flags;
> +	int nops = 0, i = 0;
> +	struct insn insn;
> +	u8 *nop = NULL;
> +
> +	do {
> +		kernel_insn_init(&insn, &instr[i], MAX_INSN_SIZE);
> +		insn_get_length(&insn);
> +

I suppose you'd like to see that replaced with something like this,
rite?


--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -350,8 +350,8 @@ static void __init_or_module noinline op
 	u8 *nop = NULL;
 
 	do {
-		kernel_insn_init(&insn, &instr[i], MAX_INSN_SIZE);
-		insn_get_length(&insn);
+		if (insn_decode(&insn, &instr[i], MAX_INSN_SIZE, INSN_MODE_KERN))
+			return;
 
 		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90) {
 			if (!nop) {
