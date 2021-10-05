Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B25422109
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:46:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BAEC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EPwDe2DUzm060XW9tRJU3VkqkXdZqPBj6sTBo+C/lDs=; b=YbsaAn6hrxSeol5lMUr+t2YH2N
        ITaOISCVNO+WJvuvYu908xaVgaXrUDL2WIqBL9q1AtMA6KXbGR5p6+CVYM35Wvvru+Goq6jNxuKwN
        m2mtjRsZNJAeH/CjMWAWVzH4BQGmSp9b7RTMYP0DGRRnjSdK9nVz4wKvWYgaB+FM5pbA7u5uXyeFn
        4HlGa0D94LAeFdvmQleh9qi1Px1Yd1oLYL3PRKf8UgnFGk/PaAJHD2cevL5v+ixr32fq8yhUAE0jl
        U0/SYMyhPPQPTZjlffcRFuyWvqUDN+ibwBJItamR458m4oKP757cnWq/bXsRDwyam7k2QV4jnB8aw
        YwA2yK8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXg4N-00819R-Hb; Tue, 05 Oct 2021 08:45:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76CDF30019C;
        Tue,  5 Oct 2021 10:45:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67253212E312E; Tue,  5 Oct 2021 10:45:02 +0200 (CEST)
Date:   Tue, 5 Oct 2021 10:45:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] objtool: Remove reloc symbol type checks in
 get_alt_entry()
Message-ID: <YVwQjlC50b0a23OC@hirez.programming.kicks-ass.net>
References: <feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:07:50AM -0700, Josh Poimboeuf wrote:
> Converting a special section's relocation reference to a symbol is
> straightforward.  No need for objtool to complain that it doesn't know
> how to handle it.  Just handle it.
> 
> This fixes the following warning:
> 
>   arch/x86/kvm/emulate.o: warning: objtool: __ex_table+0x4: don't know how to handle reloc symbol type: kvm_fastop_exception
> 
> Fixes: 24ff65257375 ("objtool: Teach get_alt_entry() about more relocation types")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks!

Does not in fact apply due to Linus' patch. Fixed that up and will run
more careful tests this time :-)
