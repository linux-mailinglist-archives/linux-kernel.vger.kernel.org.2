Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D5388EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353576AbhESNVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241024AbhESNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621430387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXXvD9CiFNirNA4dOLZzvSxS6V8dpX3pz9Nd6UAH9HM=;
        b=V6Q4+VKqhV+xeeEihoUeKwk4RTRgR30luUiXP91qjuBPo1D7u0MtHXny9YXyeIkJkoks7K
        jGy/W8BrW5rsGABW7lTOTf+L+rTd0iQ1tR3E+ljRBWRr0f/yqgLcSUJ3hYZWzjFkBuqjNA
        mqxqmEBsoFMVbPmf7lJEGQGCn/Jh/8k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-WK6me8dQOGKDLNyEzQ8HUg-1; Wed, 19 May 2021 09:19:46 -0400
X-MC-Unique: WK6me8dQOGKDLNyEzQ8HUg-1
Received: by mail-ed1-f72.google.com with SMTP id n6-20020a0564020606b029038cdc241890so7645217edv.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXXvD9CiFNirNA4dOLZzvSxS6V8dpX3pz9Nd6UAH9HM=;
        b=QzRrgJMlSOq5CkgpWfF6sEJWfUc0DW2SlgeFlrFvJbT+roXqzi3V0RZpCzTRsHXi3T
         Tzv9y5BkPsfJe8J7ZTwD3qMzE59UJxJrgGWqNgCUnQ42us/tiyRXVYnZPXDGVGLOVB5Q
         K1FWnbr3eAPGH+hyppycGmIvuDCQUSwxd+XqxfPPOpRwqOIVc57VwnEb4W8CeVhQ9/t2
         9D1inJL4nQB6vRuzQpmc1Bg41Yr4UHX9Y+yKhixM7MdDJcQSrpzQs0LNA9i0aZYAS+KX
         Vakzof4XNptRLp2cBN34bY4+usje3jGHJRUdU90fgy24iSXx7/i66sY4SqH3ML0CqNJP
         JTNA==
X-Gm-Message-State: AOAM533lvFJoF90pXROgItz04UZ5ST7sTYyN/5hCQd6kRwtjE6D6v8f3
        Epqnv6w31UgpG//VlCPKk1j6TP6ljh5i7BVez6SrO7uueccE4/rCnB0aDAyMFbxJBDIw8g1s0SE
        1M9YXWxWKA+/wcRxRVLhxQPXl
X-Received: by 2002:aa7:ca1a:: with SMTP id y26mr14299307eds.297.1621430385026;
        Wed, 19 May 2021 06:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvRFKubsHlILUrx/qm59JE7s2LmaR1khw5pnBK55ULXzlaOM21JTyS8pJ7Y6SbybI7WONb4w==
X-Received: by 2002:aa7:ca1a:: with SMTP id y26mr14299287eds.297.1621430384843;
        Wed, 19 May 2021 06:19:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cn21sm8976581edb.36.2021.05.19.06.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:19:44 -0700 (PDT)
Subject: Re: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier
 issue
To:     Liming Sun <limings@nvidia.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
 <1620433812-17911-1-git-send-email-limings@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1c3a1f86-14de-c787-9831-409d1e4c4243@redhat.com>
Date:   Wed, 19 May 2021 15:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620433812-17911-1-git-send-email-limings@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/21 2:30 AM, Liming Sun wrote:
> The virtio framework uses wmb() when updating avail->idx. It
> guarantees the write order, but not necessarily loading order
> for the code accessing the memory. This commit adds a load barrier
> after reading the avail->idx to make sure all the data in the
> descriptor is visible. It also adds a barrier when returning the
> packet to virtio framework to make sure read/writes are visible to
> the virtio code.
> 
> Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
> Signed-off-by: Liming Sun <limings@nvidia.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also include this in the next pdx86-fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> v1->v2:
>   Updates for Vadim's comments:
>   - Add the 'Fixes' field in the commit message.
> v1: Initial version
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index bbc4e71..38800e8 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -294,6 +294,9 @@ static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg)
>  	if (vring->next_avail == virtio16_to_cpu(vdev, vr->avail->idx))
>  		return NULL;
>  
> +	/* Make sure 'avail->idx' is visible already. */
> +	virtio_rmb(false);
> +
>  	idx = vring->next_avail % vr->num;
>  	head = virtio16_to_cpu(vdev, vr->avail->ring[idx]);
>  	if (WARN_ON(head >= vr->num))
> @@ -322,7 +325,7 @@ static void mlxbf_tmfifo_release_desc(struct mlxbf_tmfifo_vring *vring,
>  	 * done or not. Add a memory barrier here to make sure the update above
>  	 * completes before updating the idx.
>  	 */
> -	mb();
> +	virtio_mb(false);
>  	vr->used->idx = cpu_to_virtio16(vdev, vr_idx + 1);
>  }
>  
> @@ -733,6 +736,12 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
>  		desc = NULL;
>  		fifo->vring[is_rx] = NULL;
>  
> +		/*
> +		 * Make sure the load/store are in order before
> +		 * returning back to virtio.
> +		 */
> +		virtio_mb(false);
> +
>  		/* Notify upper layer that packet is done. */
>  		spin_lock_irqsave(&fifo->spin_lock[is_rx], flags);
>  		vring_interrupt(0, vring->vq);
> 

