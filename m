Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BB38FAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhEYGZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhEYGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621923806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqC+rL03NFU00q36iPYaCWY4fHiegTpGAwzrspkzWwU=;
        b=GVug03hw1sZcb9Wb+KKL7CaHuWURywZ7gSiHNqvXivsvx7JruHqaDQqOttK1EC9uJ28xW5
        2PiQxBd39E7LDxG7ZSuFok8pmruTrmPPhsAEEqCbVo32+rlIOCQy3l6lHCCx0WUtlPjAId
        yBreBL3kYCwm6k2cbIBaIUWrqSiM9a0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-SEosPU_sOp2W7li400SkPw-1; Tue, 25 May 2021 02:23:25 -0400
X-MC-Unique: SEosPU_sOp2W7li400SkPw-1
Received: by mail-pl1-f198.google.com with SMTP id m12-20020a170902f20cb02900ef9c8577c4so14222472plc.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RqC+rL03NFU00q36iPYaCWY4fHiegTpGAwzrspkzWwU=;
        b=rxXLNPPP+wbx5hkLPPvreUqEHS3okAAHPGg8EDSzwpLsmhmXpo+RggoslnEbYVhMkg
         zBAhYI3ZIuIPOFkaMfn8A8WnMtXtbAAnXArsPWxdJBoBxnt7W61wSkoMBWNUTRjWn75C
         xH+MCsAKfn/s0i8848L8oKYql9whwJSgmUtleS1fqqx0ABgxq7hFcNyP5oJ6fYF+SpvP
         tTv7K7MMw4P78SLG+CJVuMbfL3e8gUi39Cq2r7aL+WHiZZont0c5MW/WC4SR4ZLg7mWN
         YMTnE/b8zOe7DsNgMY5oYHQ70T+xVPz6w1i5F7lV1xkvNyjxv3Ob3hsR96yXTGiW4rIJ
         k86g==
X-Gm-Message-State: AOAM533f1LoePDHScLXkObcpp9Wquom+7ULnkKv5PdRHkOW1w+E8rzcG
        te6KKijpI8iXvHok+x8rCGFfoIj3IqdX302yOHR6of4l94wMzV1mY+Mo86ZnEeYqmMP8GzRpgQN
        QLv6XQlsnl9MoNKjgiEMo1aYECnIRmkqhifsHrp+VfJeX872rATeDtEbGSwA7IoQ7puK6BPbSwR
        EY
X-Received: by 2002:a17:90a:602:: with SMTP id j2mr29435214pjj.211.1621923803929;
        Mon, 24 May 2021 23:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzthPvWzWsy+OgjCaqNyzQJxLtpWU/5mo8q3NP6jddpWWmCJIfZD4jC3PimfRJ+ctmhjllivg==
X-Received: by 2002:a17:90a:602:: with SMTP id j2mr29435186pjj.211.1621923803627;
        Mon, 24 May 2021 23:23:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j20sm10584356pfj.40.2021.05.24.23.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 23:23:23 -0700 (PDT)
Subject: Re: [PATCH] virtio_console: Assure used length from device is limited
To:     Xie Yongji <xieyongji@bytedance.com>, amit@kernel.org,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210525045304.1085-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <007b4e26-8ea1-ac22-fd77-e54b7417351b@redhat.com>
Date:   Tue, 25 May 2021 14:23:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525045304.1085-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/25 ÏÂÎç12:53, Xie Yongji Ð´µÀ:
> The buf->len might come from an untrusted device. This
> ensures the value would not exceed the size of the buffer
> to avoid data corruption or loss.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/char/virtio_console.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 1c40ca6d76ba..598863e6daf8 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -475,7 +475,7 @@ static struct port_buffer *get_inbuf(struct port *port)
>   
>   	buf = virtqueue_get_buf(port->in_vq, &len);
>   	if (buf) {
> -		buf->len = len;
> +		buf->len = min(len, buf->size);
>   		buf->offset = 0;
>   		port->stats.bytes_received += len;
>   	}
> @@ -1709,7 +1709,7 @@ static void control_work_handler(struct work_struct *work)
>   	while ((buf = virtqueue_get_buf(vq, &len))) {
>   		spin_unlock(&portdev->c_ivq_lock);
>   
> -		buf->len = len;
> +		buf->len = min(len, buf->size);
>   		buf->offset = 0;
>   
>   		handle_control_message(vq->vdev, portdev, buf);

