Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449332BC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359442AbhCCOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842941AbhCCKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:45 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A65C06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:23:05 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id d25so5104439vsr.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00ZDg1wTbaCuyimU7RbtuQX/Ar+utTU6e/Q0HjfvUWM=;
        b=Xo6jCv0MSaXMYVG7EjCNoCN7IUG9sRzt7zgmeNb5FACPWfAPfhIaO/jbilQdSYDsrv
         oQVPqtiZp4zAtnLA0PR25iQJjUnRTtb8TxSsreaipB0PeBoLJJVCGDahJXwcI1yC9IPo
         fk8h1ij+hYkzcq0+LApkVbv6Zz0yL6bjNXc21snqq2bxkww5j/Kd38HoNimh5BRnhgSk
         +SnOBRNp6JQF/hgj+kL1/aVkZbJJCzoeGOZmXXlvrkCKoOWF5ddzrCOvFguVjt0s2m9O
         xpFhH0nVOmyxH8mM7hczJqhEJ3f30CXucBhdvRf4QQTnWHZ4fkhcMX1gsDYNYTMOwVsQ
         AjgA==
X-Gm-Message-State: AOAM533Iz6LqWBR+H+b08q1+Mp1auYWXFrm3Yhkm+ajuqPAd4hdKAVzL
        n71YRhy9CAMoXb/Nipj9EQM63ZqS15ZgEzNckQA=
X-Google-Smtp-Source: ABdhPJy8c2MpDySWxP5HZQagcTdVc+YWgqqkNTkVSjxkuVENooUJXVOZGD43K3CPbPygGlLv7LcFioaKmVcnvuzBUpo=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr1086852vsr.40.1614759751867;
 Wed, 03 Mar 2021 00:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20210303020422.174818-1-zhang.yunkai@zte.com.cn>
In-Reply-To: <20210303020422.174818-1-zhang.yunkai@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Mar 2021 09:22:20 +0100
Message-ID: <CAMuHMdXxxvLddxzJzZSxU5ZXsvC6-7FCNHN+tQaMZvOq6peq6g@mail.gmail.com>
Subject: Re: [PATCH] module: remove duplicate include in ./arch/arm/include/asm/pgtable.h
To:     menglong8.dong@gmail.com
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        zhang.yunkai@zte.com.cn,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:04 AM <menglong8.dong@gmail.com> wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'asm-generic/pgtable-nopud.h' included in 'pgtable.h' is duplicated.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
