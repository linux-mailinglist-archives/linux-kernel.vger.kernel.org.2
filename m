Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777143E37C2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 03:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhHHBBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 21:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhHHBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 21:01:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35600C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 18:00:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f42so26209648lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 18:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jg+z5UT6dR3yxC3V2/tVo1HaIM6Ux+r5uAtmBe0kOy4=;
        b=LFRR/oe8Yelq9ZLPgIb9k3XoKoccqOj5ZUOZPP+ARC433jYL8DEoz9DvHSweZWz2fw
         1LcfJLZXFJkYh+czcq+c0dCzY+ZcKzCMpm/IcXKRjhyhn1queP55qZzs2q9Qtp3MiVtl
         acCHUfmfv25IyM7cmWTHVlPo+5M3cdtp7/awA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jg+z5UT6dR3yxC3V2/tVo1HaIM6Ux+r5uAtmBe0kOy4=;
        b=pbLwutaTIRF+pqxA9l5SnWMQzGyCJFzibiDMR0fwrvFVmHORUqdOtCVbiu1UuFeOn2
         Xx06LPZThZ9SzzBoLdvmWvJy/6AxxThm+j+3zhWNtt5A3QQVaANddlvnTR1Lsp687cfH
         45UpWzHAaLrFY9woCINCJ8j1gvhGB8KqSWyeDo7p85hUYa1LZgknFdoBN9GRBQUCryp1
         u0CACjgU9SgIzKzQkq4fV1LIFNxMhNeUwy1G+FWYnSpgBKPyzs7planRJijNxjkri54U
         RL2d/xRKNhVOpuW+Ol/Vw6xdDNQJ6EWE3o7h3dbtb2Y+YVhyad0j8melBcfH/IizQiWD
         KuwA==
X-Gm-Message-State: AOAM532GZRnEBg963WRBFCzehCfrqmLRNgRCfbzGivDNW95sLJfVqjCn
        CeXQYngq7XjxxJV7nsKhhnx/CnJkoaX6jC2L
X-Google-Smtp-Source: ABdhPJxviURpxgv/sjwiL7U2BwsXwaP8oA6+N9Cp+wTQuBjrUEw6IAHKz+leX2pdTpVx9mm5tmn0XQ==
X-Received: by 2002:a05:6512:33d0:: with SMTP id d16mr6226955lfg.348.1628384440316;
        Sat, 07 Aug 2021 18:00:40 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l14sm1277031lfc.54.2021.08.07.18.00.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 18:00:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c16so26286853lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 18:00:39 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr11841342lfa.421.1628384439379;
 Sat, 07 Aug 2021 18:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
 <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
 <20210807050314.1807-1-hdanton@sina.com> <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
 <20210807091128.1862-1-hdanton@sina.com> <CAHk-=wh+z6ePDWhCX-EfypR-9VyHf8j_cQyOETOHtSzC6LPNAQ@mail.gmail.com>
 <20210808004243.2007-1-hdanton@sina.com>
In-Reply-To: <20210808004243.2007-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Aug 2021 18:00:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=CdjTFEsVb7wr+ZEyNKoM2JBdvdcTGJqW5EeQPqzFdw@mail.gmail.com>
Message-ID: <CAHk-=wh=CdjTFEsVb7wr+ZEyNKoM2JBdvdcTGJqW5EeQPqzFdw@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 5:42 PM Hillf Danton <hdanton@sina.com> wrote:
>
> Given the syzbot report, I doubt 3 is correct.

I doubt your whole scenario.

> If 3 is actually correct, however, the fix in this pull request is
> incorrect.

Why do you not accept the fact that the old code was buggy, and the
bug was that the alloc->find didn't increment the count from 0
correctly under the lock?

The fact is, the commit in question is ObviouslyCorrect(tm), and I
don't understand any of your arguments against it.

The old code would look up a uncounts entry, but then drop the lock,
before incrementing it.

That explains *everything*. It means that you have this basic race:

Thread (a) on CPU1: starting out _without_ a reference to the
uncounts, look up entry under the lock, but don't increment the count,
release lock.

Thread (b) on CPU2: have a reference, do a put_ucounts(). Count goes
to zero, take the lock, unhash it, free the entry

Thread (a) continues, increments the count on a UAF entry, triggers KASAN.

Look, the fix in question _fixes_ exactly the above. The KASAN traces
clearly show that alloc_ucounts() was involved. Now it does the right
thing, and it does the count increment under the lock, and the
put_ucounts() thing atomic_dec_and_lock_irqsave().

And this isn't even an interesting case. This was not a subtle bug.
The ucounts code had an _obvious_ and unquestionable bug, and handled
this wrong. The ucounts refcount code wasn't even doing anything
unusual, it was just doing it BADLY and WRONG.

This situation is _literally_ why atomic_dec_and_lock exists in the
first place. The fact that the ucount code had missed this all was
just a sad and pitiful bug, and it was just embarrassing that we
hadn't noticed the obvious problem with commit b6c336528926 ("Use
atomic_t for ucounts reference counting") earlier.

What it is you claim happens that _isn't_ just due to this stupid and
trivial bug? Because the scenario you outlined did not make sense, and
I've pointed out _why_ it did not.

          Linus
