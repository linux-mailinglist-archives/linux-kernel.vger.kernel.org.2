Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4374227D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhJENcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235020AbhJENcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633440652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1i8Euern9P25K11N8MWPbpda+LgMAsFjt0OleN5ka4=;
        b=OgcRnWCVf1b4BaQJizo06sHQTUJjf/KZQ4tqDUmD0eiCkwwnv5OKBwB1Vu3X8URhDgHlk2
        s6OrY/BUmPCAWMNyoWYiVr8cRHeeGp43AR+UxqYNn3oVD+rqLE2qRhBC9lLa9YTNUcZsQF
        NUXRi1HclIZdosv6o6s5otnNpdpl268=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-OOHMfYtON1Gm0zQ_m0rHRA-1; Tue, 05 Oct 2021 09:30:51 -0400
X-MC-Unique: OOHMfYtON1Gm0zQ_m0rHRA-1
Received: by mail-wm1-f72.google.com with SMTP id f11-20020a7bcd0b000000b0030d72d5d0bcso1296471wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1i8Euern9P25K11N8MWPbpda+LgMAsFjt0OleN5ka4=;
        b=h9GUM7T5kDLgkEP4jB9hVGUg01UmxJdM/Mr3XdhnySjfkf5WlP5mKbQsYQR1SAiSyc
         h6Rn2cByGXYbpKqp3X6El3H9UXaRYN2A7MbtFpw+WjSjB6VM9nPTxn1eHCBkrIEt1h/T
         OzMWLN9etVfDrPHrRmdT/s/IZ7D/zcMMeGA6bRnFEailK9rQly9zN2qcV1a0w6g/G95t
         V/2AfAoZrzeQqfMXjVJH+qnj2LyxbRj4O4K6vLbfs3j8UU76Agu1QgDm5/kctmG3+n5N
         jJeV97sl2apKGJv7VuUi2hJprnmmKMqFmgI5qWOhjjFug9ET0+HAAFNsN22Ex4Fg6U6P
         2r/A==
X-Gm-Message-State: AOAM532O5Uc/qHH5nkRHcCs5tP5JnpKtqgzYuLYLvTab6pUmEZZftuux
        hTELdtcwOqQNB1jd6L3umcOeqTPsEh1jN6w1Eads9/1VpFH/47fWuZ4G4CBzk6//7MNGD/aUwbO
        AbTZUwREyOP4VvyDb97U8+4UN
X-Received: by 2002:adf:f94b:: with SMTP id q11mr21752286wrr.408.1633440649631;
        Tue, 05 Oct 2021 06:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOOs163cK4VZu3EocaK1ey7lkWDzdoDW8k0yZYvyozSF8o+cLe2SMVDBPk8+nISneLdVSrhQ==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr21752251wrr.408.1633440649399;
        Tue, 05 Oct 2021 06:30:49 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.3.114])
        by smtp.gmail.com with ESMTPSA id z12sm17751793wrv.31.2021.10.05.06.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 06:30:48 -0700 (PDT)
Message-ID: <40a84813-afc4-049b-2713-8bdad9c4bc20@redhat.com>
Date:   Tue, 5 Oct 2021 15:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org, Dmitriy Vyukov <dvyukov@google.com>,
        rusty@rustcorp.com.au, amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
 <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
 <20210923030026-mutt-send-email-mst@kernel.org>
 <fcd17df1-5aed-346b-e7cd-abe4dfb67e69@redhat.com>
 <20211005075433-mutt-send-email-mst@kernel.org>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20211005075433-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 13:55, Michael S. Tsirkin wrote:
> On Thu, Sep 23, 2021 at 09:34:18AM +0200, Laurent Vivier wrote:
>> On 23/09/2021 09:04, Michael S. Tsirkin wrote:
>>> On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
>>>> On 22/09/2021 21:02, Michael S. Tsirkin wrote:
>>>>> On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
>>>>>> hwrng core uses two buffers that can be mixed in the
>>>>>> virtio-rng queue.
>>>>>>
>>>>>> If the buffer is provided with wait=0 it is enqueued in the
>>>>>> virtio-rng queue but unused by the caller.
>>>>>> On the next call, core provides another buffer but the
>>>>>> first one is filled instead and the new one queued.
>>>>>> And the caller reads the data from the new one that is not
>>>>>> updated, and the data in the first one are lost.
>>>>>>
>>>>>> To avoid this mix, virtio-rng needs to use its own unique
>>>>>> internal buffer at a cost of a data copy to the caller buffer.
>>>>>>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>> ---
>>>>>>     drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>>>>>>     1 file changed, 33 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>>>>>> index a90001e02bf7..208c547dcac1 100644
>>>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>>>> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>>>>>>     struct virtrng_info {
>>>>>>     	struct hwrng hwrng;
>>>>>>     	struct virtqueue *vq;
>>>>>> -	struct completion have_data;
>>>>>>     	char name[25];
>>>>>> -	unsigned int data_avail;
>>>>>>     	int index;
>>>>>>     	bool busy;
>>>>>>     	bool hwrng_register_done;
>>>>>>     	bool hwrng_removed;
>>>>>> +	/* data transfer */
>>>>>> +	struct completion have_data;
>>>>>> +	unsigned int data_avail;
>>>>>> +	/* minimal size returned by rng_buffer_size() */
>>>>>> +#if SMP_CACHE_BYTES < 32
>>>>>> +	u8 data[32];
>>>>>> +#else
>>>>>> +	u8 data[SMP_CACHE_BYTES];
>>>>>> +#endif
>>>>>
>>>>> Let's move this logic to a macro in hw_random.h ?
>>>>>
>>>>>>     };
>>>>>>     static void random_recv_done(struct virtqueue *vq)
>>>>>> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>>>>>>     }
>>>>>>     /* The host will fill any buffer we give it with sweet, sweet randomness. */
>>>>>> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
>>>>>> +static void register_buffer(struct virtrng_info *vi)
>>>>>>     {
>>>>>>     	struct scatterlist sg;
>>>>>> -	sg_init_one(&sg, buf, size);
>>>>>> +	sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>>>
>>>>> Note that add_early_randomness requests less:
>>>>>            size_t size = min_t(size_t, 16, rng_buffer_size());
>>>>>
>>>>> maybe track how much was requested and grow up to sizeof(data)?
>>>>
>>>> I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.
>>>
>>> the issue I'm pointing out is that we are requesting too much
>>> entropy from host - more than guest needs.
>>
>> Yes, guest asks for 16 bytes, but we request SMP_CACHE_BYTES (64 on x86_64),
>> and these 16 bytes are used with add_device_randomness(). With the following
>> patches, the remaining 48 bytes are used rapidly by hwgnd kthread or by the
>> next virtio_read.
>>
>> If there is no enough entropy the call is simply ignored as wait=0.
>>
>> At this patch level the call is always simply ignored (because wait=0) and
>> the data requested here are used by the next read that always asks for a
>> SMP_CACHE_BYTES bytes data size.
>>
>> Moreover in PATCH 4/4 we always have a pending request of size
>> SMP_CACHE_BYTES, so driver always asks a block of this size and the guest
>> takes what it needs.
>>
>> Originally I used a 16 bytes block but performance are divided by 4.
>>
>> Do you propose something else?
>>
>> Thanks,
>> Laurent
> 
> Maybe min(size, sizeof(vi->data))?
> 
But it means, in the case of mixed buffers, we will ask 16 bytes on the first call, not 
use it, and  ask SMP_CACHE_BYTES bytes on the next call to get only 16:

- add_early_randomness() asks for 16 bytes but wait = 0 and thus the request is queued but 
not used. add_early_randomness() is called when we switch from one hw_random backend to 
another (so generally only once...)

- hwrng_fillfn() and rng_dev_read() always ask rng_buffer_size() (max(32, SMP_CACHE_BYTES)).

So we can say we use SMP_CACHE_BYTES in 99% of the cases.

Moreover, this will be discarded by patch 3 and 4 as we have a loop to ask more data in a 
fixed size buffer.

I'm not sure it's worth introducing this change in this patch.

Thanks,
Laurent

