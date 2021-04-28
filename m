Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3B36D67F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhD1LcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:32:12 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:39644 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhD1LcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:32:11 -0400
Received: by mail-vs1-f48.google.com with SMTP id u22so20657693vsu.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdnFFFMKwc8giJspG3q7avU314RxpR0O2wdBbbGCW0w=;
        b=Yb6jVIWhuvxw/lEARF33F99LwZM4becFZAadJ1kNMAN1MvR8F5fAd2NXb8CI2nzzV7
         sgRR2z/1A6OdairpcXHEHSyENlL5JTS2+WZ8caDNMlyu5I9PH0e/i4vlf+hSxHvEX+YQ
         cjPmpx8FsHzwCKhMcf2GJ9NVRkjE3XWouCF8nIFkZbWQMJhhKrY/bNjaxhp03n85Gruh
         U3mGyR1zUUrnY4KfPq5NB4hzU/gUwJCx5P1S2eL6dAwMCJBzh2c9gzL5FOfpoFR++6H1
         CH2adMFCKHJcrKrWroL5Qmg+4h8SUAqW0MPzhA/44/5yCo1GOrmzYxsvhjm6Uq3T8b5Y
         lrng==
X-Gm-Message-State: AOAM530YVQRZuUWzCN6WUREtp9Ul/aQmZFCYmahuF0Pra28P6BPbpQgj
        goZUJCCDIVvlqHy4Uo9k+Y+2PPs9gS1NzFVUT6o=
X-Google-Smtp-Source: ABdhPJzpMYOOL4z+23OswNPDfCB076CX1yxp7QQGenXzie7NpEr4UCoTIUVn1dUqqUKyGMRg16yZanCVl1B7gRnHUPQ=
X-Received: by 2002:a67:cd84:: with SMTP id r4mr13211137vsl.40.1619609486414;
 Wed, 28 Apr 2021 04:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <1846777.ZUqDs8pn68@mobilepool36.emlix.com>
In-Reply-To: <1846777.ZUqDs8pn68@mobilepool36.emlix.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Apr 2021 13:31:15 +0200
Message-ID: <CAMuHMdXv5S1coGiXJxHioXaDbMxTLXhqoY+XokkpLN4ciEZSCQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove argument from mem_init_print_info()
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 1:13 PM Rolf Eike Beer <eb@emlix.com> wrote:
> All callers passed NULL there, and I have not found anything in git history that
> shows this has been any different in the last 15 years.
>
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/m68k/mm/init.c              |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
