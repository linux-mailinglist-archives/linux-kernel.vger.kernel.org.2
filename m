Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD45A30BF73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhBBNbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhBBNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612272561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvwRtVP5vp80IXVInMVRsjcG2OB+pyvOocXOW5/K1lg=;
        b=PenMMhzh5DV+Mwm5WudHGfimfYX5lIE2nm9W/FOoGnDWW3d8k9u4Vf5gMZ5Z1E8Np6+MDF
        MFGjvvfHZay6ZzxHL5zF/wB+G69GRfzXtCEWWxMTWnDYV9iVdYh17KZrIWbKn36xn+f/Co
        z22tbEqOQjULFe95cEK8N69jXKJOjp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-RfqjVO5yMKuZ1F_Ryx1DAw-1; Tue, 02 Feb 2021 08:29:16 -0500
X-MC-Unique: RfqjVO5yMKuZ1F_Ryx1DAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8652B195D560;
        Tue,  2 Feb 2021 13:29:14 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8E9B36FA;
        Tue,  2 Feb 2021 13:29:11 +0000 (UTC)
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
References: <20210202112450.11932-1-osalvador@suse.de>
 <20210202112450.11932-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 2/2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <f1990f9d-305c-f5f9-e77d-5c5d71143672@redhat.com>
Date:   Tue, 2 Feb 2021 14:29:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202112450.11932-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1088,10 +1150,10 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
>   				pages++;
>   			} else {
>   				/* If here, we are freeing vmemmap pages. */
> -				memset((void *)addr, PAGE_INUSE, next - addr);
> +				memset((void *)addr, PAGE_UNUSED, next - addr);
>   
>   				page_addr = page_address(pud_page(*pud));
> -				if (!memchr_inv(page_addr, PAGE_INUSE,
> +				if (!memchr_inv(page_addr, PAGE_UNUSED,
>   						PUD_SIZE)) {
>   					free_pagetable(pud_page(*pud),
>   						       get_order(PUD_SIZE));

I'm sorry to bother you again, but isn't that dead code as well?

How do we ever end up using 1GB pages for the vmemmap? At least not via 
vmemmap_populate() - so I guess never? There are not many occurrences of 
"PUD_SIZE" in the file after all ...

I think we can simplify that code.

-- 
Thanks,

David / dhildenb

