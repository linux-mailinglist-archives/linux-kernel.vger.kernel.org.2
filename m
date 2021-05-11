Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC90537A2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEKJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhEKJHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:07:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47DD1B14B;
        Tue, 11 May 2021 09:06:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DCCE01F2B6D; Tue, 11 May 2021 11:06:32 +0200 (CEST)
Date:   Tue, 11 May 2021 11:06:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chi Wu <wuchi.zero@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, mszeredi@redhat.com,
        sedat.dilek@gmail.com, axboe@fb.com, jack@suse.cz,
        hcochran@kernelspring.com
Subject: Re: [PATCH] mm/page-writeback: Update the comment of Dirty position
 control
Message-ID: <20210511090632.GH24154@quack2.suse.cz>
References: <20210511052626.19005-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511052626.19005-1-wuchi.zero@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-05-21 13:26:26, Chi Wu wrote:
> As the value of pos_ratio_polynom() clamp between 0 and
> 2LL << RATELIMIT_CALC_SHIFT, the global control line should be
> consistent with it.
> 
> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..e9a4f6cf12bb 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -845,7 +845,7 @@ static long long pos_ratio_polynom(unsigned long setpoint,
>   *     ^ pos_ratio
>   *     |
>   *     |            |<===== global dirty control scope ======>|
> - * 2.0 .............*
> + * 2.0 * * * * * * *
>   *     |            .*
>   *     |            . *
>   *     |            .   *

Generally, pos_ratio is used only within [freerun, limit] range so its
values outside of that range don't matter much. But you're right that
pos_ratio_polynom() clamps the computed value as you describe and we can
visualize that in the graph as well. Just please move the '*' line you add
by one space to the right so that the curve really follows the cubic curve
upto 'freerun' mark (the vertical '.' line).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
