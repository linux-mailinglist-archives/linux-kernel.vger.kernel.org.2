Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647823997F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhFCCUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:20:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:51886 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFCCUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:20:08 -0400
IronPort-SDR: 9Fe6yUzHp/t3G31d4O+3IAGifjumUfGeudE74bz/0S0n3cgF8+aCNUj5sFySZvaNPvZ84YryjG
 4CGEEuNGNbpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203937411"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203937411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:18:22 -0700
IronPort-SDR: aIgogudB/xgPovZkty4cGTTVDDPkaoIn4LK55UWXjGi7xxn4m2KSblfJrn5zToJE+9XWx2Tmjb
 bp5VXHB4Xb5Q==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550525649"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:18:21 -0700
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
 <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
Date:   Wed, 2 Jun 2021 19:18:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> It looks to me all the evils came from the fact that we depends on the 
> descriptor ring.
>
> So the checks in this patch could is unnecessary if we don't even read 
> from the descriptor ring which could be manipulated by the device.
>
> This is what my series tries to achieve:
>
> https://www.spinics.net/lists/kvm/msg241825.html

I would argue that you should boundary check in any case. It was always 
a bug to not have boundary checks in such a data structure with multiple 
users, trust or not.

But yes your patch series is interesting and definitely makes sense for 
TDX too.

Best would be to have both I guess, and always check the boundaries 
everywhere.

So what's the merge status of your series?

-Andi


