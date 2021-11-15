Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A289451C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhKPALG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353255AbhKOUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:55:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7AEC061229
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v0cEKznz+bdKQmpgmLdrTxblJ+4rLf7n2JRdMFbmYIA=; b=dDXa5A8mOv3QGPKTbyNFns0pVI
        RJi2uapzXC8P26skt/z0PIC9AIOYLN2mqKoInVgsHlxDnOaRL6/4S8aBJ6+iPjek1YITjM2HnJLsq
        D+S1+1XFkvsz2qNFec0ccAbphkaPRV9pBUeY5Nv0IjJhL8Mvu2LxeCNz1HEnqHbx0UDQov+1wi25Y
        UM992PCWN9vlZRtQBxENWJdB02pTnmsIEG69W/IOX1NBOyIOnBdAZMCo+FKtQ+eAPDh1BB1PlWsTt
        dHZk9TZtXvtItCisLrQouyS8zEeYnNDvssqaQOqLxXzPjToKLNKW3Ekk+6S7juclzRDu+31EbuLeP
        0bJCp/6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmiqC-00GCDF-TY; Mon, 15 Nov 2021 20:44:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3E22986687; Mon, 15 Nov 2021 21:44:35 +0100 (CET)
Date:   Mon, 15 Nov 2021 21:44:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Message-ID: <20211115204435.GP174703@worktop.programming.kicks-ass.net>
References: <20211113124035.9180-1-brgerst@gmail.com>
 <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
 <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
 <20211114110305.GN174703@worktop.programming.kicks-ass.net>
 <CAMzpN2jWs8heND7PydKw9CCZ0cjvJgxLMwXXQj45rwR6twpJLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2jWs8heND7PydKw9CCZ0cjvJgxLMwXXQj45rwR6twpJLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 01:29:46PM -0500, Brian Gerst wrote:
> On Sun, Nov 14, 2021 at 6:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Nov 13, 2021 at 11:54:19PM -0500, Brian Gerst wrote:
> > > On Sat, Nov 13, 2021 at 8:18 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > >
> > > >
> > > > On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
> > > > > The per-cpu section is currently linked at virtual address 0, because
> > > > > older compilers hardcoded the stack protector canary value at a fixed
> > > > > offset from the start of the GS segment.  Use a standard relative offset
> > > > > as the GS base when the stack protector is disabled, or a newer compiler
> > > > > is used that supports a configurable location for the stack canary.
> > > >
> > > > Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.
> > >
> > > This patch probably makes more sense if we drop the fixed model, as
> > > that gets rid of alot of code that works around having to link the
> > > percpu section differently.
> >
> > Can someone spell out these benefits please? To me having per-cpu start
> > at 0 makes perfect sense, how does not having that make things better?
> 
> The best reason is that the percpu section is currently not subject to
> KASLR.  It actually needs extra support to counter the effects of
> relocation.  There have also been a number of linker bugs over the
> years that have had to be worked around.

I'm confused.. having the variables 0-offset is related to KASLR how?
The dynamic placement of per-cpu thunks and their base address in %GS
gives plenty opportunity to move them around at boot time, no?

> If we were to decide to drop the fixed stack protector the diffstat
> would look something like:

Dropping the fixed stack protecter seems fine to me; I just don't see
why we should move away from 0-offset.
