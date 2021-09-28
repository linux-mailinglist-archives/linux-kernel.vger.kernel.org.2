Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313D41B836
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhI1UPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbhI1UPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:15:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:14:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t10so1007947lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8SIHGf92dn1sh3tlw4mMiagZZhFPc2x3X4xv5HwhS0=;
        b=dZFxgAV0Q8siRpZwgABvfcPhijJIwvxQdPdbfkhnxtl3T/U9YNLhK/dVtQgKU3uqNS
         qFRj9pbfIPCv1+EzFD2p3S5tfXfnE7dI5ObpL6waARND7DOGeBpKVn4vp6ONsEYCkMG0
         Eqpyj080jq94JcoV0/m+ZgDhth/f6sMK/3zJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8SIHGf92dn1sh3tlw4mMiagZZhFPc2x3X4xv5HwhS0=;
        b=SomPIseuDQsBIOytdzswlud+K4rUwFhp08gXDt/KpWTgQwlHPvkHP+I7tWdv4eW9PH
         w3CCq/JafSHox7uXii33YBlILamn00miDJ9IrKSIHa3AUjsGKY9KOjPab2IT3b6WIy0W
         LVhWZSrW/Oa+7pfQ0vreuBVHNFQII9V79BIlwnnEme9buN1hgVhVH1WBGM2NYlt99xd4
         uaPQkPDNY7//LU+VYU84bQmp7O2u79qijpyzQ9KuDqAZG62Dw3EEH/LOPc2y/gSDzzXq
         UvQVxE02bqWM3ftaXT1eyWjI+TILz/8ItBuqocxNk+8d/k043PXjLneGsutml6+jxtNc
         fntQ==
X-Gm-Message-State: AOAM532vbuS4rxstrdlq7aA+kUOteA8oSNqn+tDv3HHLCkSCCpoTKHqJ
        tVoKRxSIjxbFGsRTwBJXUbKF1cKmVfVdst3i
X-Google-Smtp-Source: ABdhPJyqfS0B2NeheMpKIvSJJ0os00uSrOQNn3+MYXDYKnJbQEV5IYf+fDvVzoW/O0WZmv8qYUk7vQ==
X-Received: by 2002:a05:6512:3212:: with SMTP id d18mr1497895lfe.306.1632860047375;
        Tue, 28 Sep 2021 13:14:07 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h23sm10520lja.131.2021.09.28.13.14.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:14:06 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i4so1094684lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:14:05 -0700 (PDT)
X-Received: by 2002:a19:ef01:: with SMTP id n1mr7733893lfh.150.1632860045751;
 Tue, 28 Sep 2021 13:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13> <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
 <YVC4zz1vCskBMb6I@zn.tnic> <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
 <YVNXWJEeGOqxXIjf@zn.tnic>
In-Reply-To: <YVNXWJEeGOqxXIjf@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Sep 2021 13:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
Message-ID: <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok, how does that look?

Well, cleaner.

You lost the leXX_to_cpu() part, so now it does the wrong thing if you
were to cross-build the tooling side on a BE architecture.

The actual kernel side is fine, of course, since it runs on x86 by definition.

So it's purely the tool side - I assume this instruction decoding is
used for objtool or something.

I'm not sure that matters. BE is dead, nobody would ever cross-build
tooling that way. But maybe a compile-time error, at least, so that
the problem is obvious.

            Linus
