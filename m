Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B93E9423
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhHKO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:59:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhHKO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:59:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82E2F221BF;
        Wed, 11 Aug 2021 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628693964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSK9Ueh4HkzV8UK8QM+3oyCtIN6KFd4kqVEY7guN9Ag=;
        b=AmIC5rOloroA5xeSCJ4XmkCRIKHcGPFO7G5JESvhEPj7FL1ZlDCd/R26VK7OyMa6Yqt11i
        zxEjE0uTxsP14bt3MlHcES2c9ulRDeNSsxETvXzXiJk9OlEminGvpf//1OCVLC2ybFz7h/
        zh/IuqwN0i626hyEa+aB2nVN6axPBtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628693964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSK9Ueh4HkzV8UK8QM+3oyCtIN6KFd4kqVEY7guN9Ag=;
        b=1zB6XBHofM7Y5DdNBUwnv+AN/ik3lw5V9M3uNH0J+4y70HfQrKSfagcgsVHrBNudp5byQs
        BmHLkLoGaWalbzBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7462AA3CDA;
        Wed, 11 Aug 2021 14:59:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4A2431E62D5; Wed, 11 Aug 2021 16:59:21 +0200 (CEST)
Date:   Wed, 11 Aug 2021 16:59:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     "F.A. SULAIMAN" <asha.16@itfac.mrt.ac.lk>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix array index out of bound exception
Message-ID: <20210811145921.GG14725@quack2.suse.cz>
References: <20210811131150.20282-1-asha.16@itfac.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811131150.20282-1-asha.16@itfac.mrt.ac.lk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-08-21 18:41:50, F.A. SULAIMAN wrote:
> From: "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
> 
> Array index out of bound exception occurs when the 'part' variable is
> passed into the freeSpactTable array, this can be avoided using pointer
> arithmetic. 
> 
> Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>

I'm sorry but this doesn't even compile and the change is obviously
bogus...

								Honza

> ---
>  fs/udf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2f83c1204e20..d330c7162c3a 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2522,7 +2522,7 @@ static unsigned int udf_count_free(struct super_block *sb)
>  			sbi->s_lvid_bh->b_data;
>  		if (le32_to_cpu(lvid->numOfPartitions) > part) {
>  			accum = le32_to_cpu(
> -					lvid->freeSpaceTable[part]);
> +					(lvid->freeSpaceTable + part));
>  			if (accum == 0xFFFFFFFF)
>  				accum = 0;
>  		}
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
