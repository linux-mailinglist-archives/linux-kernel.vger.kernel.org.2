Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57C13E2FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhHFTmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:42:20 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46063 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhHFTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:42:19 -0400
Received: by mail-pl1-f178.google.com with SMTP id d17so8425422plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpLObiiQLd5hw3nNKqOroEB/FSEufNd2Kqe0wsHzpa4=;
        b=POPKNHAftDmb3mwkNa+/gbjtiIiC0yBQyUGtQQhkPH+zqbIQAv3Dj2Kcv8lG3hHk9l
         /N9ugnNIh89ir5v8jwfUy3m8uh/sWVV6vyF19ylRdlHQrnsT/zFi1oNJks7QaF7Ah/Vp
         7/A0VfUBEk5fujGNtON/WpDx8lhFR/57qKzx/ic6finTnlNjbZnBqZ8kuMpPFT7KsFmS
         qdtELd/Bsj+x6dmoY6lorrhhBuOQY4jiaM+FPkl9GNtqBxyFv/OXNl7v+RHUPMT7XenW
         QDaGIu1Csub1d4FkCQ86a3Bvz++4e+O9qi6FBX2cNxmnmZ8N0mLWY99qQgQt7dSBlZOK
         ZJnw==
X-Gm-Message-State: AOAM533jwPw55evyiN1m32+aQQMS3gMNQzFwJOswbJRF4qTIqd3q2M/2
        Bp1fdyXLKykaI3ylCE9izmw=
X-Google-Smtp-Source: ABdhPJyEJ03tBxCW8K04znwjFoXvo/hL/lg+XnsGBoy0m5j8M/NpYf/BBkwhicKTfFjDqcs/xTm5uA==
X-Received: by 2002:a17:90a:ce05:: with SMTP id f5mr22649696pju.93.1628278922237;
        Fri, 06 Aug 2021 12:42:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7? ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
        by smtp.gmail.com with ESMTPSA id f10sm11636313pfa.17.2021.08.06.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 12:42:01 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
Date:   Fri, 6 Aug 2021 12:42:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805121541.77613-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The spec says
> 
>    7.4.6.1 Digest Error handling
> 
>    When a host detects a data digest error in a C2HData PDU, that host
>    shall continue processing C2HData PDUs associated with the command and
>    when the command processing has completed, if a successful status was
>    returned by the controller, the host shall fail the command with a
>    non-fatal transport error.
> 
> Currently the transport is reseted when a data digest error is
> detected. To fix this, keep track of the final status in the queue
> object and use it when completing the request.
> 
> The new member can be placed adjacent to the receive related members and
> fits in the cacheline as there is a 4 byte hole.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> Hi,
> 
> I've tested this by modifying the receive path. Via the fault_inject
> interface I injecting wrong hash values. The request would then be
> completed with status != 0 and nvme_decide_disposition decices to
> retry the request. So this seems be in more sync with what the spec
> says on this topic.
> 
> Daniel
> 
>   drivers/nvme/host/tcp.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 097f7dd10ed3..5253147df4c7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
> +	u16			status;

Why is this a queue member and not a request member?

>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -496,7 +497,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	if (!nvme_try_complete_req(rq, queue->status ?
> +			queue->status : cqe->status, cqe->result))
>   		nvme_complete_rq(rq);
>   	queue->nr_cqe++;
>   
> @@ -676,6 +678,7 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   	switch (hdr->type) {
>   	case nvme_tcp_c2h_data:
> +		queue->status = NVME_SC_SUCCESS;
>   		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
>   	case nvme_tcp_rsp:
>   		nvme_tcp_init_recv_ctx(queue);
> @@ -758,7 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>   		} else {
>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
> +				nvme_tcp_end_request(rq, queue->status);
>   				queue->nr_cqe++;
>   			}
>   			nvme_tcp_init_recv_ctx(queue);
> @@ -792,14 +795,14 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			"data digest error: recv %#x expected %#x\n",
>   			le32_to_cpu(queue->recv_ddgst),
>   			le32_to_cpu(queue->exp_ddgst));
> -		return -EIO;
> +		queue->status = NVME_SC_DATA_XFER_ERROR;
>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>   		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
>   					pdu->command_id);
>   
> -		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
> +		nvme_tcp_end_request(rq, queue->status);
>   		queue->nr_cqe++;
>   	}
>   
> 
