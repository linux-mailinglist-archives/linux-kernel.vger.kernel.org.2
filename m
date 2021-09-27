Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7010419EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhI0S5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0S5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:57:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4ABC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:56:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so80513744lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfRTwMwersuCGxd5JCtedM8u457k2mgmO1fTwDc7S1g=;
        b=XVO+vSJum3hTG5MRZK0A2TuuBeaK6wi5Vuo0syE70SESftsXwSeKhqT4v/KupOGnzK
         PHJKKC9g/6XDY0JGtaPo55VwW0Ed2Tm/gu4Q3wRY8Fpw+IsXzScSOlG6b7mcO9a2K4x0
         n10wMyVz2JbglLEVjsap2kmIdhzq15VtU46dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfRTwMwersuCGxd5JCtedM8u457k2mgmO1fTwDc7S1g=;
        b=M9/lfJgaDueGFJFyzkB0ldAjVFWOyAlBh2iGTMlsLuSO9N7xmp6JUw3mfAS5cwMD07
         7c88seseP7rebDktB/ruxzVFNY0AKCEgroSWGkgIeOjpRfdk79j0QXkkziqPA8bwGfzu
         Sj6wNFkYZWAV8qyMkmuJZhCCrXqmwwWmN2q4Guiq7mKh1bkkAzF9BZ4UchG4ho2NHvdb
         rFq/dnI3FonCofjCwgrSaS7UzbjyqHjsCo+/QPDQwsZFzxM7NRC6d6TVws4GSfACDxtE
         PvzPjFt3cTtSN7+VzFNuFe0tlSfq5vdHsRU+nIml/UnjPnTiRtR0QcHKuymjmBOzP0jq
         5G7Q==
X-Gm-Message-State: AOAM532fkbQrMSpo1/Hnt2KJ7Q/919NRA1NfSFtYg/jZ1kqT0YN4m1k4
        oJJd8ThEgJkZdmJdvKrOYv/QnWKKzQX3IqtkVhI=
X-Google-Smtp-Source: ABdhPJxO3AvGaRT7cnOwdHfetdvjp8W/9lHeGo8V4qf7nPx7mjLNH5aJIx7K2upSEXbVfkWF9RxFtw==
X-Received: by 2002:a2e:9782:: with SMTP id y2mr1289957lji.421.1632768970227;
        Mon, 27 Sep 2021 11:56:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x130sm1674581lff.76.2021.09.27.11.56.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:56:09 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u18so80312111lfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:56:09 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr1374199ljc.249.1632768968815;
 Mon, 27 Sep 2021 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
 <20210927110548.GA771805@roeck-us.net>
In-Reply-To: <20210927110548.GA771805@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 11:55:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
Message-ID: <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
Subject: Re: Linux 5.15-rc3
To:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 4:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Sep 26, 2021 at 02:21:52PM -0700, Linus Torvalds wrote:
> > So after a somewhat rocky merge window and second rc, things are now
> > actually looking pretty normal for rc3. Knock wood.
> >
> > There are fixes all over, and the statistics look fairly regular, with
> > drivers dominating as they should (since they are most of the tree).
> > And outside of drivers, we have a fairly usual mix of changes -
> > architecture fixes, networking, filesystems, and tooling (the latter
> > being mostly kvm selftests).
> >
> > Shortlog appended, it's not too long and easy to scan through to get a
> > flavor for the details if you happen to care.
> >
> > Please do give it a whirl,
> >
>
> Build results:
>         total: 153 pass: 152 fail: 1
> Failed builds:
>         mips:allmodconfig

Gaah. I assume this is the

   arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error:
"M_SPC_CFG_CLEAR" redefined

thing still.

It's been pending too long in the mips tree, I'll just take the patch
directly and finally empty your queue of build failures.

> Qemu test results:
>         total: 480 pass: 479 fail: 1
> Failed tests:
>         sparc64:sun4u:nodebug:smp:virtio-pci:net,i82559er:hd

And going back to your -rc1 email, I see

 "The qemu runtime failure bisects to commit 694a1116b405 ("virtio: Bind
  virtio device to device-tree node"), and reverting that commit fixes the
  problem.  With that patch applied, the virtio block device does not
  instantiate on sparc64. This results in a crash since that is where the
  test is trying to boot from"

That commit 694a1116b405 doesn't revert cleanly, but the conflict is
trivial (we've removed a "return 0" since then).

I've added the guilty parties to the participants list, but if this
test failure remains in rc4 I'll just do that revert at that point.

> Almost there ...

Almost.

               Linus
