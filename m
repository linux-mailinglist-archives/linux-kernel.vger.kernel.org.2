Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0313A12E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhFILka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:40:30 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37524 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhFILk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:40:28 -0400
Received: by mail-ej1-f44.google.com with SMTP id ce15so37947513ejb.4;
        Wed, 09 Jun 2021 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ul1U8JIUteuos9/dP4bDxgjOTGCqSKiL2ODQktxyAA4=;
        b=NrAvAw+SlQCaKYGIrWnem5ASSdgT9h4sSiKueM3rQgWd5Rt5M2dwVAFwBDbKxFQ8o1
         uwXfcoK/seadfO1qytduzEolYQaEjV/mlP1fOBllXcx5hkmqvZB3U8dpw/ViNK4ZMZk5
         QsRLipAJYMw+LhNRykHHW0vcSHEBNvcNgaJtLhco4ERKKNLG4iUSiHm9LIa00Ibu1QDL
         trD7k57Jy3iJCW7AOyqWKkuEneurIN9fd6hF+cIV/u2Sk9sQNtsIbNRD5wQUUUkymDic
         xgDH5Pt25DaOOz124qvmW7Ly+st3vVE3WF3OkNNsirGAlOLTCKK5+SztsiUDMVIy7vFp
         6DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ul1U8JIUteuos9/dP4bDxgjOTGCqSKiL2ODQktxyAA4=;
        b=POpo5OQ5xOZVS5+EHvT5oN55xpnYfqjatBROKvFbsBRe0bpTldYcS658DkjpqpT3ld
         n9PCCFhXc6d4TuNHnlXPFc56+XYUS64f0noIuhbTIZKgwcYzfU5UeVdfzKvwTuZ//M/7
         XpYtIRZbp4AXwKApRdHfjY3JFOOO0WWcD1Oxg5AbXNSXt84vIqbLXd7xTXu2XHqLfXnt
         XUXNAT7I84Oe50HMYbGlUcvaw8yZTnblXUqd8lgf9RYBy0w3dzXdd08eDt0xKmMNgeVf
         q4z9OMN59PajK/90vASZJgb89KHJQnIZ1a0DarBhzZXc6dYn0VjCGR44tNRjmevTdrmK
         jWyQ==
X-Gm-Message-State: AOAM531OQQCuX5cOkvs1JXPQYf2PGbdE9OugfvuDsjlS1ezaXsKExTrm
        V/MfIT2e4QIKPcZOGYqSgAQSGgjjtys=
X-Google-Smtp-Source: ABdhPJyGgvfbGS+6VLWC+HxFhcNZeUC85KCVRXBSQy8Si5ABAvFpcc1EkWYXSd9MxmOYu7S2sHwuGw==
X-Received: by 2002:a17:906:1796:: with SMTP id t22mr27837394eje.304.1623238653336;
        Wed, 09 Jun 2021 04:37:33 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5ae19.dip0.t-ipconnect.de. [217.229.174.25])
        by smtp.gmail.com with ESMTPSA id r1sm1020241edp.90.2021.06.09.04.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:37:32 -0700 (PDT)
Subject: Re: [PATCH -next v2] platform/surface: aggregator: Use list_move_tail
 instead of list_del/list_add_tail in ssh_packet_layer.c
To:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210609072448.1357524-1-libaokun1@huawei.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <aa1f8a45-d5f7-4462-040a-46476f804b90@gmail.com>
Date:   Wed, 9 Jun 2021 13:37:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609072448.1357524-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 9:24 AM, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail() in ssh_packet_layer.c.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

Looks good to me, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max

> V1->V2:
> 	CC mailist
> 
>   .../surface/aggregator/ssh_packet_layer.c  | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 15d96eac6811..2f546ad11c4e 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1567,9 +1567,7 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>   		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>   
>   		atomic_dec(&ptl->pending.count);
> -		list_del(&p->pending_node);
> -
> -		list_add_tail(&p->pending_node, &claimed);
> +		list_move_tail(&p->pending_node, &claimed);
>   	}
>   
>   	spin_unlock(&ptl->pending.lock);
> @@ -1957,8 +1955,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>   		smp_mb__before_atomic();
>   		clear_bit(SSH_PACKET_SF_QUEUED_BIT, &p->state);
>   
> -		list_del(&p->queue_node);
> -		list_add_tail(&p->queue_node, &complete_q);
> +		list_move_tail(&p->queue_node, &complete_q);
>   	}
>   	spin_unlock(&ptl->queue.lock);
>   
> @@ -1970,8 +1967,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>   		smp_mb__before_atomic();
>   		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>   
> -		list_del(&p->pending_node);
> -		list_add_tail(&p->pending_node, &complete_q);
> +		list_move_tail(&p->pending_node, &complete_q);
>   	}
>   	atomic_set(&ptl->pending.count, 0);
>   	spin_unlock(&ptl->pending.lock);
> 
