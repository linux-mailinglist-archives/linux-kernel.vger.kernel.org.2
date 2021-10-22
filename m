Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35A7437720
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhJVMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhJVMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634905743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuUgTaC7SncRn/56fPFHOc3RSrpIisjOLVPx5zTF8wM=;
        b=Yo0ReFKCg99uRbF4u3kCBENaSLKDOSZjw+mlsShssRvqRbBJ5BLohR3SKBlWL5y3vb8PIB
        GWqsBcijeRMC+fWvviFFpnK2m0fUxTbG24rTD2PidPExpqYAczvbtLkl3D5VtfMTS4NkQ2
        1aNRveSe32j+I3eJw3NwVDwAFt1ikZI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-OpHycZr-P-ib9eNsmUigfA-1; Fri, 22 Oct 2021 08:29:02 -0400
X-MC-Unique: OpHycZr-P-ib9eNsmUigfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c0005000000b0032c9c156acbso921835wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YuUgTaC7SncRn/56fPFHOc3RSrpIisjOLVPx5zTF8wM=;
        b=f76wJz1uNJ5qNG9a6a4dYPCK4V13tbkMAzfdTGQAX3Kc8BKgE+tU8MinnOBDeVFbgq
         xtpcTXnBoDDXs773c5N4z9HKm408DjgmL93X/qDs6SXQ2JNPMiEN+TUk8uWJ6G9eNGFR
         IOjKc1aMx5FuP7OnZtY866x5iELTev6PGaHxT6eZoGcaFfOD2axLP6XRuh0D3qsRho/b
         6HOozDD8XI38Lpx1lNKLh7cVriqZJCrfpleG16INpVt4mKApiNSeUtifo4PmRfocQs8o
         CQFhyIkeYRKRh2I3oIr98NYGt+tNIgnW4cBNDpaMTAd1Xlab3Q2RL+PexMb5FI4e0G0y
         mAhg==
X-Gm-Message-State: AOAM533yVonkzdf0xrzp+U507dYRuC2xKOhRstcsnyVMcyJ5MBf//AP5
        KGtfqDXqXfC7uN+NO/BFNV0tkuCg/5lcQnsvzvkAqxYjgMTT1cfb/eFxtszd5HmLUettuaFacsz
        KnFLNOVtVV9tg+RrHNS5Z3Az1
X-Received: by 2002:adf:b355:: with SMTP id k21mr15307028wrd.380.1634905741165;
        Fri, 22 Oct 2021 05:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8b0jvSBO/rDYlcgNKG5q+gpSX25bwLoicK9Z2PsuXIXbBKjkxBVkfERN2zEYyrkQpuyMqbA==
X-Received: by 2002:adf:b355:: with SMTP id k21mr15306985wrd.380.1634905740893;
        Fri, 22 Oct 2021 05:29:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id h14sm3553851wmq.34.2021.10.22.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 05:29:00 -0700 (PDT)
Message-ID: <d6f6bb06-17a5-92d4-82f9-f8350d0a7b0f@redhat.com>
Date:   Fri, 22 Oct 2021 14:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3] kasan: add kasan mode messages when kasan init
Content-Language: en-US
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marco Elver <elver@google.com>
Cc:     chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        nicholas.tang@mediatek.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org
References: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.21 11:48, Kuan-Ying Lee wrote:
> There are multiple kasan modes. It makes sense that we add some messages
> to know which kasan mode is when booting up. see [1].

s/is/is active/ ?

Looks reasonable to me

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
> v3:
>  - Rebase to linux-next
>  - Move kasan_mode_info() into hw_tags.c
> v2:
>  - Rebase to linux-next
>  - HW-tag based mode need to consider asymm mode
>  - Thanks Marco's suggestion
> 
>  arch/arm64/mm/kasan_init.c |  2 +-
>  mm/kasan/hw_tags.c         | 14 +++++++++++++-
>  mm/kasan/sw_tags.c         |  2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 5b996ca4d996..6f5a6fe8edd7 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -309,7 +309,7 @@ void __init kasan_init(void)
>  	kasan_init_depth();
>  #if defined(CONFIG_KASAN_GENERIC)
>  	/* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	pr_info("KernelAddressSanitizer initialized (generic)\n");
>  #endif
>  }
>  
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index dc892119e88f..7355cb534e4f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -106,6 +106,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
>  }
>  early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
>  
> +static inline const char *kasan_mode_info(void)
> +{
> +	if (kasan_mode == KASAN_MODE_ASYNC)
> +		return "async";
> +	else if (kasan_mode == KASAN_MODE_ASYMM)
> +		return "asymm";
> +	else
> +		return "sync";
> +}
> +
>  /* kasan_init_hw_tags_cpu() is called for each CPU. */
>  void kasan_init_hw_tags_cpu(void)
>  {
> @@ -177,7 +187,9 @@ void __init kasan_init_hw_tags(void)
>  		break;
>  	}
>  
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
> +		kasan_mode_info(),
> +		kasan_stack_collection_enabled() ? "on" : "off");
>  }
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index bd3f540feb47..77f13f391b57 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -42,7 +42,7 @@ void __init kasan_init_sw_tags(void)
>  	for_each_possible_cpu(cpu)
>  		per_cpu(prng_state, cpu) = (u32)get_cycles();
>  
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	pr_info("KernelAddressSanitizer initialized (sw-tags)\n");
>  }
>  
>  /*
> 


-- 
Thanks,

David / dhildenb

