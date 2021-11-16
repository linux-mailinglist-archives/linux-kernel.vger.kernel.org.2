Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C114528D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhKPD5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhKPD5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:57:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53717C1E82A3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:35:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b11so15831060pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YrJDwz5lHylUrRKBiCCXn7XIadwbTCaDNmr8F8Qv+s=;
        b=kRgsOovbagRO/7210nSyOKEBlmhfA5hNYfPQV4k7lydus9N2uNl5Vt0UygZC7jGLy1
         CcSKdAOPN7CAjIaxG2Nk7LhNoTdTNyUIV57l7UZ/U0TQtm7n+dBKTmv+GCqWpklKxw86
         72xq1Tvc+lxHwltemgeZ72MdiUZIJVqjFa0RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YrJDwz5lHylUrRKBiCCXn7XIadwbTCaDNmr8F8Qv+s=;
        b=E+F0qHgKiYflUKAHZmlcnIZyhocAsZqdsRsNqvpWi/+wFbxyR44hNaldSieb+T+zmj
         L0+q2I9LjEHeEKQOX6+4QSodl5SrahhaRDoFyU68AQ+Lj6jBnVUj/Z+NeKjV80bP7WZ2
         210iEzdCjSS8YSCiB8JojuRa2TEVv5OUWAGEQ973FVuXTL9+f/gLv5/V97O1l9blN0Ok
         OCZ1S7GJKgKS/wqvpAM3JZpgufnxF0Anxkbg/lVVehGGsjDwn0Vq/P21ZUe3fY6a8B9R
         MD9sW/Egm4f89vQuEpSmcgcdAysI/A5UfPf7JDvY4I00JGScnFh4R4sylFb76nMWZL2K
         +RLw==
X-Gm-Message-State: AOAM533zXDCpwEvbJX9P1bDeX5xnt26yUH+tDn+0QMhcQGwAZeHVWyCz
        aYKKT947ETf1pRhFnGDPpuRlFw==
X-Google-Smtp-Source: ABdhPJy9iYaBB3Pj/LejC8q7/hsST+5gxO7ABIHhxz3+lYk9ZK6BkrL6e9tXPNM1m5lGV6jB9/FWOw==
X-Received: by 2002:a17:90a:c398:: with SMTP id h24mr3495024pjt.73.1637022914921;
        Mon, 15 Nov 2021 16:35:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s21sm16292860pfk.3.2021.11.15.16.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:35:14 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:35:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Rob Clark <robdclark@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Anton Altaparmakov <anton@tuxera.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joey Gouly <joey.gouly@arm.com>,
        Stan Skowronek <stan@corellium.com>,
        Hector Martin <marcan@marcan.st>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: Build regressions/improvements in v5.16-rc1
Message-ID: <202111151633.DE719CE@keescook>
References: <20211115155105.3797527-1-geert@linux-m68k.org>
 <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
 <YZKOce4XhAU49+Yn@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKOce4XhAU49+Yn@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 05:44:33PM +0100, Marco Elver wrote:
> On Mon, Nov 15, 2021 at 05:12PM +0100, Geert Uytterhoeven wrote:
> [...]
> > >   + /kisskb/src/include/linux/fortify-string.h: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter):  => 263:25, 277:17
> > 
> >     in lib/test_kasan.c
> > 
> > s390-all{mod,yes}config
> > arm64-allmodconfig (gcc11)
> 
> Kees, wasn't that what [1] was meant to fix?
> [1] https://lkml.kernel.org/r/20211006181544.1670992-1-keescook@chromium.org

Ah, I found it:

http://kisskb.ellerman.id.au/kisskb/buildresult/14660585/log/

it's actually:

    inlined from 'kasan_memcmp' at /kisskb/src/lib/test_kasan.c:897:2:

and

    inlined from 'kasan_memchr' at /kisskb/src/lib/test_kasan.c:872:2:

I can send a patch doing the same as what [1] does for these cases too.

-- 
Kees Cook
