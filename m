Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE60342172
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCSQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:05:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:05:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616169927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=106TxHLyAtVBuDkUwRrxGzFn3N3YZC0Oy6JLDXxkcVM=;
        b=n6uGhy4oFLlNYqoTAK0NnbF6MwaJDk9Uo9SiCgbud5ITjJvKDa7FN9znEu5CI2G2nNszX2
        EPFOhJA6EWqKAs0/3yIuIHDR2T670qEFLXxg8nZHYtgDnfF95a7P5NL96sRYPbDuNsgrXF
        AXJXplX08ASDvMgDdR9PH+taDshX8vMeXJhRpf6aMmbmFi3vwu0MbiwYENHRENElwK/HeQ
        Cs8LabpHheH1VybxTD28GLAdRWKe6tf/Fhe0BkafEqABQ3shDiAkcAu1vjFBMlcFv0OiLV
        AQ6ALunNdaYo49UJlF/5tG9uD1U7v+fyGx7cZIntixvcFx7U1bMEkBZGxZZ1zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616169927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=106TxHLyAtVBuDkUwRrxGzFn3N3YZC0Oy6JLDXxkcVM=;
        b=slKqoBUYD3EXzUUzx4Zqmba+Ip1ao4FJsSAQ60pplrT1XwRrgSLRtxr8AsUX11L+Znxxu/
        8HqnthuPOzKNJ0CQ==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 3/9] x86/entry: Convert ret_from_fork to C
In-Reply-To: <f7ed7fa5b222afa2d2820e1d8c83fdc3fdd57af2.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org> <f7ed7fa5b222afa2d2820e1d8c83fdc3fdd57af2.1616004689.git.luto@kernel.org>
Date:   Fri, 19 Mar 2021 17:05:27 +0100
Message-ID: <87v99n5dtk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:

> ret_from_fork is written in asm, slightly differently, for x86_32 and
> x86_64.  Convert it to C.
> +__visible void noinstr ret_from_fork(struct task_struct *prev,
> +				     int (*kernel_thread_fn)(void *),
> +				     void *kernel_thread_arg,
> +				     struct pt_regs *user_regs)
> +{
> +	instrumentation_begin();
> +
> +	schedule_tail(prev);
> +
> +	if (kernel_thread_fn) {
> +		kernel_thread_fn(kernel_thread_arg);
> +		user_regs->ax = 0;

If you replace this with:

   syscall_set_return_value(current, user_regs, 0, 0);

then it's architecture agnostic and can move to kernel/entry, no?

Thanks,

        tglx
