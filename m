Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87D39A294
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFCN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:57:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:32352 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhFCN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:57:04 -0400
IronPort-SDR: fIc/hf6nHugKq0FiJhkuK6xEzI9Btozra7WnMZB9cEckJa5Z0R6q3p01poTt074ezC2cpCCXFJ
 2PixF+vV7pNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="267910102"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="267910102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:55:09 -0700
IronPort-SDR: WSa7HuZNkrlwz34Gbfei5TXfLURTgD2GlmLyG8N/jgYZni0MyjUmN6cSa58+JEkd6TyCxYnzg9
 guBhNlSSzzuA==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550698748"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:55:09 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
 <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
Date:   Thu, 3 Jun 2021 06:55:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, but what I meant is this, if we don't read from the descriptor 
> ring, and validate all the other metadata supplied by the device (used 
> id and len). Then there should be no way for the device to suppress 
> the dma flags to write to the indirect descriptor table.
>
> Or do you have an example how it can do that?

I don't. If you can validate everything it's probably ok

The only drawback is even more code to audit and test.

-Andi


