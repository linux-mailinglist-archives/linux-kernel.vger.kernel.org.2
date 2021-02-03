Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B84530E3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBCUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBCUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:03:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E329C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:03:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 8so451927plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnxhWz1pN2kdt7xfbO4NRF8c0j2EbnQ4AfDU/TQ6pI0=;
        b=IJAT+V9jEKmD3/hz9sZZbR6exYwBw75s6HVYvCREJIM03/RdTo3G6cQ+RvQ1orR5p4
         kc4JqKf6397I8VNQmJrFTNP3jO5nFJYrxviBV4RM+nLn3gvWw/OrxTG+KoJqZXYv1Kde
         VgySvk7uRqNgqNfTqopEuJXxjPPuaz/g8DVTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnxhWz1pN2kdt7xfbO4NRF8c0j2EbnQ4AfDU/TQ6pI0=;
        b=bGT+O6a4f8Yc8j8U0j6cTi3gAR44ygPpf0Tkqk1jstRqpTQXOlRjjDqt+grEC+6gv8
         4r+kEtn20OcbDi+Lz5QvCAP0qNYSLeSR1TSOBCf65uCpHXDxLWFjfoEZ71YpfSCJMRdX
         UPYUIBSvqNZkUZCmiXcO0+i3SVbyH8lQro5kBO0Uv7dSYNA7Bk0fGcM0itZW40yMcvyU
         AAXxEzetqdcigiwIPQIsm5hdJ+hWHmsyk2oKy7ZHJeF0udgViq2dloDViJgz47ZHKWja
         SfWjun3ahauCma9cmW5a/SFBctXqQAY0Q7kg6WX7uXsrCsfUhzf/6l5r2LHkVIbiGLbc
         Pi5Q==
X-Gm-Message-State: AOAM530q2mqE52P4IODj/C87Kh/+sAqybcytJC7slExygWXGO4pwlngq
        cLzm/44HX2nzoitXpIBirey9VA==
X-Google-Smtp-Source: ABdhPJzy/ot00jPf50W+6aRzRBLtT42uZYU3mpc8lCUNPUApoInnp5OnjQ9oTpnPaiDbD6WpZSh0qA==
X-Received: by 2002:a17:90b:3886:: with SMTP id mu6mr4570866pjb.153.1612382590066;
        Wed, 03 Feb 2021 12:03:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j9sm3682830pgb.47.2021.02.03.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:03:08 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:03:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Message-ID: <202102031202.F0AEC4A7@keescook>
References: <20201230154104.522605-1-arnd@kernel.org>
 <20210112191634.GA1587546@ubuntu-m3-large-x86>
 <20210203184840.GA1711681@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203184840.GA1711681@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:48:40AM -0700, Nathan Chancellor wrote:
> On Tue, Jan 12, 2021 at 12:16:34PM -0700, Nathan Chancellor wrote:
> > On Wed, Dec 30, 2020 at 04:40:40PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > clang cannt evaluate this function argument at compile time
> > > when the function is not inlined, which leads to a link
> > > time failure:
> > > 
> > > ld.lld: error: undefined symbol: __compiletime_assert_414
> > > >>> referenced by mremap.c
> > > >>>               mremap.o:(get_extent) in archive mm/built-in.a
> > > 
> > > Mark the function as __always_inline to avoid it.
> > > 
> > > Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I would like to see some movement on getting this fixed in 5.11. As it
> > stands, this is one of three __compiletime_assert references with
> > CONFIG_UBSAN_UNSIGNED_OVERFLOW. If we want to keep the BUILD_BUG()
> > around, I think this is fine. Alternatively, turning it into a runtime
> > check would be fine too.
> > 
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Ping? It is pretty late into the 5.11 cycle and this is still broken.

I think we should just do the __always_inline. Who can take this?

-Kees

> 
> Cheers,
> Nathan
> 
> > > ---
> > >  mm/mremap.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index c5590afe7165..1cb464a07184 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -336,8 +336,9 @@ enum pgt_entry {
> > >   * valid. Else returns a smaller extent bounded by the end of the source and
> > >   * destination pgt_entry.
> > >   */
> > > -static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> > > -			unsigned long old_end, unsigned long new_addr)
> > > +static __always_inline unsigned long get_extent(enum pgt_entry entry,
> > > +			unsigned long old_addr, unsigned long old_end,
> > > +			unsigned long new_addr)
> > >  {
> > >  	unsigned long next, extent, mask, size;
> > >  
> > > -- 
> > > 2.29.2
> >  

-- 
Kees Cook
