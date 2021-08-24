Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3447B3F6A95
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhHXUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:42:33 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:45945 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhHXUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:42:33 -0400
Received: by mail-ej1-f43.google.com with SMTP id e21so31007918ejz.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lXjlGQeZwtGrCrOOb0RdT7e8+O8LKwMxLevcNbK09wA=;
        b=oXj8xVmt+XEYCjkj07Bnn109AUAbfgduvtYH9tF+l0mb/wwYKYiRGGVfrf9GoZCWtj
         BVu9IrnAftNQjtfomhCC+5YZ7nzP0/wiu+nlslzZ6RY4pngaKxwZfmB6GiGDF94YBd8V
         Z/uV7bI+5k3B4QgWqNzV8IXYnvz2aLdGakWZ/csCQI/6r4VjUYmHiyoTRivNhyc4Fi1g
         v/WNFTyp64i5s8nhZ3KzmtD3JWf0KUw6DiVLomSDVGS5IEgpavuQuVfhQaTbf+g+jQ+X
         wWjMlh7dXAgR7vI8xdA7GL/hDfmyJAcBmPwXjoCydJZalU7Dey7RwqbT6P3/CiwfNbsG
         vr3A==
X-Gm-Message-State: AOAM532tp5vqIRmTBJmPupcmRfQDaoaKQdR9yo18XWHPVd0Ml4/YURBe
        b4SEoA6LNg0Uur4COtktek0Ar9qvZcLlAg==
X-Google-Smtp-Source: ABdhPJxMtUR08EyoMF/xqa4kwmDcm1cw/WJoelupOJTNc0gB5HITs9wnej4S7UMh5AyF1F0bG/a03A==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr42625526ejb.208.1629837707333;
        Tue, 24 Aug 2021 13:41:47 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id js21sm4370502ejc.35.2021.08.24.13.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 13:41:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
To:     sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
Date:   Tue, 24 Aug 2021 13:41:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/21 10:44 PM, sasaki tatsuya wrote:
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
> Changes since v1:
> - Add nvme_update_keep_alive to update keep alive timer in core routine.
> - Add nvme_user_cmd_post to call nvme_update_keep_alive in ioctl.c
> 
>   drivers/nvme/host/core.c  | 12 ++++++++++++
>   drivers/nvme/host/ioctl.c | 19 +++++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..76f0ee431b11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1263,6 +1263,18 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   	nvme_queue_keep_alive_work(ctrl);
>   }
>   
> +void nvme_update_keep_alive(struct nvme_ctrl *ctrl, unsigned int new_kato)
> +{
> +	dev_info(ctrl->device,
> +		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
> +		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +
> +	nvme_stop_keep_alive(ctrl);
> +	ctrl->kato = new_kato;
> +	nvme_start_keep_alive(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_update_keep_alive);
> +
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..79006bfb5537 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -187,6 +187,22 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>   	return true;
>   }
>   
> +static void nvme_user_cmd_post(struct nvme_passthru_cmd *cmd,
> +			       struct nvme_ctrl *ctrl)
> +{
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */
> +	if (cmd->opcode == nvme_admin_set_features &&
> +	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */

no need for this comment.

> +		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
> +
> +		nvme_update_keep_alive(ctrl, new_kato);

I think you can now inline nvme_update_keep_alive here, no need to keep
it in a function.
