Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD042163E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhJDSUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:20:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:40528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233716AbhJDSUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:20:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206344020"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="206344020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 09:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="558600272"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 09:36:21 -0700
Date:   Mon, 4 Oct 2021 09:40:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211004094003.527222e5@jacob-builder>
In-Reply-To: <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
        <20211001123623.GM964074@nvidia.com>
        <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Sat, 2 Oct 2021 01:45:59 +1300, Barry Song <21cnbao@gmail.com> wrote:

> >  
> > > I assume KVA mode can avoid this iotlb flush as the device is using
> > > the page table of the kernel and sharing the whole kernel space. But
> > > will users be glad to accept this mode?  
> >
> > You can avoid the lock be identity mapping the physical address space
> > of the kernel and maping map/unmap a NOP.
> >
> > KVA is just a different way to achive this identity map with slightly
> > different security properties than the normal way, but it doesn't
> > reach to the same security level as proper map/unmap.
> >
> > I'm not sure anyone who cares about DMA security would see value in
> > the slight difference between KVA and a normal identity map.  
> 
> yes. This is an important question. if users want a high security level,
> kva might not their choice; if users don't want the security, they are
> using iommu passthrough. So when will users choose KVA?
Right, KVAs sit in the middle in terms of performance and security.
Performance is better than IOVA due to IOTLB flush as you mentioned. Also
not too far behind of pass-through.

Security-wise, KVA respects kernel mapping. So permissions are better
enforced than pass-through and identity mapping.
To balance performance and security, we are proposing KVA is only supported
on trusted devices. On an Intel platform, it would be based on ACPI SATC
(SoC Integrated Address Translation Cache (SATC) reporting structure, VT-d
spec. 8.2). I am also adding a kernel iommu parameter to allow user
override.


Thanks,

Jacob
