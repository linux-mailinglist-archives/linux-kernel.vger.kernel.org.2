Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601434F6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhCaCdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:33:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15830 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhCaCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:32:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F99KH0y9Gz9v1q;
        Wed, 31 Mar 2021 10:30:43 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 31 Mar
 2021 10:32:39 +0800
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     <dhowells@redhat.com>, <linux-afs@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <huawei.libin@huawei.com>
References: <20210327121624.194639-1-zhengzengkai@huawei.com>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <19cc788d-2c14-99ef-1162-ed919364dcfd@huawei.com>
Date:   Wed, 31 Mar 2021 10:32:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210327121624.194639-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Reviewers,

> Add missing return to fix following compilation issue:
>
> fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
> fs/afs/dir.c:51:1: error: no return statement in function
> returning non-void [-Werror=return-type]
>
> Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
>   fs/afs/dir.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 17548c1faf02..1795a05b7cb7 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -48,6 +48,7 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
>   static int afs_dir_set_page_dirty(struct page *page)
>   {
>   	BUG(); /* This should never happen. */
> +	return 0;
>   }
>   
>   const struct file_operations afs_dir_file_operations = {

Is there anyone who can take a look?  ;-)

Thanks!

