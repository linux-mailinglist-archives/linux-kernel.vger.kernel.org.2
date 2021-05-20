Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3D389EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhETHbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhETHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621495780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJI5xVvNxINRYWmcOTjljaXIWh1BlzRm8Wtm6C6Fnm0=;
        b=EqGltirlFHJxOAh7fVNZ1JUrMnrNNoYpHgVRIicfPpU/cJ7CZpS1+CjgOgfTQDVKt725mU
        ZzZ4Iwn0hh8ney1LmwD2srjelx2gE4Pq6FwCPGF85GvvKrysT9tzs5fUbXzSLoO9pQEU05
        klyU4ey3NYkRL01CZYrtHSb5+39FOU8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-5ZXbl5gXOhijuQyWhaWwdw-1; Thu, 20 May 2021 03:29:38 -0400
X-MC-Unique: 5ZXbl5gXOhijuQyWhaWwdw-1
Received: by mail-ed1-f69.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso9046916edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJI5xVvNxINRYWmcOTjljaXIWh1BlzRm8Wtm6C6Fnm0=;
        b=pb14HVBZCLsyEX8Q6Zn8dlY5D9qN44J43QJxtYe8E2aDjMv1j9Aggs5WtZPCsHrJai
         Cu72nPxj7hei3k5Wm/MosiuOg1X1hA2G0Y+xH/CzCi/EEBV195izM044A22yj4+jNJ6e
         BC9Y7dHl4DE4X3aCLy4H6NVhsz7JNNTNPiQdy2smrD42CHjrBCeA4wfUo939tFri4xm1
         1x58xi/5lrrgMM5VGB6gZL0ASYwi+wAAF/cTkfv8cfaXxEvL/rgzELctAGf2Cr0KGhxZ
         alW06lh3mEmhxQpPF9xZeb5jAqWRgdDjH4QIzbOdqA8Xg7TKZlWum0a4kH0eK+yz5Kx5
         I5kA==
X-Gm-Message-State: AOAM532TNEWR91x7cpSqWH39yvChG9hRgM4YUL3eu8/EPikoBONtuSbS
        1957+NOcvE6DuYAQrUc8UCeylfz8fhgq4GGRmMgQg+dE3fsi6mC8JB72q65ABv+nymuImIgq2sb
        2cJJewc1l5qDBRdkhPtRPxmWJ
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr3520776edt.246.1621495777139;
        Thu, 20 May 2021 00:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8+dyhQJCj4ceZNKLk7+x81350KC9GtSx2oTbohE3ItwuPVfBsGaPBRhHO/WvAEjvYZV1bYw==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr3520763edt.246.1621495776983;
        Thu, 20 May 2021 00:29:36 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id h9sm978823ede.93.2021.05.20.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:29:36 -0700 (PDT)
Date:   Thu, 20 May 2021 09:29:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        mst@redhat.com
Subject: Re: [PATCH -next] virtio_ring: Correct function name
 virtqueue_get_buf_ctx()
Message-ID: <20210520072934.ubkprak3li6nyrjf@steredhat>
References: <20210518050057.614081-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210518050057.614081-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 01:00:57PM +0800, Yang Yingliang wrote:
>Fix the following make W=1 kernel build warning:
>
>  drivers/virtio/virtio_ring.c:1903: warning: expecting prototype for virtqueue_get_buf(). Prototype was for virtqueue_get_buf_ctx() instead
>
>Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>---
> drivers/virtio/virtio_ring.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index 88f0b16b11b8..992cb1cbec93 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -1882,7 +1882,7 @@ bool virtqueue_kick(struct virtqueue *vq)
> EXPORT_SYMBOL_GPL(virtqueue_kick);
>
> /**
>- * virtqueue_get_buf - get the next used buffer
>+ * virtqueue_get_buf_ctx - get the next used buffer
>  * @_vq: the struct virtqueue we're talking about.
>  * @len: the length written into the buffer
>  * @ctx: extra context for the token
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

