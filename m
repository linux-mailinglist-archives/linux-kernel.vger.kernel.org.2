Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2F454B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhKQQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbhKQQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:49:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:46:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z10so13826963edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ET0tmIiYHyvEMKlBP8oDqKG/hNfHTYYovrhLrY7mVM4=;
        b=gVSQ2J9OLPLCHzVVSOZFyLxcFnUjeNKwWFMMHgPvy2CzMqGKqoDu86Klbd8K/onXqm
         xFADHCD9yHfkiuNtwgvt8f1v4R1b9+0xB9hlDvXQhyaoeAlLAXApR036UKKrHEjGWd9F
         +JCiHyuT3OE7Firp5lwTbk7rdXmugnSjOMr8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ET0tmIiYHyvEMKlBP8oDqKG/hNfHTYYovrhLrY7mVM4=;
        b=BU4IyAyoxR6IYzaS5viyIVkL2oc+ZwrdPZCpi0RympVPioiuFA9tF3K6jsYQmNW/qS
         Bj4cOhUnPoW566AFEJTIP7A2qZmls4LIv1Cf122ckZhdYk8DJ7sxUNuinwQ20xsvbp8f
         4yuMmZt7Eb5KCRYp0DdNFUlAd4yFGaijCPtibCW8s849DY7rgcCYIYHk/3zmUOa1EiH2
         bzuIzD0XNUZAbzWASiioyBvwVW0EaIFrwNehK3dli7D/MshrT146Z9zQjTdvU2V79tvt
         Rr6N9Lyfh/oIbTQffvqu2/yaEdHiZMvL0+K6h4eX4bW3BJaa+DwBHdEGl1HUGwd/eI1s
         L8Zg==
X-Gm-Message-State: AOAM533t+IWlVRpfzKTfd0IgO2rwrrJi+sUVH8urjsp88Y67wMfl3nJp
        NBcyzpXSHJkgXnsPgz5WP4NMlrYIUfeT3KUZ
X-Google-Smtp-Source: ABdhPJwYbA3epTpTu0ycxh4Hv1DOUrksv5wW7r/PEF1BWaVgdZhLvtIV0hGMpgVOWNVJrbk+jnNKLQ==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr87786edt.168.1637167571769;
        Wed, 17 Nov 2021 08:46:11 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id qf9sm249933ejc.18.2021.11.17.08.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 08:46:11 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2656790wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:46:10 -0800 (PST)
X-Received: by 2002:a7b:c005:: with SMTP id c5mr1212849wmb.155.1637167570617;
 Wed, 17 Nov 2021 08:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20211117014949.1169186-1-nickrterrell@gmail.com> <20211117014949.1169186-2-nickrterrell@gmail.com>
In-Reply-To: <20211117014949.1169186-2-nickrterrell@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 08:45:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibYLDep=BPrUaw_wuZRDXnq5BVtG-6gLuBq6+3fdMhOQ@mail.gmail.com>
Message-ID: <CAHk-=wibYLDep=BPrUaw_wuZRDXnq5BVtG-6gLuBq6+3fdMhOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: zstd: Fix unused variable warning
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 5:43 PM Nick Terrell <nickrterrell@gmail.com> wrote:
>
> From: Nick Terrell <terrelln@fb.com>
>
> Backport the fix from upstream PR #2838 [0]. Found by the Kernel test
> robot in [1].

Ugh. Mind having a better commit message?

This just tells you that it's a backport. It doesn't actually talk
about what it fixes.

Yes, the summary line says "Fix unused variable warning", but it
doesn't talk about why that variable is unused and why it's not
removed entirely.

And it's not obvious in the diff either, because the context isn't
sufficiently large.

So a comment along the lines of "the variable is only used by an
'assert()', so when asserts are disabled the compiler sees no use at
all" or similar would be appreciated.

Of course, the alternative would be to make the backup definition of
'assert()' actually evaluate the argument. That's not what the
standard assert() is supposed to do, but whatever, and the zstd use
doesn't care.

So using

    #define assert(condition) ((void)(condition))

instead would also fix the warning at least in kernel use (but not
necessarily outside the kernel - the standard C 'assert.h' is just
evil).

                  Linus
