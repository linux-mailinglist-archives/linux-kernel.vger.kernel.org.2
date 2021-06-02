Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E43984CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFBJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhFBJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622624391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G01wiBaLKBgH8SUhvu9oGDvUb9DEe5X1aND1gEIw1Uw=;
        b=hKuxxa9aN0dRi9J1uEMKv5d2m+qIG8REu7EKa+Rl8i71tR5jmLDJfCHIjAYLDiNjPUhAKF
        gQRG5ixW4nQhQdHWecRVnZw/DR/S4ec3iLa/9xvx3MyBJ3oYIanxYN4alo7x37kYWhPyBy
        ALtiPJyCWHpbpDDJjWNKmUPAWD+iA9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-zwmvb23FO-28UhSOUcWeUg-1; Wed, 02 Jun 2021 04:59:49 -0400
X-MC-Unique: zwmvb23FO-28UhSOUcWeUg-1
Received: by mail-wm1-f72.google.com with SMTP id r15-20020a05600c35cfb029017cc4b1e9faso1906728wmq.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G01wiBaLKBgH8SUhvu9oGDvUb9DEe5X1aND1gEIw1Uw=;
        b=Rp0b+E5XfXTLe/Xsm8BGechUJ5ltMm8+J68Y1pjtJySqS/IAN+lgl08lhqJAjGhy5D
         fBW4iAkl9gmtnjk2P/OVHunabuJaILPC/sIPORFnvJEXCqhWoBGrUBa0EHZnVNr3uYvv
         pCVQwskP2oeQdsccg28T0NDzucxv848c00v8fLCIpheR2GtJWnIznrRm5s9ZpE2IEG96
         Hzwk4wdp4pdTfaaYnpsl6VA05zImwO66czKIdMdiUVN1KJ9DHupr4GVUstIldSIr5gAQ
         UFhdXZrKx+hy8fv9ERZAvrFzW3dL4qmuytYmAUMPYgU62ODt17bsjIo2+FLdiWLT4yYI
         dLTQ==
X-Gm-Message-State: AOAM531jj0lqMX/JomP0pKjf2AxNnAxTmXVJsYfXVeIgwivA9K1yL9op
        av2E1kK7NsHqS51AeCOY6/AAkJpHAaJuWTzAIiU2Uk1d1VN1snU8Vs5K0cJnSzmaaO5BzuDZoFo
        JXT+b+KsiMSCOm4TEAKHEzfHv
X-Received: by 2002:a1c:b403:: with SMTP id d3mr30619884wmf.79.1622624388640;
        Wed, 02 Jun 2021 01:59:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCtRron1WFQC5Hl070ikJ3dyVvR/vrEL+ewi/Nnf7WjDG+gQRJfo9tqov5kPUU764Ml8sA/A==
X-Received: by 2002:a1c:b403:: with SMTP id d3mr30619871wmf.79.1622624388470;
        Wed, 02 Jun 2021 01:59:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id m5sm1982332wmq.6.2021.06.02.01.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:59:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm,memory_hotplug: align code to fit 80 characters
 per line
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
References: <20210602084752.3534-1-mgurtovoy@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d90420a5-ecec-d9cc-8e27-07004701ef94@redhat.com>
Date:   Wed, 2 Jun 2021 10:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602084752.3534-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 10:47, Max Gurtovoy wrote:
> The "if" clause can fit to one line. Also while we're here, fix the end
> pfn print (use %#lx instead of #%lx).
> 

I think the subject could be more expressive. I'd suggest

"mm,memory_hotplug: cleanup alignment checks in check_pfn_span"


Reviewed-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   mm/memory_hotplug.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 70620d0dd923..8c3b423c1141 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -288,10 +288,9 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>   		min_align = PAGES_PER_SUBSECTION;
>   	else
>   		min_align = PAGES_PER_SECTION;
> -	if (!IS_ALIGNED(pfn, min_align)
> -			|| !IS_ALIGNED(nr_pages, min_align)) {
> -		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
> -				reason, pfn, pfn + nr_pages - 1);
> +	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align)) {
> +		WARN(1, "Misaligned __%s_pages start: %#lx end: %#lx\n",
> +		     reason, pfn, pfn + nr_pages - 1);
>   		return -EINVAL;
>   	}
>   	return 0;
> 


-- 
Thanks,

David / dhildenb

