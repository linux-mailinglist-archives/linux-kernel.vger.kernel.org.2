Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB533FB8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhH3PST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhH3PSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:18:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCAC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:17:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y34so31926108lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MLDjuaO3kwL/1nbZTsh0jGPs/YFO84fUbfNfncMSic=;
        b=LmR59qk2FmxeGYJnLILnxG55+F1Y1fPWfF0iSUYreYGwUjwGW+V+FQVlnjsZCZ5RHN
         ifTbyr4z0Ux1Nz3er5VtBeonqVloZJJaRYfHzzt0EHqfmkjbVBgDC6tXOXJUa5uWBV8U
         y3cXJis8UFcYLG9EfU0VPhCakYRHo4dEQnhes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MLDjuaO3kwL/1nbZTsh0jGPs/YFO84fUbfNfncMSic=;
        b=Cye3jOaHH7whQ4faY0+DeNsAcY02+ua79UF/rhIIVixwhQrtwL0R7hLliajrx1vr/z
         xZTEVlQ26KBOHOzYF7UzOt54ZTNEPXCeCDLt+KIWfeMDsCMbyRh9PY6a1lufS6zuej6v
         hXiIF4UO2ykNCrabuk+rdejC0nz668Y1psfXqGAvEDLuYIVRDu4+iTMj3xe2d6pSvI7F
         pqrL2uyEaWODIIdvR+3ecYKsB0BWn31FMAlGAuW0RFA93z0a92ZVWMdlojvjW0Cnq7th
         Bgc2u0s9tYs84FhRAlRUXp1XxZryoS+eVduJ4aXxkaxpgjS0hvDE4RxikIrI8LwghdoD
         O8Hw==
X-Gm-Message-State: AOAM530ps3IxYdtZvpY2Hxz8k4LeZxKg73T4kNfo617Jr9tvDxqcngoM
        DjD7xQEcyAHhktZOPgS25o54NnTsFPeRVlDK
X-Google-Smtp-Source: ABdhPJxILG90nDDJ39L4qGuZzfWnwRnnwYpYjzH4RNw1OWoeAZ9TQIOpAD/zpQDnzkq1WP+8Prle1w==
X-Received: by 2002:a05:6512:6d5:: with SMTP id u21mr14506106lff.212.1630336640954;
        Mon, 30 Aug 2021 08:17:20 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id c35sm695495lfv.137.2021.08.30.08.17.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:17:20 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y34so31925977lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:17:20 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr9565206lfu.377.1630336639905;
 Mon, 30 Aug 2021 08:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <CADVatmP8HQfZBPevLuuWtWh=1eBD=cmY84iJoMcoHh0n480Bag@mail.gmail.com>
In-Reply-To: <CADVatmP8HQfZBPevLuuWtWh=1eBD=cmY84iJoMcoHh0n480Bag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 08:17:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjz+RhR8rr4rAZBPf-mxZXvn2RQe-XTQcL8X+HXBAFxBA@mail.gmail.com>
Message-ID: <CAHk-=wjz+RhR8rr4rAZBPf-mxZXvn2RQe-XTQcL8X+HXBAFxBA@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 2:12 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> We were recently working on openqa based testing and is a very basic
> testing for now.. Build the kernel for x86_64 and arm64, boot it on
> qemu and rpi4 and test that the desktop environment is working. And,
> it now tests mainline branch every night. So, last night it tested
> "5.14.0-7d2a07b76933" and both tests were ok.

Thanks. The more the merrier, and if you do this every night, having a
fairly low-latency "it stopped working" will be good.

Of course, if you can find some other slightly more oddball
configuration that you would also like to test, that it would be even
better.

Because while it's lovely to have more automated testing, if
_everybody_ only tests x86-64 and arm64, the less common cases get
little to no testing.

No big deal, but I thought I'd just mention it in case you go "Yeah, I
know XYZ is entirely irrelevant, but I happen to like it, so I could
easily add that to the testing too".

               Linus
