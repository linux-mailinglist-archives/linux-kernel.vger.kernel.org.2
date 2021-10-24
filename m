Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0949E4389B4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJXPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhJXPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635088319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sd2F/rv0/rYPqdyLkTSI2b2h2/QE9BM0Qe4Pjpyf4UM=;
        b=hd1q1KNDbG+43Mdrfl6JMaC4POgcu6FiRsXLRAFOOXtoY3LUbUeVSr0GDw6Awgb2xKvGpg
        QuQXD3ivxlnsoM5M5xywEJ88dIWYjH66HdqyPnjhqKI/4eQk4j/9LdtEW8dcCW0+SKh/GB
        o8dsOjyKMyZE7vkp1gSZQqyWLd1e0L0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-39inwkcoP4eRWriaB6sZYg-1; Sun, 24 Oct 2021 11:11:57 -0400
X-MC-Unique: 39inwkcoP4eRWriaB6sZYg-1
Received: by mail-ed1-f72.google.com with SMTP id k28-20020a508adc000000b003dd5e21da4bso55067edk.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 08:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sd2F/rv0/rYPqdyLkTSI2b2h2/QE9BM0Qe4Pjpyf4UM=;
        b=Ycd3EBmMvxNISM5XvujjB0SeZDbSFVsevGOQEVbqsnHsOjYxJvr5FTyuZ3xkZbKNYY
         dfSetlkL4Wia80YuuUWhxCnqmmg5McCZqI4pp7oBV8j8mmngg+M8e7cRdzGzlWFLZlyS
         9AU5Mjij9UEngX3rbIetvgt6QDEO+TGIwPRj/Cc/qX8eLffdPcK4Iyi5bw1Br/zelRFb
         L/OvOxxusNOO6q0Ud1qWA2+X3MsO6t5oD/F4XPVzYv0Xe9hbp+W/pcNkJ4J2YvAOUx8p
         7atDfzeR9sAvH8dL4JOjgXQwVEyAVK7hzcVHW5bmUr+m0Pl5CCISsteJOAUCyNtqHQS7
         xkaA==
X-Gm-Message-State: AOAM53066hxpMh8F8KF867ICTo9vtFguppWxDrVUAOlhJf3cWirAWh8s
        hqKH4GWxGWdJ4Tr4hRJ2gt3joiAD6BRu/+rnGCDU04YqNtQOOsyxDO2jzbHOEPGay1h1REZtC/A
        HWwOeu7uLa6l48zdudApo42+r
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr15112449eja.512.1635088316552;
        Sun, 24 Oct 2021 08:11:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnbdd6RsZKytm29Sr1ykC3If/f4opiXGmBqrEf8/Foj95mR0OgBYQPl3pTDCqV4RSW7O4AMg==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr15112407eja.512.1635088316246;
        Sun, 24 Oct 2021 08:11:56 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id gb3sm4479930ejc.81.2021.10.24.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 08:11:55 -0700 (PDT)
Date:   Sun, 24 Oct 2021 11:11:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024105841-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > The default value is 0 meaning "no limit". However if 0
> > is specified on the command line it is instead silently
> > converted to 1. Further, the value is already validated
> > at point of use, there's no point in duplicating code
> > validating the value when it is set.
> > 
> > Simplify the code while making the behaviour more consistent
> > by using plain module_param.
> > 
> > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/block/virtio_blk.c | 14 +-------------
> >   1 file changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6318134aab76..c336d9bb9105 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -30,20 +30,8 @@
> >   #define VIRTIO_BLK_INLINE_SG_CNT	2
> >   #endif
> > -static int virtblk_queue_count_set(const char *val,
> > -		const struct kernel_param *kp)
> > -{
> > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > -}
> > -
> > -static const struct kernel_param_ops queue_count_ops = {
> > -	.set = virtblk_queue_count_set,
> > -	.get = param_get_uint,
> > -};
> > -
> >   static unsigned int num_request_queues;
> > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > -		0644);
> > +module_param(num_request_queues, uint, 0644);
> 
> Not the best solution.
> 
> You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> example.

Well your patch does make it possible to know what nr_cpu_ids is.
But does it matter? The actual number of queues is still capped
by the num_queues of the device. And I'm concerned that some
userspace comes to depend on reading back nr_cpu_ids
from there, which will cement this as part of ABI instead of
being an implementation detail.
Exposing the actual number of queues in sysfs might make more sense ...

Generally you suggested embedded as a use-case, and I don't really
see lots of embedded userspace poking at this parameter in sysfs.

What I'd like to see, and attempted to achieve here:
- avoid code duplication
- consistency: some way to specify the parameter but still make it have the default value

Better suggestions are welcome.

> 
> >   MODULE_PARM_DESC(num_request_queues,
> >   		 "Limit the number of request queues to use for blk device. "
> >   		 "0 for no limit. "

