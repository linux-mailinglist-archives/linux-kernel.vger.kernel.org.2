Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5303770C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEHJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhEHJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620464518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCbUAU9uZUHADCrJEyLeipgqPF0tUBdom+0LDVHCM/U=;
        b=IFf0OkfF87ayO/6jCkZptHVN4anSQQHnXOaTHe8IMXOy5dsOvEyjeps3WDlUc0pTPMPqkh
        0yJ2s3f3+F7eDcftLA6Epkp/IU/T7ir0lhQdmXcnwE0hdHSVifHdhmniXe0OvbToqyycuw
        tq7fLXGp2/vNWB90JolFfJSBsww7QtM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-zT8aDJQFMXe61fJUi6GrZQ-1; Sat, 08 May 2021 05:01:56 -0400
X-MC-Unique: zT8aDJQFMXe61fJUi6GrZQ-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402144db0290387e63c95d8so5838439edx.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 02:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCbUAU9uZUHADCrJEyLeipgqPF0tUBdom+0LDVHCM/U=;
        b=GJlX21lSYwm5XISyalXmLmMBSl/DwAhyMB3FdzshDVeMiSfNYAJkwevUoYa0AkEaA5
         vu2s+ATsg6mlLhSurLtZLN0qi/JAKVA3bYyFo4HyfBx3J8qgzxjW2E1F7WkAVCcO0ZSA
         nMRg8v0lFI22s5gyq8q0GIYLobyDK5zIX8c5H+nFdKn1ZBdXue7IXtwJum5o7sQrT61g
         GOwcR2MfhjYsvGUf30+of948dWTVnCb7SjTPwEJxikfPL/QOPsqIgN8KNh1R5eIld2jj
         liohC1k+ugo5uwkx2UWnLV00lIxB9uvPPGrfZyRD4JBESoxfXGizi4GY/mRZiPFaTYtD
         RmdA==
X-Gm-Message-State: AOAM530lHbp8LhdAjp6dng1ixaJUFjJeUZAQp/FygEXcIb6VIC/cAZ1r
        OCilqat5jSzJ0RiZy1grsyxd9HOCkhnAfpg4cXXhU8yN5JhbtPrCWZTbnLQ/L90urLZutWfpEgC
        eqNCmTQ+q/JVyHyJ2qg7SK5uJ
X-Received: by 2002:a05:6402:154d:: with SMTP id p13mr17078155edx.371.1620464515300;
        Sat, 08 May 2021 02:01:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt5GlxBSQQ3xpVkR0d/Nh0jBErUXlyzjJMNN+s0evPf6E0kgadaL4aiTqwg23olMcW4g9J/w==
X-Received: by 2002:a05:6402:154d:: with SMTP id p13mr17078142edx.371.1620464515168;
        Sat, 08 May 2021 02:01:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c5sm107224eds.94.2021.05.08.02.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 02:01:54 -0700 (PDT)
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
Message-ID: <816fdf7e-b69e-0cb3-ccb9-20b174682209@redhat.com>
Date:   Sat, 8 May 2021 11:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
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

I'm not familiar enough with this / the virtio code to be able to
judge if this makes sense (I assume it does).

Can I get an Ack or Reviewed-by from one of the other Mellanox
folks please?

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

