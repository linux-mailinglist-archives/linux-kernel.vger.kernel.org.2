Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DE4422BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKAVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:37:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41811C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:35:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 1so25637717ljv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7xnA/1aaoRBIc6J8h72yDhrlo1CeZnkWHnggGQPu1g=;
        b=FvzXbuNNfz59lIkE50rk42kdYK9c682XyyX2sslNajNHI26k2R3ZPCcM/siHj1scHW
         Rsb5fIRlilbyUFOj9nIJnVroNiadNayfBHtcRn/GLy9v9YjwU5OCGbkc/fO382toRbG6
         QzFviHI8m48UzttmH2f/CFj4FqMn8gpJDk0+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7xnA/1aaoRBIc6J8h72yDhrlo1CeZnkWHnggGQPu1g=;
        b=snIoVwBfuzreoSiPAN6ao1S2e4f3uCzDHw4Vp23KdvE+WQLh7Zhom1p5gvQ8m0FrOS
         gTFJZc1GfGAWxIvsWYQKSBNjshQ+hOSmDSFr97cK+ZW8JfCaaUy7WD+vfICLON7bL5uD
         YHYy3+VnAXoLS/UW/kBxIxE1HB2+XG3YrKnR1hGbILNIzsidiEoPXPE6twIymIJufHiC
         TrKoRWL9bVhCYcIH7tfmzydXSvv1tjHWz/5MoXp/AQ837jF+WNhInmOuI5fV1351RQN5
         Lt/NNGt3jWD0MlQEv/tMDVmpqzT8fXAzpw2ypQ5hP3KCPzFw0Sz5RD8P3CzHpJ358jIB
         gzBQ==
X-Gm-Message-State: AOAM531sJh/tRyR/RoyGTGn4Cwiz00c5BjJWsqKiBtvuQ8JOxFxj3Bd6
        k5WvGSv9bFiDjWQ7I0LQwNo21p84IQvbF4HF
X-Google-Smtp-Source: ABdhPJw2apseW1DDk6Bqwrle/k0uHSom+Ege3ef4GSUb7WMibVtGcxtmMgMK1ls98UUeRfTrgQj1UA==
X-Received: by 2002:a05:651c:1254:: with SMTP id h20mr34006431ljh.420.1635802507994;
        Mon, 01 Nov 2021 14:35:07 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z17sm258100lfr.177.2021.11.01.14.35.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:35:06 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 1so25637556ljv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:35:06 -0700 (PDT)
X-Received: by 2002:a2e:b744:: with SMTP id k4mr34065351ljo.31.1635802506130;
 Mon, 01 Nov 2021 14:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211101194336.305546-1-shy828301@gmail.com> <YYBRePv3w9cfCpHC@casper.infradead.org>
In-Reply-To: <YYBRePv3w9cfCpHC@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 14:34:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihHKSno9_35mgoX5F+COUep7X6EbouyDVKEoncFix8OQ@mail.gmail.com>
Message-ID: <CAHk-=wihHKSno9_35mgoX5F+COUep7X6EbouyDVKEoncFix8OQ@mail.gmail.com>
Subject: Re: [PATCH] mm: page-flags: fix build failure due to missing
 parameter for HasHWPoisoned flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 1:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Should probbaly cc Linus, and also note that Stephen noticed & fixed
> this problem already.
> https://lore.kernel.org/lkml/20211101174846.2b1097d7@canb.auug.org.au/

Oops. And both my "small" and "large" config have MEMORY_FAILURE and
TRANSPARENT_HUGEPAGE enabled, which seems to be why my build tests
didn't trigger the failure case.

Will fix up.

             Linus
