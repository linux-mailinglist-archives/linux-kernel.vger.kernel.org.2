Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700B3771AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhEHMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 08:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhEHMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 08:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620476556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqIHXF/RzgI6RicHORDy0FfhUzmOMaZdt2NO6pcWHTE=;
        b=VLFPOQB5QT/0suCjdFn7pbeTKyH0+hVkNizAIcbcFHF33LPq7SZ7t0kCyjmwh77Bp0ImrK
        g/vWuOl6/znw8xfD+3GKt4AIxBNhTPrwCWDAeXIeqSIfp2ONx5E9zzK7y2VwDHwrCOwJrL
        lOdp5zOvnE7HktsBf8lv2ogT5nfrJK0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-bZm1p7YoN5iigbnUR7Q2mg-1; Sat, 08 May 2021 08:22:35 -0400
X-MC-Unique: bZm1p7YoN5iigbnUR7Q2mg-1
Received: by mail-oi1-f199.google.com with SMTP id m204-20020acabcd50000b02901e5520ef540so6121209oif.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 05:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XqIHXF/RzgI6RicHORDy0FfhUzmOMaZdt2NO6pcWHTE=;
        b=tzYgfzikdRKvbJSPKksQKE//OgNb/Ei7uxVqd2cUNRgEehfOFysqmWuipQSsDVzxId
         WAcSGKBdOiVxznAgul0SKe3LvQNbstFWIYjAOww67zG4C474l9x5tDFn4k1lgSVTqyj7
         q2yZZAOjXm/cFDCaKZOQodtioqXpk/JkOdyVsniCjGVJrq+JKv6wrVAzrBjLJscsVy8m
         6IbmYIV8Wu72ou0S5HFawHE8LB2yy1xCh56lu+0GQGBOuwujAxlmoYsTOVwnRcCwrn8a
         W8kv5jI90Eo/1gyKxqBqUThZbtx8XcoxoEVjhAIgnrsrhGQcQvkBkYPKmcmBRdJL4Rxd
         b5uQ==
X-Gm-Message-State: AOAM5300gjt/XfK9tP0YjdPIAsTm4/qwiT3YNyOfGMy6D3RMVx9QrIH1
        4v/WS3lcIaBgcfND5sVIbDswUQrwP1zGHWJ+0k1AvFtiv7btKdNIJRZaa98JmuucnvTWecg2giG
        lBkw4rCIf5ekJI1VlMvggMFUU
X-Received: by 2002:aca:c402:: with SMTP id u2mr11001587oif.139.1620476554666;
        Sat, 08 May 2021 05:22:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCaPhvMNHUP48XCcuNXFvnwBEM6JmWvAjl7sIYqItYIsYwDPp1DaYba66prqr9etqJ/4m3QQ==
X-Received: by 2002:aca:c402:: with SMTP id u2mr11001579oif.139.1620476554493;
        Sat, 08 May 2021 05:22:34 -0700 (PDT)
Received: from [192.168.0.112] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id z4sm1744288otq.65.2021.05.08.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 05:22:34 -0700 (PDT)
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20210507221527.699516-1-ckuehl@redhat.com>
Message-ID: <9b9c8779-84b4-5c6d-8dc2-c16f18c68c70@redhat.com>
Date:   Sat, 8 May 2021 07:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210507221527.699516-1-ckuehl@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/21 5:15 PM, Connor Kuehl wrote:
> Distribute requests across the multiqueue complex automatically based
> on the IRQ affinity.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bcb8a02e2d8b..dcdc8b7b1ad5 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -30,6 +30,10 @@
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>  
> +struct virtio_fs_vq;
> +
> +DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
> [..]
> +
> +		for_each_cpu(cpu, mask) {
> +			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
> +			*cpu_vq = &fs->vqs[i];
> +		}
> +	}

Hmm, actually, it's just occurred to me that the per-CPU state could be
problematic with multiple virtio-fs mounts.

I'll workshop this some more.

Connor

