Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E063E5400
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhHJHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234999AbhHJHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628578788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
        b=IVZbmluvWu4JJPvdImiMu3yE4XyTVZi5F/EdBCh005ymNougw3T/XlcH+RG30A/Aq4rbP9
        V0LgdL/pai/HrKy19wAuR9nqeSmc+aLLuvrEUHeexBHm/QP+ZelNTRciYzDNi4Tiu3eAuA
        GviKVpyh1jQRwd2d9QIFIiUB5etopGc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-7oj7QVjRN0CYtedt8Xy-bg-1; Tue, 10 Aug 2021 02:59:47 -0400
X-MC-Unique: 7oj7QVjRN0CYtedt8Xy-bg-1
Received: by mail-pj1-f69.google.com with SMTP id d35-20020a17090a6f26b0290178ab46154dso3895740pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
        b=YSDi8nHswmbV/C1nB1T5DYolwgEC9SWZm0HtvqosFCQ9PZ0E7pwhgwhLs9PEuDLHvf
         EekG75S6Le3/c6vaVtpD0rfooJyLbgpCb/YFbfwc8/d4azMdMhMykRZNVAGIqZIeMa1c
         X2KfDFhatKsV5vmFsnk2jqVI/m4gc9J7wXSzoQn296F/E2j+Pybb8GZukvGVCGMFucrG
         QeHGpOYlP9lvkgofA1PuDz0/AlAM+b8NxyfLXuj5nrXk4Wp3Q17KrRc0BuutAGj9sh2V
         6r89LQCfmI58Uv1/zRLhd3luXp2q5BuXEkpA7SIVEck9c88m2HBWtUPPkCx65Ra/AOQu
         B5aQ==
X-Gm-Message-State: AOAM531173TMyI1bqI90yeyjXF3kr25vkg8BM5EyuHI6vQ42a6CbTc3p
        rHvDlcQ9CdN5PEWJPnOJ6g647ImrHqVNjsUB/xob3R5AvAd2PddVOUUrqAm6CWKsUMadeqAoz0M
        05wipQCBxU5cmL5bi5Q09XD75mxWaPBn1x+EnxypYjmYOWcXpAK8VkBdKqKbUdkRbHEnN3JSSbI
        SC
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr29351087pjb.134.1628578786265;
        Mon, 09 Aug 2021 23:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrbs/YDU3MNI8hVXqMW422VJSPmpjHIL4mjB5dm/5UNU1I3yH/ewcl/R9s/ijTMhy9D8SBg==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr29351059pjb.134.1628578785896;
        Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p3sm1722059pjt.0.2021.08.09.23.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
 <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <46c513b4-6644-d4b0-84f4-32df34b6d7b8@redhat.com>
Date:   Tue, 10 Aug 2021 14:59:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/10 下午12:59, Yongji Xie 写道:
> On Tue, Aug 10, 2021 at 11:05 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/8/9 下午6:16, Xie Yongji 写道:
>>> An untrusted device might presents an invalid block size
>>> in configuration space. This tries to add validation for it
>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>> feature bit if the value is out of the supported range.
>>>
>>> And we also double check the value in virtblk_probe() in
>>> case that it's changed after the validation.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>>>    1 file changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 4b49df2dfd23..afb37aac09e8 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>>>    static unsigned int virtblk_queue_depth;
>>>    module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>>>
>>> +static int virtblk_validate(struct virtio_device *vdev)
>>> +{
>>> +     u32 blk_size;
>>> +
>>> +     if (!vdev->config->get) {
>>> +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> +                     __func__);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
>>> +             return 0;
>>> +
>>> +     blk_size = virtio_cread32(vdev,
>>> +                     offsetof(struct virtio_blk_config, blk_size));
>>> +
>>> +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
>>> +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
>>
>> I wonder if it's better to just fail here as what we did for probe().
>>
> Looks like we don't need to do that since we already clear the
> VIRTIO_BLK_F_BLK_SIZE to tell the device that we don't use the block
> size in configuration space. Just like what we did in
> virtnet_validate().
>
> Thanks,
> Yongji


Ok, so

Acked-by: Jason Wang <jasowang@redhat.com>



>

