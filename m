Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C463F3E37EE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 04:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhHHCF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:05:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA0C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 19:05:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so26536365lfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX2HTwzZggvD+/CG61KYTnOmRYH17ci9lhlwr1XzV1c=;
        b=TMYKQYYWfjMKw53n6WsGGumD7deDc4aNbiJ+2vEfxx6coxwbwAIzR+jhqmDcGTBj/X
         3zTFGg3uV8Z6B32I0XoIXJrR+cNVWn8YUv9ZYHGwXRzWA52KhiaPhlLaPwNzJD0ROKK/
         qhcMU3HbgWzRiIklt59Ihq7YcQg4RK1cyVYPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX2HTwzZggvD+/CG61KYTnOmRYH17ci9lhlwr1XzV1c=;
        b=BqYZVEgkcZ8ohasruJWCJj3x9lvxqjEMmaWlCPPhaqZMGLXUpL8yAe0C4xG/sMKprE
         KfLAhak9YhNJf0EDOG8Exr52r/1Ndujsf2y8oCGB31435fu3fE8KRXPsgoGb+iEf/kNZ
         hWUx5r9TeTMawZNH7uH6T5LsIavqMkNxN4jz/FALFvSXGmcqWuk5KXC+Yx3QKK2mNXCB
         i8R5t8cWEEZYeSnxJVDmWtFGZrhuQgDL7KKgVw2L+LbIpZAWKrSnNT3VCDflmEJ+LtfD
         QW0rJxyiaV6Wi9Fs5Wt/BR5UCCVAKjdgduxg5sUGqjUw/7BiX6NDXYUx/7sW1Ks5WV4x
         9eAQ==
X-Gm-Message-State: AOAM533Q5VXeLceyfDozSxA4IPVTX/PeIBZi5vzVCVy7FaYBoH+Gi/DY
        DZIt56QY8dfTpDEuJtvwxdmi2IpS8Lf0Y2Jj
X-Google-Smtp-Source: ABdhPJxYV0nVdWHyl3lxV+vYhiuDstuHFuBAQjRgLPJWWG5G9e/R6sawJKpOEfwtKz6u/X+AzP8otw==
X-Received: by 2002:a19:d609:: with SMTP id n9mr12267870lfg.198.1628388337825;
        Sat, 07 Aug 2021 19:05:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z25sm1284985lfh.283.2021.08.07.19.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 19:05:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n17so1199044lft.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 19:05:37 -0700 (PDT)
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr12600516lfp.253.1628388337111;
 Sat, 07 Aug 2021 19:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
 <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
 <20210807050314.1807-1-hdanton@sina.com> <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
 <20210807091128.1862-1-hdanton@sina.com> <CAHk-=wh+z6ePDWhCX-EfypR-9VyHf8j_cQyOETOHtSzC6LPNAQ@mail.gmail.com>
 <20210808004243.2007-1-hdanton@sina.com> <CAHk-=wh=CdjTFEsVb7wr+ZEyNKoM2JBdvdcTGJqW5EeQPqzFdw@mail.gmail.com>
 <20210808012056.2067-1-hdanton@sina.com> <CAHk-=wiKuUWiX_7joreSoiqwreGXBoY-1OhGFAV5QCO+ekmQKA@mail.gmail.com>
In-Reply-To: <CAHk-=wiKuUWiX_7joreSoiqwreGXBoY-1OhGFAV5QCO+ekmQKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Aug 2021 19:05:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL+O8tw=GKOZfwAwi3RfR72HqHrj227bwfHijQq57fSg@mail.gmail.com>
Message-ID: <CAHk-=whL+O8tw=GKOZfwAwi3RfR72HqHrj227bwfHijQq57fSg@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 6:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because that fix matches the syzbot reports I saw. It explains them
> 100%, and the fix is clearly the right thing.

Just to clarify: the exact symptoms of the race before that fix can
vary. The simplest form was the one I described:

> Thread (a) on CPU1: starting out _without_ a reference to the
> uncounts, look up entry under the lock, but don't increment the count,
> release lock.
>
> Thread (b) on CPU2: have a reference, do a put_ucounts(). Count goes
> to zero, take the lock, unhash it, free the entry
>
> Thread (a) continues, increments the count on a UAF entry, triggers KASAN.

because that one happens immediately. But a more likely one is
actually that the "Thread (a) continues" thing happens _before_ the
entry is free'd (but after thread (b) has decremented the count to
zero), and then what happens is that thread (a) doesn't actually
trigger UAF and a KASAN report at that point yet.

Instead, thread (a) will install the pointer to the - free'd - ucounts
somewhere, and the UAF will trigger only rather much later.

Which makes the KASAN reports much harder to read, of course, because
by the time you actually access the invalid uncounts pointer, the
original *cause* of the problem is gone.

So I described the "easy" case to see, not the only one that that the
bug in b6c336528926 ("Use atomic_t for ucounts reference counting")
would trigger.

But commit 345daff2e994 ("ucounts: Fix race condition between
alloc_ucounts and put_ucounts") really is the obvious fix for an
obvious bug.

Could there be _another_ bug? Sure. Fixing one bug - no matter how
obvious the fix - doesn't guarantee there isn't something else lurking
too. But if so, I haven't seen the syzbot reports for it.

            Linus
