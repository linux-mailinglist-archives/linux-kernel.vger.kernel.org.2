Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB52401D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbhIFPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhIFPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630941119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTAWUJqHsSCVJupFQIBe5xPSnSiwqkAc+Gj9oW0KiHI=;
        b=hCUTQ60yRDC45D5WgRhNoi6zxj68p9S256BB5o1FH0N1ssrBeUXgQrbg57VQdd8hhEiYY3
        jk/5LyJDoe/P5KhvR+S2nspzyGMB1gdnhynDIi7k/bxtF9gdW+KvMpTOfPsp3Dh5XeGCC6
        kxqe1XXaa7fEUxVlXL6iXmh5JQ/2K+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-dSdiKBoLPf6XPBNbzijzvw-1; Mon, 06 Sep 2021 11:11:58 -0400
X-MC-Unique: dSdiKBoLPf6XPBNbzijzvw-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020a5d68ca000000b001552bf8b9daso1272108wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sTAWUJqHsSCVJupFQIBe5xPSnSiwqkAc+Gj9oW0KiHI=;
        b=DlYUCFecXR65ue3EGiDaS8qKUT3ogWy4dNmsrbydwEl5x9jParyKLTUB783wE4fSjw
         EdC2WRxNlt+KPLKvzd7nKO8iAY+0dDheETEOltSrGwe+DLlzCBo0i54uSGVuxa49+WOy
         ce0VTKpYvDR7/GSNBr/fwgl8oW0yJmPp7FUi/OIBHraygpEA4AYHKOzv28Ea/sQmdHjA
         UDfLp/IdVrmNOhT0+r36bR/5xybuO0D57Zf1FvppFlgrMOpdQnBQ2Pz9nIgRgn5X09SK
         FbzZBreM4P/AJMqF0pBUdF/bRbCFzDNSPGcj4QZqMF9t+AqMFg/TtSqI15T23K+LyRgG
         uIwA==
X-Gm-Message-State: AOAM531OTaCyRFoMjLrNA0f1kfPrMhGyBjDFswqZWVuxffoNKEbtnJfX
        dVRwQ4R0P2b1Z5zgF8ASY0LRUPRRWGWCukSD/X++nO1Q9JF9GYb3NkZjFvoTPd9AvleUYUnahpO
        kSWcHsv+3XPSEzpJKIYrR1Pgu
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr14310405wrn.327.1630941117340;
        Mon, 06 Sep 2021 08:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVfjP/aW0NF3LaFLZ7LNJWIHA0o4u1fJBl+7x7QDc7wVMjUPQuMjUI9qn9/xMi4h2tqzibnw==
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr14310385wrn.327.1630941117141;
        Mon, 06 Sep 2021 08:11:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id x21sm7498364wmi.15.2021.09.06.08.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 08:11:56 -0700 (PDT)
Subject: Re: [PATCH v2] mmap_lock: Change trace and locking order
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2abcacff-e629-a7a0-044f-986ebfc7416d@redhat.com>
Date:   Mon, 6 Sep 2021 17:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.21 04:21, Liam Howlett wrote:
> Print to the trace log before releasing the lock to avoid racing with
> other trace log printers of the same lock type.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>   include/linux/mmap_lock.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0540f0156f58..b179f1e3541a 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -101,14 +101,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
>   
>   static inline void mmap_write_unlock(struct mm_struct *mm)
>   {
> -	up_write(&mm->mmap_lock);
>   	__mmap_lock_trace_released(mm, true);
> +	up_write(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_write_downgrade(struct mm_struct *mm)
>   {
> -	downgrade_write(&mm->mmap_lock);
>   	__mmap_lock_trace_acquire_returned(mm, false, true);
> +	downgrade_write(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_read_lock(struct mm_struct *mm)
> @@ -140,8 +140,8 @@ static inline bool mmap_read_trylock(struct mm_struct *mm)
>   
>   static inline void mmap_read_unlock(struct mm_struct *mm)
>   {
> -	up_read(&mm->mmap_lock);
>   	__mmap_lock_trace_released(mm, false);
> +	up_read(&mm->mmap_lock);
>   }
>   
>   static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> @@ -155,8 +155,8 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>   
>   static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>   {
> -	up_read_non_owner(&mm->mmap_lock);
>   	__mmap_lock_trace_released(mm, false);
> +	up_read_non_owner(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_assert_locked(struct mm_struct *mm)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

