Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01500315C42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhBJBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbhBIWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uskw3PbEX7wEnO/ex/Xsz3m8Nxa2KyupOaIbM7L2BOs=;
        b=P1xXy+miLpiOjA2OGvxj6K8aFyJu4bBHAQV2HpFLOkcPy/ljnqBvR9bFuh7mOwmXXcgHqw
        coESVx9hUcKaM101TIIVnhkxAJKeya6zLdolpQzSEMKsHisDPD7lg4SgKL2KmTPyshCfjp
        +Jwn2BrAdp9+x1bb2DWkXu0krlnLpTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-k2Jf9BXbPxKvPSd8tNYV6w-1; Tue, 09 Feb 2021 16:17:45 -0500
X-MC-Unique: k2Jf9BXbPxKvPSd8tNYV6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB8F192CC44;
        Tue,  9 Feb 2021 21:17:42 +0000 (UTC)
Received: from redhat.com (ovpn-115-63.rdu2.redhat.com [10.10.115.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE56A60D11;
        Tue,  9 Feb 2021 21:17:40 +0000 (UTC)
Date:   Tue, 9 Feb 2021 16:17:38 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>, Linux MM <linux-mm@kvack.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-ppc@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 0/9] Add support for SVM atomics in Nouveau
Message-ID: <20210209211738.GA834106@redhat.com>
References: <20210209010722.13839-1-apopple@nvidia.com>
 <CAKMK7uGwg2-DTU7Zrco=TSkcR4yTqN1AF0hvVYEAbuj4BUYi5Q@mail.gmail.com>
 <3426910.QXTomnrpqD@nvdebian>
 <20210209133520.GB4718@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209133520.GB4718@ziepe.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:35:20AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 09, 2021 at 11:57:28PM +1100, Alistair Popple wrote:
> > On Tuesday, 9 February 2021 9:27:05 PM AEDT Daniel Vetter wrote:
> > > >
> > > > Recent changes to pin_user_pages() prevent the creation of pinned pages in
> > > > ZONE_MOVABLE. This series allows pinned pages to be created in 
> > ZONE_MOVABLE
> > > > as attempts to migrate may fail which would be fatal to userspace.
> > > >
> > > > In this case migration of the pinned page is unnecessary as the page can 
> > be
> > > > unpinned at anytime by having the driver revoke atomic permission as it
> > > > does for the migrate_to_ram() callback. However a method of calling this
> > > > when memory needs to be moved has yet to be resolved so any discussion is
> > > > welcome.
> > > 
> > > Why do we need to pin for gpu atomics? You still have the callback for
> > > cpu faults, so you
> > > can move the page as needed, and hence a long-term pin sounds like the
> > > wrong approach.
> > 
> > Technically a real long term unmoveable pin isn't required, because as you say 
> > the page can be moved as needed at any time. However I needed some way of 
> > stopping the CPU page from being freed once the userspace mappings for it had 
> > been removed. 
> 
> The issue is you took the page out of the PTE it belongs to, which
> makes it orphaned and unlocatable by the rest of the mm?
> 
> Ideally this would leave the PTE in place so everything continues to
> work, just disable CPU access to it.
> 
> Maybe some kind of special swap entry?
> 
> I also don't much like the use of ZONE_DEVICE here, that should only
> be used for actual device memory, not as a temporary proxy for CPU
> pages.. Having two struct pages refer to the same physical memory is
> pretty ugly.
> 
> > The normal solution of registering an MMU notifier to unpin the page when it 
> > needs to be moved also doesn't work as the CPU page tables now point to the
> > device-private page and hence the migration code won't call any invalidate 
> > notifiers for the CPU page.
> 
> The fact the page is lost from the MM seems to be the main issue here.
> 
> > Yes, I would like to avoid the long term pin constraints as well if possible I 
> > just haven't found a solution yet. Are you suggesting it might be possible to 
> > add a callback in the page migration logic to specially deal with moving these 
> > pages?
> 
> How would migration even find the page?

Migration can scan memory from physical address (isolate_migratepages_range())
So the CPU mapping is not the only path to get to a page.

Cheers,
Jérôme

