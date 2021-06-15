Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D483A782E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFOHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhFOHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623743019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5BYj4j/2r6NqdvA1bsc1o0RQ7n98tK7o7BcnsyMqpo=;
        b=jFSkYTXxiHw4Yb2asAz+fAdEkel8Dl13eg9tnEwnf/uegifZIzVR6LjW9O6VwuEQnGqVVO
        TNsZf94mthp3q3FZISX9wxjMrcLST2ZMr9ZLec76qJQAtOMDrEtSYG6tYbo/V2eRxMZ+DJ
        G5STRDCPh9OxrlmYCBHx+Apd98wv/z4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-HfgoTR5hN4GVpUqtl2LICg-1; Tue, 15 Jun 2021 03:43:36 -0400
X-MC-Unique: HfgoTR5hN4GVpUqtl2LICg-1
Received: by mail-wm1-f71.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so211850wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v5BYj4j/2r6NqdvA1bsc1o0RQ7n98tK7o7BcnsyMqpo=;
        b=Paj9zrLQkA8VOQhfStPnigR17G7SximnOYIRfZVf4r/fQ/m1nUucuA2byRHDBV/+rQ
         S9WJ0sQ0ZKB/vseT4lTr2jwrSyYbHYnxg4pMipGcJa534i2DZnH2gr1dYwjaErAiSPMy
         gHiTFegRdKhRLuBLRA2qhNqBtoLGEfBZmc8aTyNXbElhNlxZ1kRQtncCWhS8nJcrrSw9
         jiSCcPY5J+19ivYy9Z8Epw81l5GGSnaukYVUBvC2NnJJzYvjH6hT+WvfFIul5vF0aYpp
         bSOx+MNwg4sWyopnwsCq35FH6GhX34hvVN4zqWvwGK5l+8aoNMUgs6Ocd8LvK5ksqVBu
         QKMQ==
X-Gm-Message-State: AOAM531FGJ+/TJhZUlFJMZH96THC9hTdZH/dvpwykDRsHs5Nnwr2Wwhs
        6AS5B2Tsl81CGNp/w/yksPpqzt1VPm5y/zbiA/pQ+9b4/3YTOtiIA57Ljl/V71BmFUhis5wtxp3
        jhKkg50ycT1Zwkqeg4VoetlG8
X-Received: by 2002:a5d:4408:: with SMTP id z8mr23844153wrq.336.1623743015004;
        Tue, 15 Jun 2021 00:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMxOPKD3EUDoJqW31zoVPS5bmkuhx9H0WhqkSf3TNl8uon/XcN4wF0Lr6RJPhGNltMeiOgrg==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr23844143wrq.336.1623743014831;
        Tue, 15 Jun 2021 00:43:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6136.dip0.t-ipconnect.de. [91.12.97.54])
        by smtp.gmail.com with ESMTPSA id g186sm15065784wme.6.2021.06.15.00.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:43:34 -0700 (PDT)
Subject: Re: [RFC] virtio-mem: virtio_mem_init: Access bb_size just in BBM
 mode
To:     Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
References: <20210615065948.23493-1-teawater@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7fd8bf39-642d-1cdf-bc5d-c19630045013@redhat.com>
Date:   Tue, 15 Jun 2021 09:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615065948.23493-1-teawater@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.21 08:59, Hui Zhu wrote:
> From: Hui Zhu <teawaterz@linux.alibaba.com>
> 
> /* In BBM, we also want at least two big blocks. */
> vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> 			      vm->offline_threshold);
> This line does not modify vm->offline_threshold depending on the data in
> vm->sbm that shares this address is 0 in SBM mode.
> I think it might be difficult to make sure when we change this in the
> future.
> 
> This commit adds an if to make sure that this line just be executed in
> BBM mode.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_mem.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 10ec60d..8185916 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2472,8 +2472,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
>   				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
>   	/* In BBM, we also want at least two big blocks. */
> -	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> -				      vm->offline_threshold);
> +	if (!vm->in_sbm)
> +		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> +					      vm->offline_threshold);
>   
>   	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>   	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> 

Good that you also spotted it, I already have a fix pending for that :)

https://lkml.kernel.org/r/20210602185720.31821-2-david@redhat.com

-- 
Thanks,

David / dhildenb

