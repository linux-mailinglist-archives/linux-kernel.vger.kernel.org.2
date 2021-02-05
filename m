Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA931066E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBEIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231400AbhBEIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612512889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j2V28G6TB0k1xZOho5buyO+OVavUzwQhVeitnTV4PM=;
        b=bFrPAbt7EXY0WhqGaHvUkK5icuXrMpbj3OTVF4lMYCPuQUfPE/NphamE+gc5SW5eedkwdT
        WonWMZ+YzJlg8TKRIsDNdtPzVERnYrXpLLWld4D4MIZYCJY/sbFtW1LCe/03K27iVMpmPD
        cHnQjzYhRIB/h1UFslCJSakZraS4/Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-2wj2oO0EOiidv6OQRj0u6w-1; Fri, 05 Feb 2021 03:14:47 -0500
X-MC-Unique: 2wj2oO0EOiidv6OQRj0u6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B9D804022;
        Fri,  5 Feb 2021 08:14:46 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 169921971C;
        Fri,  5 Feb 2021 08:14:44 +0000 (UTC)
Subject: Re: [PATCH] mm/mlock: stop counting mlocked pages when none vma is
 found
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210204110705.17586-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2e3ff8fb-8d8f-b906-2187-3b558e56adfa@redhat.com>
Date:   Fri, 5 Feb 2021 09:14:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210204110705.17586-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.21 12:07, Miaohe Lin wrote:
> There will be no vma satisfies addr < vm_end when find_vma() returns NULL.
> Thus it's meaningless to traverse the vma list below because we can't find
> any vma to count mlocked pages. Stop counting mlocked pages in this case to
> save some vma list traversal cycles.

I think this is correct. We will have addr >= vm_end for any VMA, so 
there are no applicable VMAs.

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/mlock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 73960bb3464d..f8f8cc32d03d 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -622,7 +622,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
>   
>   	vma = find_vma(mm, start);
>   	if (vma == NULL)
> -		vma = mm->mmap;
> +		return 0;
>   
>   	for (; vma ; vma = vma->vm_next) {
>   		if (start >= vma->vm_end)
> 


-- 
Thanks,

David / dhildenb

