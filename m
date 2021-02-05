Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608C231178A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBFAAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhBENyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:54:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD161C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I/zCHB3AKYfLyGJDZRMfUipnBo+pZ650FjreQP9o/Ls=; b=abIPejy9up2Vky844BVmTHGjHX
        30IbnovW0HYic8QNYfYO0qMVgDV1MiiAmRLBgkmkT6ua9HLLiNdASUAqoR91OA2RnR2Mumaf3VHjI
        HvtZFLIMT8DIcxBsTMM/Hi3QO0xMvXrPFKxJbeBuiCvJW+aKjEbERuU6dYoq8ZW9rkqRGYc6PnPur
        e3p8/i3a2JcTM2/YPK6ygyWUahgqV6ojWNKM9aIzi0ld8Fz/NWdEi8Mb6RNWATio4Pd3UQXO4k3Ri
        ozkwtORh+IarZUJzF4iiuS8wu4QBDPwaGe+i+Q2uOCTvWkUSJdvgyPgmbU28GpnKsem7Ktm4ki1l7
        3Bc4ofPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l81Y1-002MW1-2J; Fri, 05 Feb 2021 13:53:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D0BD3013E5;
        Fri,  5 Feb 2021 14:53:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AB6320A0D644; Fri,  5 Feb 2021 14:53:17 +0100 (CET)
Date:   Fri, 5 Feb 2021 14:53:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 03/12] x86/irq/64: Adjust the per CPU irq stack pointer
 by 8
Message-ID: <YB1NzV4Zxfmu7PEH@hirez.programming.kicks-ass.net>
References: <20210204204903.350275743@linutronix.de>
 <20210204211154.410462790@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204211154.410462790@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:06PM +0100, Thomas Gleixner wrote:
>  Move the definition
> next to the inuse flag so they end up in the same cache line.

> -DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
> +DEFINE_PER_CPU(void *, hardirq_stack_ptr);
>  DEFINE_PER_CPU(bool, hardirq_stack_inuse);

Not strictly guaranteed they end up in the same line. If you stick them
in a struct and force alignment on the instance you'll have better
guarantees.
