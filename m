Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9E4205F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhJDGtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:49:39 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:46866 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhJDGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:49:35 -0400
Received: by mail-ua1-f45.google.com with SMTP id u5so8616637uao.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkQyyOwNhUveMKMLyLtnL30fGuoMI6Ske0DgXTygTcg=;
        b=xOVNAavQDIOLWgntsTBVyCCzhM/SRTAG/W/YyXvJPSxcfhAO3n2sNclS538pH4ZKCN
         ygUiPxN9g8RY77i66JDA2vfKZBn8pPKrw4hVEClmME7OKgSfM0IrCvG0SumysviudrIz
         wPifhkdKB0YP/zNcn7CbAV2cnvW8oy3pMx6WWfz7StYjCWjJHJZ5v1axF2eQmoRU01WZ
         AvHUBUrvN3ohVfxwOC5OeuPf4vkiSL3oMvU4gMsYzQwa6hFU/urYptHUDCNU4Kwq2WBq
         tW5KSYgdUkpAUtzYJD5AEVUFrjMdmZNDnBejEHzfv4xkf0EZ2IhXCLY4zBggP3plvidU
         prXA==
X-Gm-Message-State: AOAM531tbY8GQtP710BTVxUDZrXrdAEgkc4K1xgV3l4qK1HFb8hZ4EeV
        8egmtSB54vFxCEZCxTjoxKLpVZnr2g5rs6+tLhi80SqP
X-Google-Smtp-Source: ABdhPJzekemMTDmOcZmAwc8VjcdhOBpqy9LccBnGIanXqRsFDCR1FNoQwvmiBHwkI3zP0T0FAw6AH1Y5YyKf1zNYeb8=
X-Received: by 2002:ab0:311a:: with SMTP id e26mr5140985ual.122.1633330066468;
 Sun, 03 Oct 2021 23:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211003000223.25769-1-rdunlap@infradead.org>
In-Reply-To: <20211003000223.25769-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 08:47:35 +0200
Message-ID: <CAMuHMdWxZn85bk9MuMfW1K_k4v68t4duvJtVHgArdqgawxf78Q@mail.gmail.com>
Subject: Re: [RFC PATCH] m68k: set a default value for MEMORY_RESERVE
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 2:02 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> 'make randconfig' can produce a .config file with
> "CONFIG_MEMORY_RESERVE=" (no value) since it has no default.
> When a subsequent 'make all' is done, kconfig restarts the config
> and prompts for a value for MEMORY_RESERVE. This breaks
> scripting/automation where there is no interactive user input.
>
> Add a default value for MEMORY_RESERVE. (Any integer value will
> work here for kconfig.)
>
> Fixes a kconfig warning:
>
> .config:214:warning: symbol value '' invalid for MEMORY_RESERVE
> * Restart config...
> Memory reservation (MiB) (MEMORY_RESERVE) [] (NEW)
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # from beginning of git history
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

As this is relevant for m68knommu, I'll leave it to Greg, unless he's too
busy.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
