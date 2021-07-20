Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E983D0102
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhGTRO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:14:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGTROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:14:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6ED202F0;
        Tue, 20 Jul 2021 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626803693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpRzxjBR15aVpBT84U5St6uEXHRtmrkDNyaHcqlpRxU=;
        b=aJc6vcnXTypljSasNQrNi7jUVzYz6kXF3wNqGyFc1w3cxqPXtDh21qSVKINqjNoRd2vdda
        KwIzvGHvEXrQw6TRdlWxVEQHepHfpToGVGqGpmYicJWtJapSSIXxzejp+cEMCeAAPNINR5
        q3ggYtohYIr0FEbY83TcCAmU2Hp+s2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626803693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpRzxjBR15aVpBT84U5St6uEXHRtmrkDNyaHcqlpRxU=;
        b=5Fp85cA8D+JIkL8mBigq7LA7PgkQQHBD0qQFSf+Kwz4NQnSgT2bSGfQ/YGgzAWyK8XpvPX
        2uYrdt2nDH7GKODQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 88A0613B9D;
        Tue, 20 Jul 2021 17:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xr7KFOwN92AbUgAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:54:52 +0000
Subject: Re: [PATCH v3 3/6] nvme-rdma: Update number of hardware queues before
 using them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-4-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <90ab8cc1-a900-9869-3a65-acf69ebc08fb@suse.de>
Date:   Tue, 20 Jul 2021 19:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-4-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 2:43 PM, Daniel Wagner wrote:
> When the number of hardware queues changes during resetting we should
> update the tagset first before using it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/rdma.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
