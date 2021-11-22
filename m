Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D6458A05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhKVHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhKVHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637566970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XAbxjcnQGWVtvkYaQ80Gfqu/bCr+6feL1euVa+EhEk=;
        b=XTmHVvfONn4FshdsjEIb25kSu0h45DSiMtE7uGG1JwP8Mdd4iCXre+NdoPyHByqJ/lI7lH
        qqy+/5eWNrxxuP9S0c8+WN9grnJNCtRTiRrQwy2ko0iLJlQDi4aiycBV9Wbm+3vKPMt/tZ
        pt1pORzmSVoAviUlnBLzWt8GIqjtHmE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-pQBFSZgoNRmICEIvacpCLA-1; Mon, 22 Nov 2021 02:42:49 -0500
X-MC-Unique: pQBFSZgoNRmICEIvacpCLA-1
Received: by mail-ed1-f70.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so13966235edv.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/XAbxjcnQGWVtvkYaQ80Gfqu/bCr+6feL1euVa+EhEk=;
        b=x5SrLOc+xfws2vFxOGUFvHGAiuCLAuMj8v4ZPc30mN0T1Xw1yttJuxlayBLpRHjsY3
         Vf2qLkIFQfXUMqsTYyEKh2oXbsO1YAGdoPopY3kpDor9OiTf3qHQKkLFT30YvAZMR2bV
         9L69nKyAbf3nATwwRUy0FXNiGCgxosoUrXAulPs+IRiC0BehkoExO8vxLonLbUTwz5mh
         QddGu/fFF8ZTvqHFzQHAyuhNx1GIGHnECTSkqiCWE4WR9UTJOfRXFiVTv84vsV42g3jD
         PHxy7WPm1lYmVPjw/91fHS7gWRI8td9DjB9zO+M328Gn8n2bZ4fcECAANmaz4eKwIn8n
         wNtA==
X-Gm-Message-State: AOAM532cXYsvlkW+n+f7h4wtXUo7G17jntyQu7XzvrT/rSBPMMw1VDUG
        fsM0fWfdxnzpWOIFK8s+SVyqBmGtlFxj+4JRdQtfbCUKy7HLlEVJA7dLuih6gqdOrCb4CVM58/Q
        1pCMj89/yrj6oJMRpIzIb1881
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr37000368ejb.178.1637566968363;
        Sun, 21 Nov 2021 23:42:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTJqGs1B8o8V6KFilAJwvYHxoBKa2JlfENlQuYYQh/xLzQNbXGuOX/XyoPnu/ayfDrCqXk+g==
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr37000350ejb.178.1637566968195;
        Sun, 21 Nov 2021 23:42:48 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id w24sm3273814ejk.0.2021.11.21.23.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:42:47 -0800 (PST)
Date:   Mon, 22 Nov 2021 08:42:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122074245.d75nqk5quyaopfpt@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:51:09AM +0800, Jason Wang wrote:
>On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> On Wed, 27 Oct 2021 10:21:04 +0800
>> Jason Wang <jasowang@redhat.com> wrote:
>>
>> > This patch validate the used buffer length provided by the device
>> > before trying to use it. This is done by record the in buffer length
>> > in a new field in desc_state structure during virtqueue_add(), then we
>> > can fail the virtqueue_get_buf() when we find the device is trying to
>> > give us a used buffer length which is greater than the in buffer
>> > length.
>> >
>> > Since some drivers have already done the validation by themselves,
>> > this patch tries to makes the core validation optional. For the driver
>> > that doesn't want the validation, it can set the
>> > suppress_used_validation to be true (which could be overridden by
>> > force_used_validation module parameter). To be more efficient, a
>> > dedicate array is used for storing the validate used length, this
>> > helps to eliminate the cache stress if validation is done by the
>> > driver.
>> >
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>>
>> Hi Jason!
>>
>> Our CI has detected, that virtio-vsock became unusable with this
>> patch on s390x. I didn't test on x86 yet. The guest kernel says
>> something like:
>> vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>>
>> Did you, or anybody else, see something like this on platforms other that
>> s390x?
>
>Adding Stefan and Stefano.
>
>I think it should be a common issue, looking at

Yep, I confirm the same behaviour on x86_64. On Friday evening I had the 
same failure while testing latest QEMU and Linux kernel.

>vhost_vsock_handle_tx_kick(), it did:
>
>len += sizeof(pkt->hdr);
>vhost_add_used(vq, head, len);
>
>which looks like a violation of the spec since it's TX.
>
>>
>> I had a quick look at this code, and I speculate that it probably
>> uncovers a pre-existig bug, rather than introducing a new one.
>
>I agree.
>
>>
>> If somebody is already working on this please reach out to me.
>

My plan was to debug and test it today, so let me know if you need some 
help.

>AFAIK, no. I think the plan is to fix both the device and drive side
>(but I'm not sure we need a new feature for this if we stick to the
>validation).
>

Yes, maybe we need a new feature, since I believe there has been this 
problem since the beginning.

Thanks,
Stefano

