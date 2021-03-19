Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9C341F31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCSOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhCSOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616163379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9zw8CBtfbLr4B7lOytRKxO98oyOVaQpoL0ZeKO0tUA=;
        b=SC1tlFBc190+t50F8g6ELVLYCp8m848W6UscSogoGu+umSh0tgiotVxxjC/oJotuJI4p3m
        Ic5aMWVf+YiGAGSPhAfzz/W3P0hMtY86WKLN56cLXbK11oy6ilYZnm9w77yyFDYbuOAXgz
        JTVXDjeS+nckfc1bjz+3BYGI4Ji2SGo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-s8h9grWiNxSnTlHP30Hx0A-1; Fri, 19 Mar 2021 10:16:18 -0400
X-MC-Unique: s8h9grWiNxSnTlHP30Hx0A-1
Received: by mail-oi1-f198.google.com with SMTP id t186so4027559oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9zw8CBtfbLr4B7lOytRKxO98oyOVaQpoL0ZeKO0tUA=;
        b=rO1LumITJDiPkspI/ZLrRcFnUlEWzSBgRJ75KMwJakIACPrw0ATNOSDT7q5wc9TneJ
         Bju051OrsggfBiEeC7/HU9n9bDyWRiPPl5iZ50RLlsu8APcfWtBdUbxScPDz3CisMswQ
         d/Oy0tb0U4SdzKIqtyHAzSm9Zp5mnBKrjj2rY7bZs6ZMqvQjiJs7/vX6Ft16Cji55pve
         4bUjsIDl2bReeqinWl40/SiylN6KnEOA+WCv7i2A8fg549D8NnIc4PySckkxyxAA0pZE
         UeYd+FCKpbGm4QQ/EYSPuh4ZFRMziL/m17jlvK73p/Svup+TwchUcib1vIpdbJRoi5yr
         6jbA==
X-Gm-Message-State: AOAM532xR9xp+qtKyPsDuaUh93GU6esKvtbWffoWyVoM07rtPn6N8qtC
        OF5lVQP/a/QD82ApKyzivK+cyiOWKbYwfo1Hhq6THQm2VOXtGjJLajJ3Fsl3KDGopo0V0YJ40oV
        YhCedqxOyDrtPAKFlYx6mlwQQ
X-Received: by 2002:a4a:9843:: with SMTP id z3mr1589792ooi.51.1616163377365;
        Fri, 19 Mar 2021 07:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx2MNWNkKfrw15p1iOgcE1WNwGab8mOM64AvISX48wKkP2zrsJ388mw1npd31B6KpqhIwamA==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr1589778ooi.51.1616163377153;
        Fri, 19 Mar 2021 07:16:17 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id v6sm1253529ook.40.2021.03.19.07.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 07:16:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        miklos@szeredi.hu, jasowang@redhat.com, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <20210319134948.GA402287@redhat.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <6a44908d-7e2d-d239-c56a-68730c5357cd@redhat.com>
Date:   Fri, 19 Mar 2021 09:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319134948.GA402287@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 8:49 AM, Vivek Goyal wrote:
> On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
>> If an incoming FUSE request can't fit on the virtqueue, the request is
>> placed onto a workqueue so a worker can try to resubmit it later where
>> there will (hopefully) be space for it next time.
>>
>> This is fine for requests that aren't larger than a virtqueue's maximum
>> capacity. However, if a request's size exceeds the maximum capacity of
>> the virtqueue (even if the virtqueue is empty), it will be doomed to a
>> life of being placed on the workqueue, removed, discovered it won't fit,
>> and placed on the workqueue yet again.
>>
>> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
>> Descriptors) of the virtio spec:
>>
>>    "A driver MUST NOT create a descriptor chain longer than the Queue
>>    Size of the device."
>>
>> To fix this, limit the number of pages FUSE will use for an overall
>> request. This way, each request can realistically fit on the virtqueue
>> when it is decomposed into a scattergather list and avoid violating
>> section 2.6.5.3.1 of the virtio spec.
> 
> Hi Connor,
> 
> So as of now if a request is bigger than what virtqueue can support,
> it never gets dispatched and caller waits infinitely? So this patch
> will fix it by forcing fuse to split the request. That sounds good.

Right, in theory. Certain configurations make it easier to avoid this 
from happening, such as using indirect descriptors; however, in that 
case, the virtio spec says even if indirect descriptors are used, the 
descriptor chain length shouldn't exceed the length of the queue's size 
anyways. So having FUSE split the request also helps to uphold that 
property.

This is my reading of the potential looping problem:

virtio_fs_wake_pending_and_unlock
   calls
     virtio_fs_enqueue_req
       calls
         virtqueue_add_sgs

virtqueue_add_sgs can return -ENOSPC if there aren't enough descriptors 
available.

This error gets propagated back down to 
virtio_fs_wake_pending_and_unlock which checks for this exact issue and 
places the request on a workqueue to retry submission later.

Resubmission occurs in virtio_fs_request_dispatch_work, which does a 
similar dance, where if the request fails with -ENOSPC it just puts it 
back in the queue. However, for a sufficiently large request that would 
exceed the capacity of the virtqueue (even when empty), no amount of 
retrying will ever make it fit.

> 
> 
> [..]
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 8868ac31a3c0..a6ffba85d59a 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -18,6 +18,12 @@
>>   #include <linux/uio.h>
>>   #include "fuse_i.h"
>>   
>> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
>> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
>> + * addition to the pages used, so this can help account for that overhead.
>> + */
>> +#define FUSE_HEADER_OVERHEAD    4
> 
> How did yo arrive at this overhead. Is it following.
> 
> - One sg element for fuse_in_header.
> - One sg element for input arguments.
> - One sg element for fuse_out_header.
> - One sg element for output args.

Yes, that's exactly how I got to that number.

Connor


