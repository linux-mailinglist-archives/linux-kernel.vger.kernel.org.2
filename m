Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA33997C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCB6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:58:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:25459 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFCB6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:58:19 -0400
IronPort-SDR: oRsrnTnzhLYAbUj1uKUow/1HRm0BZTc3ahGuCFiwZ3dvqAzT4hupl/yAoyh98kitDRxUr9Vooa
 cKiZnrH/QDEQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203972542"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203972542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 18:56:35 -0700
IronPort-SDR: C5MKCIFgSivqj4s0xMPWU5bJ61YOvmOkiOYqHbOXSTq5KqhrzVWVu5om4euFeO0TYD42KUMP+C
 3oyspki/GTFg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550518879"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 18:56:28 -0700
Subject: Re: Virtio hardening for TDX
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <33504152-624a-45cc-51b3-10ce7aa2428f@linux.intel.com>
Date:   Wed, 2 Jun 2021 18:56:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that it's probably needed by other cases as well:
>
> 1) Other encrypted VM technology
> 2) VDUSE[1]
> 3) Smart NICs

Right. I don't see any reason why these shouldn't work. You may just 
need to add the enable for the lockdown, but you can reuse the basic 
infrastructure.

>
> We have already had discussions and some patches have been 
> posted[2][3][4].

Thanks.

Yes [2] is indeed an alternative. We considered this at some point, but 
since we don't care about DOS in our case it seemed simpler to just 
harden the existing code.  But yes if it's there it's useful for TDX too.

FWIW I would argue that the descriptor boundary checking should be added 
in any case, security case or separated metadata or not, because it can 
catch bugs and is very cheap. Checking boundaries is good practice.

[4] would be an independent issue, that's something we didn't catch.

Also the swiotlb hardening implemented in this patchkit doesn't seem to 
be in any of the other patches.

So I would say my patches are mostly orthogonal to these patches below 
and not conflicting, even though they address a similar problem space.

-Andi


