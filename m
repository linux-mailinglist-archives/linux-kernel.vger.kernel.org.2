Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6311A37391F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhEELPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 07:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhEELPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 07:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620213266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlQdZDxdtDpmyzdzOMVSqfZvSbkAtbDp7XD0iOszPH0=;
        b=b+9j9FUnw2wnBG1pV/nUKZ3C1KppqI4v8scVh45ZYecI8jt8hFMzhWbVfyiUtq3VchmjST
        GsWVj0Pah+3PVoTJuJqbhcMZg/a6bZzkxllKRvhfOxUjDgpFnh21qefyO1XxMBGKnGCNW1
        Qvwtl4N5J9prRNEE6MXlCNgfIuVKecU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-qtlmmr4TPzmzbTcFV92fCg-1; Wed, 05 May 2021 07:14:24 -0400
X-MC-Unique: qtlmmr4TPzmzbTcFV92fCg-1
Received: by mail-wr1-f71.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so545311wrl.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vlQdZDxdtDpmyzdzOMVSqfZvSbkAtbDp7XD0iOszPH0=;
        b=DE+23yUF7DkL+HHWxd3BeT5QdY7X+k3hqxa94n+sCq+c8k6RGGo3WOCJFK8VQBqb8Q
         qKZJhPfjcAir3Eguglk6+yRgAn6Tdk8uIXdiQIscSBgVM+soGG311fDMIkkbfbiBCFZW
         xo5xJUWgwSBZm8zoDgwLsv0lNIY76IG0EwrvDZAOSgVHhUw58Jj0KGfR5DiI53Fo7FWZ
         KohUA9ZS/Eo1udAw9kS2Vx0bbOELgD72JfeaVdW36lXgGS4Z5t1fYjKcENrClhKg6OUV
         9Jzsz/yi6220PfdLQTfNdcDo/m0kp5AGK5emf0SxQJ9OqRaavgvTIIsOu0v0ppghiJik
         +4Tw==
X-Gm-Message-State: AOAM532uL/Aa0bsj4s8yrPccbmNOYav0R5y3cBP9kT93dyIhVGFoMFHk
        1ZIqZFxv7HL1gOjY5/VO5ICQMCkrXcjizHoSXS1BwSofIjUahUIFvvKZVMHmrj1L7HIuqk6AbuY
        UjwH5Uk+HqV0Gd7f6lNkhJJ4leELQCk6DASbhyTthm8PEbUb0zdLjySBZl2DmtSWJgAiM9UF2
X-Received: by 2002:a5d:6e11:: with SMTP id h17mr4099507wrz.331.1620213263228;
        Wed, 05 May 2021 04:14:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbp+IuFL9y7PdYXvXqJOPhuWFItd6hzVhZYzE8i1fkoAg5gdrqwoi11M+U5pAkhFB1b+BhwA==
X-Received: by 2002:a5d:6e11:: with SMTP id h17mr4099479wrz.331.1620213262965;
        Wed, 05 May 2021 04:14:22 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id i13sm19403759wrs.12.2021.05.05.04.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 04:14:22 -0700 (PDT)
Subject: Re: [PATCH] nommu: remove __GFP_HIGHMEM in vmalloc/vzalloc
To:     Chen Li <chenli@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <875z00rnp8.wl-chenli@uniontech.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a15f99c4-14a9-8f81-6fd9-45caa46ebc72@redhat.com>
Date:   Wed, 5 May 2021 13:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <875z00rnp8.wl-chenli@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.21 14:44, Chen Li wrote:
> 
>  From mm/nommu.c:
> void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> {
> 	/*
> 	 *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc()
> 	 * returns only a logical address.
> 	 */
> 	return kmalloc(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
> }
> 
> nommu's __vmalloc just uses kmalloc internally and elimitates __GFP_HIGHMEM,
> so it makes no sense to add __GFP_HIGHMEM for nommu's vmalloc/vzalloc.
> 
> Signed-off-by: Chen Li <chenli@uniontech.com>
> ---
>   mm/nommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5c9ab799c0e6..339a2f2eb1aa 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -233,7 +233,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
>    */
>   void *vmalloc(unsigned long size)
>   {
> -       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM);
> +       return __vmalloc(size, GFP_KERNEL);
>   }
>   EXPORT_SYMBOL(vmalloc);
>   
> @@ -251,7 +251,7 @@ EXPORT_SYMBOL(vmalloc);
>    */
>   void *vzalloc(unsigned long size)
>   {
> -	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> +	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
>   }
>   EXPORT_SYMBOL(vzalloc);
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

