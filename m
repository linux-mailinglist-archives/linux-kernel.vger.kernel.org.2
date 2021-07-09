Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A03C275F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:16:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A3C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:14:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z2so2353805plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R+fTBIjY21MCLp7RRYBt/oOcJr+pa44IXLNh6vt+W88=;
        b=jNpk4RaiHKPM0nDWx6YT3nhvD8zW2WxUFbPX7MxM3PSAScAljHLnNFbmb9Z8/8o2eM
         tclvrIphO4LtI+ujEPU7CJArUV2Ty1MX3fm4g/XIl64+zBVePRnJCsWnzXLX+wTfN8mQ
         fGbwUKfP6Hr+EW6i1jPAy9kW0sVJp5bwmRQMvpBSy+3EqL3BsGbDrtsSfmZhSWwbhylh
         ABzTLCshTGEDaIDq4qU9g7D5y5EYwI0tzFlEOcUWgSuyH6w5PlWwzGXeL4Ej9Z7w5XvI
         dbYKbPVVXyLQ3aPijKmiPduYkyGvYfuXec5j21EZ3HRkwaizzQwWH50fbN9X6H87cXwX
         vRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+fTBIjY21MCLp7RRYBt/oOcJr+pa44IXLNh6vt+W88=;
        b=kvGBJv137PdT2h0UwsxzQVRqCAHLKriv9IK38UTB0ypgz+FvxmggW8EBvk08VGR+nX
         VkQtFeTD3NS75L2OeTTpFS4XXZWTKwGdUQfVNcaTyEDzEuXyFWfa6cyGWH9ysx1WIA9Q
         aBiCJknmW6K3WWBrPoRy0OZsxV2n06ZlUR7wHW1Xiwpr8nd4GFJ4/+oB89QkDfr7ZuvJ
         /3J3nXcU6v4ZsNI3klD14W63MI1/oB8p7foAU7NAWsYUiTt3HRw8w1fbH37jRTsZQIhd
         k5aEY6AST+iM6qtDp4PwniURlsE1ioW8dc1J8i4ZOkzmfIqb+ZK4JapbPScIXxqN+wOE
         oRmw==
X-Gm-Message-State: AOAM531ca1LlgxWcXQnUl08waEEOcPsf9SJW6b2Y1rh7nt4i1rnLvDK2
        IICwT/o2oG7tSaAxW0LO8qI=
X-Google-Smtp-Source: ABdhPJxcp7ZWGofRijkIhy6mURZftr8wF+UXk2UeqVNXi3BysBn/JUwRsrRqGUeYLwwTqx73BVqkFw==
X-Received: by 2002:a17:902:9f93:b029:104:9bae:f56a with SMTP id g19-20020a1709029f93b02901049baef56amr31745641plq.75.1625847253480;
        Fri, 09 Jul 2021 09:14:13 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id i8sm9556861pjh.36.2021.07.09.09.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:14:13 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
Date:   Fri, 9 Jul 2021 09:14:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-6-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/2021 2:27 AM, Daniel Wagner wrote:
> nvme_wait_freeze_timeout() in nvme_fc_recreate_io_queues() needs to be
> paired with a nvme_start_freeze(). Without freezing first we will always
> timeout in nvme_wait_freeze_timeout().
> 
> Note there is a similiar fix for RDMA 9f98772ba307 ("nvme-rdma: fix
> controller reset hang during traffic") which happens to follow the PCI
> strategy how to handle resetting the queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8e1fc3796735..a38b01485939 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3249,6 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   		nvme_fc_xmt_ls_rsp(disls);
>   
>   	if (ctrl->ctrl.tagset) {
> +		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_fc_delete_hw_io_queues(ctrl);
>   		nvme_fc_free_io_queues(ctrl);
>   	}
> 

Thanks for the note. that definitely helped follow what is being 
attempted. I also agree with Hannes that the comment from the rdma patch 
should also be present to understand what's going on.

Looking at the patch - this is not done in the same place or manner as 
rdma. Freezing and stoppage is prior to cancelling and that doesn't 
correspond where this was added (this is after all cancellations). We 
also seem to be missing a nvme_sync_io_queues() call in the sequence as 
well. So I believe there's more work to be done on this patch.  I'll see 
what I can do.

We really need to see about a common layer for transports. So much we do 
is similar. We were ok at the start, but we've drifted apart over time 
and the requirements to the core layer aren't propogating to all transports.

-- james
