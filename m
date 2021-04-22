Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F460367CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhDVIr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235555AbhDVIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619081210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igvzL5hliAA2FzGw5dEDKa40CGCMUv5IZGyJe8BTj8Q=;
        b=h9ErolHulMq2N6vsJ+qzBJqX5ORmk39L1JJbSz+oYBKw5SPx0Q1pgwckG2Y/Ucy40j9Rxp
        7cpoYpkR/L4nD8rpWwhQ9b06FKVDJTjCjpHGguBIPIT/YiUuJUwIbvlbdxIG0hZg/WwqXa
        Mxo3glAPVOeFGxRE8syke6m8uf/e+A4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-7U-IgantOE25S3_3HK05Bg-1; Thu, 22 Apr 2021 04:46:42 -0400
X-MC-Unique: 7U-IgantOE25S3_3HK05Bg-1
Received: by mail-ej1-f69.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso6928959eja.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igvzL5hliAA2FzGw5dEDKa40CGCMUv5IZGyJe8BTj8Q=;
        b=Pz4YDuXwJ0ibdcGYorNPYUZ232MoWLVkAOqexNplnuFGVMMTagIK1g/VQ6O+S63QQr
         p8zPv2xG7rFsZy3/KVmFzCEvemunggFO8FN83LtiGm1F1oNmYSBL5NgMiuz6z7cABmio
         jlKq51xcxoc5hX0gEi0b00MbZqNu2laLZ2bAWIfunBrNMvymfrlVBSPo4SWSqY+FSTy5
         vfYsRPL9X9bl1Bt3tEoWrHfcyov51GftrUajDwR1OrLR9dr6L7YGeMoFSWnWBSuwdzbg
         cDMEjLWqr8bryKRX+dV67DisyhoDSuoH1+Mp0kQa9zAIwh7yFyEZmpNppzcEIBpFD2CE
         N0Ig==
X-Gm-Message-State: AOAM531UG1WZ6MWjmzW/zaIj64MeOlNZmGugQn0ghPqmHix50T1vS39R
        MN1gq7e6o1iTMQG85gmNqEbZRQuC3//V8l2p3bfTiw0wP5wG0f5AJ0+f0BDq0V8sVVSLGsWsObu
        2GKoohfEpXjnL4RyCRN5QNK5L
X-Received: by 2002:a05:6402:1a52:: with SMTP id bf18mr2410643edb.289.1619081201235;
        Thu, 22 Apr 2021 01:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMOmZX/WNU70MrtatibX4Wtl/+Aav9csAem9coMeZKqvTUqG/etSg6TxT6HkUvxXRS4imtXQ==
X-Received: by 2002:a05:6402:1a52:: with SMTP id bf18mr2410622edb.289.1619081201063;
        Thu, 22 Apr 2021 01:46:41 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id q25sm1506681edt.51.2021.04.22.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:46:40 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:46:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Alexander Popov <alex.popov@linux.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stsp2@yandex.ru" <stsp2@yandex.ru>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210422084638.bvblk33b4oi6cec6@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210421095213.25hnfi2th7gzyzt2@steredhat>
 <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:06:28PM +0300, Arseny Krasnov wrote:
>On 21.04.2021 12:52, Stefano Garzarella wrote:
>> On Tue, Apr 13, 2021 at 03:39:51PM +0300, Arseny Krasnov wrote:
>>> v7 -> v8:
>>> General changelog:
>>> - whole idea is simplified: channel now considered reliable,
>>>   so SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id' were removed.
>>>   Only thing that is used to mark end of message is bit in
>>>   'flags' field of packet header: VIRTIO_VSOCK_SEQ_EOR. Packet
>>>   with such bit set to 1 means, that this is last packet of
>>>   message.
>>>
>>> - POSIX MSG_EOR support is removed, as there is no exact
>>>   description how it works.
>> It would be nice to support it, I'll try to see if I can find anything.
>>
>> I just reviewed the series. I think the most important things to fix are
>> the `seqpacket_allow` stored in the struct virtio_transport that is
>> wrong IMHO, and use cpu_to_le32()/le32_to_cpu() to access the flags.
>
>Thank You, i'll prepare next version. Main question is: does this
>approach(no SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id') considered
>good? In this case it will be easier to prepare final version, because 
>is smaller and more simple than previous logic. Also patch to spec
>will be smaller.

Yes, it's definitely much better than before.

The only problem I see is that we add some overhead per fragment 
(header). We could solve that with the mergeable buffers that Jiang is 
considering for DGRAM.

If we have that support, I think we could reuse it here as well, but it 
might be a next step.

Thanks,
Stefano

