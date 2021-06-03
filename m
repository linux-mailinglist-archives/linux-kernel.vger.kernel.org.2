Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770F39AB19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:55:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:45226 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCTzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:55:48 -0400
IronPort-SDR: cNWS7CAQAEfPotZtFLpnSONR1pv3JNA3uD6UIgIfBcYVYSK11r4LBYQ9VHgn9gHbqNl7A3lh0O
 HyfDijBCgxYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184507803"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="184507803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 12:53:45 -0700
IronPort-SDR: j796NHDs2Zozxq/wBHEuvMXvyPgtLyCvrhm5igEiL3IiR3qXnYzpqEuyF5uad7fplBhS/dqAsL
 5gvTbni69t6A==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550819682"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 12:53:44 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
Date:   Thu, 3 Jun 2021 12:53:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Tell that to every crypto downgrade attack ever.

That's exactly what this patch addresses.

>
> I see two credible solutions:
>
> 1. Actually harden the virtio driver.
That's exactly what this patchkit, and the alternative approaches, like 
Jason's, are doing.
>
> 2. Have a new virtio-modern driver and use it for modern use cases. Maybe rename the old driver virtio-legacy or virtio-insecure.  They can share code.

In most use cases the legacy driver is not insecure because there is no 
memory protection anyways.

Yes maybe such a split would be a good idea for maintenance and maybe 
performance reasons, but at least from the security perspective I don't 
see any need for it.

>
> Another snag you may hit: virtio’s heuristic for whether to use proper DMA ops or to bypass them is a giant kludge. I’m very slightly optimistic that getting the heuristic wrong will make the driver fail to operate but won’t allow the host to take over the guest, but I’m not really convinced. And I wrote that code!  A virtio-modern mode probably should not have a heuristic, and the various iommu-bypassing modes should be fixed to work at the bus level, not the device level

TDX and SEV use the arch hook to enforce DMA API, so that part is also 
solved.


-Andi

