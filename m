Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF444528E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhKPEDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhKPEC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:02:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B95C1F44AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:49:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id o14so15920067plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yJN/gap7KdAy16hYzWg/TQ53YhYMDXXVj0aBb/U2j/w=;
        b=ikqo5RKRgOuCWb/tE5Wsu6/Lbpz7tcMIObAYBIERj2KzOwVpFwpieRXXUvMaX7XwT2
         k8oMEES4I07wBo8L4PPK+0ha0Ba+0KC/fVNmtjIkcag841l3Zdh53YX0XHAUtFLqwgU4
         xry7HOSDO25dm/KDW4U7zjUNdHYx47YgH0Ulk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yJN/gap7KdAy16hYzWg/TQ53YhYMDXXVj0aBb/U2j/w=;
        b=LlhL9+xi9a4NGX3nzLU5tb3PLqrKAgys9+ex1TtbJWvN+V8Ei4z26CCkAA2cRdXkKB
         ufpO7JM4H7ZRbgppaqjCsy+nSTl7zQskLSTL2LmO159Gs02kNulO5d69Feq0Hl1o2F0y
         zd7f5MwSZI5LmmUpOVrnqDOGalJOZhFcRS9tgmmlUIP0pVXewbcEaYA50LtbLwZF4m8G
         ARLjF0xQTLwRDNmXZAC89eMYtCBzkg32wpgHk6kfe0lMQ/yOFKiAuW5SLdHib8LRLF3G
         MpHEL/xmjXxXEFIZbG3q9m8HtfRqs21TllaWycRUmbwK99UD3K9KVS/Mbi8fERVEtF2V
         +4CA==
X-Gm-Message-State: AOAM530IyQ7tHN7zyRbcMpotde7wbk+o5yspmwJPGn7fp0nRWrDaW5b3
        a9hvJ6hHC84eKNjlH1L+KZfbbw==
X-Google-Smtp-Source: ABdhPJzft+ivC/MlWDFI2hxkz8qHExc3R4XStEq5YjNU9NTrcs/Epfe1Egcz95hubrvaUXp3X8CJnw==
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr40756726plh.81.1637023759622;
        Mon, 15 Nov 2021 16:49:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm165302pfj.160.2021.11.15.16.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:49:18 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:49:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore/blk: Use "%lu" to format unsigned long
Message-ID: <202111151648.0498D0AE@keescook>
References: <20210629103700.1935012-1-geert@linux-m68k.org>
 <162500112137.438178.14586324457676666976.b4-ty@chromium.org>
 <CAMuHMdWwDK0bB2B7iFXqMhkZrmw26vKDFZEv+z+mYYTavp5-Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWwDK0bB2B7iFXqMhkZrmw26vKDFZEv+z+mYYTavp5-Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 08:58:51AM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Tue, Jun 29, 2021 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> > On Tue, 29 Jun 2021 12:37:00 +0200, Geert Uytterhoeven wrote:
> > > On 32-bit:
> > >
> > >     fs/pstore/blk.c: In function ‘__best_effort_init’:
> > >     include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 3 has type ‘long unsigned int’ [-Wformat=]
> > >       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
> > >         |                  ^~~~~~
> > >     include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
> > >        14 | #define KERN_INFO KERN_SOH "6" /* informational */
> > >         |                   ^~~~~~~~
> > >     include/linux/printk.h:373:9: note: in expansion of macro ‘KERN_INFO’
> > >       373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> > >         |         ^~~~~~~~~
> > >     fs/pstore/blk.c:314:3: note: in expansion of macro ‘pr_info’
> > >       314 |   pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
> > >         |   ^~~~~~~
> >
> > Applied to for-next/pstore, thanks!
> 
> Thanks!
> 
> > [1/1] pstore/blk: Use "%lu" to format unsigned long
> >       https://git.kernel.org/kees/c/c5d4fb2539ca
> 
> Looks like this still hasn't made upstream, although it has been in
> linux-next since the end of June?  The issue is still present (and
> now an error with -Werror), but hidden due to commit d07f3b081ee63226
> ("mark pstore-blk as broken").

Argh, I didn't notice that d07f3b081ee63226 actually landed upstream. It
was not supposed to land since pstore-blk got fixed before the merge
window. Bleh. I will try to get this all sorted out.

-Kees

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kees Cook
