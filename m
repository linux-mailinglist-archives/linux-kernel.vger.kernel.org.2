Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B159836B349
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhDZMlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhDZMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:41:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TRdEA94ZdhMo/6RApbudBekxefiDgCx+6J5g2PdXH4M=; b=SXXQ7MEls1rxUUukRaqj5tuilg
        20fQsDjwOrbxG42KiTS29OxS5UU3RpNUkDvFf8zA32XSgOLu9GJDD1U7S1Fn6IkMCbGQBPeiaff2U
        pXinHSUOtlB2v4FNiKPDJhL2M1jlNO8ESkwlZqsBCg+ptBOaz/L23+ClfhWqCoxTMRqugzAp4BnSP
        /3XN5vaTAHvcAraktb5rglgGEA4x18usHb7GwHyvgXviblBUN/obXqFbuPN3+ujcj89XgG9JnNn0d
        4a9WBr3r5D0nQquv7h8Z/LfySY1W5jDxbAGskgHpSV3+QXEsIOUJANlsgiOts85WAQgRe2g03vQIT
        sfpCwxMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb0X3-005c5S-OU; Mon, 26 Apr 2021 12:40:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58C473001D0;
        Mon, 26 Apr 2021 14:40:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E7B62D1F890B; Mon, 26 Apr 2021 14:40:09 +0200 (CEST)
Date:   Mon, 26 Apr 2021 14:40:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in
 __hrtimer_start_range_ns()
Message-ID: <YIa0qWdxM7vIsf/4@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com>
 <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
 <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de>
 <87v989topu.ffs@nanos.tec.linutronix.de>
 <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
 <87sg3dtedf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg3dtedf.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 02:33:00PM +0200, Thomas Gleixner wrote:

> >> +	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> >> +	force_local &= base->cpu_base->next_timer == timer;
> >
> > Using bitwise ops on a bool is cute and all, but isn't that more
> > readable when written like:
> >
> > 	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases) &&
> > 		      base->cpu_base->next_timer == timer;
> >
> 
> Which results in an extra conditional branch.

Srlsy, compiler not smart enough?
