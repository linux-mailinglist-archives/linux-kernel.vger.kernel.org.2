Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD83FEA07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbhIBH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243451AbhIBH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630567726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWmLpJjiGr7OPwqTTslMad67D5ZXIJqk/nCEHV/6mJc=;
        b=UM7e47L1iYctAkbV+k2Zu37vQ0Vk+ePvBB7RNTRqMGTrcJzftoyuJwLenBlxoS2WNAnb+y
        H+NWZHf1Utj8V4TuF5ZQrFJYxSiMPg1BwIZZDqlrb6n1V5xxtwVlk+rR4rXiu46kAtUdMq
        +niLSlNb8H136SwKb4R87AudPqoWeS0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-HyZiAvniNEGVmgEKfRGlZA-1; Thu, 02 Sep 2021 03:28:45 -0400
X-MC-Unique: HyZiAvniNEGVmgEKfRGlZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so351122wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bWmLpJjiGr7OPwqTTslMad67D5ZXIJqk/nCEHV/6mJc=;
        b=OFPiRUf1FVFfd350dpdHn0ykJJk2kIuV1AII0Q0Px8yiHis1wTp31k67GYkSE4ohS0
         Adr471xeW29+ILu8d3SwXLe2Jko43iCa+cu6Npj4gEU6L3d9KQRUMxmDeXnPzun5RALR
         sbTs4sLYnlLnXyaD94u4iCZqhAnhlc8IYtKzSTztoptOvPCIxnP+N5RKY8h2rbEaW3gQ
         LeigztzIT56IC4+CNXJjyjOEEjy2QgFd9DDPdhINo5FbUlQjlVLS076CItYLx5yciTcx
         lD7JjijfZeNDLzDhO2/U8fwIvEBrzGYqKnuWz4gky/hqt/VgigbEY2GjKmFNjP7WFmUW
         Xc7g==
X-Gm-Message-State: AOAM533Z4CR6oDF+K+dUcvCkZGxV2R4awDdSlJD9x6xSEFEvhbqqrRi3
        qkYvucx17UZmJQtOVkI9s3mmPrfH8OMNJhT5sZ+gUSUwP7n4/P32BuynTRB0xs7wTuAz5Pom2wY
        IO8DNBrIhgiXsHIsUBdaX2xeA
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr1668607wmq.181.1630567724308;
        Thu, 02 Sep 2021 00:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIOi+cTmhCifgWh9iVHFhrgRJpAHgEmMTgWMaiCle472LHiZLKPX+umcbB1iWehCf4YtMW6A==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr1668588wmq.181.1630567724125;
        Thu, 02 Sep 2021 00:28:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id d8sm1030403wrv.20.2021.09.02.00.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:28:43 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205722.7328-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 4/5] mm: Introduce zap_details.zap_flags
Message-ID: <5f3aa3fa-e877-02d1-8721-debbe688e7af@redhat.com>
Date:   Thu, 2 Sep 2021 09:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901205722.7328-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 22:57, Peter Xu wrote:
> Instead of trying to introduce one variable for every new zap_details fields,
> let's introduce a flag so that it can start to encode true/false informations.
> 
> Let's start to use this flag first to clean up the only check_mapping variable.
> Firstly, the name "check_mapping" implies this is a "boolean", but actually it
> stores the mapping inside, just in a way that it won't be set if we don't want
> to check the mapping.
> 
> To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
> that we only check against the mapping if this bit set.  At the same time, we
> can rename check_mapping into zap_mapping and set it always.
> 
> Since at it, introduce another helper zap_check_mapping_skip() and use it in
> zap_pte_range() properly.
> 
> Some old comments have been removed in zap_pte_range() because they're
> duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
> easy to grep this information by simply grepping the flag.
> 
> It'll also make life easier when we want to e.g. pass in zap_flags into the
> callers like unmap_mapping_pages() (instead of adding new booleans besides the
> even_cows parameter).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm.h | 19 ++++++++++++++++++-
>   mm/memory.c        | 34 ++++++++++------------------------
>   2 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 69259229f090..fcbc1c4f8e8e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1716,14 +1716,31 @@ static inline bool can_do_mlock(void) { return false; }
>   extern int user_shm_lock(size_t, struct ucounts *);
>   extern void user_shm_unlock(size_t, struct ucounts *);
>   
> +/* Whether to check page->mapping when zapping */
> +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)

So we want to go full way, like:

typedef int __bitwise zap_flags_t;

#define  ZAP_FLAG_CHECK_MAPPING		((__force zap_flags_t)BIT(0))

> +
>   /*
>    * Parameter block passed down to zap_pte_range in exceptional cases.
>    */
>   struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;
>   	struct page *single_page;		/* Locked page to be unmapped */
> +	unsigned long zap_flags;

Why call it "zap_*" if everything in the structure is related to 
zapping? IOW, simply "mapping", "flags" would be good enough.

>   };
>   
> +/* Return true if skip zapping this page, false otherwise */
> +static inline bool
> +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> +{
> +	if (!details || !page)
> +		return false;
> +
> +	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
> +		return false;
> +
> +	return details->zap_mapping != page_rmapping(page);
> +}

I'm confused, why isn't "!details->zap_mapping" vs. 
"details->zap_mapping" sufficient? I can see that you may need flags for 
other purposes (next patch), but why do we need it here?

Factoring it out into this helper is a nice cleanup, though. But I'd 
just not introduce ZAP_FLAG_CHECK_MAPPING.

-- 
Thanks,

David / dhildenb

