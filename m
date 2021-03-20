Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637A342F35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCTTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:18:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E298C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:18:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a198so15100670lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVNqh986E52U93S+Xl3r6awL7z3dUtOFYc3bgu+oIXg=;
        b=ZwgK1qvl23/gFe170eG0WMX0xqWAH7nCJr3BD91hAZ2cSNe8zVq2W14ahSXrh3wD6d
         m2GedAPvKaiJp6gRXkow9DP84VvHm8t+f5F4GTXcZAD5QJtJWXRuAZNs5GHx+HTBX03M
         KFEeM4tShubhnQ1pVZoZSBp+1xU0QW15i1geU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVNqh986E52U93S+Xl3r6awL7z3dUtOFYc3bgu+oIXg=;
        b=OTykfmFSU2vu8WxZS4HQAB7AfHR4klZhwiRX3a6cDtKv9wn7Op+NDir5pHZggCy3Fc
         oswhkmOHs65tbVz8FMHCHVBQ2TXhlkRKLAuuMT+i2bNuXbwpWbA3fdqzD6lWAsBUpLn8
         x5VnAkELWmrJ22zTU2a7HCv+RLamVlrEwupEHMH8g347bNDuZQv//7h+8gqfhoMzIPfu
         RHQwnSwkn5dBN8VDxZJkXLIRpPusm31hVjfeIbp1t9wR2mGk4S3GP39nhHuSK4xIVwRy
         YIzNqRKDqnB5ZCUmGFZI+t6RHlUaasbIe6T1JZQlZox+btFAasInpFRO4m9Q3fANP+z5
         TZfg==
X-Gm-Message-State: AOAM533RJidxSbmHpmSyHIzojmLxc+7flB6a5zaxMXjSskiPH3kyPyGN
        za4T1FlA/DqUakDAzePaoL1LzQ7J846PVQ==
X-Google-Smtp-Source: ABdhPJypY3AwcW/h4di1GSav+eerGGeYZfeKJLiiiaFVBM81YRiHUVM3MypobbwvjW1Z3q3uxtPEhg==
X-Received: by 2002:a19:607:: with SMTP id 7mr4387624lfg.433.1616267912766;
        Sat, 20 Mar 2021 12:18:32 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y8sm1267885ljk.9.2021.03.20.12.18.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 12:18:31 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id m12so15104937lfq.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:18:31 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr4170310lfv.421.1616267911421;
 Sat, 20 Mar 2021 12:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210320153832.1033687-1-axboe@kernel.dk> <m14kh5aj0n.fsf@fess.ebiederm.org>
 <CAHk-=whyL6prwWR0GdgxLZm_w-QWwo7jPw_DkEGYFbMeCdo8YQ@mail.gmail.com>
In-Reply-To: <CAHk-=whyL6prwWR0GdgxLZm_w-QWwo7jPw_DkEGYFbMeCdo8YQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Mar 2021 12:18:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
Message-ID: <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] PF_IO_WORKER signal tweaks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 10:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Alternatively, make it not use
> CLONE_SIGHAND|CLONE_THREAD at all, but that would make it
> unnecessarily allocate its own signal state, so that's "cleaner" but
> not great either.

Thinking some more about that, it would be problematic for things like
the resource counters too. They'd be much better shared.

Not adding it to the thread list etc might be clever, but feels a bit too scary.

So on the whole I think Jens' minor patches to just not have IO helper
threads accept signals are probably the right thing to do.

           Linus
