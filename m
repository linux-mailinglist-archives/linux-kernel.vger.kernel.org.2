Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A937A4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEKKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:46:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhEKKqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:46:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F930AFEB;
        Tue, 11 May 2021 10:45:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BA5761F2B6D; Tue, 11 May 2021 12:45:40 +0200 (CEST)
Date:   Tue, 11 May 2021 12:45:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chi Wu <wuchi.zero@gmail.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org, axboe@fb.com,
        hcochran@kernelspring.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mszeredi@redhat.com, sedat.dilek@gmail.com,
        tj@kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: Update the comment of Dirty
 position control
Message-ID: <20210511104540.GJ24154@quack2.suse.cz>
References: <20210511090632.GH24154@quack2.suse.cz>
 <20210511103606.3732-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511103606.3732-1-wuchi.zero@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-05-21 18:36:06, Chi Wu wrote:
> As the value of pos_ratio_polynom() clamp between 0 and
> 2LL << RATELIMIT_CALC_SHIFT, the global control line should be
> consistent with it.
> 
> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..3882405dc051 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -845,7 +845,7 @@ static long long pos_ratio_polynom(unsigned long setpoint,
>   *     ^ pos_ratio
>   *     |
>   *     |            |<===== global dirty control scope ======>|
> - * 2.0 .............*
> + * 2.0  * * * * * * *
>   *     |            .*
>   *     |            . *
>   *     |            .   *
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
