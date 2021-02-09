Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356ED31588A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhBIVVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233410AbhBIS45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:56:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9D7A64E7C;
        Tue,  9 Feb 2021 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612896316;
        bh=GtmYHHEcqdc1UDShBy9Mlu65hB49cZakKnpnx2Og2eQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aP06nY6YiMDXRIS38tSvtTFV3YBFhASWUaeMt0wV7bsUISO1KRF7YPBwEtxI+jImq
         Oo+t2pdYIgktk2hCzRPdzSufB5ybOpG67+SSggtzUmLn4rXV9KRJv1YFGQFt+f6hxv
         RmTEse/HAUq8eITtewK4JuF7VDBZ8cI7dGiz9HGY=
Date:   Tue, 9 Feb 2021 10:45:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] arm64: kasan: fix MTE symbols exports
Message-Id: <20210209104515.75eaa00dea03175e49e70d6c@linux-foundation.org>
In-Reply-To: <20210209170255.GG1435@arm.com>
References: <dd36936c3d99582a623c8f01345f618ed4c036dd.1612884525.git.andreyknvl@google.com>
        <20210209170255.GG1435@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 17:02:56 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Tue, Feb 09, 2021 at 04:32:30PM +0100, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index a66c2806fc4d..788ef0c3a25e 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -113,13 +113,17 @@ void mte_enable_kernel(void)
> >  	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> >  	isb();
> >  }
> > +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> >  EXPORT_SYMBOL_GPL(mte_enable_kernel);
> > +#endif
> >  
> >  void mte_set_report_once(bool state)
> >  {
> >  	WRITE_ONCE(report_fault_once, state);
> >  }
> > +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> >  EXPORT_SYMBOL_GPL(mte_set_report_once);
> > +#endif
> 
> Do we actually care about exporting them when KASAN_KUNIT_TEST=n? It
> looks weird to have these #ifdefs in the arch code. Either the
> arch-kasan API requires these symbols to be exported to modules or not.
> I'm not keen on such kasan internals trickling down into the arch code.
> 
> If you don't want to export them in the KASAN_KUNIT_TEST=n case, add a
> wrapper in the kasan built-in code (e.g. kasan_test_enable_tagging,
> kasan_test_set_report_once) and conditionally compile them based on
> KASAN_KUNIT_TEST.

In other words, the patch's changelog was poor!  It told us what the
patch does (which is often obvious from the code) but it failed to
explain why the patch does what it does.

The same goes for code comments, folks - please explain "why it does
this" rather than "what it does".

