Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735EE44B34A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbhKITfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbhKITfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:35:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD0C06120B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6q8o/4Pkkcqnzs9b9O2zsqdgubB0fcTVKR8hrr53nDc=; b=kk3EVhy9UUxRRrN11k4L21uxpj
        UVHGtyDqnm5clQjHGudLAhYcuwUsgUkYFAAVAWXGWYiL6CU79Y+K/qKTrzhDoP6tZA6JeqBiuq3uZ
        2CBABtVWk0FCq520AbJydDEJ6XEoX/3H0L2wAEFqwLRFMPhO4IPdJ/C5qU6mOe4ZeQPFad7Kjl26Z
        uqslipsFl8/XZYKVgaT6KMqZ7++/rjsdgykqcNIo7JHrdTHJ/FmA/WmCoIzGI+OxodxK0UhEWfX/u
        5te8+sda545OXivI+FBlGHiuOMmt6Tj6303R9JNIyGVVRt/UFvoDuPxS2dwPoQfRuUdGLJGM/+mgX
        l7zL0uDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWrB-00F7LI-A8; Tue, 09 Nov 2021 19:32:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5D4A3001C7;
        Tue,  9 Nov 2021 20:32:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 893D02C525D31; Tue,  9 Nov 2021 20:32:32 +0100 (CET)
Date:   Tue, 9 Nov 2021 20:32:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/7] static_call: get rid of static_call_cond()
Message-ID: <YYrM0JLelRacIXHN@hirez.programming.kicks-ass.net>
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
>  static inline
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
> +	WRITE_ONCE(key->func, func ?: (void *)&__static_call_nop);
>  }

Ha, yes, I suppose that ought to work.
