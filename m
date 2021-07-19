Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D83CCCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhGSEZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 00:25:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:27312 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhGSEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:25:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UgB0hYy_1626668564;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UgB0hYy_1626668564)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 12:22:45 +0800
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     Jason Wang <jasowang@redhat.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        david@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <b427ac2a-e439-3675-8a42-9fdcd23a5114@redhat.com>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <d1b6f3d5-22a0-f0a5-ed49-1523dd740ffb@linux.alibaba.com>
Date:   Mon, 19 Jul 2021 12:22:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b427ac2a-e439-3675-8a42-9fdcd23a5114@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks,

I checked, actually all virtio drivers have switched to use the helper 
after this one merged.

在 2021/7/19 上午11:46, Jason Wang 写道:
>
> 在 2021/7/16 下午8:46, tianxianting 写道:
>> Do you interest in this patch? just little improvment:)
>>
>> 在 2021/7/13 下午11:38, Xianting Tian 写道:
>>> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>>>
>>> Use the helper virtio_find_vqs().
>>>
>>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>>> ---
>>>   drivers/virtio/virtio_balloon.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c 
>>> b/drivers/virtio/virtio_balloon.c
>>> index 510e931..18e0bf3 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
>>>           callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>>>       }
>>>   -    err = vb->vdev->config->find_vqs(vb->vdev, 
>>> VIRTIO_BALLOON_VQ_MAX,
>>> -                     vqs, callbacks, names, NULL, NULL);
>>> +    err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>>> +                callbacks, names, NULL);
>>>       if (err)
>>>           return err;
>>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Maybe it's better to convert all the drivers that doesn't use 
> virtio_find_vqs{_ctx}.
>
> Thanks
