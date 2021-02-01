Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4185A30A63D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBALLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233257AbhBALLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612177786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Etg0NTTFIEyqb4anncIHu5/36agc5JrkvEYqPeFC1M=;
        b=RUq0031lU/ugB0j2whLc9/mYZHSjHcUrPcaC6rLnkiut+s013z4LWQ0TgoUCgz3VeougjH
        gM79T1kOXQyXPGuZraNQZzTnhTjzWZTVoUxQvtj/MoxA8XJ58GUCGmWvjnKRAP+Q3MBd/w
        dD1eBlxYsVI30Yf7biwcgUHZ6yZm7Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ZEAc3c7SNEW8gA7P-nLi1Q-1; Mon, 01 Feb 2021 06:09:44 -0500
X-MC-Unique: ZEAc3c7SNEW8gA7P-nLi1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92EA663C8E;
        Mon,  1 Feb 2021 11:09:43 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4792C169;
        Mon,  1 Feb 2021 11:09:42 +0000 (UTC)
Subject: Re: [PATCH] mm/mempolicy: use helper range_in_vma() in
 queue_pages_test_walk()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210130091352.20220-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <33c3c6cb-c13d-0bb3-1c65-c16d6ffe0cac@redhat.com>
Date:   Mon, 1 Feb 2021 12:09:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210130091352.20220-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.21 10:13, Miaohe Lin wrote:
> The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
> migration: fix migration of huge PMD shared pages"). But we forgot to
> use it in queue_pages_test_walk().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/mempolicy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6961238c7ef5..ab51132547b8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -677,7 +677,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>   	unsigned long flags = qp->flags;
>   
>   	/* range check first */
> -	VM_BUG_ON_VMA((vma->vm_start > start) || (vma->vm_end < end), vma);
> +	VM_BUG_ON_VMA(!range_in_vma(vma, start, end), vma);
>   
>   	if (!qp->first) {
>   		qp->first = vma;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

