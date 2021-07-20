Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDD3D0111
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhGTRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:17:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55092 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhGTRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:15:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8514E2246A;
        Tue, 20 Jul 2021 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626803765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoxJJ5NGUDLAYGuGREc01BPrLsJH1eS+cT2d1AAwCUA=;
        b=a69n++8vwI0jS0IOmXfH0QJAexPDIcQGA0Zh67/BFeTdGihCNT8C6uAGJApV3N8Zs/3xtK
        cADxorAbUkKl/NS0AVxwOJEwkuhxMH7TOhhkK7b4yzPK0AIlC+dNvHx1kXPYI350SoswKm
        gxlRS04IUP4y6rsJcSgKy2OZkt8jIcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626803765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoxJJ5NGUDLAYGuGREc01BPrLsJH1eS+cT2d1AAwCUA=;
        b=TwJGfHMkAK6AVE8Z2MajKrSXezDPpNDddcWpRWGF9j6BzIFP/xCWYyTiAs2NZCKEwWAtsm
        a0GtWIl+fvfCTeCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D42013B9D;
        Tue, 20 Jul 2021 17:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id okDKFTUO92BoUgAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:56:05 +0000
Subject: Re: [PATCH v3 5/6] nvme-fc: avoid race between time out and tear down
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Chao Leng <lengchao@huawei.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-6-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <376e5dd0-a6e1-0018-9048-abcb6f405eaf@suse.de>
Date:   Tue, 20 Jul 2021 19:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-6-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 2:43 PM, Daniel Wagner wrote:
> From: James Smart <jsmart2021@gmail.com>
> 
> To avoid race between time out and tear down, in tear down process,
> first we quiesce the queue, and then delete the timer and cancel
> the time out work for the queue.
> 
> This patch merges the admin and io sync ops into the queue teardown logic
> as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
> out and tear down". There is no teardown_lock in nvme-fc.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Chao Leng <lengchao@huawei.com>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> [dwagner: updated commit id referenced in commit message]
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
