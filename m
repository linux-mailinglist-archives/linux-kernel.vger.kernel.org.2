Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6E3BA423
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhGBTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGBTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:00:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0337C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OOFkg3bgn9LW9+M4UE4UvleU2R47+ykAYhZOcWI/BnM=; b=TSGGYBoFIVnvrAjOFhmYiZ3q1w
        Sf/gG2mSYgDuJr21duKFO/pFqyM3zwH9rpDy4zGx7JkMugbh/SghVHX0rjSTGRIFIro7/7qMSjrmb
        XsAp1GQG1X6Ugqu8R+r+GUWeU8qnaEa+R7GXn0mV1kV7AdarV8NMCh1NArBn0EBJUihpUFrY3KalT
        knmfkdpV8ts/6+HSfxR4oOaEuf4ubXqsz114c5SFBv/ff/IyVv9Q1oqQVmbmUdwjunnw89C+q7mRm
        8ntAKm/7HZ7OJ78vKkAJTwpSZDCQ0K98i+Swrp31J+3LfxqaB0Mh3ILGdDo4uKYj69TDrkUdZk9AQ
        zegaKM5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzOM8-007y5D-Qg; Fri, 02 Jul 2021 18:57:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4542E300091;
        Fri,  2 Jul 2021 20:57:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 245882B8556D4; Fri,  2 Jul 2021 20:57:39 +0200 (CEST)
Date:   Fri, 2 Jul 2021 20:57:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <YN9ho7yDFStVw8g3@hirez.programming.kicks-ass.net>
References: <202106281231.E99B92BB13@keescook>
 <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook>
 <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com>
 <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
 <CAKwvOd=-qdp6xcuVb-fSni6X-0UuJ6GM5+TJdWSkAfvNmqfZ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=-qdp6xcuVb-fSni6X-0UuJ6GM5+TJdWSkAfvNmqfZ+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 10:26:40AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 2, 2021 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > I've asked this before; *what* is missing from LBR samples that's
> > reponsible for the performance gap?
> 
> Are we able to collect LBR samples from __init code?  I can imagine
> trying to launch perf from init/pid 1, but I suspect at that point
> it's way too late.
> 
> Increasingly, boot times of hosts (and virtualized guests) are
> becoming important to us, both in the datacenters and on mobile.

For a guest, possibly, I've no idea how any of that virt crud works.
