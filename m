Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF1332D95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCIRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhCIRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615312367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s63iBzKBd4M36rC3LznClTyqjR9ceoDGyLPQ5MKvLKY=;
        b=IIZtFUey+9YwhGinj8Ax6JBNolEUcEAMuNqYpYg9xLT2VFx11AtvP+hpel1465A/5gGBzN
        hJ6AqQV3dC0tR5anEEUSRveusrGF3oCW/8KD+Udn2twZgRa5HhVbblYmnfC6YONqWu7/GZ
        aCigHxtHs7ls0UckxJmJ4wPr8++x2NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-5Gzoo8e2Pcu_ka1g8Rs6Fg-1; Tue, 09 Mar 2021 12:52:44 -0500
X-MC-Unique: 5Gzoo8e2Pcu_ka1g8Rs6Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF82108BD0E;
        Tue,  9 Mar 2021 17:52:42 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B316560C4A;
        Tue,  9 Mar 2021 17:52:39 +0000 (UTC)
Subject: Re: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
Date:   Tue, 9 Mar 2021 18:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309174113.5597-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 18:41, Oscar Salvador wrote:
> When sizeof(struct page) is not a power of 2, sections do not span
> a PMD anymore and so when populating them some parts of the PMD will
> remain unused.
> Because of this, PMDs will be left behind when depopulating sections
> since remove_pmd_table() thinks that those unused parts are still in
> use.
> 
> Fix this by marking the unused parts with PAGE_UNUSED, so memchr_inv()
> will do the right thing and will let us free the PMD when the last user
> of it is gone.
> 
> This patch is based on a similar patch by David Hildenbrand:
> 
> https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/x86/mm/init_64.c | 63 ++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 9ecb3c488ac8..3bb3988c7681 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -871,7 +871,50 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	return add_pages(nid, start_pfn, nr_pages, params);
>   }
>   
> -#define PAGE_INUSE 0xFD
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define PAGE_UNUSED 0xFD
> +
> +/* Returns true if the PMD is completely unused and thus it can be freed */
> +static bool __meminit vmemmap_pmd_is_unused(unsigned long addr, unsigned long end)
> +{

I don't think the new name is any better. It implies that all it does is 
a check - yet it actually clears the given range. (I prefer the old 
name, but well, I came up with that, so what do I know :D )


-- 
Thanks,

David / dhildenb

