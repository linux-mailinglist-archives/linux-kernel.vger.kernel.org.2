Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C801739CADC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFEUSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:18:24 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:41929 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFEUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:18:23 -0400
Received: by mail-ej1-f50.google.com with SMTP id ho18so8859570ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mjD4/+PVhor5FQTGL1NBpfMmrk3n9PK870plLcDafg=;
        b=gtPYTa4mevejO6eifsz/Bf6nxGrcpbvzhXE/eB2Rj39e9F0LOtV97nu9OpFH15OwKB
         qcWtzmWlw8HYYuPXodgHRF/mso8nhdH5OlVLuC2sEChQKCzruZtWQVG9lucqOsRtGSDC
         ZOW91Qzp9sl66fdTE2Q6P0wQ55ubHEsYDFG1JsvgBhhKuXEA7ZBzZx6MCbGpUNTmy7Pk
         Pvj+o1iqx2uBz/DTC+pF2xa9cR/vZy0e0SyBdrLcf/d7fZ2euRYrZslpTZXAPLpY7nXy
         V/9k9S3AcPqy6WVUC1gugBZwqrixS3mmbRuw5csYC5iA/oEWsrwdDFkExSU6WrFBrm93
         w0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mjD4/+PVhor5FQTGL1NBpfMmrk3n9PK870plLcDafg=;
        b=DM0rQBfHgJONMh0K6DPK8FgwrLSKyeh1+vEaIDbIm4xnrQ1Vr4luIIA+PSvd3SGLZi
         Kf2ZixGgzYIXhDrXk/IDjPtrldmZ8Yu4EW/7q69GH3CspggUD/Rm2GFAnq2BD2gfMsYc
         pN31P6UONIsriJAMQ4kFFCcjvi7mD6gXv4QUbv0PuxnPWSZ71hySAnHCiCmWIy1TuSqK
         VE/OtjiwOlBLc8wN0w2NrAenXwu8SaI/YRmD/zKC/G6NKYgdcUBK7nbbw5Ituv/n0WCZ
         1lJvZXZH/0Fx21YqXkbUHwanEE1pWKIRnsKKsb8XUqOz3zibr9rkA9FNFedc2BpJazFn
         YlCg==
X-Gm-Message-State: AOAM5337HzSzpO7x8ZlLGKo8owLDiKO3VUpPDXtg33yKCugf04TrOnO1
        F8d602knFsksb4TQl8awgmTAJd/7My/sakn8o+c=
X-Google-Smtp-Source: ABdhPJxQXJUSip2KTtQj1xX9V7nhAclVThgh53bHNyVhA8ZbUlsAwoDmsjvdy3x81KiNyseqEHGz7J5/kIIXAcKgKZ4=
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr10485042ejb.227.1622924127566;
 Sat, 05 Jun 2021 13:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210603140700.3045298-1-yukuai3@huawei.com>
In-Reply-To: <20210603140700.3045298-1-yukuai3@huawei.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 5 Jun 2021 23:15:16 +0300
Message-ID: <CA+fCnZewY8MNf1fWaTg0VLwSivEejn1-msRXiuy7WGXApfBJYQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix doc warning in init.c
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 4:58 PM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Fix gcc W=1 warning:
>
> mm/kasan/init.c:228: warning: Function parameter or member 'shadow_start' not described in 'kasan_populate_early_shadow'
> mm/kasan/init.c:228: warning: Function parameter or member 'shadow_end' not described in 'kasan_populate_early_shadow'
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  mm/kasan/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index c4605ac9837b..348f31d15a97 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -220,8 +220,8 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  /**
>   * kasan_populate_early_shadow - populate shadow memory region with
>   *                               kasan_early_shadow_page
> - * @shadow_start - start of the memory range to populate
> - * @shadow_end   - end of the memory range to populate
> + * @shadow_start: start of the memory range to populate
> + * @shadow_end: end of the memory range to populate
>   */
>  int __ref kasan_populate_early_shadow(const void *shadow_start,
>                                         const void *shadow_end)
> --
> 2.31.1

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
