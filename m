Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2190143769F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJVMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhJVMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634905121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHiQsSRspKzkgF3ZMnWRJhAGzqwtYB2rLteRYpthZYA=;
        b=gmu+xACYrKUBzyqgOLd8PoBrCCRdH0tqWz3oS3QOhVms40IFtYHQYXiBGW6boca41PAIR2
        Klcmxb8XBJPzMSlLsDhnvRxMp1fAi3N4y4+xrCCoQAW3VNMLWae44WtmyNcRxPRfJtEva7
        1tSPBZa8qPFBr4CmdWFLWZUz53dpKKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-WU8VfC0hMnKrc1zqMNDZwg-1; Fri, 22 Oct 2021 08:18:40 -0400
X-MC-Unique: WU8VfC0hMnKrc1zqMNDZwg-1
Received: by mail-wm1-f71.google.com with SMTP id m1-20020a1ca301000000b003231d5b3c4cso1077740wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 05:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eHiQsSRspKzkgF3ZMnWRJhAGzqwtYB2rLteRYpthZYA=;
        b=CZ4AAHqkHRczbC3FHOSwcCkAXSFskUM19c1ftwRw5p5Q9Ld+lzdRBHINe4rIqDtLvS
         TSv8fVRTc+Hd8+0Mx/zNyRF4QNEfGBy1OvHtuCHwiH46t6Ps/8w7W1+wvaQeJhETuA2T
         3oeIHTId4/YCwj+7OIW6x4XaztjIpUgIgYepLQmIwHhHaXvp6OF0TLbbP1SkTX2a3SfG
         8t4pwWf6qaBAp/uTHijBnYf9spGpY5C5/COAXxURoojqIHQqUtbsXYkVJ8m9C9B+q3Pc
         D63UOmOlTsoNSSuWVN0uE9HyQ6NXNusvz2rgYzDxelsdMbUxTYHCsF7/iEM+oJU3ZfNV
         52Pg==
X-Gm-Message-State: AOAM5314oMDU0bW+prvmoGyKZxMJgpkGqUsSluXO4aeyC6Px1mtVPpcw
        WOcq33TAePHbR9n/ejQS4NvHp3yNrIE+Se5VjsoP4yMPvlwfIPblAEs3lfEL4TUGIFeqK/F+k/c
        S1OZFqfK80rutuGsu0SiRWHlo
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr28951357wmq.94.1634905119034;
        Fri, 22 Oct 2021 05:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1ggdZm2CvOd30M4C23buFZImaoTh0+w0fNQ3aG+feIxYnB1S99uNwhCvG27zeEg+egOy1ZQ==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr28951326wmq.94.1634905118770;
        Fri, 22 Oct 2021 05:18:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id w26sm7847817wmk.34.2021.10.22.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 05:18:38 -0700 (PDT)
Message-ID: <f6e7ae53-abd3-a286-bcd6-1d3a2d846620@redhat.com>
Date:   Fri, 22 Oct 2021 14:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] selftests: vm: Remove duplicated include in
 hugepage-mremap
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20211021122944.8857-1-wanjiabing@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021122944.8857-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 14:29, Wan Jiabing wrote:
> Fix following checkinclude.pl warning:
> ./tools/testing/selftests/vm/hugepage-mremap.c: fcntl.h is included
> more than once.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/testing/selftests/vm/hugepage-mremap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
> index 8bc117b12f78..257df94697a5 100644
> --- a/tools/testing/selftests/vm/hugepage-mremap.c
> +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> @@ -12,7 +12,6 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> -#include <fcntl.h>
>  #include <errno.h>
>  #include <fcntl.h> /* Definition of O_* constants */
>  #include <sys/syscall.h> /* Definition of SYS_* constants */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

