Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9F3AF73C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFUVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:15:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD42C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:12:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso336406wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upvJpvDpbG36lybZTu/zbziqkwcTUN98yBpQxBCEitg=;
        b=hf+vylHfbpjAIwbuZig8AcBZtFFtvpuwLgWAK0xAEED/S5f1QpyJfhap+NUYBxp70/
         Nc7A/WjM8Bc2d9Q8J33prbp8JL4si1X81VnrkY2y2G/loIUkHEjHNpcQWZmmh0OWb3Hm
         aor+B/U0oMYwdpDpoBRALi9B4mIHovTQodZ/Vshg9lZR63EAHP5Xyf3kSTgNqcLYLRtx
         loRrTLKRuBfMmk988NCNrBISy/3kD5A2GL8vVJDEi8YLuvMQsgByW5scN0TQ2X6ylGWt
         FBj9+3Injm6ZcQ/fS8BVG5S0Anlut9UOdr3voyWMMfukw6Y31hc1PO7Wdt+xhnUk/hGo
         o6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upvJpvDpbG36lybZTu/zbziqkwcTUN98yBpQxBCEitg=;
        b=SyInmurlCHFU6zPCp6uv+CwBwYNODFCpwVKb5/HY9gRoiihbmhM7r1p2Jzn9PFbHD7
         WBth21Xhcxgp4SzL9/lRamOM7rwsYgUBm0Kep4G/2sF8zFI2Mt+SX3wP2wLH3Yut9I+J
         MAnto9hBNEbG/QAHLbZXEd5nK5M9P/2HWI9RGp1HWTcuDgK+DN1/UvSamu4LvBLbHi6D
         5/K2sqS4NDr+yRMNqRF836ojj6dx3cfPh0zeJwhO+IvBj+ss94igietXUE19ymycN75P
         0u06d+a7pQnne7ekm+eCxG33H8EIMX5/OIp7c7p+x2OfjSA3EYxRkvdLI0MYOAFLZo+e
         E5hQ==
X-Gm-Message-State: AOAM531lhGIj+6E1dOWPDah6+2rko/sYzYsGxfkyPCu38sZWk/J+aZ2e
        C7hqs9XOg3iOPpwFSYToz4fRkg==
X-Google-Smtp-Source: ABdhPJzoJ27v5/nqDbjYHYDBMk/Q/eg/sb9hrdfFgYFn85qOt8APwAF+5cbaV7FQJDbDYm11JkDj0g==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr561369wmo.36.1624309966480;
        Mon, 21 Jun 2021 14:12:46 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v8sm20023786wrc.29.2021.06.21.14.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 14:12:46 -0700 (PDT)
Subject: Re: [PATCH v3 13/23] mm/mmap: Make vm_special_mapping::mremap return
 void
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-14-dima@arista.com>
 <901f4541-ee96-5d6b-5453-559731d65e82@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <e8b98439-6e53-b3ac-af78-bb814292349e@arista.com>
Date:   Mon, 21 Jun 2021 22:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <901f4541-ee96-5d6b-5453-559731d65e82@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 8:20 AM, Christophe Leroy wrote:
> 
> 
> Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
>> Previously .mremap() callback had to return (int) to provide
>> a way to restrict resizing of a special mapping. Now it's
>> restricted by providing .may_split = special_mapping_split.
>>
>> Removing (int) return simplifies further changes to
>> special_mapping_mremap() as it won't need save ret code from the
>> callback. Also, it removes needless `return 0` from callbacks.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>   arch/arm/kernel/process.c | 3 +--
>>   arch/arm64/kernel/vdso.c  | 4 +---
>>   arch/mips/vdso/genvdso.c  | 3 +--
>>   arch/x86/entry/vdso/vma.c | 4 +---
>>   include/linux/mm_types.h  | 4 ++--
>>   mm/mmap.c                 | 2 +-
>>   6 files changed, 7 insertions(+), 13 deletions(-)
>>
> 
> Build failure:
> 
>   CC      arch/powerpc/kernel/vdso.o
> arch/powerpc/kernel/vdso.c:93:19: error: initialization of 'void
> (*)(const struct vm_special_mapping *, struct vm_area_struct *)' from
> incompatible pointer type 'int (*)(const struct vm_special_mapping *,
> struct vm_area_struct *)' [-Werror=incompatible-pointer-types]
>    93 |         .mremap = vdso32_mremap,
>       |                   ^~~~~~~~~~~~~
> arch/powerpc/kernel/vdso.c:93:19: note: (near initialization for
> 'vdso32_spec.mremap')
> arch/powerpc/kernel/vdso.c:98:19: error: initialization of 'void
> (*)(const struct vm_special_mapping *, struct vm_area_struct *)' from
> incompatible pointer type 'int (*)(const struct vm_special_mapping *,
> struct vm_area_struct *)' [-Werror=incompatible-pointer-types]
>    98 |         .mremap = vdso64_mremap,
>       |                   ^~~~~~~~~~~~~
> arch/powerpc/kernel/vdso.c:98:19: note: (near initialization for
> 'vdso64_spec.mremap')
> cc1: all warnings being treated as errors
> make[3]: *** [arch/powerpc/kernel/vdso.o] Error 1
> make[2]: *** [arch/powerpc/kernel] Error 2
> make[1]: *** [arch/powerpc] Error 2
> make: *** [__sub-make] Error 2
> 

Thanks for reporting, Christophe, I'll fix that in v4.

Thanks,
          Dmitry
