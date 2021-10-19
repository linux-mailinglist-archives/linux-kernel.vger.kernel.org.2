Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A124332B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhJSJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhJSJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:43:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37673C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OzhAUkgUxAsZVvVo72iev/FptlxQMpUIteNenWAl3x0=; b=rSJMH2it0fhVmZSXw9YaBpIgpR
        SKr7zwGcVAxgWgS8Hl4MRBF0w482BIyv9XQ24lc7aEMwoPdzDsZTDh9IXazBACRN7NsoJUVAGpKRk
        kmrtNTtDThwwLBdH7nfogCybneL8fBcTggNLk+K4cUK9GL6hHmWRqOIwe0rLo4TudjUxvLJ1jVSUp
        91n+b0k1cDyS9I2GP10m+xw0gRKwYdi7u0x14bgiqSQYY6l8/JLbnzXeyiqa44bfFPLUk9m6Y271Z
        AIQ8JwZqKvXyBFtoYZwL51JNySiNNkhxYFv+VrCL4jFqrFp2HkQ5B4M/m6vqpSV9ywYGuA5WLSH2D
        rzVP4jyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mclc9-00Akbj-Dl; Tue, 19 Oct 2021 09:40:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E9BE30024D;
        Tue, 19 Oct 2021 11:40:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B493236E4530; Tue, 19 Oct 2021 11:40:56 +0200 (CEST)
Date:   Tue, 19 Oct 2021 11:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW6SqH1R7stXk2GG@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <YWmPCF+g+sF4+ieh@zn.tnic>
 <20211015165635.GH174703@worktop.programming.kicks-ass.net>
 <20211018225905.86034-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018225905.86034-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:06:35PM +0000, Alexander Lobakin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 15 Oct 2021 18:56:35 +0200
> 
> Hi,
> 
> Gave it a spin with Clang/LLVM, and

Just your normal clang build, not some fancy LTO ? eg.  make CC=clang.


> > > > +	target = addr + insn->length + insn->immediate.value;
> > > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> 
> this triggers
> 

> > > > +
> > > > +	if (WARN_ON_ONCE(reg & ~0xf))
> > > > +		return -1;
> 
> this:
> 
> WARN in patch_retpoline:408: addr pcibios_scan_specific_bus+0x196/0x200, op 0xe8, reg 0xb88ca
> WARN in patch_retpoline:408: addr xen_pv_teardown_msi_irqs+0x8d/0x120, op 0xe8, reg 0xb88ca
> WARN in patch_retpoline:408: addr __mptcp_sockopt_sync+0x7e/0x200, op 0xe8, reg 0xb88ca
> [...]
> (thousands of them, but op == 0xe8 && reg == 0xb88ca are always the same)
> 
> I know this reg calculation is about to be replaced, but anyway ;)

Well, I was sorta hoping to keep that with something like:

  https://lkml.kernel.org/r/YWgA+vbWCdGLZhq5@hirez.programming.kicks-ass.net

Anyway, let me try and reproduce.
