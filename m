Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89C3459EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhKWJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:14:11 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41870 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhKWJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:14:07 -0500
Received: by mail-ua1-f43.google.com with SMTP id p37so42270552uae.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1m+V4iz0zscyHDEe2kjIVDF61K1AEveOhgU9Y4zjfE=;
        b=sg+9kXrVfcgDJpZYGa9+J5TgpHsoOXtiFmoJ71NRVKtn1UHXy5xEeYwpCjpjKe4/rA
         uhaBgS9TBCJcsaOYZg54lCZvAdTZurUwDFt55xO07d0XN7nWCsTBkvCck4zqmcxHAXqm
         yqfLDEiaFZZD8aXw4XroZFOBZ90CB4cmH6/dYGjEiTx3CQeIPrxVidkhz1IeDhMXi1cj
         rBDx66h/ivND8YwCDI+Ihz673mG5M2Hyb9qNcWkCadbgJaVwgoSNPvs2prTSGGO7c8U2
         w9/TLa/EbqD7v0sipGU4K/na+1xzbPevQJ5IaAQO+yBtK5029auzcQPpQSSQrxrHks9a
         89Lg==
X-Gm-Message-State: AOAM530zRLarKwUEpkz+H2d/YDsplBJ6qhKZbOqiAZToS2ym3IYGXRQO
        UI6eKLc0f5KYkIunZmO1KJIE2D+eVYt/GQ==
X-Google-Smtp-Source: ABdhPJxeMVYVm/T1sEwmJv62/JPcmzwLwL4BJTA+q3EUCrwKPQdOmsbGrEz2osuRnUTPuKCmsWmh/A==
X-Received: by 2002:ab0:35d2:: with SMTP id x18mr6381402uat.32.1637658659097;
        Tue, 23 Nov 2021 01:10:59 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id bk3sm5819009vkb.33.2021.11.23.01.10.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 01:10:58 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id t13so42251170uad.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:10:57 -0800 (PST)
X-Received: by 2002:a05:6102:1354:: with SMTP id j20mr5889703vsl.41.1637658657537;
 Tue, 23 Nov 2021 01:10:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com> <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com> <20211122175414.GA1588@lapt>
 <9b524543-e868-7b9d-aae7-97c47f41db52@fi.rohmeurope.com> <20211123073346.GA1628@lapt>
 <YZyubUvWW98ThOPe@smile.fi.intel.com>
In-Reply-To: <YZyubUvWW98ThOPe@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Nov 2021 10:10:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHVxY+BGct2fC+jZ--jOXP0w7yabJOwYED-_1RANM0JA@mail.gmail.com>
Message-ID: <CAMuHMdXHVxY+BGct2fC+jZ--jOXP0w7yabJOwYED-_1RANM0JA@mail.gmail.com>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Nov 23, 2021 at 10:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Be sure you get better assembly in these cases. As I have told already,
> hweight() is a single assembly instruction, I'm not sure open coded variant

... on a select set of architectures.

Do we need CONFIG_HAVE_FAST_HWEIGHT?

> may be better even for long bitmaps. That said, assembly comparison and
> some performance tests would be nice to have.

> As an API per se it might make sense to have such, but you know that we don't
> add it without users.

Indeed. And code for unused APIs increase kernel size, too
(without LTO).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
