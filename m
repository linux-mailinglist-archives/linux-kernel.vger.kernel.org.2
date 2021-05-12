Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2F37B89D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhELIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhELIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:53:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABDCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/MqLJ4rj5L9md7sMeoP8AyNO73HQlye6pz1itww7fL0=; b=VH7QEH+8UXpc3iQM9a9fSnn8j9
        ydrqlOcHTf/nuBBN6RYNYWugp5wJry3Pq3ucdVgzZHOXD5owD43L8bVJkWC/n8dZPrD7OPlT41by0
        qOtDPCblF2WKGl8eruNFA3LckTJmeynOg7tPf9jtkMRbeDWZ0ycfH0wyQJpK/wrFLA5y9TV/mP5xF
        DHv200DgV9vIiybbWAI6SNzleG0yHr2ZJOZjro0EGefQT7A37crZm1UI40x1fdVnm+Y3C/WmhMRel
        Q/Hf325Ekd4sVcQcM5USRQmiKZA1Y1vNzgHVYf2UonpMatEb8D7v20dR1r3nhjcUQA3z1lNISxtLF
        +QcoHrYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgkZ6-0086jG-0Y; Wed, 12 May 2021 08:50:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76E3C3001E1;
        Wed, 12 May 2021 10:49:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D35B29CB9DBF; Wed, 12 May 2021 10:49:59 +0200 (CEST)
Date:   Wed, 12 May 2021 10:49:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [patch 1/2 v2] x86/cpu: Init AP exception handling from
 cpu_init_secondary()
Message-ID: <YJuWt16izc2toXIM@hirez.programming.kicks-ass.net>
References: <20210507110210.147106915@linutronix.de>
 <20210507114000.429303187@linutronix.de>
 <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com>
 <87wns8ko48.ffs@nanos.tec.linutronix.de>
 <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:29:25PM +0200, Thomas Gleixner wrote:
> +#ifdef CONFIG_SMP
> +void cpu_init_secondary(void)
> +{
	/*
	 * Relies on the BP having set-up the IDT tables, which
	 * are loaded on this CPU in the below
	 * cpu_init_exception_handling().
	 */
> +	cpu_init_exception_handling();
> +	cpu_init();
> +}
> +#endif

Or something along those lines? It took me a little to figure out why
start_secondary() didn't have idt_setup_traps(), hopefully something
like this will avoid a little future confusion.
