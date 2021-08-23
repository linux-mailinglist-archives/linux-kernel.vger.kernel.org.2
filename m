Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC523F4F52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhHWRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:17:21 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42760 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhHWRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:17:07 -0400
Received: by mail-ed1-f52.google.com with SMTP id z19so2766556edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUCyu2M+XnnIg56S9qGvy39oPESzj10FdrNHnuAxzuc=;
        b=ICkv1qwXWCE/+QK5J79Odhh1gaDlTsDLwLwwx+3ZPuNnYgI5bfKrC6QkabPzNPco1a
         oL9RfhRa2lfmHgMlIZE8jAm2RKXbu0R+SQAqjS1O/CyQSZaEdPNvvxWCFS4VLESEJ02B
         Mtx7CBM4n4Bx9iruKoose1oCZEHwXEaW2DuPYCPn+pMVVDnMdyWO0OAeZfMuHXO3kYsn
         bovtpJjgYHaGFAQrYDSFr/vRXSo7aKdyBpK0K6k8DsCAGfOIlkT1bJbTN3vFMBAInN5O
         VU1edZar4cQFQ/sf2KM8aCd76Y6GXr4T1HBO2ygOKyKzt5B+iDJjEw7myTVILC4NXPCr
         flpg==
X-Gm-Message-State: AOAM5307eTgMFPdBzjq46Yy65MrLCuIpcsrkvtXtWO3fnfsCPJGzevcA
        uOyQyqs3N5SVMOnzyL6auqk=
X-Google-Smtp-Source: ABdhPJxpOT0fUPynmkj7Rh5qMyesz4W8uSAmXQbwc6w3wKCGF0XA4fj5COiSd9dyemeGW4TdxVP3rw==
X-Received: by 2002:a05:6402:1c03:: with SMTP id ck3mr38504746edb.312.1629738983576;
        Mon, 23 Aug 2021 10:16:23 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id v12sm9885549ede.16.2021.08.23.10.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:16:23 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20210811152803.30017-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
Date:   Mon, 23 Aug 2021 10:16:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/21 8:28 AM, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When triggering a rescan due to a namespace resize we will be
> receiving AENs on every controller, triggering a rescan of all
> attached namespaces. If multipath is active only the current path and
> the ns_head disk will be updated, the other paths will still refer to
> the old size until AENs for the remaining controllers are received.
> 
> If I/O comes in before that it might be routed to one of the old
> paths, triggering an I/O failure with 'access beyond end of device'.
> With this patch the old paths are skipped from multipath path
> selection until the controller serving these paths has been rescanned.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: - introduce NVME_NS_READY flag instead of NVME_NS_INVALIDATE
>            - use 'revalidate' instead of 'invalidate' which
> 	    follows the zoned device code path.]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v3:
>    - Renamed nvme_mpath_invalidated_paths to nvme_mpath_revalidate_paths()
>    - Replaced NVME_NS_INVALIDATE with NVME_NS_READY
> v2:
>    - https://lore.kernel.org/linux-nvme/20210730071059.124347-1-dwagner@suse.de/
>    - removed churn from failed rebase.
> v1:
>    - https://lore.kernel.org/linux-nvme/20210729194630.i5mhvvgb73duojqq@beryllium.lan/
> 
> drivers/nvme/host/core.c      |  3 +++
>   drivers/nvme/host/multipath.c | 17 ++++++++++++++++-
>   drivers/nvme/host/nvme.h      |  5 +++++
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2f0cbaba12ac..54aafde4f556 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1878,6 +1878,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   			goto out_unfreeze;
>   	}
>   
> +	set_bit(NVME_NS_READY, &ns->flags);
>   	blk_mq_unfreeze_queue(ns->disk->queue);
>   
>   	if (blk_queue_is_zoned(ns->queue)) {
> @@ -1889,6 +1890,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	if (nvme_ns_head_multipath(ns->head)) {
>   		blk_mq_freeze_queue(ns->head->disk->queue);
>   		nvme_update_disk_info(ns->head->disk, ns, id);
> +		nvme_mpath_revalidate_paths(ns);
>   		blk_stack_limits(&ns->head->disk->queue->limits,
>   				 &ns->queue->limits, 0);
>   		blk_queue_update_readahead(ns->head->disk->queue);
> @@ -3816,6 +3818,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>   		return;
>   
> +	clear_bit(NVME_NS_READY, &ns->flags);
>   	set_capacity(ns->disk, 0);
>   	nvme_fault_inject_fini(&ns->fault_inject);
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3f32c5e86bfc..d390f14b8bb6 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -147,6 +147,21 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   	mutex_unlock(&ctrl->scan_lock);
>   }
>   
> +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> +{
> +	struct nvme_ns_head *head = ns->head;
> +	sector_t capacity = get_capacity(head->disk);
> +	int node;
> +
> +	for_each_node(node)
> +		rcu_assign_pointer(head->current_path[node], NULL);
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (capacity != get_capacity(ns->disk))
> +			clear_bit(NVME_NS_READY, &ns->flags);
> +	}

Shouldn't the null setting to current_path come after
we clear NVME_NS_READY on the ns? Otherwise we may still
submit and current_path will be populated with the ns
again...
