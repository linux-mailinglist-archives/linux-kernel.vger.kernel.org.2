Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7C429E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhJLHDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhJLHDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634022093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcxrlQUjq8xG8UjdON0+Dxic3MPMUmRwzuZ5LLezMSM=;
        b=Or9BG3DFuI9yT/Fepwa9K/awRj3J5ORR34B4VzNDy9Ena9Wm8VzCV+8iDiXIpdxa/Zb0BO
        miTjVXcdnSisZczfFHXH4O1Y1e4rtQt1lvz83s+IiZiPb3JcCUqequjDjO3B8HOXNlMDb6
        66Z0lYXm05y9J5Z/JWtGJXTy4GBe0uA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-9Ul297AtPR-voeFmK9YgYA-1; Tue, 12 Oct 2021 03:01:32 -0400
X-MC-Unique: 9Ul297AtPR-voeFmK9YgYA-1
Received: by mail-wr1-f69.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so9193619wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JcxrlQUjq8xG8UjdON0+Dxic3MPMUmRwzuZ5LLezMSM=;
        b=6PlU5NB4kENEgm8s0WDXG1pLAOGneQSXaPVkNKRyY1qxyG++6oplVaoa17aWntypNk
         j+2JwKd5KbTUttXzchZhkAx882Q0vlKcQ3a0pxuc2V4hnD0e/jCS+pEL3h2+DYU4wro0
         3HXUKdf3hprQK5287tdhcYcbNrcrGiucqyW/TA8d6tc4iGNg0+sq54GpqWL4GhKNIVMk
         bcsVwYJ9DsceH64ZRCra3mf3cO6vxFACt7DLbgg+uE4oIhRDtDVHaYPWpFwaJp8im3Gk
         uFTZ5GV7YCXOt3H6J70jyCEhAzE/Hw/fPptJkuULNKzD5c/xv9ODVL3G1oWzBGITe1zt
         Ad8A==
X-Gm-Message-State: AOAM533aWuUdqAjaSPFeDTz42y1Z+B4CqNR8ZMRqsQbUmJKlDB9rKOtj
        K1SAYAetL9YzyeW8D++6rtucbzwwVnc4NwLYxVUTUO1ePKQ4hOHK1hXRfTZZW1r+PmVR3nJVNjP
        /2SW1nFCjUNt2c/UxAxRtTx9J
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr5574656wrx.192.1634022091328;
        Tue, 12 Oct 2021 00:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXA3U+5ahCYPei3Bm6Mik/omjluNny8a69EmIkoT8VpaGZsKzd7/MpKs8SD1TjSeBkDCKxBw==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr5574637wrx.192.1634022091169;
        Tue, 12 Oct 2021 00:01:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a12.dip0.t-ipconnect.de. [91.12.106.18])
        by smtp.gmail.com with ESMTPSA id r9sm9403871wru.2.2021.10.12.00.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 00:01:30 -0700 (PDT)
Subject: Re: [PATCH] Fix application of sizeof to pointer
To:     davidcomponentone@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20211012030116.184027-1-davidcomponentone@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3ee52f17-0357-a99a-352e-424bfcc07f27@redhat.com>
Date:   Tue, 12 Oct 2021 09:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211012030116.184027-1-davidcomponentone@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.21 05:01, davidcomponentone@gmail.com wrote:
> From: David Yang <davidcomponentone@gmail.com>
> 
> The coccinelle check report:
> "./tools/testing/selftests/vm/split_huge_page_test.c:344:36-42:
> ERROR: application of sizeof to pointer"
> Using the "strlen" to fix it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>   tools/testing/selftests/vm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> index 1af16d2c2a0a..52497b7b9f1d 100644
> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -341,7 +341,7 @@ void split_file_backed_thp(void)
>   	}
>   
>   	/* write something to the file, so a file-backed THP can be allocated */
> -	num_written = write(fd, tmpfs_loc, sizeof(tmpfs_loc));
> +	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
>   	close(fd);
>   
>   	if (num_written < 1) {
> 

I think the code really just wants to write anything to the file that 
will be >= 1, which is also the case with this weird usage of sizeof.

As an alternative, I think we can just write anything else to the file

num_written = write(fd, (void *)&fd, sizeof(fd));

or

num_written = write(fd, "1", 1);

If I am not wrong/

-- 
Thanks,

David / dhildenb

