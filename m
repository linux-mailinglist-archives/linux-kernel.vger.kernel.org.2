Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB87C3DFC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhHDHZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:25:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46034 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhHDHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:25:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A811520106;
        Wed,  4 Aug 2021 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628061908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbOcGokMbJk/XuXlCzXTIBoRTK5BBDFqLJNu9Hgtsf0=;
        b=syC0N/OopS1qLJN9kO78E5MwdaRpWnvkyLcwSEKPR9xGuL3cQQ6qgoXrHYDN9I9ZK5Jud0
        4KNh4GzQQwAyfuWY5QoZen54tRYWscL/YqkaNXvgYes53TC8gO7U5juredf/5Va4Xjxj0J
        cxRwNbQSL4POMyRhFnhTZq5rCi8A7HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628061908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbOcGokMbJk/XuXlCzXTIBoRTK5BBDFqLJNu9Hgtsf0=;
        b=cDHpXk24cpzV0WvT3kFBWu/IZc5vCa/uk28EBjTH5Iw7QVU/KlY6jIn6ym1b9hY8Kda4hA
        eyYu+f+J6EfEosBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98F0F139FC;
        Wed,  4 Aug 2021 07:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eoQWJdRACmH3dAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 04 Aug 2021 07:25:08 +0000
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <788e9210-37d4-6a52-2b5d-241c2442cea0@suse.de>
Date:   Wed, 4 Aug 2021 09:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-9-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:26 PM, Daniel Wagner wrote:
> During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
> called unconditionally. When we reconnect we need to pair the freeze
> with an unfreeze to avoid hanging I/Os. For newly created connection
> this is not needed.
> 
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/rdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index de2a8950d282..21a8a5353af0 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>  			error = PTR_ERR(ctrl->ctrl.admin_q);
>  			goto out_cleanup_fabrics_q;
>  		}
> +	} else {
> +		nvme_unfreeze(&ctrl->ctrl);
>  	}
>  
>  	error = nvme_rdma_start_queue(ctrl, 0);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
