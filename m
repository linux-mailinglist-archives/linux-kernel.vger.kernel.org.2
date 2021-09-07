Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A775403022
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbhIGVNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346913AbhIGVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:13:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF2C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:12:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g14so737823ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ok/njKfAvMbY2bs8maF3NrOkKRGpfJfru97+63nEmx0=;
        b=s5GWSDpWu58oD3yAVhObs6Mh+1cMdtz92XNa1zuBbI6zNg77xE/cZQtEPx1dvWyUAE
         O5nW526vH9R9SLJW3hMzS8RvqeQP05lD05Iiv/rjMguHynIjSNik9ORM1WIu2zVHOgT1
         w4wXkZb2qvOBAhfjNips1c4HyGBCS7lNmJRXfbPIQr7u2ca+BWXUuu2ZWY3TnTpYitm/
         SKOD8y0ZzXnofhBCV1apS89d5XBbxSfEzN/aManxLp+cnEZHVIiujBmIZ6mEbKAs6Seo
         6mzixEwWA6e/qxVkSk5YGnfjRnaVThBhzKyiOjDN+EGikwGVVEjb7bN6bArv9lo5wOMT
         mBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ok/njKfAvMbY2bs8maF3NrOkKRGpfJfru97+63nEmx0=;
        b=e7NMkodB65wc4rtaOEYVYbvMVYKEJXRAG8Ltvs7Jek7JrsvcE9UgmLmlq/Hm1gX55r
         +ysJU2TVnTor9FGxX93AAo0MDuzKnekf3ppAOe1sKV7J8XJi6am2dRX8z+1hke4h9e07
         ZDbOlyqGKQsQfwKz+ifbdOybPaNBM2s1k0gAQJh0Id86s4sd7vhdiPVvNUaAhiNtK8IV
         AJNwjL6JOhp+Q5YKen3O8rV3a8QDt+vXOfmo5smpJaz9oaUlFMhgnmDaCDbhhsVOZiHp
         Ad+nBKQD7wemf79jC8z5Z0fyaG85pbJOqwJNJTuVW6xDqye9iO50vNkqTUEss/X5eaan
         eIog==
X-Gm-Message-State: AOAM5311AZXnvxELgTk2eyxGv72Sb+ZFRUVVJ7tJMqSL0s+YRWCIxc3E
        8XOGOIUh3kKbDaXDKXSNGzCfRI1aeM8B7eU4qkfF7Q==
X-Google-Smtp-Source: ABdhPJxVo+5dn5sq45dUKKInWfHLLjgHn3FLUSHTGeHvskAHnwqBIY7lN084fuzpwYdZCUlevLaVgY+8bT403lYcb6Y=
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr184279lja.198.1631049132456;
 Tue, 07 Sep 2021 14:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com> <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com> <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
 <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net> <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
 <36cf9869-4e4d-e0c6-bf71-981285bd8041@suse.cz>
In-Reply-To: <36cf9869-4e4d-e0c6-bf71-981285bd8041@suse.cz>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Sep 2021 14:12:01 -0700
Message-ID: <CAKwvOd=HfA-08N6LqCS54QcYBcuRgqjcuhVk0dioEte_DxqVqg@mail.gmail.com>
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 12:36 AM Martin Li=C5=A1ka <mliska@suse.cz> wrote:
>
> On 9/2/21 19:05, Nick Desaulniers wrote:
> > IIRC GCC only
> > added the attribute recently in the 10.X release, so it might be too
> > new to rely on quite yet.
>
> The no_stack_protector attribute was actually added in the GCC 11.x relea=
se:
> https://gcc.gnu.org/gcc-11/changes.html

Ah right, that lays more weight though that this feature is still too
new to rely on quite yet.  Martin, do you know if what happens with
regards to inlining when the callee and caller mismatch on this
function attribute in GCC?  This is very much a problem for the
kernel.

> Note the compiler is definitely used by Fedora, openSUSE Tumbleweed
> and other cutting edge distributions.

Kernel supports GCC 4.9+ currently. This feature can only be emulated
with the coarse grain -fno-stack-protector (or gnu_inline with out of
line assembler definition...:( ).
--=20
Thanks,
~Nick Desaulniers
