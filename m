Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311173129B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 05:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBHERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 23:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhBHERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612757749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgeC64i1kjNEGNpncvkRVMjI5koc16zoFV1Q6tI8jiI=;
        b=bD+SJ4FWqkwK3CWSL+2o0oRdRrKS19kT/scewrQkbaJ913I6gaX/50FOqhD1rlotGQeku1
        riyxkGCMRkVn2A1Lm4vrDiE4p1yftMmsiakzVJ28PZbob5Tn6o3NKIxvj4xDu8Klra+9CL
        LEPC5sGeBU22HtZbWBKEj0WV58PMZqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-gI7zhTsbOQ63T7BN92t-zw-1; Sun, 07 Feb 2021 23:15:47 -0500
X-MC-Unique: gI7zhTsbOQ63T7BN92t-zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7302B192D785;
        Mon,  8 Feb 2021 04:15:46 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E935D9C6;
        Mon,  8 Feb 2021 04:15:40 +0000 (UTC)
Subject: Re: [PATCH V3 18/19] virtio_vdpa: don't warn when fail to disable vq
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-19-jasowang@redhat.com>
 <20210205102442-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2911e3c2-84ff-006a-24ba-fb6aea9d25d5@redhat.com>
Date:   Mon, 8 Feb 2021 12:15:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205102442-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/5 下午11:24, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2021 at 02:55:02PM +0800, Jason Wang wrote:
>> There's no guarantee that the device can disable a specific virtqueue
>> through set_vq_ready(). One example is the modern virtio-pci
>> device. So this patch removes the warning.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Do we need the read as a kind of flush though?


The problem is that PCI forbids write 0 to queue_enable. So I'm not sure 
what kind of flush do we need here?

Thanks


>
>> ---
>>   drivers/virtio/virtio_vdpa.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>> index 4a9ddb44b2a7..e28acf482e0c 100644
>> --- a/drivers/virtio/virtio_vdpa.c
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -225,9 +225,8 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
>>   	list_del(&info->node);
>>   	spin_unlock_irqrestore(&vd_dev->lock, flags);
>>   
>> -	/* Select and deactivate the queue */
>> +	/* Select and deactivate the queue (best effort) */
>>   	ops->set_vq_ready(vdpa, index, 0);
>> -	WARN_ON(ops->get_vq_ready(vdpa, index));
>>   
>>   	vring_del_virtqueue(vq);
>>   
>> -- 
>> 2.25.1

