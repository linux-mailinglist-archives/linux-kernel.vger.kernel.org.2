Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB43E3018
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhHFUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:07:24 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:41901 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHFUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:07:23 -0400
Received: by mail-pj1-f45.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so10320915pjy.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 13:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AJy43CLMalIoLg/WtPA6ZpLHKZX2UeVbc74Z/QQaV8=;
        b=NJKcpBZv+dF/5aHPL0Q3nPou4HG4y2QCnZCI6RmCbs/2jIM5dHB7waXYiDb4STGxN+
         lW7fZI3bAj2lbDhR8JU5YkzMr+26Iu0MlH3I3T8jzQ0XrTlWgWa8iTlMnF0DD/Zbtqci
         2JCbJylDWvk7cqGp+AxL1IQlPCzgS04wsq7XyBLhmPKonKLvlvJo0vfKL1tSRJSjh5IX
         e1a0IjDsDJ3FE9hcFcJhaxjCrixyvDCWqRXrJaD+DEkKcS5pvbYJrnDRB3wEgArTy9R+
         /xUX7qQo0ez9U6sYLqNMCw/+ZEEicEyOihhbb7FW9k8wJo2FRjhLgBZsDO4nB/4dcdF8
         p3SQ==
X-Gm-Message-State: AOAM5304SBGOnPG4jGnqoBBaAmcFNNknagFyEJFIoRG3bn9iHqFzBXim
        vvQwfuDjU2ajdvbFFIVIoLh3nLtH4+o=
X-Google-Smtp-Source: ABdhPJy6FibPcKcy2ykUNKYQZjArN+qdr3XielsGJGbrPozfXZ+gLrPTs3h/p2ENK+sbex48diGToA==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr45543pgj.395.1628280425953;
        Fri, 06 Aug 2021 13:07:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7? ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
        by smtp.gmail.com with ESMTPSA id r7sm13232981pga.44.2021.08.06.13.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 13:07:05 -0700 (PDT)
Subject: Re: [PATCH] nvme: update keep alive interval when kato is modified
To:     sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
        kernel test robot <lkp@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
 <202108021253.QwqCWvYe-lkp@intel.com>
 <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
Date:   Fri, 6 Aug 2021 13:07:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 7:12 PM, sasaki tatsuya wrote:
> Currently the connection between host and NVMe-oF target gets
> disconnected by keep-alive timeout when a user connects to a target
> with a relatively large kato value and then sets the smaller kato
> with a set features command (e.g. connects with 60 seconds kato value
> and then sets 10 seconds kato value).
> 
> The cause is that keep alive command interval on the host, which is
> defined as unsigned int kato in nvme_ctrl structure, does not follow
> the kato value changes.
> 
> This patch updates the keep alive interval in the following steps when
> the kato is modified by a set features command: stops the keep alive
> work queue, then sets the kato as new timer value and re-start the queue.
> 
> Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
> ---
>   drivers/nvme/host/core.c  |  3 ++-
>   drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..89c52da15618 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1255,13 +1255,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
>   }
>   
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> +void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
>   		return;
>   
>   	nvme_queue_keep_alive_work(ctrl);
>   }
> +EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
>   
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..0066728e77b2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -231,6 +231,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			return -EFAULT;
>   	}
>   
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */

This is too specific. I'd move it to nvme_user_cmd_post similar to how
we handle passthru commands (with start/end that does stuff based on the
effects)

> +	if (!status && cmd.opcode == nvme_admin_set_features &&
> +	    (cmd.cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */
> +		unsigned int new_kato = DIV_ROUND_UP(cmd.cdw11, 1000);
> +

The section below needs to move to a core rountine:
nvme_update_keep_alive()

> +		dev_info(ctrl->device,
> +			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
> +			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +		nvme_stop_keep_alive(ctrl);
> +		ctrl->kato = new_kato;
> +		nvme_start_keep_alive(ctrl);
> +	}
> +
>   	return status;
>   }
>  
