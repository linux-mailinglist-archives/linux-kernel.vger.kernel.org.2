Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027042D1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhJNFja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhJNFj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634189844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LbQ6apDDu1Jq5rKCrmcNIdSI/FmgQ8vn2r7YrYHAG0=;
        b=U6/T30wNLoGA6MnxO0VuLmfxug7mzdeiTH0iMRs6bXGv+EBYai6wALSdXG/803ByeJAMWW
        BI3yHxIesBNzibxN9lmhqds2a4xyFTPoJkTCxqE1FeleEF7o/7IXfYzJUUczSIXO4yANr3
        F+gjvzPNrsynH3fCEK78cnIiyUgDvzQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-hhflCeY7MWCbcFEtZ4je-A-1; Thu, 14 Oct 2021 01:37:23 -0400
X-MC-Unique: hhflCeY7MWCbcFEtZ4je-A-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso4153070edj.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0LbQ6apDDu1Jq5rKCrmcNIdSI/FmgQ8vn2r7YrYHAG0=;
        b=3islevYFEWXtVgM13WwLsT8i8ihQsxJ+/lufgXjPII2CsCyV/u79WcmuihoX9tya6r
         GO18K1OqcJMnLng+mhb7xNWCqKizF05/80BFylam+TcT4BnIWHCLoyq/cdEFm8uUrzYL
         KwPiqxJFgnDL49g6l6vM446FCa2BNHyvewrUptzduI+2jUuyyW2vs9U2lTgUyenQdFBy
         Ck4SEJ0WAQ6GIasMqQvwp3uL0G0pH67MnHv0ZO3R3wzidtkvKrAjR6ES9F1VxCOunV8u
         eaWW6VNgAn32m4zo9to84Jzj/5LmHchsbmcVt666dFnyhj+rIsABQd1wrZIAtExM0Paq
         ZvRw==
X-Gm-Message-State: AOAM533QgL/PSBZAjPpyMWE0s/vIBhku2T/Etjz7fCfrOEv5djz5uK5k
        RrCqQMVOJd9SnPQU5Yf02s/Uh/ByzDL9X3BCskPIpCj/+IZxQZz2WHss9T78emA37UDIcfqAQK8
        pdBiBgfpK3AK7bf1Pj20gqbJ0
X-Received: by 2002:a17:906:3ac6:: with SMTP id z6mr1370211ejd.196.1634189841900;
        Wed, 13 Oct 2021 22:37:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzUS2cdsI20N+DN9AluhA+OHF5rz0SCoEYzx0PLrE/5HlPqakdFLlMEbDS0i62vgUOvAaTdA==
X-Received: by 2002:a17:906:3ac6:: with SMTP id z6mr1370191ejd.196.1634189841674;
        Wed, 13 Oct 2021 22:37:21 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id nd36sm1104148ejc.17.2021.10.13.22.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:37:20 -0700 (PDT)
Date:   Thu, 14 Oct 2021 01:37:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Akira Yokosawa <akys@qa2.so-net.ne.jp>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: data dependency naming inconsistency
Message-ID: <20211014013156-mutt-send-email-mst@kernel.org>
References: <20211011064233-mutt-send-email-mst@kernel.org>
 <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 01:43:24PM +0900, Akira Yokosawa wrote:
> On Mon, 11 Oct 2021 07:07:08 -0400, Michael S. Tsirkin wrote:
> > Hello Paul, all!
> 
> Hello Michael,
> 
> I thought Paul would respond soon, but looks like he has not
> done so.
> So, I'm trying to give some hint to your findings.
> 
> > I've been reading with interest Paul's posts about Rust interactions with LKMM
> > https://paulmck.livejournal.com/63316.html
> > and in particular it states:
> > 		A data dependency involves a load whose return value directly or
> > 	indirectly determine the value stored by a later store, which results in
> > 	the load being ordered before the store.
> > 
> > This matches the perf book:
> > 	A data dependency occurs when the value returned by
> > 	a load instruction is used to compute the data stored by
> > 	a later store instruction.
> 
> You might likely be aware, but these concern "data dependency",
> not a _barrier_.
> 
> > 
> > however, memory-barriers.txt states:
> > 
> >      A data dependency barrier is a partial ordering on interdependent loads
> >      only; it is not required to have any effect on stores, independent loads
> >      or overlapping loads.
> > 
> > It also says:
> > 	A data-dependency barrier is not required to order dependent writes
> > 	because the CPUs that the Linux kernel supports don't do writes
> > 	until they are certain (1) that the write will actually happen, (2)
> > 	of the location of the write, and (3) of the value to be written.
> 
> These concern the historic "data-dependency barrier", or
> [smp_]read_barrier_depends(), which existed until Linux kernel v4.14.
> 
> > 
> > so the result it the same: writes are ordered without a barrier,
> > reads are ordered by a barrier.
> > 
> > However, it would seem that a bit more consistency in naming won't
> > hurt.
> 
> So, I don't think the historic term of "data-dependency barrier"
> can be changed.
> 
> I guess the right approach would be to further de-emphasize
> "data-dependency barrier"/"data dependency barrier" in
> memory-barriers.txt.
> 
> Rewrite by commit 8ca924aeb4f2 ("Documentation/barriers: Remove
> references to [smp_]read_barrier_depends()") did some of such
> changes, but it failed to update the introductory section of
> "VARIETIES OF MEMORY BARRIER".
> The part Michael quoted above belongs to it.
> I don't think it has any merit keeping it around.
> 
> Also, there remain a couple of ascii-art diagrams concerning
> <data dependency barrier> in the first part of "EXAMPLES OF MEMORY
> BARRIER SEQUENCES" section, which, I think, can be removed as well.
> 
> Hope this helps clarify the circumstances.

It does, thanks! It might be worth adding a sentence along the lines of

"NB: a data dependency barrier is distinct from a data dependency: it's
a barrier that used to be required in the presence of a data dependency.
Since v4.14 Linux no longer offers an API for a data dependency barrier.
Instead, using READ_ONCE is sufficient for ordering in the presence of a
data dependency".


> Paul, what is your take on the naming of "data dependency"/
> "data dependency barrier"?
> 
>         Thanks, Akira
> 
> > 
> > Thanks,
> > 
> > -- 
> > MST

