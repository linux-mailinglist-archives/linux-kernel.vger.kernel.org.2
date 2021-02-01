Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEF30A421
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBAJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232285AbhBAJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612170610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Cpz/9ce6N68oi1r3HkRt/6ubGoKxWXGrN4Wc0ffQJs=;
        b=ghbSMjtmhwwAKZqjaRzBu4M1aNAahvlNX6uH4BtZtpQahAXlyWPpeTURaByQVmX9054h5D
        ofzaPKDsUgDqnCL81aCRV6RXZIxsaWLs1TjO99sOlDrDK9vFZocr5IBaEsbADbr2qUcL4l
        NZF2vJz2FOXx3yQM9hos7Rfuibzme8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-msExTuC0OPOra3eeFgOKqQ-1; Mon, 01 Feb 2021 04:06:37 -0500
X-MC-Unique: msExTuC0OPOra3eeFgOKqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FCA659;
        Mon,  1 Feb 2021 09:06:35 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3430A5DA2E;
        Mon,  1 Feb 2021 09:06:31 +0000 (UTC)
Subject: Re: [PATCH V5 3/4] s390/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, osalvador@suse.de
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
 <1612149902-7867-4-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6e84c7a9-730d-64ee-ab8a-ae966a0e007e@redhat.com>
Date:   Mon, 1 Feb 2021 10:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612149902-7867-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.21 04:25, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform which will be
> used with recently added generic framework. It modifies the existing range
> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
> VM_BUG_ON() check that would ensure that mhp_range_allowed() has already
> been called on the hotplug path.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/s390/mm/init.c |  1 +
>   arch/s390/mm/vmem.c | 14 +++++++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 73a163065b95..0e76b2127dc6 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>   		return -EINVAL;
>   
> +	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>   	rc = vmem_add_mapping(start, size);
>   	if (rc)
>   		return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 01f3a5f58e64..82dbf9450105 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,6 +4,7 @@
>    *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>    */
>   
> +#include <linux/memory_hotplug.h>
>   #include <linux/memblock.h>
>   #include <linux/pfn.h>
>   #include <linux/mm.h>
> @@ -532,11 +533,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>   	mutex_unlock(&vmem_mutex);
>   }
>   
> +struct range arch_get_mappable_range(void)
> +{
> +	struct range mhp_range;
> +
> +	mhp_range.start = 0;
> +	mhp_range.end =  VMEM_MAX_PHYS - 1;
> +	return mhp_range;
> +}
> +
>   int vmem_add_mapping(unsigned long start, unsigned long size)
>   {
> +	struct range range = arch_get_mappable_range();
>   	int ret;
>   
> -	if (start + size > VMEM_MAX_PHYS ||
> +	if (start < range.start ||
> +	    start + size > range.end + 1 ||
>   	    start + size < start)
>   		return -ERANGE;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

