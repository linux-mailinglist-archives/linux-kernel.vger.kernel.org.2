Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33036305D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhDQN3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhDQN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:29:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3FC061756
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:29:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y124-20020a1c32820000b029010c93864955so17950970wmy.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ISBdoGIET+ZYznAio2FskDixMUDkKh8PC4/Pd4Loq2k=;
        b=d/Pja+DmXSa+DmZhRpIEt3/37I45Rs75tBubp/JfNW0JByklVj/oO1Mnpl+LGw4Miw
         s8mlIsXzOhdvN08Cwvzaknh9HE7sNEJwbpiFeunxRCkJ/1FRnctFHC8f+rWH2oM3eYFK
         MTXxU5dZXVeXwZYbTn0xfbnSLi5NFB3UxiiRg0juj/B+SUlMgWl0ZwombT8SJriD+iQc
         RDzmYTa2a0GkMdzoPk5pWWcCPGK7RMzCc1JYoUPe05/+cVNl+EpRizRV7UZfHMH+ylgW
         TyOQHeJrz/vlVZ93tboITgeFuJCSXE/A40E0JF7U+x1cZJJW5kc0u6Y73ZruuCx1HBmO
         OihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ISBdoGIET+ZYznAio2FskDixMUDkKh8PC4/Pd4Loq2k=;
        b=houO8V2Zh6FMXLkU0LhMFE9lotOu+cKP+7iGUpTWvhIm35U7EsUEFiBnSLVPCzrGbu
         x+CBEX8R0+PwQ8EiY8ipXKQWeQuHTjFKK9w66HUui2HO1qkJ0Yia+zCx0JcsZ1Tphbcy
         OINhEnBOOyYBFcRDDlYzOec8pogTPUVuZM5hSKdLqNTjBLMraiijvSm/m0kVAKbEd9Ng
         My2lVOWc+zELeZ+ceUrJVEtaerud0gcK7jeilJyqmIJQl+PInGeaS66I7Npb0bc6WVrZ
         AuBPJy2M48gteSVngGAzI3oh2mSHah3U+x+COuVum0mY/xJpNryadMKu4uUW7+YiThta
         z/nQ==
X-Gm-Message-State: AOAM530EY1a40CKmaZ7/r4A5kYYdtpuanpvDKeazS2wQIoa3Neqz2W+k
        rnTrSBMG7KIxd94iXWugkBYT
X-Google-Smtp-Source: ABdhPJxHkMpcgFrhLR2HMnbWKLQatCZYeC3c/Fjg2tVXB+3E0vMDLf0rtIbABL9RYc1DU5ZHylo/cw==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr12727799wmq.87.1618666160177;
        Sat, 17 Apr 2021 06:29:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:3c1c:8462:b77e:21a4])
        by smtp.gmail.com with ESMTPSA id l8sm12570438wme.18.2021.04.17.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:29:19 -0700 (PDT)
Date:   Sat, 17 Apr 2021 14:29:15 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, ojeda@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YHriqwf5XR0xWCi1@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHlz54rd1YQHsOA/@hirez.programming.kicks-ass.net>
 <YHmMJWmzz2vZ3qQH@google.com>
 <20210416150307.GJ2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416150307.GJ2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:03:07PM +0100, Matthew Wilcox wrote:
> Well, we could do that in C too.
> 
> struct unlocked_inode {
> 	spinlock_t i_lock;
> };
> 
> struct locked_inode {
> 	spinlock_t i_lock;
> 	unsigned short i_bytes;
> 	blkcnt_t i_blocks;
> };
> 
> struct locked_inode *lock_inode(struct unlocked_inode *inode)
> {
> 	spin_lock(&inode->i_lock);
> 	return (struct locked_inode *)inode;
> }

Indeed you can do this kind of thing in C, but as I said before (apologies if
I'm too repetitive on this) Rust forces you to do it the right way, whereas the
lack of enforcement in C leaves room for mistakes.

If you do add extensions to C to add some of these restrictions (and I encourage
you to pursue such extensions as we all benefit from better C), it is likely not
sufficient to reach the level of compile-time guarantee that Rust offers because
you need a whole slew of restrictions/enforcements.

I also note that academics have a formalisation of [a subset of] Rust that show
the soundness of these guarantees and the requirements on unsafe to compose
safely. So we're not talking about guesswork, there are formal machine-checked
proofs published about this (see for example
https://people.mpi-sws.org/~dreyer/papers/safe-sysprog-rust/paper.pdf).
