Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428273059EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhA0Lfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236744AbhA0LbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611746977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DF56LqGQIaMWl+R6iCVbZC8A2rcfzjbdx/44HSSsxXg=;
        b=iApYjrZd6ZkuZH3J3UWel9cenjgvevzjlwpgOxGUfRhkPBnLFV6BlEW6j171mRlCQK+ugf
        lHh1rfTaJWQmUcKJaG3Jjkhp8mfldqhMmOgB4Z4UhfJ77Lyo7Txcd+PRTCIAyZYjIjR+p8
        gKN2DdCuqAGjJvCroMBdEH7DiYNhc7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-3TIhgHkaM1KoSV1b3XhPUQ-1; Wed, 27 Jan 2021 06:29:33 -0500
X-MC-Unique: 3TIhgHkaM1KoSV1b3XhPUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C885B802B49;
        Wed, 27 Jan 2021 11:29:31 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D94D11002EE6;
        Wed, 27 Jan 2021 11:29:28 +0000 (UTC)
Subject: Re: [PATCH] x86/vmemmap: Handle unpopulated sub-pmd ranges
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
References: <20210127112315.28297-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ff7c0838-bfb2-9904-8dcc-4f6f979734d3@redhat.com>
Date:   Wed, 27 Jan 2021 12:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210127112315.28297-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 12:23, Oscar Salvador wrote:
> When the size of a struct page is not multiple of 2MB, sections do
> not span a PMD anymore and so when populating them some parts of the
> PMD will remain unused.
> Because of this, PMDs will be left behind when depopulating sections
> since remove_pmd_table() thinks that those unused parts are still in
> use.
> 
> Fix this by marking the unused parts with PAGE_INUSE, so memchr_inv() will
> do the right thing and will let us free the PMD when the last user of it
> is gone.
> 
> This patch is based on a similar patch by David Hildenbrand:
> 
> https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com/
> https://lore.kernel.org/linux-mm/20200722094558.9828-10-david@redhat.com/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/x86/mm/init_64.c | 81 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b5a3fa4033d3..9b6d45ea353b 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -873,6 +873,71 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   
>   #define PAGE_INUSE 0xFD

Note that I called it "PAGE_UNUSED", using "PAGE_INUSE" might make it a 
little harder to digest.

-- 
Thanks,

David / dhildenb

