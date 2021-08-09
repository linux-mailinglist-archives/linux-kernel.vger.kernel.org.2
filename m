Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB03E428D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhHIJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234127AbhHIJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628501008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tqsmr63dk3QOS6YBocvZj0OiGi+RFmnPEb+d07EEvDI=;
        b=JNTxU1lK1Y5Rgl8Tqkmiz9Kmgl7uvkh0DhQZ/dpDl3fk+nqu678HvBkDds6uJOhZ7YNgQa
        yla4UxuovPbYDy91TZ5B5EAn5bfMYS51c418JNOL/SgA6b/uBE+tUAxpKWtPmzntuc7gaU
        z5d4nHRza7BULaH+h2a7vp0nfV0252g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-OrKKCADkOB6U4ke4a3Q2yw-1; Mon, 09 Aug 2021 05:23:27 -0400
X-MC-Unique: OrKKCADkOB6U4ke4a3Q2yw-1
Received: by mail-wm1-f70.google.com with SMTP id i6-20020a05600c3546b029025b0d825fd2so4413837wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tqsmr63dk3QOS6YBocvZj0OiGi+RFmnPEb+d07EEvDI=;
        b=gFaH+8Nwp8SGe+cfx6gXhh8+u9Yck7zoWDl4JiPtzHoPOvEf2q00XsJJt7GMsntmFl
         t1jZ+UuKUk73qG9wZeu74hDAf9zThtWfHqDNHJ6fGDH6XS3LhFaY/KxnRNf6yLgQkAkb
         PTi2Esoq36djdlHdXWeCjBOFZxwIlavRAbI2ljXOVMrIYb7TEuwFKK/zxr8A7pNHsTyU
         1O8ueAYpNBGi6M6L5hzmts9uSKwPy1ZOftZ7HXmlUrOvRC9VOtFa/2ILXHunUvRIIksa
         4+Shni+yt+9yZPiqGSTIxICxZMKNzwdVLStNFPCfdqlvieA5Wom8TC2EHIoIm+bbogi9
         01Ww==
X-Gm-Message-State: AOAM533sPcy2tfei7F1giq7Un+l0L+BoOmd7USRd4206CQxhxBbeMlqW
        h0KIrCtCw+0K9vepOfDiy8Hwsn6kNXcVF+ZZVUcXgxDW1VkKwZYMfoPqLl+2LS9Sbvy3EZeTnfO
        BIi1cggDFcOzYOd+u3LRj6K+RkFNTZHH46dVSpslMpcWfioMGN5PHz7cu6gvBQPkFgu9yX4UL
X-Received: by 2002:a5d:5090:: with SMTP id a16mr23943025wrt.21.1628501006223;
        Mon, 09 Aug 2021 02:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEA9BDbCYAI6EyW3qhL1UmohheJCWcY+ZJDhITUst2nr3WsmZSk9wLNC/sjhqCIHH8khh5Sw==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr23943008wrt.21.1628501006053;
        Mon, 09 Aug 2021 02:23:26 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id p14sm7851740wro.3.2021.08.09.02.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:23:25 -0700 (PDT)
Subject: Re: [PATCH 3/5] mm: gup: remove useless BUG_ON in __get_user_pages()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, kirill.shutemov@linux.intel.com,
        jack@suse.cz, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210807093620.21347-1-linmiaohe@huawei.com>
 <20210807093620.21347-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bc5fc4a9-dcb1-c79b-9a7a-0375b7c2ec7e@redhat.com>
Date:   Mon, 9 Aug 2021 11:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807093620.21347-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.21 11:36, Miaohe Lin wrote:
> Indeed, this BUG_ON couldn't catch anything useful. We are sure ret == 0
> here because we would already bail out if ret != 0 and ret is untouched
> till here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/gup.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d6056dcab02c..d7e4507de6b1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1149,7 +1149,6 @@ static long __get_user_pages(struct mm_struct *mm,
>   					 * We must stop here.
>   					 */
>   					BUG_ON(gup_flags & FOLL_NOWAIT);
> -					BUG_ON(ret != 0);
>   					goto out;
>   				}
>   				continue;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

