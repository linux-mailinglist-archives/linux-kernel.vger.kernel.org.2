Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71280442589
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhKBCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhKBCTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:19:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCCC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 19:16:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x19so8227962ljm.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SP+2mRP4h0oHYd46FFmWaZ25rz5MwvBTnlHz6RepFE=;
        b=YTuMUGMdppCopcY9xffaNyG4IGopx4khvOLnpFdo7aTOstdlL6a48twmqSyJQISj61
         thtrqVu4i4yON6OBGrMl75wrmVtLGBx05zCP5p9wfilbEfJIxPqa4VeCNMnrp0H8lptV
         rtIcA8C/j2C+NgugRrbmVDTLwgQksU1eVhLc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SP+2mRP4h0oHYd46FFmWaZ25rz5MwvBTnlHz6RepFE=;
        b=EP3zQVUKRSeo4GrNxlid1xTUxr6CYk7AIOyuIat+Tm60drrZ4VYkLz7PY1tUi40qRY
         IqjZmzmjOfvSnFaDb4xK+OiteQu0wxF3oxfZmAeU9unQAneSDKYNahKjhlS/652NNoxs
         R9zlXUZpRrgzG3CC8Xaqpu+npqgwQkFOB7ogc8V3EViJoR60kM/Og02FgKaB16WtxcDm
         eXDOI0yQlaMnaXxGPzxzDVPgK/0rK/RXrlLXVzT/ecU5wUnaw3Q3x7m3uw4nfoM+wnK0
         Eq2pZ6oDQiOw8ZgxIcbMkRdaTi5KhPU2fL/U1Y8C51IE4S9KGoPa7XTfh3Zj6ZUsckMo
         VFCg==
X-Gm-Message-State: AOAM531XhT9YDxSkjVrCFs4Z9JUoyipLS7Xhpg27x6j3MaG3PtRdqxGg
        JylRc0tAgq+nowGGHLku2zxDjtXLNgZDNJnm
X-Google-Smtp-Source: ABdhPJyBQIZsWd9Bm2kCSYwbbxbTfsczLE8YdZu4iXGBX4bwxf8xF3zIgIKYOYHPlskPc76wvnFQpw==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr27067727ljk.125.1635819399991;
        Mon, 01 Nov 2021 19:16:39 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c13sm566699lfr.88.2021.11.01.19.16.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 19:16:39 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 1so26477295ljv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 19:16:39 -0700 (PDT)
X-Received: by 2002:a2e:b744:: with SMTP id k4mr35534070ljo.31.1635819398942;
 Mon, 01 Nov 2021 19:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211101152139.9019160F3A@mail.kernel.org>
In-Reply-To: <20211101152139.9019160F3A@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 19:16:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxDHD7PFLdtS_am8ta5uqyBnjhkQTcRLtPN6-3K+TuRg@mail.gmail.com>
Message-ID: <CAHk-=whxDHD7PFLdtS_am8ta5uqyBnjhkQTcRLtPN6-3K+TuRg@mail.gmail.com>
Subject: Re: [GIT PULL] SPI updates for v5.16
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 8:21 AM Mark Brown <broonie@kernel.org> wrote:
>
> This is quite a quiet release for SPI, there's been a bit of cleanup to
> the core from Uwe but nothing functionality wise.

You continue to have these completely invalid merge commits that don't
actually say what they merge and *WHY*:

These four have one single line of "explanation":

  531558b56be5 Merge branch 'spi-5.15' into spi-5.16
  5fe7bd5a37ff Merge branch 'spi-5.15' into spi-5.16
  66ae258ccf40 Merge branch 'spi-5.15' into spi-5.16
  becbca18ae8f Merge existing fixes from spi/for-5.15

which is not good.

And the ones that aren't one-liners have pointless other garbage in
them in addition to the actual useful information. Things like

    Hello,
   ...
    Best regards
    Uwe
   ...
    base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
    --
    2.30.2

are just complete noise that seems to indicate that you automate your
merges with garbage, instead of actually editing them and making them
be meaningful.

STOP DOING THIS.

Seriously. The commit messages for merges are important. They should
explain what the merge dows and why it exists, but it also shouldn't
contain random garbage from the email of the person who sent you a
pull request.

                  Linus
