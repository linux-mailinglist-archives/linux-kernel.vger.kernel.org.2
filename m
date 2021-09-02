Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AF3FEA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbhIBHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhIBHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:46:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9745C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWyeWhf2mGrN2JyJagjCdczw7UfMq2Y33Tl38uf/XAE=; b=LcI35W4nTS5b2bauCSKqpLDEjS
        qeHHb4v4We0nxD/n0cRywEl9iX7VJxBp8mW/qPDZsEvYd4WJdKMZv6FYvQppQrnA2+s8zeCDylyxE
        5SOaQUmgEHUagOXcHwLTTcFKuVok1RpEUMGYojo0cQScxYQN7OKjwjtWQzfrW/cSzD141g1QnRZFl
        YPhblpOiYslh8P3lhELdJmXDvf9yV9vhD1YhY8j9j3voy4x4l4Y3u1HjRNzLhB6v7OqWYWyMroMdO
        CXW7Jtllt5kwiOpkb1xh9fcXqYhmsaOO4IoIm0mhzp03+Sfm9zar4dLrRiZdwk73Ot05iLqkgf1KD
        bgXH3hUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLhOH-003EiA-VR; Thu, 02 Sep 2021 07:44:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EE2730024D;
        Thu,  2 Sep 2021 09:44:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10EE92D36BAD9; Thu,  2 Sep 2021 09:44:01 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:44:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/24] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Message-ID: <YTCAwVNHsnjAml49@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831204459.GM4353@worktop.programming.kicks-ass.net>
 <b2a74b43-2b87-9f81-2e50-ea31cbd614c6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a74b43-2b87-9f81-2e50-ea31cbd614c6@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:28:43PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2021/9/1 04:44, Peter Zijlstra wrote:
> > On Wed, Sep 01, 2021 at 01:50:01AM +0800, Lai Jiangshan wrote:
> > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > 
> > > Many ASM code in entry_64.S can be rewritten in C if they can be written
> > > to be non-instrumentable and are called in the right order regarding to
> > > whether CR3/gsbase is changed to kernel CR3/gsbase.
> > > 
> > > The patchset covert some of them to C code.
> > 
> > Overall, very nice! There's a lot of details to verify, but I really
> > like where this ends up.
> > 
> > I'm not sure about moving traps.c, but whatever, that's simple stuff.
> > I'll try and put some more eyeballs on this later.
> > 
> 
> Hello, Peter
> 
> How is it going?

Too much patches in the inbox, sorry :/

> Do I need to send a new version?

Not at this time.

> How can I cooperate or participate in the details?

What I meant was that review of these patches will have to check all the
details which will take some time.

> Do you plan to move the other path of ASM code into C code?

I do have some plans, but currently a total lack of time. Your patches
are a nice contribution.
