Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5A44D5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhKKLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKKLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:23:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A7C0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:20:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4325881pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=VRB9ou2DZeA0o+t18fFALSwlTiVINpnkFyfn5eiRYgY=;
        b=BUquwp4W1x9BwErrd4SWtP7cMmnJ6t+dsDxa2+59/GF+RVn1AW46nl/N7r+lR/hoBf
         NiWmXqxmut5t+ATFAKBnF2IGpOtQ130jkweO1CprUPkD17PJI7ucdtVAodjkeiI/ZhI2
         pJ4TpvoW5jV1t9fPaDI0f7cOYv5ZrTmqnX/8WVVQ2BZ+GQZVUNNU6QbDx/Y4HBwUs2CR
         /fQ3uTOlMyU07GKu3OagU4p+h7KTrrI3HpgGyNeWizrUYbldDWq/5XK8HDUbI6FGvn8H
         R/bERbswzdGdqarF4lyMsuPr2qJ/QTNmJMgrcsvLw4ZBIFm3UZg+YsYos9KsuXTyFL9N
         1V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VRB9ou2DZeA0o+t18fFALSwlTiVINpnkFyfn5eiRYgY=;
        b=i2sX+6C9jS1+J5QM6sWBUdfGW4f7UzoR1oNxPwRYykfGSe/cpwabtc3jgPL0brUUgo
         SadkGzCt8S4bkhoDkJdS2PJw9qkheKFuTLFt0EPNLt5juj8kj6cyouiMF+POTLWYp8bl
         WkbOsBQW86ZSDcxCHZNEGN5v9srFAg1AqecX7leP9HgwM+XkoSo66dWxjF4KZ5EPRCJD
         jKPSTwuURIzZqLIRiOeWVrQDuc169d69REEX66fzHeIOeOjcN06c5DuB6lfGno1BYgJV
         TA5Ol3NoxibkhMnr9EMQS/2rLnR5BttCoFEDr1MQeEEzCxh3ei8poxCLLv27MKhIBBO7
         Crlw==
X-Gm-Message-State: AOAM533yir6BiwRj7IKX6Db8rmn/JpcjfUBqkq07PCn4XLIZOeANP8gv
        9yELmW4JPyF/twIUXknHhhxdbsbwkL+FbBV5
X-Google-Smtp-Source: ABdhPJyMo1QkSdOM03deL7g8FxZKZms+Bek7dLKkLtiFSd7jE9rRK3I83VaSvAusUjMU/Q7j+N4vYw==
X-Received: by 2002:a17:903:41cb:b0:142:62a:4d86 with SMTP id u11-20020a17090341cb00b00142062a4d86mr7081096ple.43.1636629624445;
        Thu, 11 Nov 2021 03:20:24 -0800 (PST)
Received: from Smcdef-MBP.local ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id z1sm2039953pge.4.2021.11.11.03.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 03:20:24 -0800 (PST)
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Ajay Garg <ajaygargnsit@gmail.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211111084617.6746-1-ajaygargnsit@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Message-ID: <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
Date:   Thu, 11 Nov 2021 19:06:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211111084617.6746-1-ajaygargnsit@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/11 16:46, Ajay Garg wrote:
> commit b9d02f1bdd98
> ("mm: shmem: don't truncate page if memory failure happens")
> 
> introduced a PageHWPoison(page) call in "shmem_read_mapping_page_gfp"
> in shmem.c.
> 
> Now, if "shmem_getpage_gfp" returns an error, page is set to ERR-page.
> Therafter, calling PageHWPoison() on this ERR-page, causes KASAN to OOP
> the kernel :
> 
>   #############################
> BUG: unable to handle page fault for address: fffffffffffffff4
> PF: supervisor read access in kernel mode
> PF: error_code(0x0000) - not-present page
> PGD 18e019067 P4D 18e019067 PUD 18e01b067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
> CPU: 0 PID: 4836 Comm: MATLAB Not tainted 5.15.0+ #18
> Hardware name: Dell Inc. Latitude E6320/0GJF11, BIOS A19 11/14/2013
> RIP: 0010:shmem_read_mapping_page_gfp+0xd3/0x140
> Code: 4c 89 ff e8 6f eb ff ff 5a 59 85 c0 74 64 48 63 d8 48 89 5d 98 be 08 00 00 00 48 89 df e8 e5 67 0c 00 48 89 df e8 6d 5c 0c 00 <48> 8b 13 48 c7 c0 fb ff ff ff f7 c2 00 00 80 00 74 30 48 ba 00 00
> RSP: 0018:ffff88806b33f998 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: fffffffffffffff4 RCX: ffffffffb7a37ba3
> RDX: 0000000000000003 RSI: dffffc0000000000 RDI: fffffffffffffff4
> RBP: ffff88806b33fa20 R08: 1ffffffffffffffe R09: fffffffffffffffb
> R10: fffffbffffffffff R11: 0000000000000001 R12: 1ffff1100d667f33
> R13: 00000000001120d2 R14: 00000000000005db R15: ffff88814e64e2d8
> FS:  00007f379a384640(0000) GS:ffff888161a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff4 CR3: 00000000269dc004 CR4: 00000000000606f0
> Call Trace:
> <TASK>
> ? shmem_fault+0x480/0x480
> ? __cond_resched+0x1c/0x30
> ? __kasan_check_read+0x11/0x20
> shmem_get_pages+0x3a4/0xa70 [i915]
> ? shmem_writeback+0x3b0/0x3b0 [i915]
> ? i915_gem_object_wait_reservation+0x330/0x560 [i915]
> ...
> ...
>   ################################
> 
> So, we proceed with PageHWPoison() call, only if the page is not a
> ERR-page.
> 
> 
> P.S. : Alternative (optimised) solution :
> ===========================================
> 
> We could save some CPU cycles, if we directly replace
> 
>          if (error)
>                  page = ERR_PTR(error);
>          else
>                  unlock_page(page);
> 
> with
> 
>          if (error)
>                  return ERR_PTR(error);
> 
> 
> Fixes: b9d02f1bdd98 ("mm: shmem: don't truncate page if memory failure happens")
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 23c91a8beb78..427863cbf0dc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4222,7 +4222,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>   	else
>   		unlock_page(page);
>   
> -	if (PageHWPoison(page))
> +	if (!IS_ERR(page) && PageHWPoison(page))
>   		page = ERR_PTR(-EIO);

How about the following changes since the above if block
already do the judgment?

diff --git a/mm/shmem.c b/mm/shmem.c
index f0eee4e221a7..0c84b6624026 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4195,13 +4195,13 @@ struct page *shmem_read_mapping_page_gfp(struct 
address_space *mapping,
         BUG_ON(!shmem_mapping(mapping));
         error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
                                   gfp, NULL, NULL, NULL);
-       if (error)
+       if (error) {
                 page = ERR_PTR(error);
-       else
+       } else {
                 unlock_page(page);
-
-       if (PageHWPoison(page))
-               page = ERR_PTR(-EIO);
+               if (PageHWPoison(page))
+                       page = ERR_PTR(-EIO);
+       }

         return page;
  #else

>   
>   	return page;
> 
