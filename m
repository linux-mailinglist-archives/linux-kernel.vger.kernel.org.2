Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E2399791
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCBh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhFCBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622684173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5CzXftv1cNQGBT4N8klgWnhnGPgyo6sbkOZKNeq8SY=;
        b=NM2vVyMYIQHsMFNOvl++CGuWLyLSKQxOw8GWUszzsKAM95EHvluyZqrTZtcR0yCR10OqvK
        Z4fj91ujcJm8ggAcgTh03uKwlQgb1OMXmmQlBAVX6nkxOXzS8o8L1Q3CyJ78nDZGw6EZNZ
        8zB9T2T/X7PdL34HiDb9qxbLn51X790=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-6SWuBJQ8NNC0QRNQSGqvWg-1; Wed, 02 Jun 2021 21:36:12 -0400
X-MC-Unique: 6SWuBJQ8NNC0QRNQSGqvWg-1
Received: by mail-pj1-f72.google.com with SMTP id kk5-20020a17090b4a05b029016102a8423cso4419925pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y5CzXftv1cNQGBT4N8klgWnhnGPgyo6sbkOZKNeq8SY=;
        b=QHdnXZxdMWax1SI4U31ZHP9cx0qj6zcWzaurQOS0/U8yIMECZBIjjAp/lKVuIgedg2
         BekxSuX9XLsNDgMkWYyU7ow0iECA5JK6tfqoqOecFO3ciCSmdIWHbSMYp3mSbxKehKn8
         q1SYkGN45FguUO2+tu4Jd9zDLnaD7s6vN94msrQaH2QFAvrgvD/LEzDr92jEuKdwd7Qx
         9N0hRfHubTzx7LPvE0adFNW8UPU4v4YEA7KoPHpBZBEn+IZiXoW6NcW0VmezhMxFb3AQ
         id1c+Q7vh8RIHO80nd3SRcWMqx5tEsbb+O79z6EIwbegt633WwvzAz0qn/oOcfPeRwQO
         E5gw==
X-Gm-Message-State: AOAM530CxW9+UjcqgGzC/DEdNCDL+BB3lsU5Sxs2XKImN7mcUbdUQbtv
        p8ywRzwBpk+9pTFuBa4tqLbcqIvpf6+bJL4u4pHrgepfEOSBnEgT8ABNEEoKO21avPXkNdxJG/Z
        b7ZBtKLAfetZFrTuHhuAGL4X043SFPWiqkxwLco6eQNU0bmAmXhbc3jWYHrgXNvx74G8QVMvovu
        IQ
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr33749663pjb.218.1622684171247;
        Wed, 02 Jun 2021 18:36:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRpBImN36GsRv2cKXRVos9rLBUchXt7Oj2wQqMjyXkFNlqv8d2KeJUVTG2Ydk3LiFXcEUIXw==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr33749621pjb.218.1622684170787;
        Wed, 02 Jun 2021 18:36:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u24sm125140pfn.31.2021.06.02.18.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 18:36:10 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
Date:   Thu, 3 Jun 2021 09:36:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-2-ak@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÉÏÎç8:41, Andi Kleen Ð´µÀ:
> When running under TDX the virtio host is untrusted. The bulk
> of the kernel memory is encrypted and protected, but the virtio
> ring is in special shared memory that is shared with the
> untrusted host.
>
> This means virtio needs to be hardened against any attacks from
> the host through the ring. Of course it's impossible to prevent DOS
> (the host can chose at any time to stop doing IO), but there
> should be no buffer overruns or similar that might give access to
> any private memory in the guest.
>
> virtio has a lot of modes, most are difficult to harden.
>
> The best for hardening seems to be split mode without indirect
> descriptors. This also simplifies the hardening job because
> it's only a single code path.
>
> Only allow split mode when in a protected guest. Followon
> patches harden the split mode code paths, and we don't want
> an malicious host to force anything else. Also disallow
> indirect mode for similar reasons.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..f35629fa47b1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/hrtimer.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/protected_guest.h>
>   #include <xen/xen.h>
>   
>   #ifdef DEBUG
> @@ -2221,8 +2222,16 @@ void vring_transport_features(struct virtio_device *vdev)
>   	unsigned int i;
>   
>   	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
> +
> +		/*
> +		 * In protected guest mode disallow packed or indirect
> +		 * because they ain't hardened.
> +		 */
> +
>   		switch (i) {
>   		case VIRTIO_RING_F_INDIRECT_DESC:
> +			if (protected_guest_has(VM_MEM_ENCRYPT))
> +				goto clear;


So we will see huge performance regression without indirect descriptor. 
We need to consider to address this.

Thanks


>   			break;
>   		case VIRTIO_RING_F_EVENT_IDX:
>   			break;
> @@ -2231,9 +2240,12 @@ void vring_transport_features(struct virtio_device *vdev)
>   		case VIRTIO_F_ACCESS_PLATFORM:
>   			break;
>   		case VIRTIO_F_RING_PACKED:
> +			if (protected_guest_has(VM_MEM_ENCRYPT))
> +				goto clear;
>   			break;
>   		case VIRTIO_F_ORDER_PLATFORM:
>   			break;
> +		clear:
>   		default:
>   			/* We don't understand this bit. */
>   			__virtio_clear_bit(vdev, i);

