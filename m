Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC239A12F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFCMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:38:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:55086 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFCMim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:38:42 -0400
IronPort-SDR: hSf7E9petHXXdovaPsOnzPGHbntXlZz795wFr9gkckrkAC0hWw98hRA1cy7lLzzBuJd1dHOUHO
 0UNvcRT9K9kg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265204211"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="265204211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 05:36:55 -0700
IronPort-SDR: DMsT4IunyzTkMTPF0j+HWuKSdADAefIJviCOAMI8H+DVHk0IbyopR6+wX1W0nFTnGGRm62w+1Y
 H1wyY/+b4K/Q==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550676961"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 05:36:54 -0700
Subject: Re: [PATCH v1 6/8] dma: Add return value to dma_unmap_page
To:     Robin Murphy <robin.murphy@arm.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-7-ak@linux.intel.com>
 <c3b15bc2-104b-dace-1f23-608197b18107@arm.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <dbca06fa-d708-3c76-2890-82ca5a781366@linux.intel.com>
Date:   Thu, 3 Jun 2021 05:36:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c3b15bc2-104b-dace-1f23-608197b18107@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
> What it looks like to me is abusing SWIOTLB's internal housekeeping to 
> keep track of virtio-specific state. The DMA API does not attempt to 
> validate calls in general since in many cases the additional overhead 
> would be prohibitive. It has always been callers' responsibility to 
> keep track of what they mapped and make sure sync/unmap calls match, 
> and there are many, many, subtle and not-so-subtle ways for things to 
> go wrong if they don't. If virtio is not doing a good enough job of 
> that, what's the justification for making it the DMA API's problem?

In this case it's not prohibitive at all. Just adding a few error 
returns, and checking the overlap (which seems to have been already 
solved anyways) I would argue the error returns are good practice 
anyways, so that API users can check that something bad happening and 
abort.  The DMA API was never very good at proper error handling, but 
there's no reason at all to continue being bad it forever.

AFAIK the rest just works anyways, so it's not really a new problem to 
be solved.

>
>> A new callback is used to avoid changing all the IOMMU drivers.
>
> Nit: presumably by "IOMMU drivers" you actually mean arch DMA API 
> backends?
Yes
>
>  Furthermore, AFAICS it's still not going to help against exfiltrating 
> guest memory by over-unmapping the original SWIOTLB slot *without* 
> going past the end of the whole buffer,

That would be just exfiltrating data that is already shared, unless I'm 
misunderstanding you.

-Andi


