Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9144D320
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhKKI1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232209AbhKKI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636619046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTvK+mccx+UjyRl1JmGIPMoCfbXNcpJJ4KW+6cng93Q=;
        b=KwPaX06ubrp1Z+tPBOIk5aHAqktRWm23JLQGFGb9TPMfvHP3+ihcvTWUwopHdUJ+86GloW
        C1gnQk7ChJfZiaIFqGrTeR7QOLowRygEdwZutlbe/RrLAqQGMY0Ml1SAkUToyYoHEDDKIJ
        GzsViYauQcTMbAACZsYL/lA5VpHql6I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-_WgPA7b-MRiQi5-ZsQBp2Q-1; Thu, 11 Nov 2021 03:24:03 -0500
X-MC-Unique: _WgPA7b-MRiQi5-ZsQBp2Q-1
Received: by mail-ed1-f69.google.com with SMTP id o15-20020a056402438f00b003e32b274b24so4718561edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eTvK+mccx+UjyRl1JmGIPMoCfbXNcpJJ4KW+6cng93Q=;
        b=ysLWOiU+hLe1hvbug1eByKEgL9/hXi9jSVpPG6xYkuH/+LeTzRhfqDV627wiGdJ9hQ
         iWrTuN/GHm50V8tOZRynw4iKbhOg6NF85a8ytMMBXrKAVitgM6AQh62H5VD5zCHpdCK7
         a+X7WPlFXyHv/PHX3JhWUWXsjC+4rUyd95QmwuCtEQPTsyx0bbpev/arZvPGpkCu83pn
         +EvU1wS5Kz7FIB1wNL8qAwPuR7z7OcIPqUHUg3vamSWbgrev1LDm9mciPYUB/iaSJcOc
         7XFvd71Y0BjDxMTKX2lXRubdRGQPMnCv2H3nHEEBHgB2hxLEAvdLu/1AZBB6p8oNFb1A
         W/Tw==
X-Gm-Message-State: AOAM530hY0oYApSdwN560uNwcWLLHgy3N5vaaEzp+cZLJw0L6R8WYRR7
        RYscd9sw+jHTvM/zsZOWg/EWbHIx2geFMf2RxqsXKMsYOr7Hd8jW7d+RBo37/n0XnFZnMUvrlHY
        NCJ4cSbcNoH/DIcBV7YNjVq7Y
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr7672890edv.74.1636619042091;
        Thu, 11 Nov 2021 00:24:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh7NgnQKeWuePv51kZSn8tyMvV9om4wE15juGxL0CTJycLN+t5HM5JPD2xUZKatGFu6H1MkA==
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr7672859edv.74.1636619041867;
        Thu, 11 Nov 2021 00:24:01 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id go17sm920469ejc.76.2021.11.11.00.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 00:24:01 -0800 (PST)
Message-ID: <c759c222-34a5-7ee6-933a-457bb98bab81@redhat.com>
Date:   Thu, 11 Nov 2021 09:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Content-Language: en-US
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Sergio Lopez Pascual <slp@redhat.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110111718.5cvt6vgory3fzqld@steredhat>
 <9901a74b149d4245b0e6c998b5cde7af@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9901a74b149d4245b0e6c998b5cde7af@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 09:14, Wang, Wei W wrote:
>> Adding Andra and Sergio, because IIRC Firecracker and libkrun 
>> emulates virtio-vsock with virtio-mmio so the implementation
>> should be simple and also not directly tied to a specific VMM.
>> 
> OK. This would be OK for KVM based guests. For Hyperv and VMWare 
> based guests, they don't have virtio-mmio support. If the MigTD (a 
> special guest) we provide is based on virtio-mmio, it would not be 
> usable to them.

Hyper-V and VMware (and KVM) would have to add support for
hypercall-vsock anyway.  Why can't they just implement a subset of
virtio-mmio?  It's not hard and there's even plenty of permissively-
licensed code in the various VMMs for the *BSDs.

In fact, instead of defining your own transport for vsock, my first idea
would have been the opposite: reuse virtio-mmio for the registers and
the virtqueue format, and define your own virtio device for the MigTD!

Thanks,

Paolo

