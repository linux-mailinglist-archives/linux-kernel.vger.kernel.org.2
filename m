Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70A40F61A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbhIQKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343791AbhIQKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631875447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Z9qLUq2BDHVt4FxNaULEqhyuGeSzzXMfrlMb+du88M=;
        b=U/xy9wy9ZRhPkQkLLP/ACSyJ+LpVAYSg3FVtgCJW4STVgZ/mlN78mbMW1Bi/QLiQG6tGEY
        3NhyBU7VfomnlWcKrvHSOXnWB7CE4CSDjpyKuLtkExQf5yfMPQ1OVghhHniOoLS5wr1xQk
        SB1zvQihJuUwnK82UnBYcY+p+528BOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-Sv2-qDbdOPGjBi8k8zkiLg-1; Fri, 17 Sep 2021 06:44:06 -0400
X-MC-Unique: Sv2-qDbdOPGjBi8k8zkiLg-1
Received: by mail-wr1-f70.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso3561188wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Z9qLUq2BDHVt4FxNaULEqhyuGeSzzXMfrlMb+du88M=;
        b=eCWWTnJhE0juyX7jznMocSMSSisArFHBepaXDwyRSxDsCmdl6808q7nC6tySQAGa0B
         IEs2etqK5Ng1BKigxjDHwxUNWSuxkxv8IiJ+d1DHtWPz9rzKKjPQxbxwSfkZUnmwHNM6
         bZRCsxZRy8MAyYkvS9xEGAl5Rp9QVHCcGcXx8Zl2uWBTpIrfacM4VeBV5WJ8IG14XF3a
         jS0Si4sVR/VAQh2WXK+EHCtzgU5HhR5DpvBoPyljp+PPaGVbEz/150v3DDY7s6IOeQ3t
         xVW6F0w9FVDwRGP6V1Bc+kzvlnbqcdcHJ3dCOJF92EC6eL8FpD23ngntlZpqG00NhlYo
         AlUQ==
X-Gm-Message-State: AOAM532oQKjlFnz5RofA38VcUhwM5VwF9tiwrTvT9K00nsDxvI5pvI0S
        3H/lktudRSkGpMdHP8MyCzVNo3nwM8XnVd80gEFIo3pkgM/3DMBH+iWejeHdQ3ul+UZESDux/Xy
        idqj1Sdh8SSGqnArE7cP7zDWt
X-Received: by 2002:adf:d20f:: with SMTP id j15mr11321955wrh.255.1631875445485;
        Fri, 17 Sep 2021 03:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE438hv18Je6b3QHkYkAkmfbBOZU0BAmfYzed/MwXxbBg06Zs0/ToFExpbdRJcJoTZ7+EQDw==
X-Received: by 2002:adf:d20f:: with SMTP id j15mr11321936wrh.255.1631875445322;
        Fri, 17 Sep 2021 03:44:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c655a.dip0.t-ipconnect.de. [91.12.101.90])
        by smtp.gmail.com with ESMTPSA id c30sm6329698wrb.74.2021.09.17.03.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 03:44:04 -0700 (PDT)
Subject: Re: [PATCH] mm/memcg: Drop swp_entry_t* in mc_handle_file_pte()
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20210916193014.80129-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3d8d2411-9de3-5a87-da7c-8b268e933346@redhat.com>
Date:   Fri, 17 Sep 2021 12:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916193014.80129-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.21 21:30, Peter Xu wrote:
> After the rework of f5df8635c5a3 ("mm: use find_get_incore_page in memcontrol",
> 2020-10-13) it's unused.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/memcontrol.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b762215d73eb..12fa08e216a6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5555,7 +5555,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
>   #endif
>   
>   static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
> -			unsigned long addr, pte_t ptent, swp_entry_t *entry)
> +			unsigned long addr, pte_t ptent)
>   {
>   	if (!vma->vm_file) /* anonymous vma */
>   		return NULL;
> @@ -5728,7 +5728,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>   	else if (is_swap_pte(ptent))
>   		page = mc_handle_swap_pte(vma, ptent, &ent);
>   	else if (pte_none(ptent))
> -		page = mc_handle_file_pte(vma, addr, ptent, &ent);
> +		page = mc_handle_file_pte(vma, addr, ptent);
>   
>   	if (!page && !ent.val)
>   		return ret;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

