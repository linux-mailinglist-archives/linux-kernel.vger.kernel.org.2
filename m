Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BCD438E83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhJYEsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhJYEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635137152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6OUU63iz+cJPE/D1JS5ge1TKoVjiL2+e3CLUbXWt4I=;
        b=bISaQC7WigCg7AlhGQPe/XicYlHiknpEMuGrsHYM41iCV7vPof09lno85pGFTMsj1A2ju/
        nSglsUAqjf8YwrvogpHxKT0d4cQPmSQc386Spgd9bbG264I8NZVxdFfCJFg8sLTemBHPyf
        Asarcr+kHfnKLEx3Jd9x3oPPgWp1G/w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-cvysdTe3MqSvaGtKWi7OoA-1; Mon, 25 Oct 2021 00:45:50 -0400
X-MC-Unique: cvysdTe3MqSvaGtKWi7OoA-1
Received: by mail-pg1-f197.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so5602971pgi.19
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F6OUU63iz+cJPE/D1JS5ge1TKoVjiL2+e3CLUbXWt4I=;
        b=oMR4NvHwv/4IrRL/vrL/i2PLyztL4cu4gQ61++KIgyy6N+la2pA8xrY3S2YgGxtE3J
         af5/trhPSscwAVZ3e2PpcnWl2oNj/Fa0U05KdHIBuRVaJNgJO81IvyIIRSXo7JfG0r4D
         IZL5W2iLSrbGZk6qcLZ7MQ/06F/IQ2bW57vMdavHW3KuPdAk/V13+ElQMqCRdWKhDfQ/
         W5uuJnfKvC6C/3q16+IsUOvnEKcWbJ856pXCT06d/TFc/0MweD3+uubQMB94+rpQR9Jz
         og4Rf5GlMP1YFfNrJU7jnlyqKTB16r49a6dwLd577waIFWUSTAfQYk6yEG75YjgKxn6P
         d+TA==
X-Gm-Message-State: AOAM53021zy8Co24ic8T40fHawKiwNof7og0MNJhCz2EJztmmKOBMBeI
        I3P1dRe4GIzCPz6iZCBoLWIadIbkQa3vV4wX3FT8v9H+hd5odk+LY61V/qpT5j2YVk186BMDJ2R
        3DkQG9YLPLGsE4v2mv7o6jKo4
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr15535553pfj.15.1635137149708;
        Sun, 24 Oct 2021 21:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLB72PqNSdfJrX+247H6/uoN4JrbLXebefRT3rHVi8UXZS/3aQKoa93b8u7w4Ov85ugoXGmg==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr15535530pfj.15.1635137149307;
        Sun, 24 Oct 2021 21:45:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l6sm7186243pfc.126.2021.10.24.21.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 21:45:48 -0700 (PDT)
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
 <20211025024403.GA3684@L-PF27918B-1352.localdomain>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wei.yang1@linux.alibaba.com
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bfb2875b-0da1-27e8-829b-f6b61ea6e326@redhat.com>
Date:   Mon, 25 Oct 2021 12:45:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025024403.GA3684@L-PF27918B-1352.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/25 ÉÏÎç10:44, Wu Zongyong Ð´µÀ:
> On Mon, Oct 25, 2021 at 10:22:30AM +0800, Jason Wang wrote:
>> On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
>> <wuzongyong@linux.alibaba.com> wrote:
>>> For the devices which implement the get_vq_num_min callback, the driver
>>> should not negotiate with virtqueue size with the backend vdpa device if
>>> the value returned by get_vq_num_min equals to the value returned by
>>> get_vq_num_max.
>>> This is useful for vdpa devices based on legacy virtio specfication.
>>>
>>> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>> ---
>>>   drivers/virtio/virtio_vdpa.c | 21 ++++++++++++++++-----
>>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index 72eaef2caeb1..e42ace29daa1 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>>>          /* Assume split virtqueue, switch to packed if necessary */
>>>          struct vdpa_vq_state state = {0};
>>>          unsigned long flags;
>>> -       u32 align, num;
>>> +       u32 align, max_num, min_num = 0;
>>> +       bool may_reduce_num = true;
>>>          int err;
>>>
>>>          if (!name)
>>> @@ -163,22 +164,32 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>>>          if (!info)
>>>                  return ERR_PTR(-ENOMEM);
>>>
>>> -       num = ops->get_vq_num_max(vdpa);
>>> -       if (num == 0) {
>>> +       max_num = ops->get_vq_num_max(vdpa);
>>> +       if (max_num == 0) {
>>>                  err = -ENOENT;
>>>                  goto error_new_virtqueue;
>>>          }
>>>
>>> +       if (ops->get_vq_num_min)
>>> +               min_num = ops->get_vq_num_min(vdpa);
>>> +
>>> +       may_reduce_num = (max_num == min_num) ? false : true;
>>> +
>>>          /* Create the vring */
>>>          align = ops->get_vq_align(vdpa);
>>> -       vq = vring_create_virtqueue(index, num, align, vdev,
>>> -                                   true, true, ctx,
>>> +       vq = vring_create_virtqueue(index, max_num, align, vdev,
>>> +                                   true, may_reduce_num, ctx,
>>>                                      virtio_vdpa_notify, callback, name);
>>>          if (!vq) {
>>>                  err = -ENOMEM;
>>>                  goto error_new_virtqueue;
>>>          }
>>>
>>> +       if (virtqueue_get_vring_size(vq) < min_num) {
>>> +               err = -EINVAL;
>>> +               goto err_vq;
>>> +       }
>> I wonder under which case can we hit this?
>>
>> Thanks
> If min_vq_num < max_vq_num, may_reduce_num should be true, then it is
> possible to allocate a virtqueue with a small size which value is less
> than the min_vq_num since we only set the upper bound for virtqueue size
> when creating virtqueue.
>
> Refers to vring_create_virtqueue_split in driver/virtio/virtio_vring.c:
>
> 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
> 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> 					  &dma_addr,
> 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
> 		if (queue)
> 			break;
> 		if (!may_reduce_num)
> 			return NULL;
> 	}


It looks to me it's better to fix this function instead of checking it 
in the caller?


>
> BTW, I have replied this mail on Nov.18, have you ever received it?


For some reason I dont' get that.

Thanks


>>> +
>>>          /* Setup virtqueue callback */
>>>          cb.callback = virtio_vdpa_virtqueue_cb;
>>>          cb.private = info;
>>> --
>>> 2.31.1
>>>

