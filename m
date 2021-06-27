Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F163B5391
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhF0OHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0OHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:07:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i6so11809692pfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IC+DTzBx0Yh5RP/xh0gD6mgUcbBwa/Ap670J7IrdFk=;
        b=C1LC1+yt5BmDvVjWbUSEFUONlSQsg/cmELJVooFUXgSZNcw+r1sblrcwedoxVUVqzP
         E+QB08JPXFLFWgn33wVq8DnFj5UvAtVo7hTsw0XjeWIRfdRbW+r98MRTzfskEirTD+EN
         JaBLJDsBIeHijO0chNfokM/FG880TifMBab+lyPsqaBDplV5oDPZbovQhu8p8u0RGpoi
         FS8/cc7XE07Gnu+QF8fdjDmCtFGI9oAqH4mI1A7guViLWSw0xyFeJ/qQ9swDw2Dut1gB
         57Uu0SyFU4UiScXZk871WlTiPUM63zgVuj5YNg9NgQdpVSzz+l/RIggMwqVIiamo4oTn
         i26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IC+DTzBx0Yh5RP/xh0gD6mgUcbBwa/Ap670J7IrdFk=;
        b=pXPSPEszRL8hBWH/AlCJccPkxXsdluNuix+6xumrYKFftgchssXYOCiSD4gHyOlc+A
         teDRJYyS175Bkvu5p59qeJPo4TUVSvsoiqOPz4LqmuhqA67SZaPrcK2UPxVml1nKw778
         VcGXarsMuR0Po3kpZdpK1FB7O8nEhhzguRDR/XYZumjxyjhxkOQNmrvgSdXudLYWY8CJ
         Voejqk9qOTohgv4FIQ2Tzgc0V6dX7C8VrLYNuhnTCp0AlQt5LUTGswVrHbi9SRYarV3M
         oL3nnezPZ0RDSxMYF/cEein0r992KjiBkKEisrSkBEuDdWGga0S5RGrMl/Z83AS5cvl9
         Ynfg==
X-Gm-Message-State: AOAM532VnpmU1a4m/89BpO5JHAN3jCx+GUa95RyyUk6UpB607wPLRFhv
        NlyE6mJBIDGUsAkXwm6fexE=
X-Google-Smtp-Source: ABdhPJxTiOswHpwnAg5OcepBNu6oBL+sjCDLZSiGCQk4K/HXf6HmwBLFbpP2kQEPUI07EWDHFby8zQ==
X-Received: by 2002:aa7:86cd:0:b029:30c:2b9b:2a77 with SMTP id h13-20020aa786cd0000b029030c2b9b2a77mr1420927pfo.47.1624802694527;
        Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id j13sm11252849pfh.145.2021.06.27.07.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <9362fb6c-8a98-3189-453a-69d4c0b622e3@gmail.com>
Date:   Sun, 27 Jun 2021 07:04:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2021 3:16 AM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a9645cd89eca..d8db85aa5417 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   		dev_info(ctrl->ctrl.device,
>   			"reconnect: revising io queue count from %d to %d\n",
>   			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
> 

Looks fine. This is one of those that changed in the other transports 
but fc wasn't part of the patch set.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

