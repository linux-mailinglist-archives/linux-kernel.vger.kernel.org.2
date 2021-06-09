Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE093A12DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhFILiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhFILip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:38:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227AC061574;
        Wed,  9 Jun 2021 04:36:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g18so26275169edq.8;
        Wed, 09 Jun 2021 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHoyMIyfVW7+1kC8C+zBx8vxhLeCEYbvMnu9kCDyJSI=;
        b=eY3ttzin6upqcncYSRZ03TgoE/u4Rlr9JdI1k2eA5YE15tePqa3VXlvfNYG3I3ZtKT
         SPbuR7t2LBIhC5FtBU3L3F5BnksF2zgsoe5L/2foFaW/S5hm3NVrNZx/YeQiRIRK5wrz
         QwKwRBrpt8HmxrexTocHwfx3pPX0YtATUpsK/oWQxDD9I+ibrzd+UyQS6PEfeNOFq1mV
         SX6GUuxXHtVCPnaup2pNPe/+HQsjjsgrVUJOLjsWekvSZMPlTbP1mXNxQYLNpH5bR5OA
         +Xo6EFxrq7HvDOrL6ZMsoc4HD2qJJs5/op3CSGSQvqfbnMTcDrVxn6HZ3rg3VzSP2+Iu
         dqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHoyMIyfVW7+1kC8C+zBx8vxhLeCEYbvMnu9kCDyJSI=;
        b=Old3O9Mb+0AUXxnZw4YNGrdUMV7RooCVb2VkeGWsUh6+oUHlNYi7h4lg9RcpN+or7C
         neq/fD8yMO0ZeNBOiF79nQQeBrk9t8i/2qFrnQCzXSHKhQAGr4BXugQPKYdovAKfiVJe
         yUaR95OLwSH2E/9L7lFEvMbGZzUh05hOeotKEzjlIgW988yHdDI+hvExD1+xcAeUisxh
         Y2cWSWzd0sv24a2oX9gWG10bsOuIRhKMvPYIu9JEUBXnMJd3OHthwL6gt4ytio4rQrXD
         jXu0lZ5UZCn1YEWB12XL0vLYMaTVzK8prkqyw+CZ85qvKOrimIzqH838udbDsv0FXU/n
         DDmg==
X-Gm-Message-State: AOAM530B9GG8ZE8lzSyXNLkjehmI7S+zaDXt8NOmOeYoP984qZM4sY4J
        ezc7wcYV+nBJKzq84atCKjg=
X-Google-Smtp-Source: ABdhPJypuTgNjonPi3NeA8ZL5Vbbl2ZyyX9Sy3OfueSwvx6OkETulvWh7yQp8xG4hoyi+VZHg7kHNA==
X-Received: by 2002:aa7:d34a:: with SMTP id m10mr5794534edr.57.1623238605402;
        Wed, 09 Jun 2021 04:36:45 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5ae19.dip0.t-ipconnect.de. [217.229.174.25])
        by smtp.gmail.com with ESMTPSA id lv25sm983025ejb.100.2021.06.09.04.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:36:44 -0700 (PDT)
Subject: Re: [PATCH -next v2] platform/surface: aggregator: Use list_move_tail
 instead of list_del/list_add_tail in ssh_request_layer.c
To:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210609072638.1358174-1-libaokun1@huawei.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <6eb2ed3a-13fb-54cc-4416-d8e7671e87f3@gmail.com>
Date:   Wed, 9 Jun 2021 13:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609072638.1358174-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 9:26 AM, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail() in ssh_request_layer.c.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max

> ---
> V1->V2:
> 	CC mailist
> 
>   .../surface/aggregator/ssh_request_layer.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
> index 52a83a8fcf82..fec2d7af2646 100644
> --- a/drivers/platform/surface/aggregator/ssh_request_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
> @@ -863,9 +863,7 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
>   		clear_bit(SSH_REQUEST_SF_PENDING_BIT, &r->state);
>   
>   		atomic_dec(&rtl->pending.count);
> -		list_del(&r->node);
> -
> -		list_add_tail(&r->node, &claimed);
> +		list_move_tail(&r->node, &claimed);
>   	}
>   	spin_unlock(&rtl->pending.lock);
>   
> @@ -1204,8 +1202,7 @@ void ssh_rtl_shutdown(struct ssh_rtl *rtl)
>   		smp_mb__before_atomic();
>   		clear_bit(SSH_REQUEST_SF_QUEUED_BIT, &r->state);
>   
> -		list_del(&r->node);
> -		list_add_tail(&r->node, &claimed);
> +		list_move_tail(&r->node, &claimed);
>   	}
>   	spin_unlock(&rtl->queue.lock);
>   
> @@ -1238,8 +1235,7 @@ void ssh_rtl_shutdown(struct ssh_rtl *rtl)
>   			smp_mb__before_atomic();
>   			clear_bit(SSH_REQUEST_SF_PENDING_BIT, &r->state);
>   
> -			list_del(&r->node);
> -			list_add_tail(&r->node, &claimed);
> +			list_move_tail(&r->node, &claimed);
>   		}
>   		spin_unlock(&rtl->pending.lock);
>   	}
> 
