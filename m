Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C79145A554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhKWOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKWOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:25:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H855k1wCbzRICiENraM5pUrKiA5noa4KQuq/7wUngYs=; b=lJ5ZhcH5D+wUW+ZJcwQaFCq8uZ
        UcHLSg4YMC+dKiT3CPWHwlqmDfMKVuomyd/lY2W7RX7MFp4qdWjvRHAL1rEAYRzHjsoxZT6EAEfkQ
        nOBPjSvER3/Q/v7O2njDZyvVo4e6UrN3y5KqR/jH+CftwW6+JaVkJr+k1ECu+Zes7deOCO0Xtv98e
        BBnKMqCeeOe0+lO039scj6Erx5yUFqaSWY2s3gYAQK4pL3tChC2Dx1+T+c2hoTIMDIHcQvL9OCF/G
        xK2AMMLcV50k35nbnUfBeGZCjBYLvVchRA0YcPDXYsEj+xM5uRk0G9jTULm2r9U6wfy7J+jEHMnWL
        VLn/BaRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpWg1-0005Rb-Fr; Tue, 23 Nov 2021 14:21:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95FAF30008D;
        Tue, 23 Nov 2021 15:21:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A05A2CF5A62C; Tue, 23 Nov 2021 15:21:40 +0100 (CET)
Date:   Tue, 23 Nov 2021 15:21:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com, broonie@kernel.org
Subject: Re: [RFC][PATCH 5/6] x86: Sprinkle ENDBR dust
Message-ID: <YZz49M/QLmMJgJA7@hirez.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.273377350@infradead.org>
 <20211123140052.GF37253@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123140052.GF37253@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:00:53PM +0000, Mark Rutland wrote:
> On Mon, Nov 22, 2021 at 06:03:06PM +0100, Peter Zijlstra wrote:
> > Kernel entry points should be having ENDBR on for IBT configs.
> > 
> > The SYSCALL entry points are found through taking their respective
> > address in order to program them in the MSRs, while the exception
> > entry points are found through UNWIND_HINT_IRET_REGS.
> > 
> > *Except* that latter hint is also used on exit code to denote when
> > we're down to an IRET frame. As such add an additional 'entry'
> > argument to the macro and have it default to '1' such that objtool
> > will assume it's an entry and WARN about it.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> On arm64 we also added BTI (analagous to ENDBR) in our SYMC_FUNC_START()
> so what we don't miss a necessary landing pad for any assembly functions
> that can be indirectly branched to.
> 
> See commits:
> 
>   714a8d02ca4da147 ("arm64: asm: Override SYM_FUNC_START when building the kernel with BTI")
>   2d21889f8b5c50f6 ("arm64: Don't insert a BTI instruction at inner labels")
> 
> ... do you need something similar? Or do you never indirectly branch to
> an assembly function?

With the big caveat that I've only looked at x86_64-defconfig so far, we
don't seem to be doing that.

We also have the big benefit of having a larger immediate doesn't give
us those 'spurious' indirect branches you suffer from.

Hence also that --ibt-seal option that removes as many ENDBR
instructions as possible. Minimizing ENDBR is a feasible option for us,
where I don't think it is on ARM64.
