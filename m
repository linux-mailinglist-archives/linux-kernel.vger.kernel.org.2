Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E409940AC58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhINLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhINLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:25:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB323C061768
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:24:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s12so23216055ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cp0SQvp2N+xoe5C9OTNfUx9zbpD4P6j+IayB6VA30bk=;
        b=swnsW5M61hgulyulsIRu3aI3c5JyOHo1hV1BavL7cNd27JSmoAFdOmDyll3HQ+PKwA
         do8l1rDRqZmoPpoMAtu5qvL8wektf5sqsuE7k+qr0J0fVhYytZgixfBXDAmEMq8kAH/F
         pcHIRPN4ZC582Hgq2iITsA2M9JuBwvfDeR1Q03lkXWIvo2higY1eDlridEWIdGpqTrd3
         8wfWcyEXeuT0bhRb/+n2Gcm0SrWajWSw5Ti0eetW0Lw48BaiArItYRrO9I4JQORqbWvB
         6VargJN8dBi0DgoEyHfj/Eq+3Ft3CqUhBf+p0olPNckb4JjFdAcJiI5bnLOnZoaitVFs
         hCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cp0SQvp2N+xoe5C9OTNfUx9zbpD4P6j+IayB6VA30bk=;
        b=gBXUo5lbJfa73kZ2BAjEEsJhrqRS08NnddKG6t35r4erwLvJl9R58woSNStOVCh9TT
         6rRH7HnhW4/GuikOkrd04LumODW+KZSS+MNNcOMjR/IgJBjOdMGE8X+vSE+pj7L1YQm3
         rAGQkVM0HwcMvORj9oPVIAwVSXI7+K9Gr0T2vvktfp5lG4k5FuIeaRtjkDfrZsjL4Ips
         TURPnVxmUYkOYY8KGR19SWQuI2KZV+WeVluDGM7GXjE6ElwlBoUbconBoeK6JeEx4GVi
         kgGmn8XTfO+PenaH3Rbt/ia3du5LlfbTyFNVhmn/XjErOEpt54eH0IkDEqddB9/CWaTD
         Fsyw==
X-Gm-Message-State: AOAM53339DwfankGj5TmWb0RSyPKu+qgfA9pcUZMETKqxtxDu+kvRW6u
        49oxarnUCWB593YwJBKbs3e/vjQd1PRzL2wJYDbIwg==
X-Google-Smtp-Source: ABdhPJzf1cZ1haIuWx4qetdhB8fMA2L7nDxmvcpl12S8Bc/zLJ7IB1YUa/nTacFTu/yJmy9Nj89xbQhPxJ3NScN0wIc=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr14814634ljn.367.1631618672323;
 Tue, 14 Sep 2021 04:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210911131933.2089-1-len.baker@gmx.com>
In-Reply-To: <20210911131933.2089-1-len.baker@gmx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:23:55 +0200
Message-ID: <CAPDyKFrmSOWF4CsRApq58PVtp2XDfwsBFCYs4vHDDatQHQAA+g@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: Prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Kees Cook <keescook@chromium.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sept 2021 at 15:22, Len Baker <len.baker@gmx.com> wrote:
>
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
>
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Len Baker <len.baker@gmx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index f9a93b0565e1..a7a0f0caea15 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -927,8 +927,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
>                 goto err_out_int;
>         }
>
> -       jm = kzalloc(sizeof(struct jmb38x_ms)
> -                    + cnt * sizeof(struct memstick_host *), GFP_KERNEL);
> +       jm = kzalloc(struct_size(jm, hosts, cnt), GFP_KERNEL);
>         if (!jm) {
>                 rc = -ENOMEM;
>                 goto err_out_int;
> --
> 2.25.1
>
