Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAEA3E8603
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhHJWTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234951AbhHJWS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628633916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YZY4Fy0S693Kga/zgn3elAZcDC5WxrNoe2T+rwZApE=;
        b=gMQzqyGRz/puTvjpyiEvqfajWHHm/QDNScN7pjRNvbGcF5GD0iaqXrXYswv8+Dfh1wQswg
        023zCLvi7TSDw+FB25PUyyAnO5lOax5DjHcja1nm754KNo0y+/xvIPukWotukmY9j2fgMv
        EuV3uSZkuvVMUZkb5h/tXKPeiuNsk78=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-pAh703v7NOCIr1fwKZxlIw-1; Tue, 10 Aug 2021 18:18:35 -0400
X-MC-Unique: pAh703v7NOCIr1fwKZxlIw-1
Received: by mail-qk1-f198.google.com with SMTP id d20-20020a05620a1414b02903d24f3e6540so77919qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YZY4Fy0S693Kga/zgn3elAZcDC5WxrNoe2T+rwZApE=;
        b=CokibyfanJYphaGrlPlgy6WMn0wSvtkEa1ZSLBv68Ocfi7tINV8u36E9X2wn9zuAG3
         VmhAMMLexSuNoZgoC9ATG19dZ1dsSWFBXslZIfZ0ck/jEZRGmXxIu1rQ6UlKU7V1QIW6
         V2zTXMJbGXkS6jIJXMn0QenxrobJhMwj4B6rGerWYhsgxefurJX3ec+5k138X9+FUSlX
         /JiKMjeyozbIYJbOScMXBYNSWiaRj5rgK+mZiRk4zehk2rq1GxSaq9NmxFa6Aqf/m3PS
         +aIJ6nI+39kZFYxJNdVyEmJHilzP6BG4Q50hvNrj5iRKDUZ5CB3KtUkyXGefJwyv6TRU
         eg6A==
X-Gm-Message-State: AOAM530XsGlkLYqbektLS0HIP/TgSxhwViFAwW1HUO2YqdYe5hWJWLyZ
        cwY+pc6DflibDnKBnHiKXaiEg456lwXvEw6pCYNlpKKnktUMHXdRYrnavwPDDEIzD+MeD3F6clw
        LV3vlnnSkCILLTYd/NV9xsnaF
X-Received: by 2002:a37:b544:: with SMTP id e65mr31249876qkf.84.1628633915140;
        Tue, 10 Aug 2021 15:18:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe+BlgB4A1XuAQgShSQ1NiAMJQshbqb1mytM+jP2Rk2LYjiR4/4P9XpXXA95IcNLHVb/a1fw==
X-Received: by 2002:a37:b544:: with SMTP id e65mr31249859qkf.84.1628633914928;
        Tue, 10 Aug 2021 15:18:34 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a8sm10798674qkn.63.2021.08.10.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 15:18:34 -0700 (PDT)
Date:   Tue, 10 Aug 2021 18:18:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/7] vfio: Create vfio_fs_type with inode per device
Message-ID: <YRL7OdHv/CG+oUI6@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818322947.1511194.6035266132085405252.stgit@omen>
 <YRI8Mev5yfeAXsrj@infradead.org>
 <20210810085254.51da01d6.alex.williamson@redhat.com>
 <YRKT2UhgjfWBmwuJ@infradead.org>
 <YRLKSYQL8VvTr3gc@t490s>
 <20210810151614.39a6714f.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810151614.39a6714f.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:16:14PM -0600, Alex Williamson wrote:
> On Tue, 10 Aug 2021 14:49:45 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Aug 10, 2021 at 03:57:29PM +0100, Christoph Hellwig wrote:
> > > On Tue, Aug 10, 2021 at 08:52:54AM -0600, Alex Williamson wrote:  
> > > > On Tue, 10 Aug 2021 10:43:29 +0200
> > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > >   
> > > > > > + * XXX Adopt the following when available:
> > > > > > + * https://lore.kernel.org/lkml/20210309155348.974875-1-hch@lst.de/    
> > > > > 
> > > > > No need for this link.  
> > > > 
> > > > Is that effort dead?  I've used the link several times myself to search
> > > > for progress, so it's been useful to me.  Thanks,  
> > > 
> > > No, but it seems odd to have reference to an old patchset in the kernel
> > > tree.  
> > 
> > I learn from the reference too.  Maybe move into commit message?  Thanks,
> 
> TBH, I'm ok if it's "odd" if it's useful.  Right here we have two
> instances of it being useful.  I don't think that two lines of comment
> is excessive and we can always remove it when we either make the
> conversion or give up on it.  Moving it to the commit log would just
> bury it to be pointless.
> 
> I don't have a more concise, current, or future-proof way to describe
> the todo item than this link (ok, ok, I could s/lkml/r/ for 3 less
> chars :-P).  Thanks,

Yep, fine by me - either by keeping it in the code, commit message, or in cover
letter, as it's still an useful reference before that series got merged. Thanks,

-- 
Peter Xu

