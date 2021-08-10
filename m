Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826F13E850D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhHJVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234168AbhHJVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7GQyRF3T2F5cFOMo5DgAfgkHKpFg4ySwpREk5VvgQw=;
        b=dBdq4p0GzBJ9GNb+50XKHI7vLqSWPyUyruNTYRn0uLRIASTRDQLL82e3Ixwr649rxDa/kx
        kTYbLc7fGYlsCk9iLGtogsHiU0CaKNu16jCbATHws55VPCjQBsEzWSUQhgMV+O8gaIKIDS
        UTk9HpB3jNSbn6i7tgX/4eQjw2yKPMI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-9WM3eZ3uOb60n2mtjzFH8A-1; Tue, 10 Aug 2021 17:16:16 -0400
X-MC-Unique: 9WM3eZ3uOb60n2mtjzFH8A-1
Received: by mail-oi1-f197.google.com with SMTP id c18-20020a0568081392b029025ca5afbdeaso293831oiw.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7GQyRF3T2F5cFOMo5DgAfgkHKpFg4ySwpREk5VvgQw=;
        b=ctPixImHxR3Q+1qcHFkp3myP5VLXLumQEEpauRx0+E2vb6RJs71R1LJ1OjkRRLepsm
         pc+Rb6PJEg4Iy2wRBQDZE1WYJceVrmZsyykdvvRk8Wv/aP9iaDFSgmIwJ8UBcJgLGIsE
         o6EtBHguCjqf2bzQlTBl2bIylZRRddJDvWb9iwrNJb1zWMtUCqfVc5lk4rvXP8ZpDYPw
         BC2y5TOPZMuGbKXP0MwsKVPzjirl2O8vue6Som2nE4Hub6nooZsPppJzkqEoHU12QrTe
         kABGzFylIGevlA58eVRwBdnOwsy0YZm5cV/TmkD9rhHfZvrjPtFnZFtkuAuBlKgSBhna
         ZzTw==
X-Gm-Message-State: AOAM5319TA7PZIR2gDikigzQEqAKFFWv86MXn7ylEvntIqj8O3XyS8VR
        y/caSH3EehfgjV0ntTplEcP4baLOaaPhsMH/KXObv7TVEiE838QXQzWMO1BZ5+3/PWw8mcWH9rD
        JKeGcOV/DNY0tqfkl9ej5+90u
X-Received: by 2002:a05:6830:2a09:: with SMTP id y9mr22889064otu.217.1628630175789;
        Tue, 10 Aug 2021 14:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJtU1OkXmxYAP/vQsRrWUR2KaD6Zcstm/KC8LV/WJpIlYUp20POKRjVottBiXJCgi4DHznug==
X-Received: by 2002:a05:6830:2a09:: with SMTP id y9mr22889054otu.217.1628630175618;
        Tue, 10 Aug 2021 14:16:15 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id w35sm4062698ott.80.2021.08.10.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:16:15 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:16:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/7] vfio: Create vfio_fs_type with inode per device
Message-ID: <20210810151614.39a6714f.alex.williamson@redhat.com>
In-Reply-To: <YRLKSYQL8VvTr3gc@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
        <162818322947.1511194.6035266132085405252.stgit@omen>
        <YRI8Mev5yfeAXsrj@infradead.org>
        <20210810085254.51da01d6.alex.williamson@redhat.com>
        <YRKT2UhgjfWBmwuJ@infradead.org>
        <YRLKSYQL8VvTr3gc@t490s>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 14:49:45 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Aug 10, 2021 at 03:57:29PM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 10, 2021 at 08:52:54AM -0600, Alex Williamson wrote:  
> > > On Tue, 10 Aug 2021 10:43:29 +0200
> > > Christoph Hellwig <hch@infradead.org> wrote:
> > >   
> > > > > + * XXX Adopt the following when available:
> > > > > + * https://lore.kernel.org/lkml/20210309155348.974875-1-hch@lst.de/    
> > > > 
> > > > No need for this link.  
> > > 
> > > Is that effort dead?  I've used the link several times myself to search
> > > for progress, so it's been useful to me.  Thanks,  
> > 
> > No, but it seems odd to have reference to an old patchset in the kernel
> > tree.  
> 
> I learn from the reference too.  Maybe move into commit message?  Thanks,

TBH, I'm ok if it's "odd" if it's useful.  Right here we have two
instances of it being useful.  I don't think that two lines of comment
is excessive and we can always remove it when we either make the
conversion or give up on it.  Moving it to the commit log would just
bury it to be pointless.

I don't have a more concise, current, or future-proof way to describe
the todo item than this link (ok, ok, I could s/lkml/r/ for 3 less
chars :-P).  Thanks,

Alex

