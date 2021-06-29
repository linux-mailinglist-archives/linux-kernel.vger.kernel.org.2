Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF883B7215
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhF2Md5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:33:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40042 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhF2Mdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:33:54 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4292C226C9;
        Tue, 29 Jun 2021 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624969886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
        b=17psiHPvIhgmVbM+cUCSHTOP4LYqLwUTJpo17O0GiOMsVwnbZQfp6N+Esjy64iLXUnz4mj
        oiV0N//COGEqeDrfvioZQgQDmjpisgpFshDMjivwkL6xbYwvsN/99bpP0cT2OiwXbGozhE
        6fOWF7lHYNmDjIs0th/H3CIkt7j2omU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624969886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
        b=DB9SexW3tuHSpBBvFMe4hAj5CaGiaeTvQ1aV24x+bhEJFr4YSp4VKHQfFdduEriuDDvQxD
        vyiiigQgZDNO6hCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0F5F711906;
        Tue, 29 Jun 2021 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624969886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
        b=17psiHPvIhgmVbM+cUCSHTOP4LYqLwUTJpo17O0GiOMsVwnbZQfp6N+Esjy64iLXUnz4mj
        oiV0N//COGEqeDrfvioZQgQDmjpisgpFshDMjivwkL6xbYwvsN/99bpP0cT2OiwXbGozhE
        6fOWF7lHYNmDjIs0th/H3CIkt7j2omU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624969886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
        b=DB9SexW3tuHSpBBvFMe4hAj5CaGiaeTvQ1aV24x+bhEJFr4YSp4VKHQfFdduEriuDDvQxD
        vyiiigQgZDNO6hCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xXfYAp4S22D3SQAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:31:26 +0000
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <11737f53-8959-3d83-6be8-feca7fa40be7@suse.de>
Date:   Tue, 29 Jun 2021 14:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 12:16 PM, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
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
