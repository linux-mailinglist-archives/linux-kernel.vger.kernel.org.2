Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1B389E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhETHHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230383AbhETHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621494343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KaliF5eDoHyShQ6pVk6nswV0QmddLwdx+Te1ge1ipyU=;
        b=EJy833z/OS0DN4fNa0ISFYTp82wigHe5/PgOlw2aQqdeg1I36YfMz44qHTON6E7DeGTSdD
        0+/bDKkbO9OS/g5FM6iNViKyUaLZW73E34avway0ND9Gvcm34i1jNFyOFIQ/HJJz1KxQwb
        QrfJqugR4whwg5p6MZVakXevup/O0A8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-FrH6OUSIMTyq-1MPnwbTlA-1; Thu, 20 May 2021 03:05:42 -0400
X-MC-Unique: FrH6OUSIMTyq-1MPnwbTlA-1
Received: by mail-ed1-f70.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so9040332edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KaliF5eDoHyShQ6pVk6nswV0QmddLwdx+Te1ge1ipyU=;
        b=i52xyjisodzRT3R1RaQwfkdYolXw4xF/S4f7hBFSwAWgQuhFGGkLJPMoFxqgaeGGI+
         s8xRylNTxxlb70tlb9jiRpNF9Dy2VQYkqrD5+7jAREnRQs0yMzo5Kmrb+GyH/jX5ETzN
         GElKeQ7VT9RU+48lQnIW5CpxLD6htucRvHfWw9SRniC9OLmEW/iDeNxqjUyejx4pegyY
         4Oqn4FWmUUDqpku14UmzqQnceAxqWCLfRhkfL8egPakDkRivvc95FAtOMSeXBp8VR83M
         C72u9VCi5mwOt1Wo13QpgY4j1eSB37/7L9yikCpoRr1Ub2u2euD0McV/XcZDsXFIWjWV
         zNUw==
X-Gm-Message-State: AOAM532OUxPbIPhTDQsHSLCGp2+G5smCDfrA+bnZElFOGs/Z9M8NlpoK
        eZjLjsrgz48iBnSTef5q0lTX/Up1ixuvYhkamDDfa/T2HZFW6X5m73R3SOn4UhrKCmzcZ7I2KGP
        nO0hSmYFL3hAQkO96o6Ti/BnJ
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr3445593eds.166.1621494340849;
        Thu, 20 May 2021 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv5JoSB/zlPpuQMN8GuzvFJPHkuHmpfxSZN0QQJmqGyUr9a1onbpIw9MzbZAOgIOc+t4fM8A==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr3445576eds.166.1621494340688;
        Thu, 20 May 2021 00:05:40 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id m10sm987322edp.48.2021.05.20.00.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:05:40 -0700 (PDT)
Date:   Thu, 20 May 2021 09:05:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] vp_vdpa: fix error return code in vp_vdpa_probe()
Message-ID: <20210520070538.jniunk2rr3nyttuw@steredhat>
References: <20210519141646.3057093-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210519141646.3057093-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:16:46PM +0000, Wei Yongjun wrote:
>Fix to return negative error code -ENOMEM from the error handling
>case instead of 0, as done elsewhere in this function.
>
>Fixes: 11d8ffed00b2 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index c76ebb531212..e5d92db728d3 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -442,6 +442,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 			vp_modern_map_vq_notify(mdev, i,
> 						&vp_vdpa->vring[i].notify_pa);
> 		if (!vp_vdpa->vring[i].notify) {
>+			ret = -ENOMEM;
> 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> 			goto err;
> 		}
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

