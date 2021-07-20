Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CC3CF59B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhGTHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233097AbhGTHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626767701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4xS+Xn7d/Hv2qOixfVLURwcqLkm25EKLyV4db7jn+U=;
        b=h9wVEm+jgDsowwgPS10ZLRTGQuA5v6eI1Yn9GGkKLzI+aZq6Y+wdCP/OqOx+XTkdBgnVbE
        Fk9A3PJ3YPAcoMErCWOmsE7mS5Xg16Ba2pfRPz8cYD7Xh2pUj+HFcjwGwEcM7b9h2V1adz
        tbay4nOtp2XxFE1Nh8Mmr1WpDr9oCJY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-SE5YR3tfPtqv2xsqoOR1Qw-1; Tue, 20 Jul 2021 03:55:00 -0400
X-MC-Unique: SE5YR3tfPtqv2xsqoOR1Qw-1
Received: by mail-pj1-f72.google.com with SMTP id p10-20020a17090a428ab0290175556801d5so10780891pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f4xS+Xn7d/Hv2qOixfVLURwcqLkm25EKLyV4db7jn+U=;
        b=JendZSAInIckunlPbDHRlDISCoN+tV4V19ApLq1iaXX07/bsIekJhSv5ZEMRL+bbCN
         g1cF6UNL0de2Af/IDgDRWMXipNEsL1SkwBBO7kqPnYxG0XS4+2ugRoKTuHSY85lQ+hDx
         3HvQnuoAWlQihOCbuc6HUZ0i+5ujdLi9AolvncdkVicQPYUEljyZKXJiAjRY3gzDl1I3
         3tN6bIl00CyYbnJGk9rm8wjvATWcbToSdNp6zTCQmxxrlqapxR1gBY4BcDoJButoiD1K
         7wEVTLwf9xDFy5sEhwBPDOzySM53/lJveXvIIrFNL9o6wHAznqYxJ+P1FM+bWS3M2Jnw
         Gyfg==
X-Gm-Message-State: AOAM531Bg7e29NIphW63iwjdqoO4OIHw9+Leq2kyL+4ElYfxyFhbU2jm
        1N3joIL1Jv/ENn0Vh2kaap7iTVRT1LIY2t1a9dbDkA8SGR+xoCSdlY3+Ndu40CWjHGUKNsAaO9B
        hUOxSdgwunsOVt/p4C+fMIQWB5VcK/wiySB9sY08Uh7T71hCi60xkEH02h5lqAzelgC8Qw0MKJU
        Vt
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr23352993pjr.60.1626767698693;
        Tue, 20 Jul 2021 00:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXnQ+rg5UaIdGhKi/NFptG4RFBi9zHlqOmm3vU/LHn1hob4QbTpB1HpUcdfV/d8ngFK0/JqQ==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr23352974pjr.60.1626767698380;
        Tue, 20 Jul 2021 00:54:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f19sm18647355pjj.22.2021.07.20.00.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 00:54:57 -0700 (PDT)
Subject: Re: [PATCH v2] vsock/virtio: set vsock frontend ready in
 virtio_vsock_probe()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210720071337.1995-1-xianting.tian@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <87deb4ff-c4f9-0a5e-e349-c1a8682a864e@redhat.com>
Date:   Tue, 20 Jul 2021 15:54:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720071337.1995-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/20 下午3:13, Xianting Tian 写道:
> Add the missed virtio_device_ready() to set vsock frontend ready.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   net/vmw_vsock/virtio_transport.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e0c2c992a..dc834b8fd 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -639,6 +639,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>   
>   	mutex_unlock(&the_virtio_vsock_mutex);
>   
> +	virtio_device_ready(vdev);
> +
>   	return 0;
>   
>   out:


Just notice this:

commit 5b40a7daf51812b35cf05d1601a779a7043f8414
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Feb 17 16:12:44 2015 +1030

     virtio: don't set VIRTIO_CONFIG_S_DRIVER_OK twice.

     I noticed this with the console device.  It's not *wrong*, just a bit
     weird.

     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9f70dfc4751..5ce2aa48fc6e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -236,7 +236,10 @@ static int virtio_dev_probe(struct device *_d)
         if (err)
                 goto err;

-       add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+       /* If probe didn't do it, mark device DRIVER_OK ourselves. */
+       if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+               virtio_device_ready(dev);
+
         if (drv->scan)
                 drv->scan(dev);

So I think we need to be consistent: switch to use virtio_device_ready() 
for all the drivers, and then we can remove this step and warn if 
(DRIVER_OK) is not set.

Thanks

