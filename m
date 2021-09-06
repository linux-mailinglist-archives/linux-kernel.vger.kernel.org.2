Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F70401900
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhIFJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239548AbhIFJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630921233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYA37SlRuRPHoIjk69T5OroCeNXU9xA4x0HI4zeLbQw=;
        b=N3lbHd06W27kO/UlKam+Mu0aM+/CXd0eB3Pg+TcfCIqUtOh4A3b2Mi5FWd5Ti79koQ876a
        xtPsLicw+WPFIbKq006JssSVdlsb6voTTc5w8TwaN1L5xVYoR5g6pj9gJhEtwIHqrr2ovG
        UcFc2MPvWLzJBNp0pFSK0pspxp2TUG0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-uHdRa3-hNDW3hv6og1Rsqg-1; Mon, 06 Sep 2021 05:40:32 -0400
X-MC-Unique: uHdRa3-hNDW3hv6og1Rsqg-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a1c7210000000b002ea2ed60dc6so1997745wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cYA37SlRuRPHoIjk69T5OroCeNXU9xA4x0HI4zeLbQw=;
        b=Oo+DwInh/nAvpN8T6PSjfJ2GH0wZrMTVpaOG2egV+tUxPCGtT2HcbMAUdsoTeiXGWT
         yHrhBVBLYWj2xex6VEZrO82d9HVlCGLJrEty3AE9qSa71r9uVFWIW/m51dJz/kKspbRb
         H/H0GFBNXxRIW/hyklv2OxxnA5u4A9IJAMRPT3vpPBBGNajA2jhOHLdhnwrR+l/1dBJI
         A0wSxyCpsX+Ubu6ILYGCIHcHxMdcMcTgPlC96SSYwfAOc/Nm/0ebcKn1xBhc4G2S6upE
         NCGje0hTj0LgGxNwZmaXkft1XhyYzITRRIIdvSuCb0bOI2/RUlDMH35UREInufpdU4ZJ
         m0AA==
X-Gm-Message-State: AOAM532Bvo7oZXshUBdM37U5eAUc7L4R2l+YUcWMjDASGFmTMWTdPR5g
        gZcD9y/PaJIaVACpmQDvzeAm+Bmx/Rk3XQiLcJ+If1ZpBk0MOGJ8ktsHTPzdfjatp/T4epnj6Wr
        wuaiaBg+AEQT2rv0ciLjtdb8WvFfcWvNIinHBm73b4BbYlD3XUva17qhYtTUSHDw4rzgYdQw1
X-Received: by 2002:a1c:4cd:: with SMTP id 196mr10331372wme.10.1630921231215;
        Mon, 06 Sep 2021 02:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBtZlHsLGYFzWRzJ5Y5Nuo0pZbnJi5t0VUGtyWpg9J5ZrFUPZmKp16fwujCtQNaoe5gTaa5w==
X-Received: by 2002:a1c:4cd:: with SMTP id 196mr10331346wme.10.1630921230940;
        Mon, 06 Sep 2021 02:40:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id f20sm6656589wmb.32.2021.09.06.02.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 02:40:30 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e060283a-6295-9191-9b92-a3c183e9de02@redhat.com>
Date:   Mon, 6 Sep 2021 11:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904091839.20270-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.21 11:18, Miaohe Lin wrote:
> If __isolate_free_page() failed, due to zone watermark check, the page is
> still on the free list. But this page will be put back to free list again
> via __putback_isolated_page() now. This may trigger page->flags checks in
> __free_one_page() if PageReported is set. Or we will corrupt the free list
> because list_add() will be called for pages already on another list.
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_isolation.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 9bb562d5d194..7d70d772525c 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>   			buddy_pfn = __find_buddy_pfn(pfn, order);
>   			buddy = page + (buddy_pfn - pfn);
>   
> -			if (!is_migrate_isolate_page(buddy)) {
> -				__isolate_free_page(page, order);
> -				isolated_page = true;
> -			}
> +			if (!is_migrate_isolate_page(buddy))
> +				isolated_page = !!__isolate_free_page(page, order);
>   		}
>   	}
>   
> 

Shouldn't we much rather force to ignore watermarks here and make sure 
__isolate_free_page() never fails?

-- 
Thanks,

David / dhildenb

