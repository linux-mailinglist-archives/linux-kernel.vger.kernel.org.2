Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5F397A79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhFATMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:12:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0545C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LCgeVYYC1zbzbCB+HR8hlhgoNfX1Llo03rabJZIASVE=; b=CgbtqyY5TLK4PK2zjTBtK7w2Uc
        Ungj/LAldIOXVzKaDEG77+9ME7HPI+CNkkdnFn/bk+CdpiDQXeRoWHF7Rjg/rrEyzyzAEsEWZfD59
        vNzMSPhlGqviF7D9xAeK/YYO4uC6zKkJu8k4hQPXNPmm0BLfemyyoH0Pgnq2P/9YRJtqXddwCN1YB
        OUmSNveTEF6d71vw7HHJ5hoyS4gm2C84AWdnrnxsI3hmPyX7ZNY6q3cEmLCZPRq1E4YzIvm3PsfQL
        K/RqdNxD3E5CseKhwjnpNy0n+6XORTTU82T/+t/9XN11sdRZ2bJ5QSU4izSklXoFCXZ904Dodk7JU
        iSQ3CyMQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lo9mQ-000Xlz-IA; Tue, 01 Jun 2021 19:10:22 +0000
Subject: Re: [PATCH] afs: add a return to afs_dir_set_page_dirty()
To:     trix@redhat.com, dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210601140820.2626615-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ddf7235-dd6c-d4c3-41a8-bc5a538ccd1e@infradead.org>
Date:   Tue, 1 Jun 2021 12:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601140820.2626615-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 7:08 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> With gcc 10.3, this compile error is reported
> dir.c: In function 'afs_dir_set_page_dirty':
> dir.c:51:1: error: no return statement in function
>   returning non-void [-Werror=return-type]
> 
> Even though the code is unreachable, add a return
> to silence the error.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

or this previous patch:
  https://lore.kernel.org/lkml/20210327121624.194639-1-zhengzengkai@huawei.com/

but for either of them, ack.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  fs/afs/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 78719f2f567e..988766f88d8b 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -48,6 +48,7 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
>  static int afs_dir_set_page_dirty(struct page *page)
>  {
>  	BUG(); /* This should never happen. */
> +	return -EINVAL;
>  }
>  
>  const struct file_operations afs_dir_file_operations = {
> 


-- 
~Randy

