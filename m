Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA039118A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEZHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232129AbhEZHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622015548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVw3shBSRM9cCjmRdNWLJQgAvu0wuJKkFQWrzs4FqGI=;
        b=PPH9fImOcx+rnQUqw2sz6VqZ4OGPC+A+mFFt/hK3d7+Q5zZhIPNNBGLzBdanWG4NONQUTj
        Y3IoQ4ri9cGEk3ZEmAhxunxvPisrpHfv+044QpGfkyoqJHwNFFdaOuMI/fO2FK1eZBqRM4
        tFzf/+J8/fvIptNDTd81c1WauU01iSM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-SNtY-jH_P6qLmFnujNpbhg-1; Wed, 26 May 2021 03:52:26 -0400
X-MC-Unique: SNtY-jH_P6qLmFnujNpbhg-1
Received: by mail-pg1-f199.google.com with SMTP id a10-20020a65418a0000b029021b78388f57so203048pgq.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dVw3shBSRM9cCjmRdNWLJQgAvu0wuJKkFQWrzs4FqGI=;
        b=fDvnb7WrCpNE5VosS8QN+5nZuElwYiVyI9Jsf0Swqh2bh5T5RnYC160vPZdiDxKj2c
         oSl1mUquk/i3FIpVVdVVNM7qIRWETbQAVpdFsYHg8xgi6H0W8qm3uUUZXFrnv+b2/vx0
         b9oYWk97D0MzRYMnewRQRh0o+3moCJYWcbGb61JRSWX7XHPf0r/f+i0+R3DVFhwodKDS
         pO9sRTUVsmjtJNV5bukQvwyNns91OERyp7hobldmCSgvRy4X8PQyD7om11ooSxnZvY92
         CH0AtLxOwXAY0w5RkM69P5KExnpRRHIhGBdpcrZanuN3QQogDLBpbwRKPb29ORe48GIG
         8ORw==
X-Gm-Message-State: AOAM532vhfyBvLzNcqgdvNqCz00Rwo85L3XtbZ+UQPwq8COMyIMfdK8m
        ZSKuiyp+/ZY9D181GlkYkWoP36D1TkgzMIafWuMtjf0D4eIDmAnGrhQeM6FxB18KDQRDWvHJatj
        zNPqNs5g9cCvNR97vlJOqYu/yF5cmvajI48lx9hnO/y97AoWwEnv7O1Y+0rGY3FW5SbLYFVBrng
        sX
X-Received: by 2002:a17:90a:ac04:: with SMTP id o4mr34169891pjq.114.1622015545292;
        Wed, 26 May 2021 00:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlZ4+ufAUqXTa/BSHAz2PdlAOim2N8MhD4LPOb3cUXLInNAVYMiHTUODnYlzBp1l/jEmNg5A==
X-Received: by 2002:a17:90a:ac04:: with SMTP id o4mr34169864pjq.114.1622015544950;
        Wed, 26 May 2021 00:52:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y129sm1697041pfy.123.2021.05.26.00.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 00:52:24 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: Add validation for used length
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20210525045838.1137-1-xieyongji@bytedance.com>
 <75e26cf1-6ee8-108c-ff48-8a23345b3ccc@redhat.com>
 <CACycT3s1VkvG7zr7hPciBx8KhwgtNF+CM5GeSJs2tp-2VTsWRw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <efb7d2e0-39b0-129d-084b-122820c93138@redhat.com>
Date:   Wed, 26 May 2021 15:52:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3s1VkvG7zr7hPciBx8KhwgtNF+CM5GeSJs2tp-2VTsWRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/25 下午4:45, Yongji Xie 写道:
> On Tue, May 25, 2021 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/25 下午12:58, Xie Yongji 写道:
>>> This adds validation for used length (might come
>>> from an untrusted device) to avoid data corruption
>>> or loss.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    drivers/net/virtio_net.c | 22 ++++++++++++++++++++++
>>>    1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index c4711e23af88..2dcdc1a3c7e8 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -668,6 +668,13 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>                void *orig_data;
>>>                u32 act;
>>>
>>> +             if (unlikely(len > GOOD_PACKET_LEN)) {
>>> +                     pr_debug("%s: rx error: len %u exceeds max size %lu\n",
>>> +                              dev->name, len, GOOD_PACKET_LEN);
>>> +                     dev->stats.rx_length_errors++;
>>> +                     goto err_xdp;
>>> +             }
>>
>> Need to count vi->hdr_len here?
>>
> We did len -= vi->hdr_len before.


Right.


>
>>> +
>>>                if (unlikely(hdr->hdr.gso_type))
>>>                        goto err_xdp;
>>>
>>> @@ -739,6 +746,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>        }
>>>        rcu_read_unlock();
>>>
>>> +     if (unlikely(len > GOOD_PACKET_LEN)) {
>>> +             pr_debug("%s: rx error: len %u exceeds max size %lu\n",
>>> +                      dev->name, len, GOOD_PACKET_LEN);
>>> +             dev->stats.rx_length_errors++;
>>> +             put_page(page);
>>> +             return NULL;
>>> +     }
>>> +
>>>        skb = build_skb(buf, buflen);
>>>        if (!skb) {
>>>                put_page(page);
>>> @@ -822,6 +837,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>                void *data;
>>>                u32 act;
>>>
>>> +             if (unlikely(len > truesize)) {
>>> +                     pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>>> +                              dev->name, len, (unsigned long)ctx);
>>> +                     dev->stats.rx_length_errors++;
>>> +                     goto err_xdp;
>>> +             }
>>
>> There's a similar check after the XDP, let's simply move it here?
> Do we still need that in non-XDP cases?


I meant we check once for both XDP and non-XDP if we do it before if 
(xdp_prog)


>
>> And do we need similar check in receive_big()?
>>
> It seems that the check in page_to_skb() can do similar things.


Right.

Thanks


>
> Thanks,
> Yongji
>

