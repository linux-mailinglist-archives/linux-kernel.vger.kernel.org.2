Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0938FA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhEYGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhEYGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621923040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+ve4EsgwRWH3fX93e3xnVlqn74wnn5/jWlsUyNe/eQ=;
        b=cRtSRfi0XRwKhcfzh0l1FN0B6ddzQxuy6uBnGCXlBjW1TqpGYZXzVmWcwSvhycmpM4ctUd
        ac32W+/UMhsxTTUXav9UHu0DthuQzrXyhJJL1/6uqWCQWXs7f2Iq/nDG4BZ94Kid62iuXt
        FAYTfp28c88fD78OLAhD8G5Rvr1waGY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-iAMK3NelOzSGunaxHQ2Tmg-1; Tue, 25 May 2021 02:10:38 -0400
X-MC-Unique: iAMK3NelOzSGunaxHQ2Tmg-1
Received: by mail-pg1-f197.google.com with SMTP id q64-20020a632a430000b0290209af2eea25so20324659pgq.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7+ve4EsgwRWH3fX93e3xnVlqn74wnn5/jWlsUyNe/eQ=;
        b=PbhylmMdWTii83bBGiOMdzp+JaYlcCMivp6CysKRlMQYbs1g2JhXKSxhPajD2pRCs7
         VAd7DnqBVI4bxeb/STCeLxwEHuFUlGiyJ+Qx6g/UBnlVGhjVPpxoPZufLwnuH1dRjZen
         czDqDqLqUCOP+rJXhWhyrFE+jS7WpBWz584Ws/RVfA7Zs/+mu6tX5zG9AGsJwWOjZzWF
         mieHCs96e53Vox81O4QKVTliX0ppJvoaL5m/2jW5swYynOVch+rjzr1rATF46SbmS8D9
         3FFyYYKpZ7oXWl/w+qUbmndj36vsswAagK6jHzQ8qBs4xzUQskZ6Scz9rVNjKt+trv0h
         pFZQ==
X-Gm-Message-State: AOAM530Qn/4m4NiqgO/MQhkk+QarNDNGckptKUwpbyM2U9sxHAwFiX91
        vb8cCZbjM1LBbg9DKB7KkZBZS9v1u8gwpzoVsJmkvOWHuVLjg8hLmdsipXMVh5amZuXB4NQgdyH
        jVjf+/kBz+rXgWbjcniw1feVubUyVQvRGomcwG6yI5j2IJm/D7fQkHynje3KdMB8ATg1/jXbThc
        Ek
X-Received: by 2002:a62:e21a:0:b029:2de:4440:3a with SMTP id a26-20020a62e21a0000b02902de4440003amr28091160pfi.23.1621923037312;
        Mon, 24 May 2021 23:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcul8Osk5YUUxMqw8lYyZbg9J74NcgDmptA1ycXjYhsCuAI8yoBr2KodL1zkGCBnHfRNoPlg==
X-Received: by 2002:a62:e21a:0:b029:2de:4440:3a with SMTP id a26-20020a62e21a0000b02902de4440003amr28091140pfi.23.1621923036908;
        Mon, 24 May 2021 23:10:36 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y66sm12812325pgb.14.2021.05.24.23.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 23:10:36 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Fix error handling in virtnet_restore()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210517084516.332-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <782e9d35-99be-b77e-73f7-3291e03d6fe6@redhat.com>
Date:   Tue, 25 May 2021 14:10:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517084516.332-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/17 ÏÂÎç4:45, Xie Yongji Ð´µÀ:
> Do some cleanups in virtnet_restore() when virtnet_cpu_notif_add() failed.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/net/virtio_net.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7be93ca01650..5ca7d6780add 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3250,8 +3250,11 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>   	virtnet_set_queues(vi, vi->curr_queue_pairs);
>   
>   	err = virtnet_cpu_notif_add(vi);
> -	if (err)
> +	if (err) {
> +		virtnet_freeze_down(vdev);
> +		remove_vq_common(vi);
>   		return err;
> +	}
>   
>   	return 0;
>   }

