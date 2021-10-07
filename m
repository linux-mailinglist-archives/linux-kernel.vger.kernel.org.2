Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8B425B52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhJGTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:09:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:42498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233876AbhJGTJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:09:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226239735"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226239735"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 12:07:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="713470498"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 12:07:43 -0700
Date:   Thu, 7 Oct 2021 12:11:27 -0700
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
Message-ID: <20211007121127.53956635@jacob-builder>
In-Reply-To: <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
        <20211001123623.GM964074@nvidia.com>
        <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
        <20211004094003.527222e5@jacob-builder>
        <20211004182142.GM964074@nvidia.com>
        <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Thu, 7 Oct 2021 18:43:33 +1300, Barry Song <21cnbao@gmail.com> wrote:

> > > Security-wise, KVA respects kernel mapping. So permissions are better
> > > enforced than pass-through and identity mapping.  
> >
> > Is this meaningful? Isn't the entire physical map still in the KVA and
> > isn't it entirely RW ?  
> 
> Some areas are RX, for example, ARCH64 supports KERNEL_TEXT_RDONLY.
> But the difference is really minor.
That brought up a good point if we were to use DMA API to give out KVA as
dma_addr for trusted devices. We cannot satisfy DMA direction requirements
since we can't change kernel mapping. It will be similar to DMA direct
where dir is ignored AFAICT.

Or we are saying if the device is trusted, using pass-through is allowed.
i.e. physical address.

Thoughts?

Thanks,

Jacob
