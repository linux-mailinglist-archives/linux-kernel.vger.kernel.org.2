Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72103D58A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhGZLBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:01:18 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:44880 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhGZLBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:01:17 -0400
Received: by mail-ua1-f43.google.com with SMTP id d22so3396854uaw.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z7ueN7eMODaEBlMsJr97w9x1dSFZn7UiFG2N7PSHV98=;
        b=nwVI7R0uXPxPkT9JVneS+7+pSlYd3arhaR4IMC6ExroLCDQBCDUm7EZF6ZjTshqi32
         VA9lI14Mmpa0dZX0632rvXLz6plGqF7YlQYFkBjGf740ZfXTapI4z1IGj4UBwFq2aqIQ
         dLVIFLBcKGUDbEuHFR2wzmKgjpBBVBGy2gu5IQWqkJQMCmqdZADmzUzy8UXdwOhZcEgt
         0ZVHTWXsxv2Jcts4FCP1yOjKOIt0TzVR2iIyf2j+E3srpYbfnGU6UzVCdx1qThWNQ4Sx
         AlM3CBOHXqNmJnJLi6c/QzKmcS0foTCS0pLqF0FU0uI/fD2o6VVjyRkJQ2IChW/phezV
         aHEw==
X-Gm-Message-State: AOAM533lpYvlQAjcirZ20WXcSsOwU2CHlo2Trv40Cr+yjxwdGBDz64vo
        G+2VWvePmxt5W2m1w7EVJWDi2sZVGFXG3yVeSgCyA12lOZfoEg==
X-Google-Smtp-Source: ABdhPJw+brsVtS6eyaGEeABmJwFfGYpxe1t0GTiDb9e5bLUU+IMnUW5vYiXlcTSdoySIR9BEzRw8Kjdqg73k20AKWdo=
X-Received: by 2002:ab0:6710:: with SMTP id q16mr11921281uam.106.1627299704595;
 Mon, 26 Jul 2021 04:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210726093240.2547647-1-geert@linux-m68k.org>
In-Reply-To: <20210726093240.2547647-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 13:41:33 +0200
Message-ID: <CAMuHMdVLGkb2uQw96RQz_u4iNNb8fEEfF+NKcdAapMckBHz=Dw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 1:03 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc3[1] to v5.14-rc2[3], the summaries are:
>   - build errors: +1/-6

  + /kisskb/src/include/linux/compiler_attributes.h: error:
"__GCC4_has_attribute___no_sanitize_coverage__" is not defined
[-Werror=undef]:  => 29:29

mips-gcc4.9/mips-allmodconfig
(seen before on v5.14-rc1, fix available)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
