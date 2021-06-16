Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF23AA240
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFPRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFPRQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:16:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 132D961057;
        Wed, 16 Jun 2021 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623863690;
        bh=gGNxtrIMT0uPcIyR8xL7dS5gDVNCzQ1ZqRTD8J8gIvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p/kZI+ZWOhiayEBlcBf2UccOGaL25jy8pe1rdAUBymxKat/jCsaj/f4F3Q6ilO22I
         EN8+IUasGACW99XWk4Cn/9uekBving2qHf119B4za/Xfx7K7qeALJZ2DL1TgMbHGgz
         WIAlsEmLWgWh/VwBiVjMGxDyc4qjJKU38hcHT6vuc8EWZCnPBZcHW5XCaamBD9herd
         uVGndzTEf2COP8uzc2xDNsIQZan5Ocuoape1p5yWHt1tmIhtEaxPMvBjcS9QrEQN1f
         VBO7g/Qct2jVSEzRiga6Q5Q3msr63vqAZMCAijmhHc0TITss32v4tsKrhUKsq4goTr
         zYU5RuPWEVZWg==
Received: by mail-ed1-f49.google.com with SMTP id ba2so162307edb.2;
        Wed, 16 Jun 2021 10:14:49 -0700 (PDT)
X-Gm-Message-State: AOAM530zFbmgHLBICL7rr3JM80pjx96V8AUFk3+DYl3KxoYzb1xaMzWH
        sQLRbJmRiHWHtf60DCyqaLdybxyz+gph5ZjXVw==
X-Google-Smtp-Source: ABdhPJwq61+3X+4qez3wdlmtyatLgbakzyl1TT9FSGAsVHgy675FEbepOHWTGBGhpuAbtyiDmfHVHnmUyLpLwDEIrFg=
X-Received: by 2002:aa7:dc4c:: with SMTP id g12mr935084edu.258.1623863688616;
 Wed, 16 Jun 2021 10:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623835273.git.geert+renesas@glider.be> <a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be>
In-Reply-To: <a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 11:14:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXWOb7i8aBOmRhsSUVad=v2r095uw7gFHMqf_+96eEyw@mail.gmail.com>
Message-ID: <CAL_JsqKXWOb7i8aBOmRhsSUVad=v2r095uw7gFHMqf_+96eEyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: kexec: Always use FDT_PROP_INITRD_START and FDT_PROP_INITRD_END
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 3:27 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Commit b30be4dc733e5067 ("of: Add a common kexec FDT setup function")
> introduced macros FDT_PROP_INITRD_* to refer to initrd properties, but
> didn't use them everywhere.  Convert the remaining users from string
> literals to macros.

I'm not really a fan of the defines, so if anything I'd get rid of
them. But the bigger problem is what you brought to light with the
variable size. As I mentioned, we should refactor this and the fdt.c
code to have a common function to read the initrd start and end.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f335d941a716e841..3fe585d5a82732e7 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -318,13 +318,13 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>                 goto out;
>
>         /* Did we boot using an initrd? */
> -       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
> +       prop = fdt_getprop(fdt, chosen_node, FDT_PROP_INITRD_START, NULL);
>         if (prop) {
>                 u64 tmp_start, tmp_end, tmp_size;
>
>                 tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
>
> -               prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
> +               prop = fdt_getprop(fdt, chosen_node, FDT_PROP_INITRD_END, NULL);
>                 if (!prop) {
>                         ret = -EINVAL;
>                         goto out;
> --
> 2.25.1
>
