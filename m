Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C63CB212
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhGPFyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:54:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40092 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhGPFx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:53:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37BD522B3C;
        Fri, 16 Jul 2021 05:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626414662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdbqCluUmkyk0/mKzrlUUleiyiKeVLXtobdlC+5qzn4=;
        b=ZuLvHpOMC/NjAuOSveu1yYtrP63KsZnbkaxUZEhLxwN2mxeDUFYwuYmQ2Jbt/43v8+Ck9c
        jGQ7tpi5Vt9Um3i5m+kYbdzNXw9wRm7BS+to/Mtk8KK9STmtUqUe1irmuXgWPxPH/JJLx+
        akyYRvcFQaaAcBSJQWVIvwTg/nsVQ50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626414662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdbqCluUmkyk0/mKzrlUUleiyiKeVLXtobdlC+5qzn4=;
        b=/9vLEb7w/Jwet8HtOkTiZ+q6nGOwjfjh+y4V88pdTJC6H+8PD+oh9jZNKJfhxOPU+wVV8Q
        wh6gDkIh91dNx+AA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 04D3213357;
        Fri, 16 Jul 2021 05:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /60NAEYe8WDLNwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:51:01 +0000
Subject: Re: [RFC 3/6] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on
 is_mddev_broken()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-4-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2f8c1713-2fa2-b832-9c70-c41a87df12ee@suse.de>
Date:   Fri, 16 Jul 2021 07:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715202341.2016612-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/md/md.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 832547cf038f..80561bca1f51 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -766,7 +766,7 @@ static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
>   {
>   	int flags = rdev->bdev->bd_disk->flags;
>   
> -	if (!(flags & GENHD_FL_UP)) {
> +	if (!(flags & GENHD_FL_DISK_ADDED)) {
>   		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
>   			pr_warn("md: %s: %s array has a missing/failed member\n",
>   				mdname(rdev->mddev), md_type);
> 
Why again did you introduce the wrapper?
Shouldn't it be used here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
