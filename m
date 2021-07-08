Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CD3BF831
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGHKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:16:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhGHKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:16:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E7B12235F;
        Thu,  8 Jul 2021 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625739251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9fG/9l95sDD5upgyztRxQDi3j6L5c0fkrT4qgdJKZU=;
        b=Uo1LL/bhDWwVf9ZzX35a1SvIKiZ6vvxHTyHpxaHdDdVcvtbh99hK1UsTsVSk5Dy5/oK0Qh
        Htk/1Vrlpj/d075LsCT7e7x/xovt8GwO8Lf8HSZ0BXY5GrhYY6jaQrN+Xs1O8jY2a9DUR+
        yQvc4EBHdwHqqwPOuMshDlP8o7aThdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625739251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9fG/9l95sDD5upgyztRxQDi3j6L5c0fkrT4qgdJKZU=;
        b=kumXPEHTRHLuqo/viCd1DZo3N8g0e9KN8ULaqxBMX94BUkdRAXpneRR+qxoV4acQEdlI0x
        8V0tq38EJfq5L6BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 75DB81338E;
        Thu,  8 Jul 2021 10:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qSCpG/PP5mC0MwAAGKfGzw
        (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 10:14:11 +0000
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8edf09e2-52c1-5b96-6d45-ec210ffc33e1@suse.de>
Date:   Thu, 8 Jul 2021 12:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-6-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/21 11:27 AM, Daniel Wagner wrote:
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
Please add a comment here about the pairing. We've missed it once, so we 
should make it clear why it has to be placed here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
