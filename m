Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32963E3001
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbhHFT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:59:35 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33665 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHFT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:59:34 -0400
Received: by mail-pl1-f180.google.com with SMTP id a20so8578829plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3xIgCNAaZK0sIEmcnOuEBKGBHm8act9qqO5YgCOEC6M=;
        b=TEdsMHzLo57iog4FDRs0Wgx8DQkMVPOr+mkVwv/zRjMbEuYJdC7URoGe2cL62FvhWT
         T4T4GTT6bhtc+fq9SY8w7mcNmEroBLyyxQb0mT4eAJYKxr/AMCpEVnkW/MQZE41xMm6S
         gsaieLo8ZVAppyZNT/MF+owCtfKW+gGQYUYtAec8GS1Gp+yjrgYkwFSKOTCp8ZizW780
         L1+ldYmPV/3q3Dg/P7PEf0u6blX/ahhYa9oVDVh4P/2sLzKyS9wtdl1dIxna6higBUAq
         U9Dd/M8FUJjkwt0S2tJEOsTWRGI+DYO3Hm/hCw3Egnm6NITEkMuUVZ2oCfMspnKuUDtE
         TpEA==
X-Gm-Message-State: AOAM533mlrVnGQm7wZRNekDiWZcK+r/ZnP2bXkuKkxq2t52Vs0+VLaZA
        MOu8VeDbo0W/fsyHSlBCNGU=
X-Google-Smtp-Source: ABdhPJyjtmQrOgrUjWWnqpG1hRQ5cnxUh/NvPNKbNRvyCYxgVMhOqZcamDHfenyBNaNu6hatxX4ETA==
X-Received: by 2002:a63:e116:: with SMTP id z22mr409709pgh.361.1628279957382;
        Fri, 06 Aug 2021 12:59:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7? ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
        by smtp.gmail.com with ESMTPSA id a5sm11398251pfo.167.2021.08.06.12.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 12:59:16 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
Date:   Fri, 6 Aug 2021 12:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-9-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
> called unconditionally. When we reconnect we need to pair the freeze
> with an unfreeze to avoid hanging I/Os. For newly created connection
> this is not needed.
> 
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/rdma.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index de2a8950d282..21a8a5353af0 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   			error = PTR_ERR(ctrl->ctrl.admin_q);
>   			goto out_cleanup_fabrics_q;
>   		}
> +	} else {
> +		nvme_unfreeze(&ctrl->ctrl);

That seems misplaced.. unfreezing the I/O queues when setting up the 
admin queue?
