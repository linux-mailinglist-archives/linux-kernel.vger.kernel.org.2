Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265D23AFDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFVH0e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Jun 2021 03:26:34 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53252 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFVH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:26:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1CAA606BA3F;
        Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id URpEKndo4VDj; Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D6A261BC7C5;
        Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tx88bZgyxVTX; Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 320C961BC7B2;
        Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
Date:   Tue, 22 Jun 2021 09:24:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1471996381.142265.1624346654994.JavaMail.zimbra@nod.at>
In-Reply-To: <f2ea606a-4a05-8d14-4380-d96ca0f981a1@huawei.com>
References: <20210621152249.20901-1-colin.king@canonical.com> <f2ea606a-4a05-8d14-4380-d96ca0f981a1@huawei.com>
Subject: Re: [PATCH] ubifs: Remove a redundant null check on pointer lp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Remove a redundant null check on pointer lp
Thread-Index: ZwnP86hcvaby+ZSpOm73bGFflCebzw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> I just found out about it today thanks to your patch. Commit
> c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check") did import a new
> problem that ubifs_gc_start_commit() may return -ENOMEM while syncing fs.
> I guess ubifs_fast_find_frdi_idx() return NULL pointer is the
> termination condition in while-loop, which means we cannot get a
> freeable index LEB in ubifs_gc_start_commit().

Good catch! :-)

>> -		if (!lp)
>> -			break;
>>   		idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb), GFP_NOFS);
>>   		if (!idx_gc) {
>>   			err = -ENOMEM;
>> 
> BTW, the following modifications may be what you want?
> diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> index 7cc22d7317ea..b1f276599b04 100644
> --- a/fs/ubifs/gc.c
> +++ b/fs/ubifs/gc.c
> @@ -895,10 +895,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
>         /* Record index freeable LEBs for unmapping after commit */
>         while (1) {
>                 lp = ubifs_fast_find_frdi_idx(c);
> -               if (!lp) {
> -                       err = -ENOMEM;
> -                       goto out;
> -               }
>                 if (!lp)
>                         break;
>                 idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb),
> GFP_NOFS);

I'll drop Dan's patch from -next. Do you want to send a followup patch which removes the
in vain check?

Thanks,
//richard
