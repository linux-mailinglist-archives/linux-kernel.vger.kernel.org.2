Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06F3F498A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhHWLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:18:33 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:42794 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhHWLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:18:32 -0400
Received: by mail-ua1-f52.google.com with SMTP id m39so7755640uad.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8CSXfTepPRgRZg2J50KQ2d2v3LnVmjti3wvZR4CQ84E=;
        b=Hrw4jWoI1XF5AY1YcHs4yloDQnbsk/ecdTwnhElvdju6DNt2Yn68LVDVZTKCjyQ/Zi
         g/tj3boega4DZNPYSGf2oLlE8VXgtH/GSZhKLyOhxO9jW5xmkxG0KCZnAEN44MWot+xI
         pjNoVqlSwxl5ZMJvPwsSwgsQ5uEcOhYQvZmo5+MLxzDH3YdQD3H1dN2CoMUlPfYOTdKv
         a3bcnmZmsAlWlG7v3EnltmvrorYK4dur3EhYN93TwzVFzNfAW8Qsm7aGHwkxj23Qld2z
         GdNlGpqafTHtRRQojn7FoIimU/WTXrL8PGMUikpmu8ICbyhFfVO7pbLFr1ZA9hSLllr2
         ry5A==
X-Gm-Message-State: AOAM530+t78mfW8UsQqP4HhfqxWn3bx/ibfBDKBJVTTcUGP3oBKZr0gt
        eMs4hBNPVuDvd57BdZNK68I41GXqcyz6ZFwe2StN0S9dRAg=
X-Google-Smtp-Source: ABdhPJzOKXGfLJDL/tl3wRpw5a27W3Iaf1T4A9FSb6h0cpR3EE5FebxWUaIzqdrhDp3CN+3HhiDCPPWlIyn7d/cJtQQ=
X-Received: by 2002:ab0:209a:: with SMTP id r26mr721351uak.14.1629717469186;
 Mon, 23 Aug 2021 04:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210823104945.1373324-1-geert@linux-m68k.org>
In-Reply-To: <20210823104945.1373324-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 13:17:37 +0200
Message-ID: <CAMuHMdXQ9HwsXpZCpyJodkxwPwtKcZwPLBoxD7V++WM6VW-XCQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 12:53 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc7[1] to v5.14-rc6[3], the summaries are:
>   - build errors: +2/-2

Just two __compiletime_assert_N line number changes not yet caught
by my scripts.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7c60610d476766e128cc4284bb6349732cbd6606/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
