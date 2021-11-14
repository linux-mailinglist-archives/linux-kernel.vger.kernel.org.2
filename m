Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3944F77F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhKNLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:06:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1805C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z4pb/q5WgzKp3O7V0dr54vhOCfkxXb5Az2jqqP0Xiko=; b=f0+jelTn9oeSSBhhI6TJtU0war
        vgZd6AIX5xMvQkL53wgjvVcDqdr4RecGu9SQNTbOP08IGsTQgubLkCXDpakxPFU0wz7btfRsNnYTo
        OeQQ6UdaUnZW6rp4S62qjvNSDuaqxlvqGVG5pmg7ceJ96zyr+5+bdEmVlHEfvXg5EXwrz1qWZg3nv
        Nnceq4a5hMYqXMntz7aI1PhdORMG/qmoXy+kFwdN5+tJhM/7GxsYkRHPwZrjzQka3hIwcQZpzCdt4
        Z3RWbaHBnvJVkBT85em0xQeQIl7lQsU/cRK9/LCtKBqiRbQ5wY1tliQtdzP18Kj/Xz54gwK5r8uD2
        jI/dICpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmDHt-004v9m-LY; Sun, 14 Nov 2021 11:03:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E899981659; Sun, 14 Nov 2021 12:03:06 +0100 (CET)
Date:   Sun, 14 Nov 2021 12:03:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Message-ID: <20211114110305.GN174703@worktop.programming.kicks-ass.net>
References: <20211113124035.9180-1-brgerst@gmail.com>
 <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
 <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:54:19PM -0500, Brian Gerst wrote:
> On Sat, Nov 13, 2021 at 8:18 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> >
> >
> > On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
> > > The per-cpu section is currently linked at virtual address 0, because
> > > older compilers hardcoded the stack protector canary value at a fixed
> > > offset from the start of the GS segment.  Use a standard relative offset
> > > as the GS base when the stack protector is disabled, or a newer compiler
> > > is used that supports a configurable location for the stack canary.
> >
> > Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.
> 
> This patch probably makes more sense if we drop the fixed model, as
> that gets rid of alot of code that works around having to link the
> percpu section differently.

Can someone spell out these benefits please? To me having per-cpu start
at 0 makes perfect sense, how does not having that make things better?
