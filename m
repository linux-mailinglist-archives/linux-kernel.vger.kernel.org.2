Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7D3BC290
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGES2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhGES2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
        b=gkVxudibJrGQdTIOAHU0ge0koPSnmtizfOeE2AqZtA0JT3BlbUnsC1iyV4bwhy6dLIoSnZ
        m9XjlTcs7PsJOmDUF+bsTiyCMka6dKnlHSA8RKtV05JCX2j/XjSdtQLoup8GghX1L769es
        JFqgSyIbOOsHiVw6RwcPaxp3fGjx+5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-TXRWdwDfNW65bj0z42Xvqg-1; Mon, 05 Jul 2021 14:25:38 -0400
X-MC-Unique: TXRWdwDfNW65bj0z42Xvqg-1
Received: by mail-ed1-f72.google.com with SMTP id m10-20020aa7c2ca0000b0290399df423df0so1245074edp.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 11:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
        b=Dj2XIHGIeXiQirdI0NpO8oB/3FlpEpTyLrNGYL66DBkC6oNKEyCOWrenjq+lw2mk1B
         By41wrnqhnWd2Y06jeEw73kfxw07m8BqHR/QdSkenT5VuI6u+DKyXC6pyk7aDmYJlzR8
         rGF8obSAvwRpQ8+ureSAoP7KF++LTAPbfHvZZ0Hgz7BeuNVyz4WLTQj4KaT/laCALrl+
         mgVyjMuRKvQAvRzNUtJ7Ee2t81FXZcWcv7iEKKiEy3o0XSddXCb9WgFsshKm+NsAA7w3
         +TtJMuPWnRzyjbfwhT2yAo0kK6h4EVUx49Zk8LDa0W7l5hOpQiF97IXMMk4/i8xnHlob
         J7lg==
X-Gm-Message-State: AOAM530ou9Iw4KLft/Kekq+HuCD2ZG0F+vxY9wc0yNqW9q15t7PAuaQ/
        Be1C3DfdAwHIX/RQACMqOpMnZ8HuqCJ+INxj6B625pKHDpQPZcsqiWX0XXCHLIVuBC8zfatdJ30
        StMq9KbTrRCeBdFnE9Tv7I+W+
X-Received: by 2002:a05:6402:1c82:: with SMTP id cy2mr17477377edb.324.1625509537501;
        Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyiqkphTkUX3OHsr5lvwvQkNygRb1AqpshkkZAXPOLJN5NLWa7fPK/aNr11ZHLweIF1oUb7w==
X-Received: by 2002:a05:6402:1c82:: with SMTP id cy2mr17477367edb.324.1625509537409;
        Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id qo20sm522933ejb.106.2021.07.05.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:25:36 -0700 (PDT)
Date:   Mon, 5 Jul 2021 14:25:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210705142431-mutt-send-email-mst@kernel.org>
References: <20210705100006.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705100006.90-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 06:00:06PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I replied on v3.
Silently ignoring what hypervisor said is not a good idea.


> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..e9d7747c3cc0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -819,7 +819,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
>  		blk_queue_logical_block_size(q, blk_size);
>  	else
>  		blk_size = queue_logical_block_size(q);
> -- 
> 2.11.0

