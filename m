Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3A3E2FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhHFT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:57:44 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:46057 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbhHFT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:57:36 -0400
Received: by mail-pj1-f54.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso19484833pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r3vnzaT72y5e2wz7p02YKqBIGki8uRtZL1NCQSFt+Ng=;
        b=VP8tUZITaVTpk4XdtW2CdI7OUYWBku65Tuonjgq85sZW4FU9r/qoVEkYVsDyqUjYBU
         GjfqLxb5mFL+Rc5m+EXeF7b1NFic09HG539lFlC/wrtH4DlwitJe3vLjGZmTAykzCm1o
         525oDXwUTvmQz6SAK7d0KNl1LtV3TEDRnr3P1REgHr0AQZSQBfemI1NRux1RoTvpt340
         LsplLMwig3ll6TRv4EGQMw4bPJF2UbPev+IafGA7+i53lUAS9fgCq+1FU6KZ18hsuqOC
         p+6yEMOCLEDmJAWmMiSSUcwXjOj1iwp7jr4oBL8Kc6wrs6yQzd0wLL2TiisuuTYbkKtt
         iNrg==
X-Gm-Message-State: AOAM533VGQvrIAZZc49UAkeUHbbflkPzHcVBDT+jSAfcQ+WHaxClWd1m
        C15vojCwO3PIukW0reSNd0M=
X-Google-Smtp-Source: ABdhPJztkMWl+2DyskHSTMLgY5kM8Vvrk62LRHlCrCvovXf09q08MZ8P1B/1E6KEuKIcF/HSqq8qzw==
X-Received: by 2002:a65:51c9:: with SMTP id i9mr7444pgq.102.1628279839583;
        Fri, 06 Aug 2021 12:57:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7? ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
        by smtp.gmail.com with ESMTPSA id v25sm11198844pfm.202.2021.08.06.12.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 12:57:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
Date:   Fri, 6 Aug 2021 12:57:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-3-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Hannes Reinecke <hare@suse.de>
> 
> When the number of hardware queues changes during resetting we should
> update the tagset first before using it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0a97ba02f61e..32268f24f62a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1789,6 +1789,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
>   static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   {
>   	int ret;
> +	u32 prior_q_cnt = ctrl->queue_count;
>   
>   	ret = nvme_tcp_alloc_io_queues(ctrl);
>   	if (ret)
> @@ -1806,14 +1807,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> -	}
> -
> -	ret = nvme_tcp_start_io_queues(ctrl);
> -	if (ret)
> -		goto out_cleanup_connect_q;
> -
> -	if (!new) {
> -		nvme_start_queues(ctrl);
> +	} else if (prior_q_cnt != ctrl->queue_count) {

So if the queue count did not change we don't wait to make sure
the queue g_usage_counter ref made it to zero? What guarantees that it
did?

>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
>   			 * If we timed out waiting for freeze we are likely to
> @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		nvme_unfreeze(ctrl);
>   	}
>   
> +	ret = nvme_tcp_start_io_queues(ctrl);
> +	if (ret)
> +		goto out_cleanup_connect_q;
> +

Did you test this with both heavy I/O, reset loop and ifdown/ifup loop?

If we unquiesce and unfreeze before we start the queues the pending I/Os
may resume before the connect and not allow the connect to make forward
progress.

>   	return 0;
>   
>   out_wait_freeze_timed_out:
> 
