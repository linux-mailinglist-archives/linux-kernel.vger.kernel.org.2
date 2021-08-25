Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0B3F70F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbhHYIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhHYIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629879369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3kk85j4W9zJim+yIZCUmng/KT5kpvGwAKM1Z2j0VRA=;
        b=UV+0Jf066thbaocrcyglTp58jqLFHUhgM43+FI9KR/gfCL/QK34gGuEOIFgbUbNAqzYJd7
        8DAmqx4cALeH6pEOddhG/QPzFUxcsUQBF616Hc//28uHgV/NzQhMJXiuaOtHSTL/d6j7z/
        Fdq4lrFnB0Gp0DXlnf8Q6jXKPmfGVFg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-0dEVbDfLNZCrJrEGg44gsA-1; Wed, 25 Aug 2021 04:16:08 -0400
X-MC-Unique: 0dEVbDfLNZCrJrEGg44gsA-1
Received: by mail-wr1-f69.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso6326201wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W3kk85j4W9zJim+yIZCUmng/KT5kpvGwAKM1Z2j0VRA=;
        b=SZ/elFxr8O4+PgFrWLjPFdkPpCg+pOCBfJWkPnom/IdgrU9aU6pwz1IWuj1X+bcG2m
         ifkSC+VVElgom1G2J4vCOfnMDLC0OSq+WffA+Euir/fNaOwxSYUGSeJcQxt5eOnpQNO/
         Xc43SGn68MNXwofHVCyBiNdM0wWTrBeHRxvbHbSYHwTYpLapO5bDV97Dv4aCMDJ92hhJ
         uzNm4XrdRv98uusln2gB8non33iq3T/RoPRxsbDnw20hBCBzI2h8flUPKdi5H7AGKSlS
         nxnGLdhmB36fu9G8ixqRhGLpCIQ4sudjIolwPwzoLqFwi62nR34vHqR/SvwFoGZqq9GC
         MDjQ==
X-Gm-Message-State: AOAM530JkA0c7P3scrclbVdJDRts272DvWjb82IRLQSMkk82ePCTn/HB
        o+gqKfR0Y/C2t65ziK013g9OfwU2sBai1cTEbeUrrvEqKkBQ1aFYSX0yQWhC3j+QwPyOIxgo1Lr
        95vZJEI4WwJMQCcsYE33TRLmidgXinE2vSGD2fIAaCRjVfqYCOW34GJqmLPC48mFAimUkQlrL
X-Received: by 2002:a1c:a94c:: with SMTP id s73mr8209351wme.12.1629879367328;
        Wed, 25 Aug 2021 01:16:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Vti2X7N4d7BWUb73EOFI18iWBQZPD2EE+9uTQhf4cSJLgUwfjGXyklR3giymkJ29/W45mw==
X-Received: by 2002:a1c:a94c:: with SMTP id s73mr8209321wme.12.1629879367093;
        Wed, 25 Aug 2021 01:16:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id n14sm10153000wrx.10.2021.08.25.01.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 01:16:06 -0700 (PDT)
Subject: Re: [v3 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
To:     Yang Shi <shy828301@gmail.com>, naoya.horiguchi@nec.com,
        osalvador@suse.de, tdmackey@twitter.com, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210824020946.195257-1-shy828301@gmail.com>
 <20210824020946.195257-3-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <32d21645-699e-09a8-9c77-67c448e1037b@redhat.com>
Date:   Wed, 25 Aug 2021 10:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824020946.195257-3-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.21 04:09, Yang Shi wrote:
> Currently just very simple message is shown for unhandlable page, e.g.
> non-LRU page, like:
> soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> 
> It is not very helpful for further debug, calling dump_page() could show
> more useful information.
> 
> Calling dump_page() in get_any_page() in order to not duplicate the call
> in a couple of different places.  It may be called with pcp disabled and
> holding memory hotplug lock, it should be not a big deal since hwpoison
> handler is not called very often.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> v3: * Remove redundant pr_info per Noaya Horiguchi
> 
>   mm/memory-failure.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7cfa134b1370..5f8249e4d7dc 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1228,6 +1228,9 @@ static int get_any_page(struct page *p, unsigned long flags)
>   		ret = -EIO;
>   	}
>   out:
> +	if (ret == -EIO)
> +		dump_page(p, "hwpoison: unhandlable page");
> +
>   	return ret;
>   }
>   
> @@ -2205,9 +2208,6 @@ int soft_offline_page(unsigned long pfn, int flags)
>   			try_again = false;
>   			goto retry;
>   		}
> -	} else if (ret == -EIO) {
> -		pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
> -			 __func__, pfn, page->flags, &page->flags);
>   	}
>   
>   	return ret;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

