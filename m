Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2A3D0103
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhGTROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:14:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59366 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGTROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:14:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB2CC202F0;
        Tue, 20 Jul 2021 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626803717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW6Wh76rfui5RdRw4XByjdKkVulRdJ5gp0kIN3vfFok=;
        b=QfBERNNHGOVtHBDuitwto5/zpmphDCbcvCiuA6jIx5HbOQJa+nGEkWur6kUugEvXZIViHH
        EKkL5UFHaqHAtOKXBQVF2/Wguwq2wUSi/AAG2i2sZVOFxEd3O09pI+sLVUiGJziIvwRist
        yftqk2oi1NfPr5DFJJNjRo4ljbQw9YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626803717;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW6Wh76rfui5RdRw4XByjdKkVulRdJ5gp0kIN3vfFok=;
        b=mdpYsCVfcyd47lfG7WbHaB5Gr2NUgt+xcDp+5nE3+ufe2qqPOvVGSarhklO00zvteP4x5x
        YnYJnXl5veZgfLDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CDB7513B9D;
        Tue, 20 Jul 2021 17:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HXulMQUO92AzUgAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:55:17 +0000
Subject: Re: [PATCH v3 4/6] nvme-fc: Wait with a timeout for queue to freeze
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-5-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1eff7f17-e347-54bf-b946-151737a69ac0@suse.de>
Date:   Tue, 20 Jul 2021 19:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-5-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 2:43 PM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
