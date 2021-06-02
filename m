Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBB3982C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhFBHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhFBHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622618102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lhy5TNU50fmOq5Bhp93lg/KbZ5b2aX5N5cZ4YcFgRAI=;
        b=I7eEPmNN+UuOgN46OlYTMsOTMv/SZVqs9CsfH0EQB2fGC/t92ub6yO5HXEYmqtPur405Rp
        m7VD+seK7IPyKV16bhxzW8sMXyPw5jBVh1q7PpCHnAmb4VjB4eRjznbMAif0kjjPdS4WmT
        ew8sKVu5elTxSU1uwxReuIntHyJ+RVo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-w8kgeJaYPG6spLPg3GfGtA-1; Wed, 02 Jun 2021 03:15:01 -0400
X-MC-Unique: w8kgeJaYPG6spLPg3GfGtA-1
Received: by mail-pg1-f199.google.com with SMTP id s7-20020a6352470000b029021b9013c124so1116484pgl.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lhy5TNU50fmOq5Bhp93lg/KbZ5b2aX5N5cZ4YcFgRAI=;
        b=erJQwfw3UrkooZwt+8aH5y0UDrpiBejxDawYox2FpWTDv2E+PsytQ8KLHUJhOaFLWZ
         JPWLj9vuH0ICa9EqC+fzh0mYrMd43T+SuCrvkvKM7wtCp2A0JDxKuFL/O6VV24WyHZtA
         vTyL8LgmwICjzuEApn6a1AHHgTr+qGdDKkoHWbjmRevXntukVTONdDiOYEGlNA3ySlRI
         oR6/TzpOlsZvykYIWymnbLxkCQDAqee/HUL8dTxmXYwA70CFtemwoWMDYhj0hHKfhxDV
         3UJvjNZrUM/jFzLbMytPF17DNRc2AEHjsopDGQP39CPt9fX3wfU/Sy8VNyl+yk2Ro4E7
         0FZw==
X-Gm-Message-State: AOAM533YKqDDJafkP67oW/PuOiEQGgYOg/oTA3vxqNKnzs2if4ZACZwf
        vMdMjpVs5M4/MBQiG/KXbMJBIwmefZdria9HHlfs1M4lbKRYp903eGcPmYQniuEkCCs2HaDzyQk
        u/GtoTLlO3RY6JuSTfE2/+nFLaohOzCn/RpOHbuChSoz7xPpjYd+4EHJmlqBrJ5WA/n/51k8y6d
        XY
X-Received: by 2002:a63:1703:: with SMTP id x3mr15032597pgl.421.1622618100356;
        Wed, 02 Jun 2021 00:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxufrPCd7Pf/XaCWAaBdiVWeER94rYldeUimhvZhIrvYw6A2cPFCPX7XVd/UFcPhoryLQJVig==
X-Received: by 2002:a63:1703:: with SMTP id x3mr15032563pgl.421.1622618100025;
        Wed, 02 Jun 2021 00:15:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c134sm15028445pfb.135.2021.06.02.00.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:14:59 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
 <20210518055336-mutt-send-email-mst@kernel.org>
 <4aaf5125-ce75-c72a-4b4a-11c91cb85a72@linux.alibaba.com>
 <72f284c6-b2f5-a395-a68f-afe801eb81be@redhat.com> <YLcePtKhnt9gXq8E@unreal>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b80a2841-32aa-02ff-b2cc-f2fb3eeed9a1@redhat.com>
Date:   Wed, 2 Jun 2021 15:14:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLcePtKhnt9gXq8E@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/2 下午1:59, Leon Romanovsky 写道:
> On Tue, May 25, 2021 at 02:19:03PM +0800, Jason Wang wrote:
>> 在 2021/5/19 下午10:18, Xianting Tian 写道:
>>> thanks, I submit the patch as commented by Andrew
>>> https://lkml.org/lkml/2021/5/18/256
>>>
>>> Actually, if xmit_skb() returns error, below code will give a warning
>>> with error code.
>>>
>>>      /* Try to transmit */
>>>      err = xmit_skb(sq, skb);
>>>
>>>      /* This should not happen! */
>>>      if (unlikely(err)) {
>>>          dev->stats.tx_fifo_errors++;
>>>          if (net_ratelimit())
>>>              dev_warn(&dev->dev,
>>>                   "Unexpected TXQ (%d) queue failure: %d\n",
>>>                   qnum, err);
>>>          dev->stats.tx_dropped++;
>>>          dev_kfree_skb_any(skb);
>>>          return NETDEV_TX_OK;
>>>      }
>>>
>>>
>>>
>>>
>>>
>>> 在 2021/5/18 下午5:54, Michael S. Tsirkin 写道:
>>>> typo in subject
>>>>
>>>> On Tue, May 18, 2021 at 05:46:56PM +0800, Xianting Tian wrote:
>>>>> When met error, we output a print to avoid a BUG().
>>
>> So you don't explain why you need to remove BUG(). I think it deserve a
>> BUG().
> BUG() will crash the machine and virtio_net is not kernel core
> functionality that must stop the machine to prevent anything truly
> harmful and basic.


Note that the BUG() here is not for virtio-net itself. It tells us that 
a bug was found by virtio-net.

That is, the one that produces the skb has a bug, usually it's the 
network core.

There could also be the issue of the packet from untrusted source 
(userspace like TAP or packet socket) but they should be validated there.

Thanks


>
> I would argue that code in drivers/* shouldn't call BUG() macros at all.
>
> If it is impossible, don't check for that or add WARN_ON() and recover,
> but don't crash whole system.
>
> Thanks
>

