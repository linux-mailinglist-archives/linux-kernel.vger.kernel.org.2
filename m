Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2D3EE361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhHQBdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhHQBc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:32:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481DC0612E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:31:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so38207262lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWD6IuudwvXHVLZghwIzB+7q/RK1CR9TCJ3QiGpBNMU=;
        b=CthTApjFsNdNUwolGv/t0aOmUlGyk5zpS52tTxKbEj3xNDrs4pRENTCs9r8EdmptPe
         P8vq+xfPlfQ8KXE9gP+Kl8SB03dM4x+DWeI+FivIkJcxKhqzVKlk/UwEZjFUNWZF1pzM
         q5ugXXNNUTJw3qFd/cEnzRG2t8IhQC00kI350=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWD6IuudwvXHVLZghwIzB+7q/RK1CR9TCJ3QiGpBNMU=;
        b=h+rdZfpIS4Th/UcDvlIoh1sNEZCOAYo6Qw9U/ok5mUX0Ol1aGyJvVAkTAIUBwtpOYN
         2LsHUAzYKlyrnJGJxsysvU9vwpaFM2oQ/0xafu6ck8t8i9H2qK+i9ufwhWAbRpJ3Hl++
         IXPOS6VozGaXsF6Tfgk8LZBDyUONVimk4mMJqJK4rveojtIqARTMi4f1FBf7JMpq0gzx
         CObo+sHnULIfkMwTK6VU4iMeBM4ONRdMNcGh5RrI7t8mQk0vZ7uU6NcW7H3Nnb61APM5
         CBBrmJA+bM4R1hMbGfZzAhL7tCXHWuzdn86n/Yh76xJBEw524w4j9FVZ5cYZ2zYidBeB
         QldQ==
X-Gm-Message-State: AOAM530BzAhdO/Fp4Rns9JMjLsBDoOBWVyT4acOHoGJbqbTjftRtWJyi
        gfGaEQ7St3Gf5CuLfE5xXlofhdPDNNGr9WWi
X-Google-Smtp-Source: ABdhPJzFLINpK1U4YiCLpe51FRSKM6CFZ0M2tfIcX4aqJBzYku+Atr09nYjyBvLzRWVNwrVpx5PlYQ==
X-Received: by 2002:a19:ac07:: with SMTP id g7mr516261lfc.236.1629163910773;
        Mon, 16 Aug 2021 18:31:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id bq33sm48702lfb.88.2021.08.16.18.31.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:31:50 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id t9so38207203lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:31:49 -0700 (PDT)
X-Received: by 2002:a19:500e:: with SMTP id e14mr468759lfb.487.1629163909695;
 Mon, 16 Aug 2021 18:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210813224131.25803-1-rdunlap@infradead.org> <CAHk-=wj4chmL3TUdXHhAV+eU-YVNj-ZtZBjNJEFBzTnPMP3_bA@mail.gmail.com>
 <CAHk-=wgnvC=Tyejg_ts1O7yZYRxAgS+mxStCWM+PcyFPnaw1sw@mail.gmail.com>
 <CAHk-=whP8o-K2=WWQm=cqx5YTpZcb+KCVvomZ+NeV19CsBMp3w@mail.gmail.com> <4eafc072-1837-737f-973a-a4e0c815cebd@infradead.org>
In-Reply-To: <4eafc072-1837-737f-973a-a4e0c815cebd@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Aug 2021 15:31:33 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiA2wnA-3_iVjN9kUf-Gve2jD8UzDkvhDGLg=R=O1vN9g@mail.gmail.com>
Message-ID: <CAHk-=wiA2wnA-3_iVjN9kUf-Gve2jD8UzDkvhDGLg=R=O1vN9g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use -Wno-main in the full kernel tree
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 3:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> That sounds likely. We can just ignore this if you had rather go that way.

I'm happy doing it, I don't think the Wmain warnings buy anything for
the kernel. My main worry is just that some compiler version might not
support it at all or similar, and it would cause problems that way.

Which is really the only reason why I'd like to narrow it down as much
as (trivially) possible.

It doesn't sound worth trying to pinpoint exact gcc version, but
making it gcc-only would at least narrow it down a _bit_.

                  Linus
