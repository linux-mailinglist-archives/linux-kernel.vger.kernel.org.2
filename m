Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4581831571B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhBITqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233170AbhBISTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612894686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdS/JNK+W4+/EonRhgG8sns52Ojv8+x5USFjY91rjWg=;
        b=A/gOXBkOWTpNofUqxwdXpAb78yFrC3diJV+iMpAq+cotd9ph2cBPqJRrclJj+JnefwOKnF
        w76WS+/2gnINmBUGLRuTCYBlK3Qf9AwcklYYlKJZ1CGb87PtXgo4eTyp9FDdoa0EOSX0d/
        dua32uqXZUr2mXzO5uX9JNOfXU0LjhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-sYh8g-K2OvmhnAjobrpvgA-1; Tue, 09 Feb 2021 13:18:03 -0500
X-MC-Unique: sYh8g-K2OvmhnAjobrpvgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68B578030C2;
        Tue,  9 Feb 2021 18:18:01 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEADF5D9C0;
        Tue,  9 Feb 2021 18:17:59 +0000 (UTC)
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20210209175048.361638-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
Date:   Tue, 9 Feb 2021 19:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209175048.361638-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 18:50, Minchan Kim wrote:
> __alloc_contig_migrate_range already has lru_add_drain_all call
> via migrate_prep. It's necessary to move LRU taget pages into
> LRU list to be able to isolated. However, lru_add_drain_all call
> after __alloc_contig_migrate_range is called is pointless.
> 
> This patch removes it.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   mm/page_alloc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6446778cbc6b..f8fbee73dd6d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8603,8 +8603,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>   	 * isolated thus they won't get removed from buddy.
>   	 */
>   
> -	lru_add_drain_all();
> -
>   	order = 0;
>   	outer_start = start;
>   	while (!PageBuddy(pfn_to_page(outer_start))) {
> 

I was expecting some magical reason why this is still required but I am 
not able to find a compelling one. Maybe this is really some historical 
artifact.

Let's see if other people know why this call here still exists.

-- 
Thanks,

David / dhildenb

