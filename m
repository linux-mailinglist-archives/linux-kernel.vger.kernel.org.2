Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD836391A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhEZOZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhEZOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:25:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d1KiEETbdzs5kCt6ni0hp8RfLQ2hML7W4tsclFu6uvU=; b=JccLGrV4mRWengejtPg+BTJGg4
        HRNT003TarySCw7ZoeXHn+aRH4qMF52iB5hVgj4bsIdMABMkXVUU7V8V/oAHY5xR3Wpwqk+5f42Ev
        76jzrkAglOM2gG2vI4Sun+nmILMx1kZkZozVm3p2qY4oopFIY3qzLa3s1+5DPczQfoFzOsyE3VLYQ
        d+nr7bCqhFpqpjZH88iKN7W9qKqgb37En+T68S6zkLlCAhVc45JRs+iwIAyE05HecCgJkWgB189Tz
        azLyfPa7Ve21da/ponzEhW/uhoVZV3o5bCFxTHqleBF13dWGuYZMBRPBlxeumD1JENqUim6tNSzyG
        8wsp3Ocg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lluOA-004b5w-NV; Wed, 26 May 2021 14:20:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1232F30029E;
        Wed, 26 May 2021 16:19:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAE59201CF1A9; Wed, 26 May 2021 16:19:58 +0200 (CEST)
Date:   Wed, 26 May 2021 16:19:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        will@kernel.org, boqun.feng@gmail.com, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <YK5ZDtEDmwpxisH1@hirez.programming.kicks-ass.net>
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <YK4xQ/BtB4rItRr1@hirez.programming.kicks-ass.net>
 <CAPc5daVLg2jVEMW6eAZJQTK7YmMmReDNrNWPnLeX2nckbHhmfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPc5daVLg2jVEMW6eAZJQTK7YmMmReDNrNWPnLeX2nckbHhmfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:29:12PM +0900, Junio C Hamano wrote:
> > On Tue, May 25, 2021 at 03:01:59PM +0100, Mark Rutland wrote:
> > > Note: I've generated the patches with:
> > >
> > >   git format-patch -C -M -D
> > >
> > > ... so the preimage of include/linux/atomic-fallback.h is not included
> > > in the diff when it is deleted.
> > ...
> > Junio; can we get something like the below sorted?
> 
> Funny, I recently looked at "git format-patch --help" and read that "-D"
> is explicitly described as "The resulting patch is not meant to be applied
> with patch or git apply; this is solely for people who want to just
> concentrate on reviewing the text after the change."

Yeah, I read that too; but like I said, I feel strongly that anything
generated by git-format-patch should be accepted by git-apply (albeit
with a --do-what-I-want argument, I agree that -D output should never be
applied without express permission).

> So, no, I think it is anti-social to send such a patch generated with -D
> unless it is purely for discussion. The side that generates the patch
> should be told to drop "-D" when running the format-patch command,
> or perhaps format-patch should be taught to error out when "-D" is
> given, perhaps?

Removing -D from git-format-patch works too, although I rather like not
seeing the '-' for the entire files. I really don't care much for the
reversible thing, I already have the content, I can zap the commit to
get it back.


I'll leave it up to you, either remove -D from format-patch, or add an
option to apply to force accept it.
