Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFE4407A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 08:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhJ3GOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 02:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJ3GOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 02:14:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A04CC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 23:12:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa4so8672421pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueTbI3S4K7Xgcet2VrZSQjxWp0w50FwioH6P7FQrkzc=;
        b=X1oHkBk0Tr/Q4WLqU9to6Ze1V35sncf3LNWZVOzAOVnvKXIItmxbjNSo/jdI8OQWK/
         7eE8six/gwo3BTRDg6NcflO33tcmSAozQNJSRRIxDsTbBrI56oiAsn8t21Wfmr+drf4y
         zZ8Mehf0waMygLEHts0d/WFIZBZUTEjiHM9OYNi68bpxldJnvOaEhPTXWKqf2co/Dr53
         JJDtTl55VNgQ4zlBSjqcusdgDP3hxLzOzxFgiN9BzNHGfZKKNBEPhBGVJTPVrcbjtJj3
         5+wMLCxx+UBziJzql1cVwhnULzcByaZPLKbkpxdtEz0Jo0s2p/w/2IOJOkq88KbPadSv
         Qt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueTbI3S4K7Xgcet2VrZSQjxWp0w50FwioH6P7FQrkzc=;
        b=O6HAhLH3/I35XGsLU034gCv9oS3xYQdbb4vPJxxzwO0IpHZaRYHLeMMV/SKeZwOiQx
         +ZrSA4ZJD+9xg3wJ2x5itBc4+t35K6FrXfTlB0qdDDy68XbIqa0jeEEMha3nTIHd7GHG
         JjiBJEPSUTZgDCZXcq59kjHlryfmjAbhT4OxoyzKe41yMVIO7OM+6dE+3yb2KNk2z8WY
         kx1mNymIIQcRiw59tUfVdmyervW95B+PjAUlczuWQDSoa3KH6I8CbANCBYP7vUF0uskk
         K/pKONmZ9UzWqIB1+n6mGAAR5ZHCNF59J79uB+5mT0LnKWtftyIgZqQL1kN21UJqUrrU
         qzSA==
X-Gm-Message-State: AOAM532IroL2zMDrrfKlyyTWbdv2YZmeNzYtRhQYfes7aInu5pdMeoGc
        eMzIKKN1lCmapqX3+wYgGuk=
X-Google-Smtp-Source: ABdhPJw7eoYuqSxorY7UQTKG1G48X6jz0BnDwNYoNc0+wS4p9vaMhLi4+xB295YCQ4hkc5jjOy+fsQ==
X-Received: by 2002:a17:90a:bb84:: with SMTP id v4mr12221256pjr.4.1635574329048;
        Fri, 29 Oct 2021 23:12:09 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (125.91.64.34.bc.googleusercontent.com. [34.64.91.125])
        by smtp.gmail.com with ESMTPSA id n14sm8534693pfo.156.2021.10.29.23.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 23:12:08 -0700 (PDT)
Date:   Sat, 30 Oct 2021 06:12:04 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <20211030061204.GA27203@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXqSoo+b9RTclW/2@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 01:08:02PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 28, 2021 at 10:04:14AM +0000, Hyeonggon Yoo wrote:
> > On Mon, Oct 25, 2021 at 10:17:08AM +0200, Christoph Lameter wrote:
> > > On Mon, 18 Oct 2021, Hyeonggon Yoo wrote:
> > > 
> > > > > Better for what use case?  SLOB is for machines with 1-16MB of RAM.
> > > > >
> > > >
> > > > 1~16M is smaller than I thought. Hmm... I'm going to see how it works on
> > > > tiny configuration. Thank you Matthew!
> > > 
> > > Is there any reference where we can see such a configuration? Sure it does
> > > not work with SLUB too?
> > 
> > I thought why Matthew said "SLOB is for machines with 1-16MB of RAM"
> > is because if memory is so low, then it is sensitive to memory usage.
> > 
> > (But I still have doubt if we can run linux on machines like that.)
> 
> I sent you a series of articles about making Linux run in 1MB.

Oh I missed your mail, I'm gonna read this!
Thanks!

Thanks,
Hyeonggon.
