Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078E830B458
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBBBBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0467064ED9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612227650;
        bh=6up2FSaK1BJFWLnx1k3/f3OqWdD1+OvwXvG0NeO90dE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Evhtffb1TBl820knsyk5ohj/ysj57SxUwCzCrjpKebnUKSKjAqGA7CMSwfIFVjFXF
         jqBym0LQyLZLHcEnFZ4KTxxSfRHenJ2stwVO9OiIC+dFWPASGMGnBjlccBSBoHanUc
         tOufu4PnlhWuSFg3TJxwGG5HU7AM8NEiE3iuHtFGBB5atzaT5b0FyOkZ/QQKftDlJC
         K3AzaDo4WqNJytWfhr66gx+KJ2BChnzX2djoniydjFAxjF1wUDKs17DFO+GF1ILIhH
         s8rOO9TF3gJIQ0yoB6sHdFTO0HUYnxO13TFTR9mbaswTTB7gKX0hPyDLiINojx9dKS
         INOxWVHzm3Xlg==
Received: by mail-ej1-f48.google.com with SMTP id b9so7712225ejy.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:00:49 -0800 (PST)
X-Gm-Message-State: AOAM530dbNeUQYUqf7A0CZpJ1TtW1C93nczJR+O1yhhGC9i+U1nJwwFm
        T5yN6Wqw9u/QvGblRRvfC+z/5JA6MwxE7rgR4zrXtw==
X-Google-Smtp-Source: ABdhPJwkp1pl/FWgaj6LM3lrJ68pn7mlyyo+X+L+ZHuogNUebFBtsWmDnGKRtDgu/akxsTmRrQjaL3vUDidUWYOSYT0=
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr20670387ejn.214.1612227648587;
 Mon, 01 Feb 2021 17:00:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612113550.git.luto@kernel.org> <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
 <20210201090840.GB3229269@infradead.org>
In-Reply-To: <20210201090840.GB3229269@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 17:00:37 -0800
X-Gmail-Original-Message-ID: <CALCETrWh7VzmSJLN5A2+rLsFnXAd6NVy9SmXJ-XB6FcTcg3yUg@mail.gmail.com>
Message-ID: <CALCETrWh7VzmSJLN5A2+rLsFnXAd6NVy9SmXJ-XB6FcTcg3yUg@mail.gmail.com>
Subject: Re: [PATCH 06/11] x86/fault: Improve kernel-executing-user-memory handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:08 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jan 31, 2021 at 09:24:37AM -0800, Andy Lutomirski wrote:
> >  #if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
> > +     if (likely(boot_cpu_data.x86_vendor != X86_VENDOR_AMD
> > +                || boot_cpu_data.x86 != 0xf))
>
> Same nitpick as for the other patch.  Maybe we wan a little inline
> helper for the specific erratum that includes the vendor and family
> checks in adddition to using IS_ENABLED for the config options?

I defer to Boris as to exactly what condition we should check here.
