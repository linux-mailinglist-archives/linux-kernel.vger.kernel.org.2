Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D691396EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhFAI14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233300AbhFAI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9hm24+zU23Gi+Onh9SuyUIdp8NMmXAQTVMpkMJ9R4U=;
        b=D12CkQN/8OwxwcPVzJBlj0E4M+f/9uZZAiE1htGy3WXbDo4bFG87snvX/x1u7gbugHiT46
        IsfAVyahdNOqIysrQ/riJ+cLJTSoNO42dEkeaI6oL8h2k8+YUqDkKJfZHKitsypanruBl1
        dThe+P/COok/yiCCX1dU/VKwfcdUGh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-n3fw0z7fMoO55oaqnCmwwg-1; Tue, 01 Jun 2021 04:26:11 -0400
X-MC-Unique: n3fw0z7fMoO55oaqnCmwwg-1
Received: by mail-wm1-f70.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so1015706wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s9hm24+zU23Gi+Onh9SuyUIdp8NMmXAQTVMpkMJ9R4U=;
        b=q/45lQhGC0MnjAAyekkZeUvz9m1Gd54Pc5RsQ7g1NgvBd5Xs1xomxZ3VsMq8tgYLzl
         xBWLM4WX2rtpfCZ4fNOVRw0ezzFfY4tVpga6VCnYAHCd9Wt5jthoeoQJyjfdrfGgxcvH
         LFGBBtxZPX5swg1ZK59isxe9fWeYEgutxEl9bekU/6egND4yrndjHprbippMyK9rrxQm
         HHiGPMxWFbQnMtu++i9RNFypCkB14B0Ee1Kzpi68Oi9Qk5zThr06qbhcXFiqjYWTRcj7
         6/1MI34vH3oTU9W7RpUSQRTh/HNkF5zNG/SZ150UaS6iRK0P77oEFRS0LvjcNMA7IHGg
         FnGg==
X-Gm-Message-State: AOAM531rlWrT8hbqG8OXNjkcIkckYzZkT3uyFLdTiNFrR8LgKbY73yhW
        F6lVxRaafxw1XghZsgGvKK/gv8diJLR9gubliyZ4wJ+gehQrO7PKUGg8xn1CtXMsYR6vJHZDsZb
        ZVSsVH1yJBdYwyZSSoDZMOntt
X-Received: by 2002:a1c:4444:: with SMTP id r65mr3318862wma.127.1622535970405;
        Tue, 01 Jun 2021 01:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPwv1a+CxKaXjYixUbH05GYCGvnq8GVgRrNSQYFBlK8J5refTfKJ/wt/VkAEsC4xSCfTWiCQ==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr3318809wma.127.1622535969749;
        Tue, 01 Jun 2021 01:26:09 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id v10sm2555375wre.33.2021.06.01.01.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:26:09 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] mm/sparse: remove one duplicated #ifdef
 CONFIG_SPARSEMEM_EXTREME
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-7-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <274fb19f-d14c-bb45-b69a-a7c8b4c1722e@redhat.com>
Date:   Tue, 1 Jun 2021 10:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531091908.1738465-7-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.21 11:19, Dong Aisheng wrote:
> Those two blocks of code contained by #ifdef CONFIG_SPARSEMEM_EXTREME
> condition are right along with each other. Not need using another #ifdef
> condition.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
>   *new patch
> ---
>   mm/sparse.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6412010478f7..2905ee9fde10 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -114,16 +114,7 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
>   
>   	return 0;
>   }
> -#else /* !SPARSEMEM_EXTREME */
> -static inline int sparse_index_init(unsigned long section_nr, int nid)
> -{
> -	return 0;
> -}
>   
> -static inline void sparse_alloc_section_roots(void) {}
> -#endif
> -
> -#ifdef CONFIG_SPARSEMEM_EXTREME
>   unsigned long __section_nr(struct mem_section *ms)
>   {
>   	unsigned long root_nr;
> @@ -142,11 +133,18 @@ unsigned long __section_nr(struct mem_section *ms)
>   
>   	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
>   }
> -#else
> +#else /* !SPARSEMEM_EXTREME */
> +static inline int sparse_index_init(unsigned long section_nr, int nid)
> +{
> +	return 0;
> +}
> +
>   unsigned long __section_nr(struct mem_section *ms)
>   {
>   	return (unsigned long)(ms - mem_sections[0]);
>   }
> +
> +static inline void sparse_alloc_section_roots(void) {}
>   #endif

Want to tag that one (endif) with /* SPARSEMEM_EXTREME */ as well while 
at it?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

