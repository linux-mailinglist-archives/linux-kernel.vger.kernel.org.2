Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C53C716B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhGMNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhGMNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:49:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF4C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:46:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k3so7534229qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KS+iF4Pc2VBgRkck8w5172ucQsF7IAiFUaz7SAcYMXk=;
        b=h/E21b2bz9c5PjZDILRVd6rY5jYdenj0x1RbXdub99cORNrUc9F+LLuuxzKTDnknmj
         ZpN6lWiw1ahrFN9CFG81RfLKbUx7ipS+4StmjzCZQSyDoXGJ+HeiyZy5tZbi0bQ7BOp7
         tgPTsHnaXa1BLZIpr+537gJD5BWGKfj0wLI28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS+iF4Pc2VBgRkck8w5172ucQsF7IAiFUaz7SAcYMXk=;
        b=XSXspKUUOR1/wtC/jD6SpQ5HAhHY8EAqsipMkmF8/MoYtYfqwIzz9FAEp8fizUhKxl
         OAsmhlP6v+hupfqUViaIu9EdT9U1ennoA+EZM8jhiyHY4V9JUp7pPWBAJ7PT6vJ6Z4VV
         Qt6NqhreubWIHtPBXAKX/jx6eiOHvqhMjy+JAdcY2KfYUbB6qt3rCVxkKz0KAjbZ/OTq
         IItA4mDB7+770CIkfC64RU/j41LIOwf7vw3GwyMO6Nn6LE5/q8gX98RRhMysL62BaKkZ
         YFovgArExzljW9Ophep/kWWkieBPTip7UXMeFnjAK7dLAWMylOMVciKsXVWqtLYxHtWh
         Ac3g==
X-Gm-Message-State: AOAM531iA55yMn/38oPABESMCrKm137u8B+0RnbTRHUnZMPakTZ6GPrb
        RBQm8dqge8x2W6iLsS2N8bsAfCtFA2LHaw==
X-Google-Smtp-Source: ABdhPJwY+qi4IP98yFsScP9xSqhJEDiBVZ1aVdylF1Nu2a1mN3EJEV5Q6Jf+WJMDN8Z7MnxvE2yBTw==
X-Received: by 2002:ac8:776f:: with SMTP id h15mr4116354qtu.26.1626183966976;
        Tue, 13 Jul 2021 06:46:06 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u4sm8365270qkb.99.2021.07.13.06.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 06:46:05 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r132so34861383yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:46:05 -0700 (PDT)
X-Received: by 2002:a25:cc52:: with SMTP id l79mr5818725ybf.476.1626183965121;
 Tue, 13 Jul 2021 06:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122447.3880803-1-sumit.garg@linaro.org>
 <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com> <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
In-Reply-To: <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jul 2021 06:45:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com>
Message-ID: <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 13, 2021 at 4:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > >  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > >  {
> > >         int ret = 0;
> > >         unsigned long symbolsize = 0;
> > >         unsigned long offset = 0;
> > > -#define knt1_size 128          /* must be >= kallsyms table size */
> > > -       char *knt1 = NULL;
> > > +       static char namebuf[KSYM_NAME_LEN];
> >
> > I guess this also ends up fixing a bug too, right? My greps show that
> > "KSYM_NAME_LEN" is 512
>
> I can see "KSYM_NAME_LEN" defined as 128 here [1]. Are you looking at
> any other header file?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kallsyms.h#n18

Ah ha, it's recent! See commit f2f6175186f4 ("kallsyms: increase
maximum kernel symbol length to 512")

...I guess this officially "Fixes" that commit then?

-Doug
