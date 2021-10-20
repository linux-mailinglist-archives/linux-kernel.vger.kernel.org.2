Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDA43472C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJTIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhJTIqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634719450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MvyTqgdf6ZEWMdPd4rQvCZfBzmf4LkWCdbjva2HVh0Y=;
        b=b6hZu1I58SJgoQEURRBDPzgKwAdKRle/5CxAQDeJvRLi8yg0SEVTR9H2bbebR8QRMwpICu
        7cGweLQJ0i1gSYHQdeS91Yh7QesRId5QazGl7az9LjkZQaXeQrki84BwwhsHbVakwCW+v4
        2e1JqiyJzDLLD7HNNO9141ZStiA4p7g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-hdXORYxfNGGYUM5W5oHdsg-1; Wed, 20 Oct 2021 04:44:09 -0400
X-MC-Unique: hdXORYxfNGGYUM5W5oHdsg-1
Received: by mail-ed1-f69.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so13612182edj.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MvyTqgdf6ZEWMdPd4rQvCZfBzmf4LkWCdbjva2HVh0Y=;
        b=TkFENBz3CGGUYZbv/QRUn3+S/rThbCADXJXuRF9hj2owpfDHeTC+7tlDFdIMjIIpLr
         XxSRjK+4qjSGZmx80Lwo0+8ZfhqNh6r6m7HnXJEhtBB2NYKQoXG53iCCT1cqzFPmDXN/
         ql2VHa+1iecmKO1Og/p0q4fz3igrSyWhHDz92jB7sV97o+qV3dk3uTB+JJECcNUAn7bt
         6IuHuhtfDCqg0r00bELhrr9I0fFiqKVHU5Q7U1TtVSbA6Al6/k2ZKpA69npCA5LCrWTQ
         V/EGxaFlkAd6fLHUqVI6IVgxXZc18imE4YTGhL8wqgc7+sX342+tCDEr3yD37rid13+C
         NV+w==
X-Gm-Message-State: AOAM531+xMi2qH+AsENSpGIR94wy+uN1fJRnYjOfBjYMIqGuOrmWWliT
        vfuIyzBT+LfTkvWbT6bG2ZPZFid0duYMSpwn2mFwT+CP+UMcV8eXAVA714jJ9CcvmzyBBpRU3mJ
        H8PcqelRsdNlgOT020CJn3jHm
X-Received: by 2002:a50:becf:: with SMTP id e15mr62263629edk.114.1634719448249;
        Wed, 20 Oct 2021 01:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziLPARPu3vpcjg9vV2//vlu9Wj1zslEGWBXZoVzlVWTah1TQHfmixIcHaGl8kIhAPyzr0PsA==
X-Received: by 2002:a50:becf:: with SMTP id e15mr62263605edk.114.1634719448084;
        Wed, 20 Oct 2021 01:44:08 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it. [79.34.250.211])
        by smtp.gmail.com with ESMTPSA id b2sm802439edv.73.2021.10.20.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:44:07 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:44:05 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020084405.yrnbouwljqkoopsk@steredhat>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
 <20211020071817.pzyfploxlryvdf3p@steredhat>
 <20211020032849-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211020032849-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 03:37:31AM -0400, Michael S. Tsirkin wrote:
>On Wed, Oct 20, 2021 at 09:18:17AM +0200, Stefano Garzarella wrote:
>> On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
>> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
>>
>> s/neogitates/negotiates
>>
>> > num_queues, the driver may end up trying to allocating zero size
>> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
>> > against the NULL. This will lead unexpected results.
>> >
>> > Fixing this by failing the probe in this case.
>> >
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > ---
>> > drivers/block/virtio_blk.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>>
>> Should we CC stable?
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>No IMO - I don't think we can reasonably expect stable to become
>protected against attacks on encrypted guests. That's
>a new feature, not a bugfix.

Yep, make sense.
I had only seen the single patch, not the entire series, and it seemed 
like a fix.

Viewed as a whole, it makes sense to consider it a new feature to 
improve audits in the guest.

Thanks,
Stefano

