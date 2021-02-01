Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8403730A5FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhBAK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhBAK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612176980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3XvAahXJW5cdCbjvCC5eOVYocg/eTTFP3qY+k4MykA=;
        b=A+SMA5I4TOM3gVx6htX3VrCrtG2Abk/6x5DNuuI8r53lob2khQXpsrSUD9P1Ra4tXkiWRs
        XtmDkwOpTMFM3j827jTPVXB1UUnygyPi/JZUX9w3oVm8wFJsB8sFn9rXt+day8jcSwVSb5
        aVOokEoZyVKVqE0f/hCnjOo5YQylGTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-oIfjoXXZOMSfnyX40v34pA-1; Mon, 01 Feb 2021 05:56:18 -0500
X-MC-Unique: oIfjoXXZOMSfnyX40v34pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE0A1842142;
        Mon,  1 Feb 2021 10:56:17 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818565D9DC;
        Mon,  1 Feb 2021 10:56:16 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: rework calculation code of Hugepage size in
 hugetlbfs_show_options()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210201082325.33875-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2bb70cac-b8ef-cdbe-fa4e-db6229587e98@redhat.com>
Date:   Mon, 1 Feb 2021 11:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210201082325.33875-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.21 09:23, Miaohe Lin wrote:
> Rework calculation code of the Hugepage size to make it more readable and
> straightforward.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   fs/hugetlbfs/inode.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3a08fbae3b53..1be18de4b537 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1014,11 +1014,12 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>   	if (sbinfo->max_inodes != -1)
>   		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
>   
> -	hpage_size /= 1024;
> -	mod = 'K';
> -	if (hpage_size >= 1024) {
> -		hpage_size /= 1024;
> +	if (hpage_size >= SZ_1M) {
> +		hpage_size /= SZ_1M;
>   		mod = 'M';
> +	} else {
> +		hpage_size /= SZ_1K;
> +		mod = 'K';
>   	}
>   	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
>   	if (spool) {
> 

Looks correct but I am not convinced the old code was that complicated 
to understand.

-- 
Thanks,

David / dhildenb

