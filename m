Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0892644DB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhKKRsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:48:09 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F1C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:45:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso10056330ote.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+LpyPIoZTKI9UToEAiLTdSPomWKgk1C2icqdbicCgnc=;
        b=BW/VDT7VHtQPLLVudjdLklsUw34VamOFBVSTwdoSlF7QOfMR7lBmwsh1DKV/DK9SxW
         XCITELNN+LNqajmFI2m48h24/wdW2G0RcmKu82cdQgWQWDPUd+8lWnhO1gnhF7l+GpTg
         VJW5w/TQFbA1S2hoqV+dfjBG+BtiyvHecv5pI/yXDJWWaYkcGgPQAzwM7cM3Nx3wr8Hz
         EUs0liLj9LiSFWn3GX6tZAzalCdxjMbbNQ/RwTAufZObjl00kBSWzVv54CiifK8CMOsc
         3ZwNj935wD+J9OtFontXTgRjZiQSsYRKM25DP1PkXhf0d1tXCCiJ1g6/htrOBcgG75WV
         Jfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+LpyPIoZTKI9UToEAiLTdSPomWKgk1C2icqdbicCgnc=;
        b=ikr1IzRB3l8iNEyQgh7fhTcXotUyhXP3TmjXNikFPJOBPEXpeAI57ixqpi3xwUu14u
         ZiYq2tkrWvbcTwHm1ZbNWiAGg+uWT6SUNduwGy45N9+fMYiDJY19tWoiB0aNyhCOMA4J
         qeI7ofUfnnZvLCl7Vsh1BdqNVkSSHayhgqI5ojlCbxuGSwM/YUP1dSlft/s157g3vvll
         UX3zwXTzGAfmts6lJPapWvJxN2dmMoS1pPsyT4udA5X4oaV0aPTqFBBaEf0UV6Mdq64e
         J10iiB5YXuGf3wxVqnIDWvVsrT39mtg9ZHq5qNubMVuXktL/klqW3LnNTzSmIf+sVSJ7
         Z1tQ==
X-Gm-Message-State: AOAM530JBAANFo4t+tHzFF1TxQ/qeqSCTJDmHWWQ/JUP9hzDD4f0+KRs
        gRzuCt74qxGUTQqECUTVySGxkXAOH0bVPNWK+bc=
X-Google-Smtp-Source: ABdhPJwhU6/85AHCrZderRz4f6gsysgalGuYs3mFuR7mgKdtwcALY5Qo7BvzSgkqqCO8XL0+K9WK3ay6Ery7UlUHR9c=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr7305130otq.173.1636652719114;
 Thu, 11 Nov 2021 09:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com>
In-Reply-To: <20211111084617.6746-1-ajaygargnsit@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 11 Nov 2021 23:15:07 +0530
Message-ID: <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another report of the issue (different call-flow, but the same error
at "shmem_read_mapping_page_gfp") at :
https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m52d98b6bdb05764524a118b15cec048b34e5ca76

with a tentative approval for the patch :
https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m24c2888a879d428cde5b34c43838301de544eb7e


Thanks and Regards,
Ajay


On Thu, Nov 11, 2021 at 2:16 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
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
>  #############################
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
>  ################################
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
>         if (error)
>                 page = ERR_PTR(error);
>         else
>                 unlock_page(page);
>
> with
>
>         if (error)
>                 return ERR_PTR(error);
>
>
> Fixes: b9d02f1bdd98 ("mm: shmem: don't truncate page if memory failure happens")
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 23c91a8beb78..427863cbf0dc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4222,7 +4222,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>         else
>                 unlock_page(page);
>
> -       if (PageHWPoison(page))
> +       if (!IS_ERR(page) && PageHWPoison(page))
>                 page = ERR_PTR(-EIO);
>
>         return page;
> --
> 2.30.2
>
