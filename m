Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313AC3983FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhFBIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhFBIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:22:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CDC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BOYTXHsr3/NGHIkPpWFO5gwA9QGF5Yb1FGgPaFrZlcw=; b=OWONBN/K8i+KtZkz9jUUxv9GY6
        WDYXwB6PD1JVmqajD2V+XAbzKv3uTyQ+zAyC5kPZdynuiXb+jJ6FNwaP1w1SkiJnepySkOCYWKV+z
        a1+Bm1lUbNic7jWGz3d5cOoXlL/BZ27yqIy3elFnQcQJfSVfSqd8bzeDnb2XHoB2nFB51whCNvqFh
        OwlWvHql6JduHjkA6wxU3Vez8ht9QWyhUeCOu6R396/MWCJFQp6Z6p9yeXufOAi1BnQAjkOtjykTV
        Mr8u+Qgeh4kR5hcl7K5oACt22QfqxhU25DCKEExpNUun9GOGqCjkRp5M/KMFByjvyO3xXI07F3FsP
        i2tVfTmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1loM6r-00Ashr-Bb; Wed, 02 Jun 2021 08:20:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 059C7300299;
        Wed,  2 Jun 2021 10:20:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E01CC2016D6C1; Wed,  2 Jun 2021 10:20:16 +0200 (CEST)
Date:   Wed, 2 Jun 2021 10:20:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/alternative: Align insn bytes vertically
Message-ID: <YLc/QIpcfjHUoOgf@hirez.programming.kicks-ass.net>
References: <20210601193713.16190-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601193713.16190-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:37:13PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> For easier inspection which bytes have changed.
> 
> For example:
> 
>   feat: 7*32+12, old: (__x86_indirect_thunk_r10+0x0/0x20 (ffffffff81c02480) len: 17), repl: (ffffffff897813aa, len: 17)
>   ffffffff81c02480:   old_insn: 41 ff e2 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>   ffffffff897813aa:   rpl_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3
>   ffffffff81c02480: final_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Nice!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
