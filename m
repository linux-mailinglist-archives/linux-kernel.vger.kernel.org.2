Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D642041BA87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbhI1WqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1WqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:46:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:44:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g41so2599505lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYJVoviJY8TMGuOWbCC+tyKsm4KUxh0hh5HWyYvACfQ=;
        b=fBisgnJv7fb9yfTNQ2Bfq1goFshMLMNje8uvJX+QOCNkpQpkzFbg37hEYgk+U00MnY
         A2KmXKN+1R2CZ4Ia1+RbsKXIHChImQlf7L5U48iQxuzWLjrWdLQ9kSxDPhrR1DTt2Q3d
         l3Wh6k2UuNbcqDMrQNuilDh7oeeW1VePL6X5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYJVoviJY8TMGuOWbCC+tyKsm4KUxh0hh5HWyYvACfQ=;
        b=sPaf+echGVGKygd2aZsMADrhdBKuGchbPP91VSHj8TsWylHYUeAIZrHg60dBho5S+p
         Wy4cyTToQ8T8ErPul9588wdq1wjD+bWFb7qwFwvfwjMmi2p45yxbOXYss1IRhV+ilr0d
         XHZmajt7OcS+jBKeD/S6cOvifS7D2q9KF56nMz/Q9fjqYDbm9xnYvLXC97QYTnZfJh6H
         vYqviyZ3onCcPcaeUUKVI/jNFUIRqDm7Cmat/Da/hhVwGCNxurj/LhFDAW8JPJzTBsmc
         EgLeMKMXQxAg6lTy9LO5HBy5TwKoh4J8g1xz+iF6ZXcPynKWXKd4lfkEjE3fXJnLQ/W/
         DX9A==
X-Gm-Message-State: AOAM53117XkDPt/dVfSUQnKEU9KpXw3TmH+o0Et+lfrXsc7Rlu29/fAk
        +MM+ex1gTc9qZPbGuqFXJQL0aTViketn7rpT
X-Google-Smtp-Source: ABdhPJwsDCnoeGwVYp6V3ho+/pc4rgjNlr77RYy8b3JTq+JV7HgMJrcazjeTKkpNcbGJpj/Wyv+PVA==
X-Received: by 2002:a05:6512:1308:: with SMTP id x8mr7921267lfu.447.1632869068730;
        Tue, 28 Sep 2021 15:44:28 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 5sm53814ljj.13.2021.09.28.15.44.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 15:44:27 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i25so2490472lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:44:27 -0700 (PDT)
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr2635770ljb.31.1632869066947;
 Tue, 28 Sep 2021 15:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13> <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
 <YVC4zz1vCskBMb6I@zn.tnic> <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
 <YVNXWJEeGOqxXIjf@zn.tnic> <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
 <YVN94ojuLApdN1IT@zn.tnic>
In-Reply-To: <YVN94ojuLApdN1IT@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Sep 2021 15:44:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyNDcrS1nEskxdes38wAajF+4B+cFwh4HCPhPEDvFL9w@mail.gmail.com>
Message-ID: <CAHk-=wjyNDcrS1nEskxdes38wAajF+4B+cFwh4HCPhPEDvFL9w@mail.gmail.com>
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

On Tue, Sep 28, 2021 at 1:41 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Bah, I got carried away with the axe...
>
> And looka here: 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles")

Ahh. s390. For some reason I thought they were LE too, clearly
incorrectly. So yeah, there still are serious big BE machines that you
might want to cross-compile from.

             Linus
