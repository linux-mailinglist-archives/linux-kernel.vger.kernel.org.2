Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1846E37B836
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhELImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:41:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA44C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aCbHCS/vOTKYin2zVWEkVMKtygd54jsqUMQnCeOW+uc=; b=mODRj1LgtJLzzvrYKwVvo6YQmv
        H1xn8XO1ggz/R6cI7fhVQ0b8uRtAE7Stn1jf8kKKoXCaIGUJnNbrL9egNfRgRr3UP2yoL+iECBrxA
        KQTCWrhyCTHXEV7l0AUCOz6jiXZhdr6VB96cgpTEM2D45cyuB5CygI0O5lfbQ7vNwuyWHFzo4j4aQ
        dBgAw392tEl7Gw5WtrCjRZwHQUWoS02KFnojLtAksh8CwgVKKTXQpa/N86pijUquhumtTM2kgN4rE
        95eJeaQHwuEDt7fNjNCKti2NnYLQTYkMe+kDLQGADqOXrtkSYm/bGVaWShxHbKM9+Uvhzx+9RJazC
        el2itSWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgkN9-0086NA-34; Wed, 12 May 2021 08:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ED2E300242;
        Wed, 12 May 2021 10:37:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 761162BA8A549; Wed, 12 May 2021 10:37:37 +0200 (CEST)
Date:   Wed, 12 May 2021 10:37:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [patch 1/2 v2] x86/cpu: Init AP exception handling from
 cpu_init_secondary()
Message-ID: <YJuT0XfLAlkM6BZM@hirez.programming.kicks-ass.net>
References: <20210507110210.147106915@linutronix.de>
 <20210507114000.429303187@linutronix.de>
 <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com>
 <87wns8ko48.ffs@nanos.tec.linutronix.de>
 <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
 <d5a7434c-9205-b6c6-c7ad-423e7050bc62@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a7434c-9205-b6c6-c7ad-423e7050bc62@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 05:25:35PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2021/5/11 05:29, Thomas Gleixner wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > SEV-ES guests require properly setup task register with which the TSS
> > descriptor in the GDT can be located so that the IST-type #VC exception
> > handler which they need to function properly, can be executed.
> > 
> > This setup needs to happen before attempting to load microcode in
> > ucode_cpu_init() on secondary CPUs which can cause such #VC exceptions.
> > 
> > Simplify the machinery by running that exception setup from a new function
> > cpu_init_secondary() and explicitly call cpu_init_exception_handling() for
> > the boot CPU before cpu_init(). The latter prepares for fixing and
> > simplifying the exception/IST setup on the boot CPU.
> > 
> > There should be no functional changes resulting from this patch.
> > 
> > [ tglx: Reworked it so cpu_init_exception_handling() stays seperate ]
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 
> For both patches:
> 
> Reviewed-by: Lai Jiangshan <laijs@linux.alibaba.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
