Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADC3997A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCBt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:49:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:55980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:49:57 -0400
IronPort-SDR: C3rH+OiG5ElAAe1yiMYeP/OCBsm/9GJ9esNaMJe9zW1EsBCEcU/0S5MR4tJCWib/nyNTyYlaFc
 QvkjOBd21eeg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203753700"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203753700"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 18:48:13 -0700
IronPort-SDR: Jyw3YKKGYvj7bwLmvWR2S0qa6bCxBwrGKuTWS3IjTqLGizol08X7sJz0tD5Vwuml83+tl+G6q3
 taWf8WDdxL7A==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550517043"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 18:48:12 -0700
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
Date:   Wed, 2 Jun 2021 18:48:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> So we will see huge performance regression without indirect 
> descriptor. We need to consider to address this.

A regression would be when some existing case would be slower.

That's not the case because the behavior for the existing cases does not 
change.

Anyways when there are performance problems they can be addressed, but 
first is to make it secure.

-Andi


>
> Thanks
>
>
>>               break;
>>           case VIRTIO_RING_F_EVENT_IDX:
>>               break;
>> @@ -2231,9 +2240,12 @@ void vring_transport_features(struct 
>> virtio_device *vdev)
>>           case VIRTIO_F_ACCESS_PLATFORM:
>>               break;
>>           case VIRTIO_F_RING_PACKED:
>> +            if (protected_guest_has(VM_MEM_ENCRYPT))
>> +                goto clear;
>>               break;
>>           case VIRTIO_F_ORDER_PLATFORM:
>>               break;
>> +        clear:
>>           default:
>>               /* We don't understand this bit. */
>>               __virtio_clear_bit(vdev, i);
>
