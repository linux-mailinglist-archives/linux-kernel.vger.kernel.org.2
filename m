Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C9359424
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhDIEsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhDIEs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617943685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lr7bSaeCS5k9NdjAFj7VzPTVSXRHhHksxSYeZxBEhok=;
        b=GLWA7zyrkbxzgFMl6zSi7kjtq1UNxWec9jit8gvigcoc44KlPJXkpw31obpufBpx9a/jTZ
        oE0NZJJTGFg8Dm6sae52ZYFyLC8+6OUi7J4eim2dWfRCKjhY0ne1kf3EWFWc8QQin/PmHY
        CS0WZ96/RH44OCmivsn651w2bSipFYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-nyENpqnlOoK5mGYgUCFRFA-1; Fri, 09 Apr 2021 00:48:03 -0400
X-MC-Unique: nyENpqnlOoK5mGYgUCFRFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5554D51A4;
        Fri,  9 Apr 2021 04:48:02 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-155.pek2.redhat.com [10.72.13.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45ABC5D9DC;
        Fri,  9 Apr 2021 04:47:57 +0000 (UTC)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
Date:   Fri, 9 Apr 2021 12:47:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408115834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/4/8 ÏÂÎç11:59, Michael S. Tsirkin Ð´µÀ:
> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
>> This patch mandates 1.0 for vDPA devices. The goal is to have the
>> semantic of normative statement in the virtio spec and eliminate the
>> burden of transitional device for both vDPA bus and vDPA parent.
>>
>> uAPI seems fine since all the vDPA parent mandates
>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
>>
>> For legacy guests, it can still work since Qemu will mediate when
>> necessary (e.g doing the endian conversion).
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Hmm. If we do this, don't we still have a problem with
> legacy drivers which don't ack 1.0?


Yes, but it's not something that is introduced in this commit. The 
legacy driver never work ...


> Note 1.0 affects ring endianness which is not mediated in QEMU
> so QEMU can't pretend to device guest is 1.0.


Right, I plan to send patches to do mediation in the Qemu to unbreak 
legacy drivers.

Thanks


>
>
>
>
>
>> ---
>>   include/linux/vdpa.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 0fefeb976877..cfde4ec999b4 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -6,6 +6,7 @@
>>   #include <linux/device.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/vhost_iotlb.h>
>> +#include <uapi/linux/virtio_config.h>
>>   
>>   /**
>>    * vDPA callback definition.
>> @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>   {
>>           const struct vdpa_config_ops *ops = vdev->config;
>>   
>> +        /* Mandating 1.0 to have semantics of normative statements in
>> +         * the spec. */
>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
>> +		return -EINVAL;
>> +
>>   	vdev->features_valid = true;
>>           return ops->set_features(vdev, features);
>>   }
>> -- 
>> 2.25.1

