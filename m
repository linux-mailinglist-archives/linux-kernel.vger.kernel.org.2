Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1838FC20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhEYIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231730AbhEYIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
        b=iOsAfrrqHKZWQViAAUHhrBhUWcaJQBGdRr+8NQtmil8S/4ue0CejCP4hb5Hhvwq7NIaQw2
        8bMxIGjodLmIiGRkRZ/qocu/hrjkdEw5hmDoMaODWzULkMBt+2VVqDHq8oz0QWBknQZKZr
        pQfudtR7CJb5CSUPa007G8O3b4b74gs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-200KBWvgMYSOPHmI2QVRAA-1; Tue, 25 May 2021 04:06:39 -0400
X-MC-Unique: 200KBWvgMYSOPHmI2QVRAA-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a0564025192b02903888712212fso16898508edd.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
        b=ru6sSrmDM2iQbn9eZL2KHM0JJBtqxER8PFnx6zL7Lv9wGBTBbXdlsNpoTPFcUMAakQ
         hmkjTykrrAdkIikGJsI369/K1Gpc4MOPH49Z6ceAAfoGlERVD36IOAYKQQTq2OICWxeE
         dNdLk2ElU3mQ+Hs/4dNGSkGjo+cBlOnJbp7oJUEht1+vnBGuPe0pyN4g5CQU4SoocNXi
         NQGWekNdLWEYRfajGRjlUaazivTmvoJzR/x9H86CJL5zpbf2+kT906zA5jbhIErKAqDY
         EZ93nXfJTNjRt+KrrFkBDQ0nDokCQVLI9W071BmpgCRPeHURBMqGS5670tax3lSsBzTb
         YwiA==
X-Gm-Message-State: AOAM5302UlzomIUUJlxX2s1OA+jPBOLl3pLe3gH/N0V8S7C0RPe5518I
        LUZHdrLwxPk0vZuYXPidV0cefiElU5lv7Y/6CJh56Qz81AkyI8JkRQ2pCJC2R1CQpfOTYOcv83O
        ttgEvjeiaaEfoWycgs88GOeCa
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr29288930edb.97.1621929998260;
        Tue, 25 May 2021 01:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygZqhf+xYB7Ndg3ayTHtQu/3t0kArAedOP5pe98sDgQVP2z7+rV66oJGM/D3XST8tFG3f5gA==
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr29288906edb.97.1621929998039;
        Tue, 25 May 2021 01:06:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n8sm8645618ejl.0.2021.05.25.01.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 01:06:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com> <YKypgi2qcYVTgYdv@T590>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1997919-e059-b50b-19b3-5741e3309000@redhat.com>
Date:   Tue, 25 May 2021 10:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKypgi2qcYVTgYdv@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/21 09:38, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
>> On 24/05/21 16:59, Christoph Hellwig wrote:
>>> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>>>> Possible drawbacks of this approach:
>>>>
>>>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>>>     expensive since it requires DMA. If such devices become popular then
>>>>     the virtio_blk driver could use a similar approach to NVMe when
>>>>     VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>>>
>>>> - If a blk_poll() thread is descheduled it not only hurts polling
>>>>     performance but also delays completion of non-REQ_HIPRI requests on
>>>>     that virtqueue since vq notifications are disabled.
>>>
>>> Yes, I think this is a dangerous configuration.  What argument exists
>>> again just using dedicated poll queues?
>>
>> There isn't an equivalent of the admin queue in virtio-blk, which would
>> allow the guest to configure the desired number of poll queues.  The number
>> of queues is fixed.
> 
> Dedicated vqs can be used for poll only, and I understand VM needn't to know
> if the vq is polled or driven by IRQ in VM.
> 
> I tried that in v5.4, but not see obvious IOPS boost, so give up.
> 
> https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll

Sure, but polling can be beneficial even for a single queue.  Queues 
have a cost on the host side as well, so a 1 vCPU - 1 queue model may 
not be always the best.

Paolo

