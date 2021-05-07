Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7C376346
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhEGKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:07:19 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:37419 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhEGKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:06:53 -0400
Received: by mail-vk1-f173.google.com with SMTP id b21so1819225vkb.4;
        Fri, 07 May 2021 03:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OhSK4/fRuA4HwTCIuizFPGiwNOBd8/VP64HP5BG0u0=;
        b=htGB1v3S9DvWqxi2BQlOlRq+hW48uCA4hLDhhGEl7iqn4iOiSOyIY5t2ug9PjAPIB8
         FLZVSuxyuwwrnhuavW78HzL58ANMVw+YbVmnWtQn70WfSbvFeUE9HW8HzFXyFAuMGmpY
         48gaLJL69dHgU3BOHFzi1VZiE22x6z4ww1qhuaBZY+FgIwLMRt0JdDKefaXnV5WHPjlJ
         wYprMWhkOlSUYiJeMoq9ojosr4qgOFeoeGGRm5MPUwEgUllhl9nfLpzW6/kdIFwsKBYk
         N0rOxUwmdpOPmhY9Z7JGmg4m8UhoU3luFVJCT+kAFTLICYbiV5cgCVakSTKO14Os++tp
         Y6bg==
X-Gm-Message-State: AOAM533mx/E6WkbxLEAChchiW5bofiYeWgPuXSouAvWCR7Tm0Qg0Oses
        td4CeBC21qZRkmxYmv6n2MmmnPzgBR3a+NP1DLoJxs16
X-Google-Smtp-Source: ABdhPJxt+pOzDHWc5H2t65kh+4s2Qz3s7gwuQ1GebHLmrZDDKPnZtkesGIVfbF6W7iXFexTUx2RQ4J/cfrxj3ln6qbM=
X-Received: by 2002:a1f:5682:: with SMTP id k124mr6833991vkb.2.1620381947610;
 Fri, 07 May 2021 03:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <87k0oaq311.wl-chenli@uniontech.com>
In-Reply-To: <87k0oaq311.wl-chenli@uniontech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 May 2021 12:05:36 +0200
Message-ID: <CAMuHMdWapV4ZypzpC0gvS01BKRQvPjsiD2uS7odb78dEeP=63Q@mail.gmail.com>
Subject: Re: [PATCH] mm: update legacy flush_tlb_* to use vma
To:     chenli@uniontech.com
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Jonas Bonn <jonas@southpole.se>,
        Openrisc <openrisc@lists.librecores.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 11:58 AM Chen Li <chenli@uniontech.com> wrote:
> 1. These tlb flush functions  have been using vma instead mm long time ago, but there
> is still some coments use mm as parameter.
>
> 2. the actual struct we use is vm_area_struct instead of vma_struct.
>
> 3. remove unused flush_kern_tlb_page.
>
> Signed-off-by: Chen Li <chenli@uniontech.com>

>  arch/m68k/include/asm/tlbflush.h     |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
