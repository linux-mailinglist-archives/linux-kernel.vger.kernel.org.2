Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258C40494B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhIILae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234507AbhIILac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3081161179
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631186963;
        bh=B88nJMsUOPeeM3syqtdV2g1zTgLHqRhB/pjL3W3dR5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ghr7h04XfsU7LC6CWR2AjKsU9Oql04NG20NZ6j37l2kilK3XQLdNcbTZ6YG6x+e/d
         jvLOQ2ez1lvxzTzXGSUF+Wh0uuGxeKZc1RNYGjN4LsNATulwv2IIqgRRm91mIAh08H
         5FAFj0DQ4JDl7qMYdSmtxxRdl22DN7WUzxZl0H10p4nlPR6zyJbVMnbMhyunM8LISk
         xtmgKDAPMgPHZ/8KzodxLurT+TqDj19uisrUT2SOkPTLbOfNm/WZ2Nh+VrbXsNuN5S
         AsWLTeZ/FdZ2PXnGRuAPAEfZMsiHDKqXsk+jFwLmU8NrQhX16LFgrmw9Ot35yh+880
         5+68F7QYrrwiA==
Received: by mail-ot1-f42.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso2084743otu.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 04:29:23 -0700 (PDT)
X-Gm-Message-State: AOAM530pb1vTJc5EeiWm/Bof/q6qP9pxxYCDvQhAB25IqK4miRA19Q5u
        BHpu1+rlzelCroeYql/ihsxtuzKbr7XYSqctA5s=
X-Google-Smtp-Source: ABdhPJz6gU2OA+HXzocssCGpcN9DU79PvRHUT66SBpt6BafNfEygcUGPpXMOd6nSxEK7EpqAZcYz1g29bDuvDl2lmAI=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr2023081ota.30.1631186962496;
 Thu, 09 Sep 2021 04:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210907145652.63362-1-bert@biot.com>
In-Reply-To: <20210907145652.63362-1-bert@biot.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Sep 2021 13:29:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGej8Ps425A-UXmW19B45_EP89-YzpwdOYQ1C-DOVLvUg@mail.gmail.com>
Message-ID: <CAMj1kXGej8Ps425A-UXmW19B45_EP89-YzpwdOYQ1C-DOVLvUg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: decompress: Use /memreserve/ DTS nodes when
 validating memory
To:     Bert Vermeulen <bert@biot.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 16:57, Bert Vermeulen <bert@biot.com> wrote:
>
> If the bootloader needs the start of memory to be preserved, for example
> because it dropped the Trusted Firmware blob there, this chunk of memory
> shouldn't be used by the kernel.
>
> To avoid adding yet another SoC-specific text offset to arch/arm/Makefile,
> this patch allows for a /memreserve/ entry in the DTS to mark off the
> memory chunk instead.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

Thanks for working on this - I hope this will allow us to phase out at
least some of the existing text_offset hacks too.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/boot/compressed/fdt_check_mem_start.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/fdt_check_mem_start.c b/arch/arm/boot/compressed/fdt_check_mem_start.c
> index 62450d824c3c..1d47de1e860b 100644
> --- a/arch/arm/boot/compressed/fdt_check_mem_start.c
> +++ b/arch/arm/boot/compressed/fdt_check_mem_start.c
> @@ -64,7 +64,7 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         uint32_t addr_cells, size_cells, base;
>         uint32_t fdt_mem_start = 0xffffffff;
>         const fdt32_t *reg, *endp;
> -       uint64_t size, end;
> +       uint64_t rsvaddr, size, end;
>         const char *type;
>         int offset, len;
>
> @@ -74,6 +74,19 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         if (fdt_magic(fdt) != FDT_MAGIC)
>                 return mem_start;
>
> +       for (offset = fdt_off_mem_rsvmap(fdt); ; offset += 16) {
> +               rsvaddr = get_val(fdt + offset, 2);
> +               size = get_val(fdt + offset + 8, 2);
> +
> +               if (!rsvaddr && !size)
> +                       break;
> +
> +               end = rsvaddr + size;
> +               if (mem_start >= rsvaddr && mem_start <= end)
> +                       /* Relocate past reserved block */
> +                       mem_start = round_up(end, SZ_2M);
> +       }
> +
>         /* There may be multiple cells on LPAE platforms */
>         addr_cells = get_cells(fdt, "#address-cells");
>         size_cells = get_cells(fdt, "#size-cells");
> --
> 2.25.1
>
