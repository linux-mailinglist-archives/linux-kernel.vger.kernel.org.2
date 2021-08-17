Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6C3EEE06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHQOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237407AbhHQOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629209024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfdIig2A38w0Tkc5U+l6+f2xruLZRnenJrdR3B6v0U8=;
        b=CtcwWDohWB+nHD4biHfvTuIi0KDkBwoGzN2SjVgj2eHQvbGWrxnFH9M540EeVzyxFI+zNQ
        RMV8iW4m5MdSZzrAVGBkadDgDyA3iIvnUKzrQ8XtybUJ2dVwlQkNmZ+wdYsu70qtF/8l8z
        bE0aP1fjrmLwmPFl29Na0xIH+Fase5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-DeVjRrMgNmiS8Mxyt9okww-1; Tue, 17 Aug 2021 10:03:34 -0400
X-MC-Unique: DeVjRrMgNmiS8Mxyt9okww-1
Received: by mail-wm1-f70.google.com with SMTP id y206-20020a1c7dd70000b02902e6a442ea44so982016wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZfdIig2A38w0Tkc5U+l6+f2xruLZRnenJrdR3B6v0U8=;
        b=I8qOzOBd3jkKAuS/1ZYh6wr25dRAH5qliBQeL0YFD33oZzwZ55jsXg+7ydVkwpM8ij
         mgnSExJ0BHEI4dQ+EGccHHJ05c+aejq8KYZrjaYLQeb3RQAKQ0pnAtzGQAmr5+EOOd57
         o+DJHTOhyV6AGl9zm1A89IbiMK9FWxliMIA1tsyBNpFyg57dZ7YF0hvnID/Uvumx5k5x
         3WtJ+lBZqOWD48N/YsW8mWwV1RPhSOr0yHNagu9w29GurQoBA22WDlIrmmR/imD2XxV9
         VZigNYebo7dpDP2rEb+hUko2gIWzFENURHLNc9nUzzDamjxWo+KRhp3XrSyvA9lrP4xP
         QYfA==
X-Gm-Message-State: AOAM530zQOFbAYp8dUVOegPcCLzIHVSMZHL08Z/M2Qb16iOL0CIfvS+5
        1KLOQGJ0w9pF/zkDEPVQ/NdteE5T0Mfp8dEjUUFQDOslbKlmEFQMVpq+II7VpTeAmvtOn0kUxdB
        i8gafaOooJ3FBddRrWF29d4kh
X-Received: by 2002:a5d:4389:: with SMTP id i9mr3495421wrq.74.1629209013196;
        Tue, 17 Aug 2021 07:03:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3/Ox+IlPMvqUKk+VG3uabY9nF4377Z3HbdDT8QLHV0jefClHrYQiPtPepVUzaFmgn79TQwA==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr3495406wrq.74.1629209013061;
        Tue, 17 Aug 2021 07:03:33 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id u5sm2525530wrr.94.2021.08.17.07.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 07:03:32 -0700 (PDT)
Subject: Re: [PATCH] remap_file_pages: Use vma_lookup() instead of find_vma()
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210817135234.1550204-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6c7e2274-98d7-721b-498b-6c5fac2a3561@redhat.com>
Date:   Tue, 17 Aug 2021 16:03:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817135234.1550204-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 15:52, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Using vma_lookup() verifies the start address is contained in the found vma.
> This results in easier to read code.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>   mm/mmap.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d9aa54be6244..1a23d4575cc4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2994,14 +2994,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>   	if (mmap_write_lock_killable(mm))
>   		return -EINTR;
>   
> -	vma = find_vma(mm, start);
> +	vma = vma_lookup(mm, start);
>   
>   	if (!vma || !(vma->vm_flags & VM_SHARED))
>   		goto out;
>   
> -	if (start < vma->vm_start)
> -		goto out;
> -
>   	if (start + size > vma->vm_end) {
>   		struct vm_area_struct *next;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

