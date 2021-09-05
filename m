Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123140115F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhIETaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237960AbhIETaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630870148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJhftX7KdnJxCNtt1OcYAAeR/bKh9VnXaLjpPXlfeQg=;
        b=O43qjVAbiztNSzIbDLga1y08fwGXtq1jsPevoJU/dt04djclkj8YjvHbNsHOcVXG8zoLer
        1dVnohQSAfmM42VTq/Ep+sV29rJ2a1MCM/6vhVLkYm5LXeGWM1T/QN/lcEE4r0TJpWSflu
        7RIw5wHw0gswG6eRgcb2bFyS5fwtbHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-N-AWEltePF6x0e5azDZmIA-1; Sun, 05 Sep 2021 15:29:07 -0400
X-MC-Unique: N-AWEltePF6x0e5azDZmIA-1
Received: by mail-wm1-f69.google.com with SMTP id m22-20020a7bcb96000000b002f7b840d9dcso2340974wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 12:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VJhftX7KdnJxCNtt1OcYAAeR/bKh9VnXaLjpPXlfeQg=;
        b=kBkwNCIoHYwbPWu2A+ELcKl4VVXg2HzP5BG4vAaNj55Y1w8PTqXQ8pJVa4WM+46QLq
         ZZPFCuKWP9Wo2/GNYQzmhWLVkSoi/pLSvglA8Ye3wHvzngp1xuSOv5OdkGhey5/JhxWj
         iSn5Sv629gA/qr8lyNoMzKeq/Rr5x41C9DZSngzglYZVX2XRl7GothbY+O+tJ+iNN5yR
         QwJ8pnIMuDSw4O5EfqyhpFwyirs0jM9bHsTrqD9OePcXsVYdONX357hTmXr9s3RAFV/a
         88GwnIXTsSjRO/eVH0mPohfxIlubNvnYCsltwD7vodBPPVf+fJRnOvkuZnq9HGy4dL2m
         rp7A==
X-Gm-Message-State: AOAM533IOR3G4/Rlh7DVH0q1uuv7u7BKBTEfA4JxM5vhfnsMjrOg6U6a
        EwhdNWwc+wL68Tc+Ypmixs5wFUX32mLZrE/WYOuJtrNKrS0NaghQZafNJQTYgwiKOV8Z8pyu/pI
        wVXJ/iU83MnFIae6zgguTpUua
X-Received: by 2002:a5d:438a:: with SMTP id i10mr9720552wrq.285.1630870145993;
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu2FTA+hrPwFqGf7dCn9mHcjQyvE9QSkO6Avx438vyzALqkqRc4eOOXzTeN2CgcYcEllBK9w==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr9720544wrq.285.1630870145830;
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6f04.dip0.t-ipconnect.de. [91.12.111.4])
        by smtp.gmail.com with ESMTPSA id l7sm5166459wmj.9.2021.09.05.12.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
Subject: Re: [PATCH] binfmt: a.out: Fix bogus semicolon
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
References: <20210905093034.470554-1-geert@linux-m68k.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7a9e8a5e-df3d-0ecd-1396-450b50ce2937@redhat.com>
Date:   Sun, 5 Sep 2021 21:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210905093034.470554-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.21 11:30, Geert Uytterhoeven wrote:
>      fs/binfmt_aout.c: In function ‘load_aout_library’:
>      fs/binfmt_aout.c:311:27: error: expected ‘)’ before ‘;’ token
>        311 |    MAP_FIXED | MAP_PRIVATE;
> 	  |                           ^
>      fs/binfmt_aout.c:309:10: error: too few arguments to function ‘vm_mmap’
>        309 |  error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
> 	  |          ^~~~~~~
>      In file included from fs/binfmt_aout.c:12:
>      include/linux/mm.h:2626:35: note: declared here
>       2626 | extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
> 	  |                                   ^~~~~~~
> 
> Fix this by reverting the accidental replacement of a comma by a
> semicolon.
> 
> Fixes: 42be8b42535183f8 ("binfmt: don't use MAP_DENYWRITE when loading shared libraries via uselib()")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   fs/binfmt_aout.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index a47496d0f123355c..0dcfc691e7e218bc 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -308,7 +308,7 @@ static int load_aout_library(struct file *file)
>   	/* Now use mmap to map the library into memory. */
>   	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
>   			PROT_READ | PROT_WRITE | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE;
> +			MAP_FIXED | MAP_PRIVATE,
>   			N_TXTOFF(ex));
>   	retval = error;
>   	if (error != start_addr)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for reporting and fixing that quickly!

-- 
Thanks,

David / dhildenb

