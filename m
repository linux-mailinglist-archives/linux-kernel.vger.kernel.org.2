Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD97C32565B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhBYTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232139AbhBYTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614280014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ntq0VlGIcmn4gcxkIRxd3iIu35CFerEbtANCfGiVdM=;
        b=gzavQ4p7CmdrS35UZ6oSd+8YaVZUTUVlxT0ZLqkfiKKn06e+esfQUqA6UfRRGOr9GvTsEE
        ajFOmf7G6a5SJHfq+v7A1EjYWKaMghy6RXizhlC6tOE7gkfZQkj7/z3h+p7TU4emIETBZP
        BzoCW2kiy39nb//JS2VZg5bvRcXgfsM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-tIPP9WkAM_2_-mui3NaTmw-1; Thu, 25 Feb 2021 14:06:51 -0500
X-MC-Unique: tIPP9WkAM_2_-mui3NaTmw-1
Received: by mail-qk1-f197.google.com with SMTP id o8so5266831qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ntq0VlGIcmn4gcxkIRxd3iIu35CFerEbtANCfGiVdM=;
        b=I9LL3T2AUM1dtSalZUcMJIhS+0u/vl7wr4iZuyNgSJ2mX/0pCPb6b5p156mzOm+cnr
         e85o/XAzIq+nUvGibi+Nn/wgP48Dr2EFoTANcEGr1F/o7BLKhBfjlUstvPWMuYQcAHgi
         4nScYrtfmqgthrvGnJXe+XAzS+Bxm4tNTlDpwqlKJLBXc1PgRGDsIM7/KbaHzN3TjrVu
         +qjHkzo2L2gtnRPvEy5SD3mZKjGIfnHTgd3fCpKOwQc+I5GowRqt4h8CEUdAP3S25Wc4
         fZYR0mRliUeSNd3G+Ru/5cMkuO3fH6edPGhIeR6GjixItrflN1XWuDvEyx03oxxGsOSI
         gtew==
X-Gm-Message-State: AOAM530V0akzzWKBd8+RWcN98GOfHMZGqOPbtd5FItFbnmqbI+0yXKre
        WhxlKWuOzaZD596wgJZgEA7tEp/HsIzaTIMfuXugF9YjfQR4d61v+fOO8SAtOElamG60yR9EiLg
        uLnzJkYWfDXBPlSQvWuevjafJ
X-Received: by 2002:a37:a183:: with SMTP id k125mr4205723qke.332.1614280011439;
        Thu, 25 Feb 2021 11:06:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfK+N05IVgdsA0MDZcag+sGz5potbwSbK8mKsg4vfzFYEPeycGT3qjurTXgTTNpmL/fJDJmQ==
X-Received: by 2002:a37:a183:: with SMTP id k125mr4205707qke.332.1614280011193;
        Thu, 25 Feb 2021 11:06:51 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id j2sm4373993qkk.96.2021.02.25.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:06:50 -0800 (PST)
Date:   Thu, 25 Feb 2021 14:06:46 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/10] vfio/type1: Register device notifier
Message-ID: <20210225190646.GE250483@xz-x1>
References: <161401167013.16443.8389863523766611711.stgit@gimli.home>
 <161401275279.16443.6350471385325897377.stgit@gimli.home>
 <20210222175523.GQ4247@nvidia.com>
 <20210224145508.1f0edb06@omen.home.shazbot.org>
 <20210225002216.GQ4247@nvidia.com>
 <20210225175457.GD250483@xz-x1>
 <20210225181945.GT4247@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225181945.GT4247@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:19:45PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 25, 2021 at 12:54:57PM -0500, Peter Xu wrote:
>  
> > I can't say I fully understand the whole rational behind 5cbf3264bc71, but that
> > commit still sounds reasonable to me, since I don't see why VFIO cannot do
> > VFIO_IOMMU_MAP_DMA upon another memory range that's neither anonymous memory
> > nor vfio mapped MMIO range.
> 
> It is not so much it can't, more that it doesn't and doesn't need to.

OK.

> 
> > In those cases, vm_pgoff namespace defined by vfio may not be true
> > anymore, iiuc.
> 
> Since this series is proposing linking the VMA to an address_space all
> the vm_pgoffs must be in the same namespace

Agreed.  I saw discussions around on redefining the vm_pgoff namespace, I can't
say I followed that closely either, but yes it definitely makes sense to always
use an unified namespace.  Maybe we should even comment it somewhere on how
vm_pgoff is encoded?

> 
> > Or does it mean that we don't want to allow VFIO dma to those unknown memory
> > backends, for some reason?
> 
> Correct. VFIO can map into the IOMMU PFNs it can get a reference
> to. pin_user_pages() works for the majority, special VFIO VMAs cover
> the rest, and everthing else must be blocked for security.

If we all agree that the current follow_pfn() should only apply to vfio
internal vmas, then it seems we can drop it indeed, as long as the crash
reported in 5cbf3264b would fail gracefully at e.g. VFIO_IOMMU_MAP_DMA rather
than triggering a kernel warning somehow.

However I'm still confused on why it's more secure - the current process to do
VFIO_IOMMU_MAP_DMA should at least has proper permission for everything to be
setup, including the special vma, right?  Say, if the process can write to
those memories, then shouldn't we also allow it to grant this write permission
to other devices too?

Thanks,

-- 
Peter Xu

