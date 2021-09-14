Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA240ACAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhINLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhINLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631619924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9fG0GXTgfPaaKu4Yvjr2ry2QvBYCQiNNCWSY5wy0Vc=;
        b=in6b71WYCISDo5ak5Paspm0R+EOI7qUn1SACVswQLbimC9zj2QYR9lZY0I43J01FYI0S1o
        OldF8ox0Bp3kKBeVzTjW+7gNsDEJe+M9a/A77vg049apXDYexbjG7yi6/esLxbTQRva9Y5
        17WFioeF+iwL/X9YSG3iDDzvJUVza08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-up0RZwcrP0iC12FVcttiCQ-1; Tue, 14 Sep 2021 07:45:23 -0400
X-MC-Unique: up0RZwcrP0iC12FVcttiCQ-1
Received: by mail-wr1-f69.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso3837562wra.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q9fG0GXTgfPaaKu4Yvjr2ry2QvBYCQiNNCWSY5wy0Vc=;
        b=Ogw1+N682D7fcfzK875mZGr0Sbg1fmE5/PwmL1Xkd13Fj1ZAHBF9FXqWY6gff3XMYJ
         wS6s5JGBX+jrBul+Vba35ZORCHbs78ts2N39QvastdYzLv7d7KZcUAZ4SUZdtzxz6aCR
         I4hsMei5XtcV8RAKv7JTjx6x0QUe2t5+F1UsklZrQ0VcwJLNp0boYIg+xd6DwhLoxxsG
         NAzM2LsrmM4xBHSYq5sUYedq9RVFVt2Gj6O/mpSMqcrUOpII3cwnlhd2T13I5YgDO3hX
         s6FFufKCTHtBsQhLRv6LDU1vFfzIsqWrvdh09o048fzMlRxkYb5jQkmNBsxLIRnEKrwL
         EdpA==
X-Gm-Message-State: AOAM531fTmHlZHVGfYJHDxbiMVQWHt1bHXx2pqn3/T2MaQXRWtbVvHuK
        NDG+Xf3ew2QRACuEWPTmRRHMr9MRXr9/zfIwMphF7Td4t7ahyhJma2/9R2alFoPC9W7SFCJ6zbP
        ntIhU0Zj6sqF/BVjT1fzBv/ZOah5mfDLG2ysCd2q7vwKMCnUBk5k8xYdwUh48GczHdf2IbeHv
X-Received: by 2002:a1c:9d4e:: with SMTP id g75mr1727746wme.20.1631619922330;
        Tue, 14 Sep 2021 04:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0iinYgdQWF9r67eyUWiGOMAvKPAWDXoHcww68hjmRs5mA5wnoVHW0Itc4/2Gg0Mv94hNwMg==
X-Received: by 2002:a1c:9d4e:: with SMTP id g75mr1727717wme.20.1631619922019;
        Tue, 14 Sep 2021 04:45:22 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id n26sm839749wmi.43.2021.09.14.04.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 04:45:21 -0700 (PDT)
Subject: Re: [PATCH v3] mm/page_isolation: guard against possible putback
 unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210914114508.23725-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <54ceacde-e36e-f0f7-6c8c-59a792ca252a@redhat.com>
Date:   Tue, 14 Sep 2021 13:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914114508.23725-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.21 13:45, Miaohe Lin wrote:
> Isolating a free page in an isolated pageblock is expected to always work
> as watermarks don't apply here. But if __isolate_free_page() failed, due
> to condition changes, the page will be left on the free list. And the page
> will be put back to free list again via __putback_isolated_page(). This may
> trigger VM_BUG_ON_PAGE() on page->flags checking in __free_one_page() if
> PageReported is set. Or we will corrupt the free list because list_add()
> will be called for pages already on another list. Add a VM_WARN_ON() to
> complain about this change.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1->v2:
>    Add VM_WARN_ON to catch unexpected isolating failure.
> v2->v3:
>    Change the patch description+subject and remove Fixes.
> ---
>   mm/page_isolation.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f93cc63d8fa1..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -94,8 +94,13 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>   			buddy = page + (buddy_pfn - pfn);
>   
>   			if (!is_migrate_isolate_page(buddy)) {
> -				__isolate_free_page(page, order);
> -				isolated_page = true;
> +				isolated_page = !!__isolate_free_page(page, order);
> +				/*
> +				 * Isolating a free page in an isolated pageblock
> +				 * is expected to always work as watermarks don't
> +				 * apply here.
> +				 */
> +				VM_WARN_ON(!isolated_page);
>   			}
>   		}
>   	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

