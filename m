Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3843A3C3DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhGKQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 12:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhGKQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 12:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626019698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XELSw37O8TDJHMK3is14sKF8BhQBplTncIZKxDsEcK0=;
        b=VjfCaCBGL8QzlW6E/cp3hW5jJVIkD0lAzvFTLaJJJxIzxXs3OnffRH71ZIXMmaB6QYligv
        C3xrAS0RUlpsqaeEFy+cvp1ibCXaWZLXLT4u1P+c6jyT6jaZu2XnIKgEv8Fw4PPyHSqKWi
        xchx3k+aBCiL1JfBj3OW9sA4Leowir4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-3mVtMmfqPZOoOzHMrOnbpg-1; Sun, 11 Jul 2021 12:08:16 -0400
X-MC-Unique: 3mVtMmfqPZOoOzHMrOnbpg-1
Received: by mail-ed1-f72.google.com with SMTP id x16-20020aa7d6d00000b02903a2e0d2acb7so3524639edr.16
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XELSw37O8TDJHMK3is14sKF8BhQBplTncIZKxDsEcK0=;
        b=CsRv1me01BxT7gis11X472OUEwxU96cJgteUV5xSwkAA7zF930+HPtkkEo5J8weog3
         r68mdS8eOLf+DQoPoSfRO66uIMvRDCBTDTipRYgAs07gM+8/e8mut1DwzwfQ4idUPli8
         +h+LGnY6jXDugP5BHlSZO+qlcqkPqVDEQ+tEwc0iO5Q2BDvd4lPlyouXLADWnTkbXYs0
         4SC5MAsiHKRVy8l2JFfXsBaTu3LRSYSmgu9KKOIOzR40/veraigND96gEH/qNd6Te+k2
         xejCKC79ajJp2D7q5t83ee+raNWoKu5VN1xfGwPLHL62QY18muhLYN8p89T9k1fKIreN
         ILCA==
X-Gm-Message-State: AOAM532rCzbKBqKWSBW2BiKpiA3mLeanrbAt+3BSZHZRA3/q9VJW4nhZ
        0AVISzmACFfkIYGDoCrQLS94jdXWp0hZo910H1xYvYZV/NhnCDwGdaAiy4ZvMu8VhfZDB8A2Pf6
        RfK3hSg/fMzUisdChHu/PMzQQ
X-Received: by 2002:a17:906:5fc1:: with SMTP id k1mr27785402ejv.360.1626019695542;
        Sun, 11 Jul 2021 09:08:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoOutlQAd3/f1sy1nxXxkoEnxMXnTXG9X2/DyP8QFWC6t3h/0LFkJ/lZQlZunhgEyGPQEKoA==
X-Received: by 2002:a17:906:5fc1:: with SMTP id k1mr27785387ejv.360.1626019695342;
        Sun, 11 Jul 2021 09:08:15 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
        by smtp.gmail.com with ESMTPSA id y7sm5292459edc.86.2021.07.11.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:08:14 -0700 (PDT)
Date:   Sun, 11 Jul 2021 12:08:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com, file@sect.tu-berlin.de, ashish.kalra@amd.com,
        konrad.wilk@oracle.com, kvm@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210711120627-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
 <20210514063516-mutt-send-email-mst@kernel.org>
 <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:38:01PM +0800, Jason Wang wrote:
> 
> 在 2021/5/14 下午7:13, Michael S. Tsirkin 写道:
> > On Thu, May 06, 2021 at 01:38:29PM +0100, Christoph Hellwig wrote:
> > > On Thu, May 06, 2021 at 04:12:17AM -0400, Michael S. Tsirkin wrote:
> > > > Let's try for just a bit, won't make this window anyway:
> > > > 
> > > > I have an old idea. Add a way to find out that unmap is a nop
> > > > (or more exactly does not use the address/length).
> > > > Then in that case even with DMA API we do not need
> > > > the extra data. Hmm?
> > > So we actually do have a check for that from the early days of the DMA
> > > API, but it only works at compile time: CONFIG_NEED_DMA_MAP_STATE.
> > > 
> > > But given how rare configs without an iommu or swiotlb are these days
> > > it has stopped to be very useful.  Unfortunately a runtime-version is
> > > not entirely trivial, but maybe if we allow for false positives we
> > > could do something like this
> > > 
> > > bool dma_direct_need_state(struct device *dev)
> > > {
> > > 	/* some areas could not be covered by any map at all */
> > > 	if (dev->dma_range_map)
> > > 		return false;
> > > 	if (force_dma_unencrypted(dev))
> > > 		return false;
> > > 	if (dma_direct_need_sync(dev))
> > > 		return false;
> > > 	return *dev->dma_mask == DMA_BIT_MASK(64);
> > > }
> > > 
> > > bool dma_need_state(struct device *dev)
> > > {
> > > 	const struct dma_map_ops *ops = get_dma_ops(dev);
> > > 
> > > 	if (dma_map_direct(dev, ops))
> > > 		return dma_direct_need_state(dev);
> > > 	return ops->unmap_page ||
> > > 		ops->sync_single_for_cpu || ops->sync_single_for_device;
> > > }
> > Yea that sounds like a good idea. We will need to document that.
> > 
> > 
> > Something like:
> > 
> > /*
> >   * dma_need_state - report whether unmap calls use the address and length
> >   * @dev: device to guery
> >   *
> >   * This is a runtime version of CONFIG_NEED_DMA_MAP_STATE.
> >   *
> >   * Return the value indicating whether dma_unmap_* and dma_sync_* calls for the device
> >   * use the DMA state parameters passed to them.
> >   * The DMA state parameters are: scatter/gather list/table, address and
> >   * length.
> >   *
> >   * If dma_need_state returns false then DMA state parameters are
> >   * ignored by all dma_unmap_* and dma_sync_* calls, so it is safe to pass 0 for
> >   * address and length, and DMA_UNMAP_SG_TABLE_INVALID and
> >   * DMA_UNMAP_SG_LIST_INVALID for s/g table and length respectively.
> >   * If dma_need_state returns true then DMA state might
> >   * be used and so the actual values are required.
> >   */
> > 
> > And we will need DMA_UNMAP_SG_TABLE_INVALID and
> > DMA_UNMAP_SG_LIST_INVALID as pointers to an empty global table and list
> > for calls such as dma_unmap_sgtable that dereference pointers before checking
> > they are used.
> > 
> > 
> > Does this look good?
> > 
> > The table/length variants are for consistency, virtio specifically does
> > not use s/g at the moment, but it seems nicer than leaving
> > users wonder what to do about these.
> > 
> > Thoughts? Jason want to try implementing?
> 
> 
> I can add it in my todo list other if other people are interested in this,
> please let us know.
> 
> But this is just about saving the efforts of unmap and it doesn't eliminate
> the necessary of using private memory (addr, length) for the metadata for
> validating the device inputs.


Besides unmap, why do we need to validate address? length can be
typically validated by specific drivers - not all of them even use it ..

> And just to clarify, the slight regression we see is testing without
> VIRTIO_F_ACCESS_PLATFORM which means DMA API is not used.

I guess this is due to extra cache pressure? Maybe create yet another
array just for DMA state ...

> So I will go to post a formal version of this series and we can start from
> there.
> 
> Thanks
> 
> 
> > 

