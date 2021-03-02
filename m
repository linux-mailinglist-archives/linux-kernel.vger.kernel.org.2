Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A5232A77E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449230AbhCBQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:16:50 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:36781 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381433AbhCBNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:39:02 -0500
Received: by mail-vk1-f178.google.com with SMTP id q17so4416272vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWZdpcHeT1R5sfyhKtA1mnaVc79LvHvbhW8TOXbn9wc=;
        b=IorNtBoz86We0u5BkV103AqslYY9OFk5dw/DqPntmYFj8kPx9ufsHydkFRz+xH5aj0
         DqyQxlK8kvLARxHgfIZmw5c3S5+g3AF4b7mEnoN930R51jJqJvyuoz4TOaZvz4TxxsND
         zMLqd8gdX9grB6TOALLqIE+qQr/hr0fZX3fq7f8jkqSiltAcMv3MR7fKMT0HG0qPhsmu
         nqz8DF3wfWuk7uZ8w3Bh+ugtf1RHb0YbyrOljMbQkCeV1NqGihL357BKWYicApvEiy12
         jccEGxUsN6TuxRvPtR5d1PPU5wl/8W0dZhipStqtqSi+8wRADM7+qtFwsBabQ/q8B1yF
         YrNw==
X-Gm-Message-State: AOAM532p2+UVf075b2nq6DIVcorX8IuSeWaRDsl2qIr7HpejzmNvKtQB
        MUGVmYKu5fmPpOKtUnX/HIloLT5HKzoNv7rSYmE=
X-Google-Smtp-Source: ABdhPJxCMLNnvIMpxGkp46lwLCQC8YS9/rNk7SISZi9kiUH74flgaNTrLvNlEzYxgSxCv3sy/kMsovOd5ffHohzqSuQ=
X-Received: by 2002:a1f:2502:: with SMTP id l2mr1949221vkl.5.1614692299993;
 Tue, 02 Mar 2021 05:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20210301142112.342909-1-masahiroy@kernel.org> <20210301142112.342909-2-masahiroy@kernel.org>
In-Reply-To: <20210301142112.342909-2-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 14:38:08 +0100
Message-ID: <CAMuHMdVBci8Xsiq2-R++chr3oK9Xd3SFRBpnJsMcr3Tfzj8jdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: syscalls: switch to generic syscallhdr.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:21 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Many architectures duplicate similar shell scripts.
>
> This commit converts m68k to use scripts/syscallhdr.sh.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
