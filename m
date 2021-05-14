Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC52F380AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhENODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234025AbhENODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mql0q91ECxfqC6RVy/aAHYne20fUi8i8dudlG8TCa1w=;
        b=IG1stBQB7LDCXY2WWiLd0HHyKRSTFOEkroH7/JitTHgKNfiPMyBxiObFoTTW+RCYHyBQY0
        HmI51iDNU5/hvQILsqd/64U6T/uBGnAZWe8RagK484VVi6VrMQgmjl9kX/pVOHYU+CSjf8
        ngNNQjyj1roRM3a4y7wwr7d4aJtwzSQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-C0KgF1GNM8W5ddg4JP6X_g-1; Fri, 14 May 2021 10:02:40 -0400
X-MC-Unique: C0KgF1GNM8W5ddg4JP6X_g-1
Received: by mail-ed1-f70.google.com with SMTP id i17-20020a50fc110000b0290387c230e257so16427623edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mql0q91ECxfqC6RVy/aAHYne20fUi8i8dudlG8TCa1w=;
        b=mFf/4UjIhtwvfPX8WIJ09WWAmnIkDl+c4PAwQfORh5SSdi76LLIwunnWrsQuF5WP+F
         1Z59Cvj+RZX82QiqZDzVjj3ihbVj2GdXhLidrMWghcUl2nROLV/kmE+GHThzVM6He8VR
         a3TtELRvNOys+ZsxXIy450TM163Thq1EPvrAqZkxP35S27nnLbOhYM53OjbRfHx3FNVN
         4FplgY2kyZohdJv1h8hurGVInn2hXEpahra1HCmN8oIxTDE62990NQI2QG52gYzEee0L
         7Qx1c56X2qNxz8+rHxx8qIM4uMFhvdwFh6oqbaJGTFdkAt1Im2IlSnZmi0zKVJ0X/+K0
         CGIw==
X-Gm-Message-State: AOAM533zcjyuBzuuXGHcEigrRJv1cKqzj+DjHvXjV9QP2jD9FMShtfxP
        G/8ivqOy01g6OebHnljON/jgMd2+usdJ/W5tA/rMsVk5zeifFM97f1b0o7B948Ee97dei62gfmq
        zLoSLWmFaBslkX5k6ETXmdWWe
X-Received: by 2002:a05:6402:17d9:: with SMTP id s25mr24831493edy.337.1621000958988;
        Fri, 14 May 2021 07:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycqL708KNoHKpLFYbO+zZJI/n5h5okb1IMaDhgZfYIUL7lAvWQGfraW3B17JyJgzWq/5E1yA==
X-Received: by 2002:a05:6402:17d9:: with SMTP id s25mr24831467edy.337.1621000958793;
        Fri, 14 May 2021 07:02:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id c5sm4547748eds.94.2021.05.14.07.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:02:38 -0700 (PDT)
Subject: Re: [PATCH] mm/shuffle: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514135952.2928094-1-arnd@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ea93aed6-58c0-0905-11e4-628ea145999d@redhat.com>
Date:   Fri, 14 May 2021 16:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210514135952.2928094-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.21 15:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang sometimes decides not to inline shuffle_zone(), but it calls
> a __meminit function. Without the extra __meminit annotation we get
> this warning:
> 
> WARNING: modpost: vmlinux.o(.text+0x2a86d4): Section mismatch in reference from the function shuffle_zone() to the function .meminit.text:__shuffle_zone()
> The function shuffle_zone() references
> the function __meminit __shuffle_zone().
> This is often because shuffle_zone lacks a __meminit
> annotation or the annotation of __shuffle_zone is wrong.
> 
> shuffle_free_memory() did not show the same problem in my tests, but
> it could happen in theory as well, so mark both as __meminit.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   mm/shuffle.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 71b784f0b7c3..cec62984f7d3 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -10,7 +10,7 @@
>   DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
>   extern void __shuffle_free_memory(pg_data_t *pgdat);
>   extern bool shuffle_pick_tail(void);
> -static inline void shuffle_free_memory(pg_data_t *pgdat)
> +static inline void __meminit shuffle_free_memory(pg_data_t *pgdat)
>   {
>   	if (!static_branch_unlikely(&page_alloc_shuffle_key))
>   		return;
> @@ -18,7 +18,7 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
>   }
>   
>   extern void __shuffle_zone(struct zone *z);
> -static inline void shuffle_zone(struct zone *z)
> +static inline void __meminit shuffle_zone(struct zone *z)
>   {
>   	if (!static_branch_unlikely(&page_alloc_shuffle_key))
>   		return;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

