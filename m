Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822CF41C0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhI2IrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbhI2IrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:47:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SWfsDGnM1C3CzjYVVIpW+X+APIBjSBls1Qn80oZJaMM=; b=QSZWAFYBMsPqV9bOwtNhxNqYoh
        RiRM38zOzxy6+13pI+shgTZsyCL1ZpiOEG8lRkAnJkceKel7RGnafEkwAD+Og9/MF3yvFnay823ek
        MgIu8pgHnMW9J5aAqRV5jT2dHYO7gc6nqKYqpKiKFN9oQn28Wn4Z4QKRJJvkNA7inusA+3yMhXZIt
        hPu8z8ha3d8jx7O2cEXNnlyGXDhiM/jeby8+DqRoVXLuOCHp1by1EIWzmE5SCpjvDeKntN7boI30f
        vr9IKAv3dzpTkQ0DD+jGamaGdUEUUIHY3TdpNPOCAiS2uhhv9ipeK7F0Zw0cBvnzWzdiVBVoiAlqb
        8zqlnszg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVVDL-006fxP-6E; Wed, 29 Sep 2021 08:45:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19283300056;
        Wed, 29 Sep 2021 10:45:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8DF32DC92D13; Wed, 29 Sep 2021 10:45:17 +0200 (CEST)
Date:   Wed, 29 Sep 2021 10:45:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH V2 16/41] x86/entry: Implement the whole error_entry() as
 C code
Message-ID: <YVQnnerXMGO6PPDZ@hirez.programming.kicks-ass.net>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-17-jiangshanlai@gmail.com>
 <CAMzpN2iubB2suZVT3r9f4_T5mkqt4Kgb4GaS0o=MD8NY6qaDtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iubB2suZVT3r9f4_T5mkqt4Kgb4GaS0o=MD8NY6qaDtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:34:02PM -0400, Brian Gerst wrote:
> On Sun, Sep 26, 2021 at 11:13 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > +asmlinkage __visible __entry_text
> > +struct pt_regs *error_entry(struct pt_regs *eregs)
> > +{
> > +       unsigned long iret_ip = (unsigned long)native_irq_return_iret;
> > +
> > +       asm volatile ("cld");
> 
> The C ABI states that the direction flag must be clear on function
> entry and exit, so the CLD instruction needs to remain in the asm
> code.

Right, also, one of my pet peeves with out entry code is that CLD and
CLAC are not next to one another.
