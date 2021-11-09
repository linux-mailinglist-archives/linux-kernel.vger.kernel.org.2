Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C37044B2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhKISl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKISlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:41:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B25C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w6en2TS9VFucr6MTK57MquaaP3KtEpQd7lErMapeABw=; b=TNFmVtEPT6gRPBu0bAB2XDKhhP
        Y11jzmG73/nbOOeRgq2a1LzhEtnMW4BdYBLzhPwfFrlf42hsPDIC7zx8OBLlBPQJw5c99vtoXx1R3
        5tRw37y9tiVgCnlQAuCy5OBd1aN4VqHCH0yUbACR7Zjq41TVjfUEAGvajADyv6xdNLCA4oW36g8Bq
        pGpzsLQJ/z+T7+DYtxSQS+mQZCSIyW9+arim+55EEcb3gvs5Cqho7how28N/NgnYjrVWXQbFjvHs9
        ZQzQOCl9WZU0U4LVIXHaPDesUAQzQk8oopIrai2QYl0uF1dySKK3B0Arnn84AfrHsXRGuLU3Rx0yA
        O+DANq1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkW0k-00F6wc-GS; Tue, 09 Nov 2021 18:38:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 572C030031C;
        Tue,  9 Nov 2021 19:38:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 364222082F4DD; Tue,  9 Nov 2021 19:38:20 +0100 (CET)
Date:   Tue, 9 Nov 2021 19:38:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/7] static_call: get rid of static_call_cond()
Message-ID: <YYrAHMy8xmPXj4ql@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109164549.1724710-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:45:43PM +0100, Ard Biesheuvel wrote:
> The main reason for the existence of static_call_cond() seems to be that
> in theory, when using the generic implementation of static calls, it may
> be possible for a compiler to elide the indirect call entirely if the
> target is NULL, while still guaranteeing that all side effects of
> argument evaluation occur as expected.
> 
> This is rather optimistic: as documented by an existing code comment,
> both GCC and Clang (version 10) get this wrong, and even if they ever
> get it right, this is far too subtle to rely on for a code path that is
> expected to be used only by the 'remaining' architectures once all the
> best supported ones implement either the out-of-line or inline optimized
> variety of static calls.
> 
> Given that having static_call_cond() clutters up the API, and puts the
> burden on the caller to go and check what kind of static call they are
> dealing with, let's just get rid of the distinction.

No, static_call_cond() signifies the function can be NULL. Both gcc and
clang generate correct (but wildly ineffecient) code for this. Without
static_call_cond() the generic implementation will do a NULL deref.

That is, static_call_cond() does properly encapuslate:

	func = READ_ONCE(key.func);
	if (func)
		func(ARGS);

You can't take that out.
