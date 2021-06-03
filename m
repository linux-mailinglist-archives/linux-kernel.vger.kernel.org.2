Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382B639A9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFCSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:03:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:4287 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhFCSDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:03:41 -0400
IronPort-SDR: oL7hzVOXAmKP/jHPbl+YWvyt0sLXGgIT3isq4ZyhOBKxGvoJZAU+uSG1ohEb7I3VnNiLl7MDS2
 Ksb/pZkhTfkA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191216405"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="191216405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:00:51 -0700
IronPort-SDR: zWl9IAVAqjS/nU7br8N4D0lZd7U38PTrXKOJDam1wiKAadNjauAH+/i6mcx4J0u5MOYtULc7BU
 orc5GUV+Jo2Q==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550787338"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:00:48 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Date:   Thu, 3 Jun 2021 11:00:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/2021 10:33 AM, Andy Lutomirski wrote:
> On 6/2/21 5:41 PM, Andi Kleen wrote:
>> Only allow split mode when in a protected guest. Followon
>> patches harden the split mode code paths, and we don't want
>> an malicious host to force anything else. Also disallow
>> indirect mode for similar reasons.
> I read this as "the virtio driver is buggy.  Let's disable most of the
> buggy code in one special case in which we need a driver without bugs.
> In all the other cases (e.g. hardware virtio device connected over
> USB-C), driver bugs are still allowed."

My understanding is most of the other modes (except for split with separate descriptors) are obsolete and just there for compatibility. As long as they're deprecated they won't harm anyone.

-Andi

