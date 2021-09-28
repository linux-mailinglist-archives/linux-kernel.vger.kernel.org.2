Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003841A99A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbhI1HWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:22:07 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:40696 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbhI1HWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:22:05 -0400
Received: by mail-ua1-f48.google.com with SMTP id i8so11896281uae.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3oM/UfSb0uF4ufg5hPTNhl4CxjwTh19TsLWgZ0xKP8=;
        b=zHaV9AT3U5jmSSql1/AiOYvnU1mjmuh0p3nl00WAUel2Ygt2dLqcdRXGvpzZHzKFaf
         Y9UE9CrUHFAyhKeCWjhUizwKkH52ooXY5tVDKbSgwTQoyCOWMFkaeib7HcUSVkOuUUJj
         u8aRV+CqArohCOpsZav4IQuwHyD3paw0c68CY0CRfU3NE3cMms5ci+SQygyBFDBpOj4A
         tilymgsgaPQxIcynnBfGeyexVP+O6QY8+wfBRGDiPOFBV48GUZPPAkdtr0sQYwOhDi2a
         h1yrqUAo1e/k8COTQjUdWXseg5u/yB/nc8x05xG+a+Aupxg+XSap70KjtO/TQqXXlPrQ
         Uwiw==
X-Gm-Message-State: AOAM531L0ljZBWQtsLplrYvIYfxXWlZrRYZ/cZThpQCOrb2EOSmE4GWH
        9XCV/xXnktYk+q3wnB30PubXB+OxANy0b5wTNcG9L4As
X-Google-Smtp-Source: ABdhPJz87WYOzHq0FLVtLg4fw0iXjvmNTcW7EfAxFF5VRuSXdnBhe/VH6GrCIVf3lD4ltjTVA74dYqJfft+Ywu1PZKg=
X-Received: by 2002:ab0:538a:: with SMTP id k10mr3714037uaa.14.1632813626497;
 Tue, 28 Sep 2021 00:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <a1c34f2b-115c-7ab9-5b69-7c11ebc18b4f@infradead.org>
In-Reply-To: <a1c34f2b-115c-7ab9-5b69-7c11ebc18b4f@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Sep 2021 09:20:15 +0200
Message-ID: <CAMuHMdWJGFm0p-5qSj4xybfo7pZB_PrSjt2ghcgL2HaB6TQENw@mail.gmail.com>
Subject: Re: m68k: default value for MEMORY_RESERVE?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Sep 27, 2021 at 11:26 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> Would it be safe (or unsafe) to add a default value for MEMORY_RESERVE?

No idea ;-)

> As it is, kconfig can generate a randconfig with
> "CONFIG_MEMORY_RESERVE=" (no value) since it has no default.
>
> Then a following 'make all' finds an invalid symbol value and restarts
> the config:
>
> .config:214:warning: symbol value '' invalid for MEMORY_RESERVE
> * Restart config...
> Memory reservation (MiB) (MEMORY_RESERVE) [] (NEW)
>
> That's OK until I try to script/automate randconfig builds.
>
> Can we do anything about this or should I just add it to my
> ignore-list?

Looking at its sole user, I guess "default 0" would be fine.
Greg?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
