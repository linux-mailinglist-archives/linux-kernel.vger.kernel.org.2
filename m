Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82139980E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFCCed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCCec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622687568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taNtlOtsZUjAi05snNFgxAJ5niVmm5tsHS8sJiSNlCE=;
        b=G0HUITQFch1hYcKWOf0w1ElnqFdMgV5+vgODmyzY4yvFNOL9Ez8FoMd74j02CCHXTOrhim
        CMycSY99FxXexjt3x9tbUFjTD3Q2f6qLly+zJj6ZpP33M5T9OudBjTU2+NLEyKXB0GaIg4
        EIu6pL/7pxP6LGWPaDaXEouNsJVmdQo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-vA9YtEHpP2OEaVTsdRflKg-1; Wed, 02 Jun 2021 22:32:47 -0400
X-MC-Unique: vA9YtEHpP2OEaVTsdRflKg-1
Received: by mail-pg1-f197.google.com with SMTP id w185-20020a6362c20000b02902208d90c8c8so2199223pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=taNtlOtsZUjAi05snNFgxAJ5niVmm5tsHS8sJiSNlCE=;
        b=LdwfybSQ9MTnLKy1OPV0R/Jxs4zUnC3xXryiWVbo6AB5uRuRNzFgw25wsVM6fPaZTv
         4PiRXFwG/M6qz3uSRIynqcXD6LnHQIF9j/3KxaalZVHakLtbFEKgBeAwfzmkZqp024LU
         j82EFRH8tvHkg45hsq9UufWNURfg2CQ2dw75mvow3YY+Slid6LzE3EjYURl1Jyf00Psc
         +CG/uDSUOF7HW3SIpGVPofrS7XWsL/NkiWPFNJ9+ji/TfPtVMFVmkFE0bwWRoTLP32tC
         oUm6s/XYDia1LPnO9ex5TL2zcYxlbh0JzgfjNxSM/nW05rqz7RHMg2Wg5PeIjQxica9y
         1Olw==
X-Gm-Message-State: AOAM531v0r8hfUOGUc0+oEIwBGByzDm8uYbGnOvzXyeTwdHtpy7n1N9C
        lj4F8qXRd2lTPE5WQr98Xxk2hpwJyp7M9bGq5wr4Q3I4bZLlNOYtgfWrmBNutzmQTAsZOzFfeAK
        fozF0GZSYzk6fHitXMBh+/bDMZTX9oCOZjtE5vHwiqLb9JL+UFvdVekCEj76nWMhYPfBtZ6vG6x
        Tj
X-Received: by 2002:a62:7b50:0:b029:2ea:9298:1dcb with SMTP id w77-20020a627b500000b02902ea92981dcbmr2002620pfc.1.1622687566597;
        Wed, 02 Jun 2021 19:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz6ep2t7jrZdGAehf8toVNlmui74UZ7cIZFq7uL7XUXGUiUUq0olnaswJvxVuevvgOPn0mCw==
X-Received: by 2002:a62:7b50:0:b029:2ea:9298:1dcb with SMTP id w77-20020a627b500000b02902ea92981dcbmr2002593pfc.1.1622687566256;
        Wed, 02 Jun 2021 19:32:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ip7sm520736pjb.39.2021.06.02.19.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 19:32:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
Date:   Thu, 3 Jun 2021 10:32:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 上午9:48, Andi Kleen 写道:
>
>> So we will see huge performance regression without indirect 
>> descriptor. We need to consider to address this.
>
> A regression would be when some existing case would be slower.
>
> That's not the case because the behavior for the existing cases does 
> not change.
>
> Anyways when there are performance problems they can be addressed, but 
> first is to make it secure.


I agree, but I want to know why indirect descriptor needs to be 
disabled. The table can't be wrote by the device since it's not coherent 
swiotlb mapping.

Thanks


>
> -Andi
>
>
>>
>> Thanks
>>
>>
>>>               break;
>>>           case VIRTIO_RING_F_EVENT_IDX:
>>>               break;
>>> @@ -2231,9 +2240,12 @@ void vring_transport_features(struct 
>>> virtio_device *vdev)
>>>           case VIRTIO_F_ACCESS_PLATFORM:
>>>               break;
>>>           case VIRTIO_F_RING_PACKED:
>>> +            if (protected_guest_has(VM_MEM_ENCRYPT))
>>> +                goto clear;
>>>               break;
>>>           case VIRTIO_F_ORDER_PLATFORM:
>>>               break;
>>> +        clear:
>>>           default:
>>>               /* We don't understand this bit. */
>>>               __virtio_clear_bit(vdev, i);
>>
>

