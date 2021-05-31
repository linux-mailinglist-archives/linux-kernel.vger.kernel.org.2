Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852EE395673
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhEaHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:47:20 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46054 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:47:19 -0400
Received: by mail-ua1-f49.google.com with SMTP id v27so6113384uat.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaxE3fD8H23OALzlaGt5xj+WmeW2E/aK7daDLonsjCo=;
        b=OJZFj9uMeDB95KBh1345ODSZp/sZzXhskl4VQp2raugrsEb7JYCbLaD4A7fs7YYJ+G
         U+r1wLF5Wi2pPBVxl2qpGqYC/orD3FoXf6PYczJf0LRJ0Ojfrpuxg0gmDXyaA4x6XjvK
         nH0aVZQfSQcUkRA4+QksGf4dwTIpgeoaDGiKvBahDSKgrZww4FQfpObEAuwfkX3LbsRz
         UP2Itn58S4L17cJ1gElTNRNJpCJMHMwPuMVVYVg94Fk+pTA1bEtSPjUtts+CaKF2E4SM
         RQOgxLIHjnuKcu55GGw3lSGeesB9gA5t20hHAV30p1lailMYd5psNQAHvbkql+rfgOr7
         EiiA==
X-Gm-Message-State: AOAM5336lH9QT8TwWSbcFE4c/RYt+HNpB0BRHl/crikwrBXdAfL8gkhX
        pL2TM2q3Sbxlx5wDaKd97bywSKdAuQFM3fcjjJ1zDIJi
X-Google-Smtp-Source: ABdhPJy2kkpoYUAcxC++APXvfiXcAprziIIsOO9DJCAw8TXNS3bqG8T/K6ce6EelZLh8WwxpD2PxR1FnR9jeURcSGcY=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr9872331uab.100.1622447138430;
 Mon, 31 May 2021 00:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com> <20210529105504.180544-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-2-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:45:27 +0200
Message-ID: <CAMuHMdVHCFiwVUq9jBobw0adwe9-x3AUB8cSxrf6gHnQTfUMTA@mail.gmail.com>
Subject: Re: [PATCH 01/15] mm: add setup_initial_init_mm() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Sat, May 29, 2021 at 12:47 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Add setup_initial_init_mm() helper to setup kernel text,
> data and brk.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for your patch!

> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -564,6 +564,16 @@ struct mm_struct {
>  };
>
>  extern struct mm_struct init_mm;
> +static inline void setup_initial_init_mm(char *start_code,
> +                                        char *end_code,
> +                                        char *end_data,
> +                                        char *brk)

"void *" (for all four)?

> +{
> +       init_mm.start_code = (unsigned long)start_code;
> +       init_mm.end_code = (unsigned long)end_code;
> +       init_mm.end_data = (unsigned long)end_data;
> +       init_mm.brk = (unsigned long)brk;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
