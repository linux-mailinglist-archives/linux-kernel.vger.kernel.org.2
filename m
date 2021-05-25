Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACA38FB94
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhEYHYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhEYHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621927374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
        b=hPIlwJnriI/zg+v9A0OywrYi2fTIyrS1r/0LoSdtabPnIjRIOLorK1RhGUIJOhw9ttQW0Q
        gWRklfXTN/mNO4aJT11whoguIWvZqsMwn7ZwohcAw8uE6s9Vfl1EQ/Wld6Z2DX9iv9/9zY
        RWvqvhPBZUAEVVp2wixIKXeMw+NydQg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-AuD0aaVHNCuC-VgHv9ittA-1; Tue, 25 May 2021 03:22:51 -0400
X-MC-Unique: AuD0aaVHNCuC-VgHv9ittA-1
Received: by mail-ed1-f69.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so16986435edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
        b=fZSHLP5Pq/JrO4dygrSrXaamorVUHe8M5H6NWqtDb7nlQQemR8opQI5DwjzmMBEWOl
         ChOzJ4N5h5Dks6swYnDFlFfXV3iSCkxDR0PeENOlQxnPVb0z9RodO/CaM5Y6MRdr+UqZ
         /S4QIhrIlVnSgLANKGVDR5/hy91JJFkhQHsd68Ad98hhUtO+XB7awncmrxCe6JpzOwJf
         YcXTaRCnnmmdtkVBOj/eDTNPGZiCMnCNb13XbxYDuIjCdnsoer6APeYZwKbF7p7jaPeJ
         +CUDsmExeh+BE6J2oex/EtoBKpzUpZHWOMXRgWPRaf9+eqnK0CMDZ+ygMQ9V/J0ojr+9
         TjFQ==
X-Gm-Message-State: AOAM533MQKynUl+9IebrXPCVk+1M3wJtTwHAxcSYcIGRQ+r5PY7X6aQd
        GDgqphjeb2EWGVc+AkDaGFjw5s6FHB4GZt3h6PveapzGUdQKZ3sEoeUOMevUFQM3WKk1vAL/yjS
        BmWPJPcWS33dCyTTzJS1i4zZK
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866813edy.224.1621927369844;
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS0no7nsHNRCqlg+nhqUCjlv+Qptu6bm1cQU9E9Jv2TBtMJhNOQr2oL6OuXDEhh8h9h/8pgA==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866806edy.224.1621927369711;
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g10sm8661205ejd.109.2021.05.25.00.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
To:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
Date:   Tue, 25 May 2021 09:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524145928.GA3873@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/21 16:59, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>> Possible drawbacks of this approach:
>>
>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>    expensive since it requires DMA. If such devices become popular then
>>    the virtio_blk driver could use a similar approach to NVMe when
>>    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>
>> - If a blk_poll() thread is descheduled it not only hurts polling
>>    performance but also delays completion of non-REQ_HIPRI requests on
>>    that virtqueue since vq notifications are disabled.
> 
> Yes, I think this is a dangerous configuration.  What argument exists
> again just using dedicated poll queues?

There isn't an equivalent of the admin queue in virtio-blk, which would 
allow the guest to configure the desired number of poll queues.  The 
number of queues is fixed.

Could the blk_poll() thread use preempt notifiers to enable/disable 
callbacks, for example using two new .poll_start and .end_poll callbacks 
to struct blk_mq_ops?

Paolo

