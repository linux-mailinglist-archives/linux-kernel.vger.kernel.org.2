Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7333C3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhCORUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:20:35 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45578 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhCORUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:20:03 -0400
Received: by mail-pg1-f177.google.com with SMTP id p21so20845707pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhte2D5Jm2p++hI6/DrWwYoclUkYAfx2V2JV3XPR538=;
        b=LTlkOr740YVIjuIokWpKFW+TSb7YZEN+6HxDrt6GeT6A0TO7icj5/jf0wgemIzArjx
         0iJhSWCAttYexg+xVUGBHEZHlgEv4DJRyUPqYCANEiu7IbNU+ayCv0OFMlRw6XqToS72
         BQgHDUyOzaEpeMICYQ5uuRBYVVq9RFmS2BcV0qXgqJ1iA2UAItXkYAa8pyUkiUvPaUAj
         1iBjOmT3qwQiTdsNH6pVW0Bc7owQ6znoBq07d42ptDLBwGLSmPICh36Eqy9vrtArkQ9d
         0Z0wiMYvGZ/K2FXmRtb1SFfLt+A0Ew/bn7iXrRVfCQC2v83LYWaL8RDzHaNmFhDiu4CK
         6Acw==
X-Gm-Message-State: AOAM532B8TJlf4oURBDkdoWuGdL7SjfmF1yifCZIZMum5er+M1SWaXDj
        2Essz6u+vsLn+/xxaFazxaNbtW3vxlw=
X-Google-Smtp-Source: ABdhPJz+HFlXqAvzFrT6KArU8kRmTwppYRUD/YWjHs1b5/oLIA6W9FdoN+bKKnZ9COU65k8zuu2VIQ==
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id q20-20020aa796140000b02901fae77b0722mr11557622pfg.2.1615828802423;
        Mon, 15 Mar 2021 10:20:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86? ([2601:647:4802:9070:4faf:1598:b15b:7e86])
        by smtp.gmail.com with ESMTPSA id g22sm219063pju.30.2021.03.15.10.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:20:01 -0700 (PDT)
Subject: Re: [PATCH] nvme/rdma: Fix a use after free in
 nvmet_rdma_write_data_done
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, hch@lst.de,
        chaitanya.kulkarni@wdc.com, Israel Rukshin <israelr@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3ffd40a5-efe8-d3e6-9142-c3fbd3419f65@grimberg.me>
Date:   Mon, 15 Mar 2021 10:20:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> In nvmet_rdma_write_data_done, rsp is recoverd by wc->wr_cqe
> and freed by nvmet_rdma_release_rsp(). But after that, pr_info()
> used the freed chunk's member object and could leak the freed
> chunk address with wc->wr_cqe by computing the offset.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/nvme/target/rdma.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 06b6b742bb21..6c1f3ab7649c 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -802,9 +802,8 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
>   		nvmet_req_uninit(&rsp->req);
>   		nvmet_rdma_release_rsp(rsp);
>   		if (wc->status != IB_WC_WR_FLUSH_ERR) {
> -			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
> -				wc->wr_cqe, ib_wc_status_msg(wc->status),
> -				wc->status);
> +			pr_info("RDMA WRITE for CQE failed with status %s (%d).\n",
> +				ib_wc_status_msg(wc->status), wc->status);

There is nothing wrong with this reference, wr_cqe is a valid reference
and I think Israel added this for some extra information that may be
useful to him.

Israel? you ok with this removed?

>   			nvmet_rdma_error_comp(queue);
>   		}
>   		return;
> 
