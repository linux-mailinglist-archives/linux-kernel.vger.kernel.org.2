Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E494345EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJTHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:36:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rV/999ZEtrgBCMBWTD3S2hZ/USczg9s4hZgnBi5qnMo=; b=eQUuVrG9Xy0BCENc50NRrbRbVs
        qCotjYFnVMuuWPyVAVvUW7lhHiPBg2TX3X7nSBEFILr2wVVsVjk1U4CC5nluBMQPTVPKlfDgIDQXo
        n3b7+11xDRpNive6c67afH5CIlsBcxB8rxisKRpSCPoE/g7EnM+2HkpsA2QgPW2GjIka0BrnFdqsP
        lY+AB6lH1LGNyG4YxU9AcGc4j+fpuQvhLvFJ3xctwrCnTIdpYuaGuy309A0lT41TPM+N90yI0QL03
        xdkdBkvFMLOeeto967q0/xhpfMeoRHneQv4whWzVDgX+jErW8K05dt025YHlF0jWXCtf/SaJBJdTO
        wqPTloJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md671-00AuSx-DG; Wed, 20 Oct 2021 07:34:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 682A3300221;
        Wed, 20 Oct 2021 09:34:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E9E02BC9DBBF; Wed, 20 Oct 2021 09:34:10 +0200 (CEST)
Date:   Wed, 20 Oct 2021 09:34:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YW/GctbsXgvM+YsQ@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.706163435@infradead.org>
 <20211013210605.bz6l7o5xzik5ckga@treble>
 <YWdVq8UWpvMwnzht@hirez.programming.kicks-ass.net>
 <YWf8Yy2e9n+/veEe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWf8Yy2e9n+/veEe@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:46:11AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 11:54:51PM +0200, Peter Zijlstra wrote:
> 
> > > But the rest of eBPF JIT just emits retpolines unconditionally
> > > regardless of feature, for example see RETPOLINE_RCX_BPF_JIT().  So I'm
> > > thinking this should probably be consistent with that (or that with
> > > this).
> > 
> > Argh, I grepped for __x86_indirect_thunk, and missed they're writing
> > retpolines themselves. Bah.
> > 
> > Yes, that needs cleaning up. I'll go prod at that tomorrow.
> 
> Bah, i've too much of a head-ache to make sense of that bpf jit code :-(
> 
> Alexei, emit_fallback_jump() uses emit_jump() and provides @prog as .ip
> argument, but other sites do weird things like 'image + addrs[i]',
> presumable because @prog points to an on-stack array instead of to the
> actual text location.
> 
> Also @prog is confusingly sometimes a struct bpf_prog* and sometimes a
> u8* which makes grepping really confusing.
> 
> I've ended up with the below.. which is known broken-crap for 32, but is
> likely simlar for 64bit as well :-( Can you please have a look?

OK, I've got a working version (thanks to Josh for finding my
brain-fart)! I'll go repost the series soon.
