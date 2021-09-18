Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E96941050E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbhIRIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhIRIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:15:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E746C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=syg0jllxOWb71JYT6IjtkO1x6INArKhmg1fRSz5VN7Q=; b=uZ9ZMUyQKCEz/3X2T3ohI+RWrC
        ZICG/LNZNobRL+EIM81FN+4hbEq2bAzkIS4aGtK5oeWW3kbN2x8hgCxX5alFD8CTBIREL/qnSZjOU
        W6dIYjcVxtZq1LBAQLSn+DaFJy596qMoemcCjSfXCuAF1k0UFNoz7zy8emMS8vXV+KKXbdu1qC+4z
        EctF/CeHeN9l6ZRnXFHM+XTIVq9LJCc+VDqelGZR96ZwVGdhFR/6HFxHYO1705+fVjleVd5kLkuuI
        E1f5S0yWEIe3768qeMyxwx7kovly9K2VSXtP664fXCjDxHpTsgqxXDVjUCRBGE3geaJW11BdtD4Ch
        SA21LClA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRVSl-000zJ6-50; Sat, 18 Sep 2021 08:12:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53EC8986249; Sat, 18 Sep 2021 10:12:42 +0200 (CEST)
Date:   Sat, 18 Sep 2021 10:12:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     cgel.zte@gmail.com
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Add exception handling
Message-ID: <20210918081242.GK4323@worktop.programming.kicks-ass.net>
References: <20210918074718.240511-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918074718.240511-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 07:47:18AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>

That's not the email address this email is from: cgel.zte@gmail.com

In fact, I seem to get a lot of email from cgel.zte@gmail.com claiming
to be from different authors. This cannot be right.

> If the type is abnormal input from argument, the code will be NULL.

This is incorrect, in that case @code is uninitialized.

> So it should return as default;

That reasoning escapes me.

Also, there's exactly two callsites to __static_call_transform(), both
take their .type argument directly from __sc_insn(). Please explain how
the value can be out of range.

I'm thinking you're:

 1) not understanding the code (or necessarily even C)
 2) working on the suggestino of some broken automation

Please, go pester other people. I'll go block all email from
cgel.zte@gmail.com because it's not a single person and the quality of
patches is below par.

> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  arch/x86/kernel/static_call.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index f608e6710300..696da3eccf28 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -45,6 +45,8 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
>  		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
>  		size = RET_INSN_SIZE;
>  		break;
> +	default:
> +		return;
>  	}
>  
>  	if (memcmp(insn, code, size) == 0)
> -- 
> 2.25.1
> 
