Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04643752CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhEFLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhEFLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:12:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:11:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so4504438otp.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZisS9Ulva7KpK75n2bAkZJcSlvsuLumk3tsrhriYebA=;
        b=uKUK3cehn/zJKkiyiX8gotl+aoO6eMUJFSG7duOiQ+kRlw7kTmpecYEgbTuA5XRrxO
         UnEp80Splq9PQ7d2h8HL5B7Y+QNNBIQ2xTYTFwMZrUjlssOSqNBZUfZJCbUG3zKN+U6g
         XW0f4l9qhSGZ+t2GjL0FDcbGKzohKbSbEzLdiKiT72/En6SLyGcHUH51HiWonWpCUBif
         7SpItufGH8PY00IGITTw/YmyOPffoSrafmNFF6nYH+0bdscXxwTTEWwFex79aCScpwRj
         vlOtIF2hhWgUu7P5lFQBXNp3sYlVs93XJEwVPAsraPXdRo00o3zzRVK4R2BatIOQ61Rv
         5tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZisS9Ulva7KpK75n2bAkZJcSlvsuLumk3tsrhriYebA=;
        b=fIgvTxQLLBTfXT/ABXqtF8gD9tIti+YALkhTy1yv7ILEQSxn09Bphy4yetZLnJSArg
         7D65LXBbdIFlvj5OV7v6jTXzDxmXR73EjFXBXGsY9We8KIzRjnc4DtCrMj0KW09q8XAD
         48NKnvx5sitBlWmFjF5rO9koMlf14boS7vfgsibES1/Ji/EM08lFAfGim9QO9LmbdE9b
         udp2/icp44t8n55Z1G+DR6OSBhxm3dDPRw4HaebuvxHTCGXHDs1IOvgnUFU2sEM7k1yf
         XU26T4eqo+HbVDlKCIogEVCvahUUt25S2cLVFarlRm0hf+LEzaj/tYlNSaoynJl0lY1k
         gPCQ==
X-Gm-Message-State: AOAM530jEt6cGe3V4UDt6QbE87TeMZjeuaPrsuunF1tx6sKCtCOXutUd
        H3LmEXDizDrSlCpXYgwUP3lOmTK0Rj14mDVIAhDmQA==
X-Google-Smtp-Source: ABdhPJxmHWClRObjSAP2fFHk3KGBUNfa0dXErsk2+1ExJ1WNCSCENYgMcejrVKspXpAuYnwAE8POb+wK1A5eEKMXGqo=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr3184548ott.251.1620299496510;
 Thu, 06 May 2021 04:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210506105405.3535023-1-glider@google.com> <20210506105405.3535023-2-glider@google.com>
In-Reply-To: <20210506105405.3535023-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 May 2021 13:11:24 +0200
Message-ID: <CANpmjNPY9AHGtuoYxOsB8UQLw4AaT0mY2bt+daKYtnjHE9MKtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: use dump_stack_lvl(KERN_ERR) to print stacks
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 at 12:54, Alexander Potapenko <glider@google.com> wrote:
>
> Most of the contents of KASAN reports are printed with pr_err(), so use
> a consistent logging level to print the memory access stacks.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Prasad Sodagudi <psodagud@quicinc.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/report.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 14bd51ea2348..8fff1825b22c 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -230,7 +230,7 @@ static void print_address_description(void *addr, u8 tag)
>  {
>         struct page *page = kasan_addr_to_page(addr);
>
> -       dump_stack();
> +       dump_stack_lvl(KERN_ERR);
>         pr_err("\n");
>
>         if (page && PageSlab(page)) {
> @@ -375,7 +375,7 @@ void kasan_report_async(void)
>         pr_err("BUG: KASAN: invalid-access\n");
>         pr_err("Asynchronous mode enabled: no access details available\n");
>         pr_err("\n");
> -       dump_stack();
> +       dump_stack_lvl(KERN_ERR);
>         end_report(&flags, 0);
>  }
>  #endif /* CONFIG_KASAN_HW_TAGS */
> @@ -420,7 +420,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>                 pr_err("\n");
>                 print_memory_metadata(info.first_bad_addr);
>         } else {
> -               dump_stack();
> +               dump_stack_lvl(KERN_ERR);
>         }
>
>         end_report(&flags, addr);
> --
> 2.31.1.527.g47e6f16901-goog
>
