Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9252449BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhKHSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKHSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:32:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208DC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8SvWCxF6YP5deSRk56JWdPo+l/wRq+UgjhyU+HeS6iM=; b=jSnO5krnK0Ews06CMKQpPfZOPK
        CEsfVq55MNDBFH4TzmN/thrD4lcoOTdyeom0PCUXwBqwvPNhBSzlDVPcdPg5sFuQfzcPqd2p0yVem
        Y3p+ZyqbDOD9wV1OLCa6Bf/YuusyF3bJoMLQTGLn1jGJAUEuWiireXvdWfokj4qiFUgF3LfCNCrRw
        DtHicwzOL9fvx+Sh84yq7H7PKTv5vxfcbqzknaI8mLmChMJS7NzVHUUYP43WEhr5oNft/hEB/7UDQ
        agvmAVTUp5cABo5+fcfWAuOSa2rscAOUpQ/FmmAvsSlgDrCL3l1LMHYiCqD9ZrNt146kplLAD6Zvq
        G90wUImg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk9Oa-00EvEG-45; Mon, 08 Nov 2021 18:29:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDC9230022C;
        Mon,  8 Nov 2021 19:29:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D24921BE9687; Mon,  8 Nov 2021 19:29:26 +0100 (CET)
Date:   Mon, 8 Nov 2021 19:29:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, ndesaulniers@google.com
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108164711.mr2cqdcvedin2lvx@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 08:47:11AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > +{
> > +	unsigned long offset, data;
> > +	unsigned long ret;
> > +
> > +	asm_volatile_goto(
> > +		"1:	mov %[mem], %[ret]\n"
> > +
> > +		_ASM_EXTABLE(1b, %l[do_exception])
> > +
> > +		: [ret] "=&r" (ret)
> > +		: [mem] "m" (*(unsigned long *)addr)
> > +		: : do_exception);
> > +
> > +out:
> > +	return ret;
> > +
> > +do_exception: __cold;
> 
> Clang doesn't approve of this label annotation:
> 
> In file included from fs/dcache.c:186:
> ./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
> do_exception: __cold;

/me mutters something best left unsaid these days...

Nick, how come?
