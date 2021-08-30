Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D080F3FB484
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhH3L0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:26:02 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:33352 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhH3L0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:26:01 -0400
Received: by mail-wm1-f41.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso11269633wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqRTnIr5Cge1DbJwXPCdaa0iV8m7g/QRqZT/v0OelUI=;
        b=dW3OtSvN79EUhXSyhu2pgi515RM29LP2B9LG35JiTPrBd2wgWpudG0MDd6Zh4P+a6q
         w2lZzYTb8986vp0JBsua7XhiFqELkPW/RQzcjoRogiUfBeJrP0BQAbdWcJ0VjyvrBREC
         0sBKDug2xl0HLd+PPhuPPwjYPfY8c+cnswbX2kXd3X4a6fqQqoTE0RAxDKXaQSWjTfuM
         1WDaIfwwtgThJBlle7vy5uCZxzg/kWCZv+BUn3Xl47+AB1spY5ZhjZyZBBGxhrqLUrWU
         5rQBwrmMFCPO2BO916/dy7Zj6r6OJhy4f/is8cHKEn72i71RvVdtvpfGdXcn7xCMvd8I
         PlgQ==
X-Gm-Message-State: AOAM532minWAUv8supL/yqFZAEo/xL70uWDiYsYTcGROJxcCzGvEnZl5
        AQpzI0klgvHZkj7khpo+aqe8PbEWJrs=
X-Google-Smtp-Source: ABdhPJwnBG2m0WK7taiBFZmrq9ajOSpvBC/acB8HnYFa6P0Ge8zvDBaho28tmmFvGEkMI0iTKeCoxg==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr23807193wmh.145.1630322707053;
        Mon, 30 Aug 2021 04:25:07 -0700 (PDT)
Received: from [192.168.64.87] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e2sm17030045wrq.56.2021.08.30.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 04:25:06 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        yi.he@emc.com
References: <20210826082137.23826-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53701a52-a49c-fcdf-49cc-98da55447e9a@grimberg.me>
Date:   Mon, 30 Aug 2021 14:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826082137.23826-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/21 1:21 AM, Daniel Wagner wrote:
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
> detected. Instead, when a digest error is detected, mark the final
> status as NVME_SC_DATA_XFER_ERROR and let the upper layer handle
> the error.
> 
> In order to keep track of the final result maintain a status field in
> nvme_tcp_request object and use it to overwrite the completion queue
> status (which might be successful even though a digest error has been
> detected) when completing the request.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> The status member placed so that it fills up a hole in struct
> nvme_tcp_request:
> 
> struct nvme_tcp_request {
>          struct nvme_request        req;                  /*     0    32 */
>          void *                     pdu;                  /*    32     8 */
>          struct nvme_tcp_queue *    queue;                /*    40     8 */
>          u32                        data_len;             /*    48     4 */
>          u32                        pdu_len;              /*    52     4 */
>          u32                        pdu_sent;             /*    56     4 */
>          u16                        ttag;                 /*    60     2 */
>          u16                        status;               /*    62     2 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          struct list_head           entry;                /*    64    16 */
>          struct llist_node          lentry;               /*    80     8 */
>          __le32                     ddgst;                /*    88     4 */
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          struct bio *               curr_bio;             /*    96     8 */
>          struct iov_iter            iter;                 /*   104    40 */
>          /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
>          size_t                     offset;               /*   144     8 */
>          size_t                     data_sent;            /*   152     8 */
>          enum nvme_tcp_send_state   state;                /*   160     4 */
> 
>          /* size: 168, cachelines: 3, members: 16 */
>          /* sum members: 160, holes: 1, sum holes: 4 */
>          /* padding: 4 */
>          /* last cacheline: 40 bytes */
> };
> 
> v3:
>   - initialize req->status in nvme_tcp_setup_cmd_pdu()
>   - add rb tag from Hannes
> 
> v2:
>   - https://lore.kernel.org/linux-nvme/20210825124259.28707-1-dwagner@suse.de/
>   - moved 'status' from nvme_tcp_queue to nvme_tcp_request.
> 
> v1:
>   - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/
> 
> drivers/nvme/host/tcp.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 645025620154..29ef0f74f620 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -45,6 +45,7 @@ struct nvme_tcp_request {
>   	u32			pdu_len;
>   	u32			pdu_sent;
>   	u16			ttag;
> +	u16			status;
>   	struct list_head	entry;
>   	struct llist_node	lentry;
>   	__le32			ddgst;
> @@ -485,7 +486,9 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
> +	u16 status;
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
>   	if (!rq) {
> @@ -496,7 +499,12 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	req = blk_mq_rq_to_pdu(rq);
> +	status = req->status;
> +	if (status == NVME_SC_SUCCESS)
> +		status = cqe->status;

Maybe more intuitive to skip the local status variable?
	/*  */
	if (req->status == NVME_SC_SUCCESS)
		req->status = cqe->status;

This way it is always consistent completing with req->status.
