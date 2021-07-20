Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880E33D0101
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhGTRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:13:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54610 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhGTRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:13:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9603E2248A;
        Tue, 20 Jul 2021 17:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626803648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnDWskgkWQt/GvciTz2020D0iW0F1STVTtgzDGjV76w=;
        b=qM7j4R+w8XO/HOCrVombPH/1omsfOH1ctONU31B7qXF3vsHvIUQBEJ38997Ulajhrwtbzp
        qEqHJ+Z2zUdl4OzweECKCwS0PuoQSVPLF0eo9LO7KyJQo4HB1pI3CXitpVF7ygc75OFmbS
        BCV4l9QabcZlc6Tf5TBP94e81GX/Nog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626803648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnDWskgkWQt/GvciTz2020D0iW0F1STVTtgzDGjV76w=;
        b=jmrm3pM49HfPncdYFKTQtJEgC7Sc3p8azACh8dqpix2yIHAADLdn4W141NYiezfuP/OjHC
        cJf4lVepSMTNsWCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5507F13B9D;
        Tue, 20 Jul 2021 17:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id jgDDE8AN92DkUQAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:54:08 +0000
Subject: Re: [PATCH v3 1/6] nvme-fc: Update hardware queues before using them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-2-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4480bd40-fb5d-7fba-ce1e-78c6fe393d43@suse.de>
Date:   Tue, 20 Jul 2021 19:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-2-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 2:43 PM, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
