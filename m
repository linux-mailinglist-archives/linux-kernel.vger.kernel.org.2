Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203B844B2E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbhKIS4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbhKIS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:56:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC5C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8iCLiLBN5Xl0oh6P9wFFDC6J3HOu+dEV+gfu75yUkRU=; b=glI9A+YbXxeP7aTXB5FSORb8sj
        x5fa1qgHtI54Fk/tFGb355mhXOT4wPyD94aUM7HAG6PVqjFf8qFxu/4hWRTjKizux3OFlzkKQqaRH
        uaBlMxwp4vPom7mnR7lPVz9A7dAQN1FKTKTFrUpO4gR9tf6AOzWWj7MGsDBF/Gpqf9i9PiauRL19F
        ID8ycUBo09dEZ0ZxXmoiHUO3A9zcJAdMzCwux3MKV8eyGW4xfFHfvfdJQSuNHp6bOowFLyi2e8GmP
        6uV1buJR4byykdQM5MVM4q9E5EzJj0uUKBsDttJ2ttm+PQBEOVMd2wMuRudC8gCkE4Z8ZeggOAZyV
        oFoC1aRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWEz-00F74y-IF; Tue, 09 Nov 2021 18:53:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32A173000DD;
        Tue,  9 Nov 2021 19:53:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20119212EE599; Tue,  9 Nov 2021 19:53:05 +0100 (CET)
Date:   Tue, 9 Nov 2021 19:53:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 3/7] static_call: use helper to access non-exported
 key
Message-ID: <YYrDkUsJVcOzxMPL@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109164549.1724710-4-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:45:45PM +0100, Ard Biesheuvel wrote:
> @@ -196,13 +190,21 @@ extern long __static_call_return0(void);
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
>  
> +#define EXPORT_STATIC_CALL_GETKEY_HELPER(name)				\
> +	struct static_call_key *STATIC_CALL_GETKEY(name)(void) {	\
> +		BUG_ON(!core_kernel_text(				\
> +			(unsigned long)__builtin_return_address(0)));	\
> +		return &STATIC_CALL_KEY(name);				\
> +	}								\
> +	EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))

So if I were a nevarious module, I would look up the above symbol from
kallsyms (it is exported and easily obtainable) and then simply
read the text to discover the key address and we're in business.

