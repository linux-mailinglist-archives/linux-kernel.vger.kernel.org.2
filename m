Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2386395680
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEaHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEaHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622447489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNGA1jL4s1cXzURPp/0nj2H5xrOIbUXubYxtkYgHXmM=;
        b=IxWuoV2hFPm5/EawJKwrpLjeuIEXaTkVN830/TMT+DVXFZvQj+X1s7M9hgpeLCEfnbbYmJ
        /GGz/tPS84cqaxuDBfUQO0gjOnoNUX8XDOkmDdMI+D1uzB9DSEgv+8tsxE6/IOgmrZBtdU
        aLKLqWD+BVN1u8O0QFv/KmYfDFg+ZSw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-EOmG_lbOMFCUmO6b5sDHgA-1; Mon, 31 May 2021 03:51:27 -0400
X-MC-Unique: EOmG_lbOMFCUmO6b5sDHgA-1
Received: by mail-pf1-f197.google.com with SMTP id s5-20020aa78d450000b02902ace63a7e93so5533495pfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bNGA1jL4s1cXzURPp/0nj2H5xrOIbUXubYxtkYgHXmM=;
        b=ENBjdhWjExWy4XUFQWTq++rzoqb/4V254dWiiJlcAnDKNe9gBw5SaX2Yp1XJQtxTvp
         OWBbga2kbSE/snAiT3zPspGG2X6z6bwnr/x/Nsby1Ls55Y36duMZr8keh6mPLePslSQb
         Dr8MQqku/qfbHTH28VfaIcd08xj6k1aXHBieg/JaI2s/AjHCFeFKHu/2oumjH5pVpOwo
         gvqlZlPXfjgTIo//BpECMw36/1ZBk1FK3kdnFfyWW0tUVClAuhplimDSDpDXFGo9dB+V
         H2bWEPItnWKqkkla+OulMjelBM3/Up1GFft9zFKPfSqqEJ1scZk365Ud59CWg8+DyXq0
         rCcA==
X-Gm-Message-State: AOAM5329Ct0Jw5HAGRbeMRLJh3+1a+OhajAkODWll8FnV1fParf5uE9J
        utBCPQon1zYTI7zYiHHOhL2p/ntx27sCoLzNLey+LP7G8xMbRSsUEqNrvL7ryUWY05PuK1GeTYL
        CDrRy6MjbUPhSvDgfB5OSFWX7Io8v09PsH74LJR42ymy/xxZjdv9jc4MjxhmAV3IZZNajv//U1F
        xv
X-Received: by 2002:a62:828f:0:b029:2e9:1449:4269 with SMTP id w137-20020a62828f0000b02902e914494269mr15634111pfd.6.1622447486436;
        Mon, 31 May 2021 00:51:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0CMdqh/gqxDzY6nw0FnXAh/wMfejyrnXngWxGVTIiHVeU9O/RV3kFZY0/yKKbzZhYNYlaVA==
X-Received: by 2002:a62:828f:0:b029:2e9:1449:4269 with SMTP id w137-20020a62828f0000b02902e914494269mr15634083pfd.6.1622447486045;
        Mon, 31 May 2021 00:51:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c17sm11010862pgm.3.2021.05.31.00.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:51:25 -0700 (PDT)
Subject: Re: [PATCH v3] virtio-net: Add validation for used length
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20210528121157.105-1-xieyongji@bytedance.com>
 <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
 <CACycT3uo-J3MYdEo0TscENewp3Xnjce8yFLtt6JkK8uZrvsMjg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4ff90e78-0c7a-def6-ef84-367bcce4cea5@redhat.com>
Date:   Mon, 31 May 2021 15:51:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uo-J3MYdEo0TscENewp3Xnjce8yFLtt6JkK8uZrvsMjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/31 下午3:19, Yongji Xie 写道:
> On Mon, May 31, 2021 at 2:49 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/28 下午8:11, Xie Yongji 写道:
>>> This adds validation for used length (might come
>>> from an untrusted device) to avoid data corruption
>>> or loss.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    drivers/net/virtio_net.c | 28 +++++++++++++++++++++-------
>>>    1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 073fec4c0df1..01f15b65824c 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -732,6 +732,17 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>
>>>        rcu_read_lock();
>>>        xdp_prog = rcu_dereference(rq->xdp_prog);
>>> +     if (unlikely(len > GOOD_PACKET_LEN)) {
>>> +             pr_debug("%s: rx error: len %u exceeds max size %d\n",
>>> +                      dev->name, len, GOOD_PACKET_LEN);
>>> +             dev->stats.rx_length_errors++;
>>> +             if (xdp_prog)
>>> +                     goto err_xdp;
>>> +
>>> +             rcu_read_unlock();
>>> +             put_page(page);
>>> +             return NULL;
>>> +     }
>>>        if (xdp_prog) {
>>>                struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>>                struct xdp_frame *xdpf;
>>> @@ -888,6 +899,16 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>
>>>        rcu_read_lock();
>>>        xdp_prog = rcu_dereference(rq->xdp_prog);
>>> +     if (unlikely(len > truesize)) {
>>> +             pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>>> +                      dev->name, len, (unsigned long)ctx);
>>> +             dev->stats.rx_length_errors++;
>>> +             if (xdp_prog)
>>> +                     goto err_xdp;
>>> +
>>> +             rcu_read_unlock();
>>> +             goto err_skb;
>>> +     }
>>
>> Patch looks correct but I'd rather not bother XDP here. It would be
>> better if we just do the check before rcu_read_lock() and use err_skb
>> directly() to avoid RCU/XDP stuffs.
>>
> If so, we will miss the statistics of xdp_drops. Is it OK?


It should be ok, we still had drops and it was dropped before dealing 
with XDP.

The motivation is to have simple codes.

Thanks


>
> Thanks,
> Yongji
>

