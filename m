Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F693A172B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhFIO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238057AbhFIO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623248660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJNebWYNcgp94iCSccsOMLK7A1oosUye0VHwk27VTQQ=;
        b=X8eFTOLkN+t2N8sEr+AH2n96QfauocrZwJqkm3XdHsD7FgIzpSQF1hJoxQI9FNohxMFeNS
        YHF57/QCJVBzG2WSgZcq6kTcx5Vv83aoVGsrQRx6oHg23MYZG/QN/XuNPQAO08Tr8LSdj1
        gBu+L9m6Q+MYCS3EbcnNYbuzu6ByATw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-doY1kP0gPB6PCqA-DYGY1w-1; Wed, 09 Jun 2021 10:24:19 -0400
X-MC-Unique: doY1kP0gPB6PCqA-DYGY1w-1
Received: by mail-ej1-f69.google.com with SMTP id n8-20020a1709067b48b02904171dc68f87so3604746ejo.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJNebWYNcgp94iCSccsOMLK7A1oosUye0VHwk27VTQQ=;
        b=cwfYDFmqptSWdjUV4UPQMMR0a3OVAsifz1Mvwm01YpWN2u9Xhw9vS6nFkoBHisC9Iu
         jbZ2gWNWU7kYmz1nRLtdu9j33xyY9/6xvYHik8WBv5eiqOpnBuOP1kMYPWPFL2hvABfK
         hAbsSddicBocvhHWgKBZr5L9ro7tLmCGj+NehgSn5IzSryOpchIXUz99CSNq+SwJFrb3
         45h/MKGMutoiZ/qEUM+v0zUkY81+9Otvz+B2ugyiQ3uBpwij/E8pw8XtIsZ727Kwd5Li
         hrXMZj2c1uWHgP7kDoOguViEeFPkcKsJU8NfzjOqXisE/Kvw11qIS7GSp7GVS/tSufVn
         6i3A==
X-Gm-Message-State: AOAM532NdNd1xZJfWDhb9MIISPpYgEsNTHW3UEhw8UTdXO6B1/ZnQQh+
        wQpf1LohLHc2x2R7J0DTaUCGWQ/S3h4h94yOPZPSQMt+p70VlNQjArtx2VJDcqoG9Zd0fvAzAej
        UjsftX3hCZX5YxmkB8co0bpjv
X-Received: by 2002:a17:906:b41:: with SMTP id v1mr155675ejg.246.1623248657847;
        Wed, 09 Jun 2021 07:24:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKtYD9bl3HjpaQgg0qSpowvDymNQ7EbiYVuMuhGkX1Yc6O3juTkqDxmT9LMu/CXykh5ydVGw==
X-Received: by 2002:a17:906:b41:: with SMTP id v1mr155657ejg.246.1623248657714;
        Wed, 09 Jun 2021 07:24:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id oz11sm1207955ejb.16.2021.06.09.07.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:24:17 -0700 (PDT)
Subject: Re: [PATCH -next v2] platform/surface: aggregator: Use list_move_tail
 instead of list_del/list_add_tail in ssh_packet_layer.c
To:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210609072448.1357524-1-libaokun1@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <be60d42b-5498-e15c-6301-3d8834af3c75@redhat.com>
Date:   Wed, 9 Jun 2021 16:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609072448.1357524-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/9/21 9:24 AM, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail() in ssh_packet_layer.c.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> V1->V2:
> 	CC mailist
> 
>  .../surface/aggregator/ssh_packet_layer.c  | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 15d96eac6811..2f546ad11c4e 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1567,9 +1567,7 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>  		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>  
>  		atomic_dec(&ptl->pending.count);
> -		list_del(&p->pending_node);
> -
> -		list_add_tail(&p->pending_node, &claimed);
> +		list_move_tail(&p->pending_node, &claimed);
>  	}
>  
>  	spin_unlock(&ptl->pending.lock);
> @@ -1957,8 +1955,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>  		smp_mb__before_atomic();
>  		clear_bit(SSH_PACKET_SF_QUEUED_BIT, &p->state);
>  
> -		list_del(&p->queue_node);
> -		list_add_tail(&p->queue_node, &complete_q);
> +		list_move_tail(&p->queue_node, &complete_q);
>  	}
>  	spin_unlock(&ptl->queue.lock);
>  
> @@ -1970,8 +1967,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>  		smp_mb__before_atomic();
>  		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>  
> -		list_del(&p->pending_node);
> -		list_add_tail(&p->pending_node, &complete_q);
> +		list_move_tail(&p->pending_node, &complete_q);
>  	}
>  	atomic_set(&ptl->pending.count, 0);
>  	spin_unlock(&ptl->pending.lock);
> 

