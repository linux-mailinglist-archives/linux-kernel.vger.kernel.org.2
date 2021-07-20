Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6803CF21E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbhGTCB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345270AbhGTCAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626748874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cx9vRaJKoB0elI+pAj8wQCUn2TBTDPaE649XEXqz5I=;
        b=hmdyk5gEtyRRb86k3BP4cpPzpqwlI+TlV3345xp29UAWOVyICyIYwzBFea7T4/5lIdwB80
        c5837Kr0R0/Q1AF1Gd5lg64grqAis/XIpMQORfdtP1gaoLoGjMJQ4rgCxNFL6OV4h3q0Qg
        iD0LqfElFt1iEU4u9o2Kq/LGG2mVWKc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-gwK0EfI5MS2pWdGwEFADDw-1; Mon, 19 Jul 2021 22:41:13 -0400
X-MC-Unique: gwK0EfI5MS2pWdGwEFADDw-1
Received: by mail-pf1-f197.google.com with SMTP id s187-20020a625ec40000b02903288ce43fc0so15117709pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 19:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9cx9vRaJKoB0elI+pAj8wQCUn2TBTDPaE649XEXqz5I=;
        b=h1hKNzOHZ2mYjIALUqTG+7vjZVkfAvEK04a6YrgQQZkQh6PrNrw/qXKW/L4welVis9
         EedC//jLSgbQbr03jpzBR5BEhjt4pJAP020uQAKEmKSsqnpnymIow4Ed/m7jzUHV+U9X
         Gw1zDSnbBP7Ilr0lDjj6qc9VT4FuNzMHfNyFd9n4LYYuDRcBMmR374N/v9Zbr8PAz9qH
         iZaGdLeKP0EALX2PYFO0i30yopO9ww8R21YJ3VA8LHzU38yKWdEg9dUc6pvahTQLl7kf
         9s0hrlmHDZUeZCJ5XDxoCNTI1MjxFKb+cPZb5dZiEDvwua3yhwAuS1SLN6rwxSF8U3YB
         TnEg==
X-Gm-Message-State: AOAM532vMkxcoTUIyGVWZcOrP57QuhhcOnSsBUXZ7e9OU7Awtt4nBpR8
        lgxFdLVONMhv0qspQr+pUy5YY1S2VmCxXyrIlbVqqk1pQJU/21o+CTaI3RPy6RKs+8M67SQn4sd
        YRedMDVcHrmwLr1/+s0S0P/KDhwtXLbWkF8iQ5tZAEDQ5QVL2ZqSoGvaKTcFm6JYsyYLyZrFl3z
        hJ
X-Received: by 2002:a63:ed47:: with SMTP id m7mr28577597pgk.194.1626748871763;
        Mon, 19 Jul 2021 19:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgxZiwuj0ggtt60dnHTwjkzia6vpHkhohJNoz9AYWKnuY4DXH4sLv44Eyv8ZJljg3HsqDpLg==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr28577572pgk.194.1626748871404;
        Mon, 19 Jul 2021 19:41:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q2sm10838498pfu.205.2021.07.19.19.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 19:41:10 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     tianxianting <xianting.tian@linux.alibaba.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        david@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <b427ac2a-e439-3675-8a42-9fdcd23a5114@redhat.com>
 <d1b6f3d5-22a0-f0a5-ed49-1523dd740ffb@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <76a227a9-1b2c-c433-c8d9-5963fb56028d@redhat.com>
Date:   Tue, 20 Jul 2021 10:41:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d1b6f3d5-22a0-f0a5-ed49-1523dd740ffb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/19 下午12:22, tianxianting 写道:
> thanks,
>
> I checked, actually all virtio drivers have switched to use the helper 
> after this one merged.


Ok. Cool.

Thanks


>
> 在 2021/7/19 上午11:46, Jason Wang 写道:
>>
>> 在 2021/7/16 下午8:46, tianxianting 写道:
>>> Do you interest in this patch? just little improvment:)
>>>
>>> 在 2021/7/13 下午11:38, Xianting Tian 写道:
>>>> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>>>>
>>>> Use the helper virtio_find_vqs().
>>>>
>>>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>>>> ---
>>>>   drivers/virtio/virtio_balloon.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_balloon.c 
>>>> b/drivers/virtio/virtio_balloon.c
>>>> index 510e931..18e0bf3 100644
>>>> --- a/drivers/virtio/virtio_balloon.c
>>>> +++ b/drivers/virtio/virtio_balloon.c
>>>> @@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
>>>>           callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>>>>       }
>>>>   -    err = vb->vdev->config->find_vqs(vb->vdev, 
>>>> VIRTIO_BALLOON_VQ_MAX,
>>>> -                     vqs, callbacks, names, NULL, NULL);
>>>> +    err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>>>> +                callbacks, names, NULL);
>>>>       if (err)
>>>>           return err;
>>>
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>>
>> Maybe it's better to convert all the drivers that doesn't use 
>> virtio_find_vqs{_ctx}.
>>
>> Thanks
>

