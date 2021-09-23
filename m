Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9D415832
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhIWG1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239266AbhIWG1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632378372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71fUOImGUODDyJCOfZ+X9xPf/a4pfZ4Afxj/CEjfaLk=;
        b=f6E8+MZIipTbD+3Ktb52dY80XXvlvWG3EkANabixyf8aF0Pw2vU4Ql0vuRGTWyIlsVyaK/
        jxyUObYbJ7+ZVMZN52by4bFVokJZgJd08fDTGrE4T60nl02I/a645T6JircL2I/I9xHRQN
        gafOgpmeSiSmEKexlUUSiMRhQk78otE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-RtOwM3-SMBK0dsk6rLnXYQ-1; Thu, 23 Sep 2021 02:26:11 -0400
X-MC-Unique: RtOwM3-SMBK0dsk6rLnXYQ-1
Received: by mail-wr1-f70.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso4213459wrw.22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=71fUOImGUODDyJCOfZ+X9xPf/a4pfZ4Afxj/CEjfaLk=;
        b=R0TC/GfBi+y+O9KE8S7d2KJam12fiaBylisqG4zGVdwm4nk2MbwcgSCXc5CXQuM4lc
         CSTkLuW+dEYmcgTZtO5mryeYfGu8gqwwj9XeuLJKkBrP42oPCiwjmaOvoXmImkYycH6f
         bQLA2UwACEsIvY0VQhm9thmSUjg/FEArVHOZRs7yplCMnBxUW6Gw4G4QLizr1QUR2y9Z
         ZU7dSep6saJmyDI6Irp2IGtEnIiYBIPbPqRu/J+/YyT2lmNBpcZ64oVfJItjaCF0a9SM
         9PH/Y85Ie1bH7rnHJ7BIZirXnOo5IigF3o1rgSEeVBohWZCMEJVtoD1uODcbk/05T6hP
         ACxw==
X-Gm-Message-State: AOAM530rCKXW+6M2PJriuOy1d+5hHLr+kui4IAcI1i5vFftx/c/+2NIm
        EL/UlcxZnnLTSeMbu/q3dfR+fZi4eDhMKOEN5nAj+mo0QrLpS+kQOyNBErXr640nRYVnAaj8uFe
        kz7CcCw1pUV4jDnsvZ2DkznKC
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr14004168wmq.97.1632378369831;
        Wed, 22 Sep 2021 23:26:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/DaTIZtdSS0b0eqh6Dbu9+P7YRuw+Cv3OyT69GeFyi7+s2AXNgBTjbFRA58JrR83WfyjtAw==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr14004142wmq.97.1632378369633;
        Wed, 22 Sep 2021 23:26:09 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.21.142])
        by smtp.gmail.com with ESMTPSA id v20sm4386301wra.73.2021.09.22.23.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 23:26:08 -0700 (PDT)
Message-ID: <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
Date:   Thu, 23 Sep 2021 08:26:06 +0200
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
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210922145651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 21:02, Michael S. Tsirkin wrote:
> On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
>> hwrng core uses two buffers that can be mixed in the
>> virtio-rng queue.
>>
>> If the buffer is provided with wait=0 it is enqueued in the
>> virtio-rng queue but unused by the caller.
>> On the next call, core provides another buffer but the
>> first one is filled instead and the new one queued.
>> And the caller reads the data from the new one that is not
>> updated, and the data in the first one are lost.
>>
>> To avoid this mix, virtio-rng needs to use its own unique
>> internal buffer at a cost of a data copy to the caller buffer.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>>   1 file changed, 33 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>> index a90001e02bf7..208c547dcac1 100644
>> --- a/drivers/char/hw_random/virtio-rng.c
>> +++ b/drivers/char/hw_random/virtio-rng.c
>> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>>   struct virtrng_info {
>>   	struct hwrng hwrng;
>>   	struct virtqueue *vq;
>> -	struct completion have_data;
>>   	char name[25];
>> -	unsigned int data_avail;
>>   	int index;
>>   	bool busy;
>>   	bool hwrng_register_done;
>>   	bool hwrng_removed;
>> +	/* data transfer */
>> +	struct completion have_data;
>> +	unsigned int data_avail;
>> +	/* minimal size returned by rng_buffer_size() */
>> +#if SMP_CACHE_BYTES < 32
>> +	u8 data[32];
>> +#else
>> +	u8 data[SMP_CACHE_BYTES];
>> +#endif
> 
> Let's move this logic to a macro in hw_random.h ?
> 
>>   };
>>   
>>   static void random_recv_done(struct virtqueue *vq)
>> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>>   }
>>   
>>   /* The host will fill any buffer we give it with sweet, sweet randomness. */
>> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
>> +static void register_buffer(struct virtrng_info *vi)
>>   {
>>   	struct scatterlist sg;
>>   
>> -	sg_init_one(&sg, buf, size);
>> +	sg_init_one(&sg, vi->data, sizeof(vi->data));
> 
> Note that add_early_randomness requests less:
>          size_t size = min_t(size_t, 16, rng_buffer_size());
> 
> maybe track how much was requested and grow up to sizeof(data)?

I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.

> 
>>   
>>   	/* There should always be room for one buffer. */
>> -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
>> +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> 
> 
> BTW no longer true if DMA API is in use ... not easy to fix,
> I think some changes to virtio API to allow pre-mapping
> s/g for DMA might be needed ...

Is there something I can do here?

Thanks,
Laurent

