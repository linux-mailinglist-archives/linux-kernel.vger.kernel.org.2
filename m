Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8132D5CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCDPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:01:09 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45352 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhCDPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:00:52 -0500
Received: by mail-ua1-f51.google.com with SMTP id c44so9332743uad.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhZu1n7avh64RVL6V6p23bsKYKSdsGX7hl3TXY91bbU=;
        b=t73YPja+W1+e046yPMzeZcP7J0tUMxYZPxVOD3Pou5oS33ut1pRuXkMl4jerXWwRga
         5eIZ6rHkjgpYodlCXFHiDUkRgQGyRV/t3YFZJamQvJyW3rTZImMXmBMjTihSEAeEn5ez
         4B8NOFWNR4pZMYxcU6+N76syy4TeinTFUWuFWJHpaJdxYBQz3tTbAquPeQCAPUVc41Sj
         URE715xJ6axjcm02NiydIACgABiizSvHeQMCJ+ERynNAbsyTbiDfjF9EWuEVDgUvFpj3
         +uNBQ4rCOgio/V/ZMw1RUO3NaGciWc5GURSuTAukqDpfgtIJDSl5ZlCrGyykaoIZc9+Y
         sK5Q==
X-Gm-Message-State: AOAM532BLd921Q4eRk3PNWWd9bjiSYJ67Pn5HN4azyro1lZMsRa50jqU
        TATz3zkHGOocEgwXqGHbgr6yhnbNXq7PhscIdVeTMA4W
X-Google-Smtp-Source: ABdhPJyU4c6+voPOlb72A3gWY7dVv1afFPy+yfOI3paaxyDHoCc0VijSOhBxmOrZw6i+gry95XTns+Ex8yhcHoVCv44=
X-Received: by 2002:ab0:20b3:: with SMTP id y19mr2377936ual.2.1614870011867;
 Thu, 04 Mar 2021 07:00:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
In-Reply-To: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Mar 2021 16:00:00 +0100
Message-ID: <CAMuHMdWn7GPkLrRnTJRT=9W-PVwoWOVBTqdM-gR180c66vGfOQ@mail.gmail.com>
Subject: Re: A note on the 5.12-rc1 tag
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Mar 4, 2021 at 1:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And, as far as I know, all the normal distributions set things up with
> swap partitions, not files, because honestly, swapfiles tend to be
> slower and have various other complexity issues.

Looks like this has changed in at least Ubuntu: my desktop machine,
which got Ubuntu 18.04LTS during initial installation, is using a (small)
swapfile instead of a swap partition.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
