Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6C36897C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhDVXrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhDVXrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:47:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:46:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so15797147plf.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NTeXqBDN9RVYOkJiN+/wuvdDNkn6afObPv6LqlUiqIk=;
        b=AnHm77yTkbagnZpDUZ1ZvFhMZVBtpPSttQwTI8axuBcYT1Llyw/Ft81RHLG76xP3Ba
         N1+NA7LVAwQDlG7HNGG+c1Q9LHDd1zHoAL8OWLgitxiqelTv5XuoRUAYqLZYLMwywsK2
         Qr1e2ZyKIfO96s7ue06+0/zS+viHg0vnQCQso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NTeXqBDN9RVYOkJiN+/wuvdDNkn6afObPv6LqlUiqIk=;
        b=MGyOUEYemoMnvpf+LcyKpZdnyNWLymfahYrm5emCtXpusu/hkS0UooQAlUgZESYnFt
         kt+xcngi6tfSh7UmsNi0Ot0QexMLH6RSQr+7/wGWbOSTd1fee/D6t78m5qlaZP051hmn
         BYB+1eIAdi2A48ocATNtQXzfKGraCG8J7880qJ4eCrTZhDUsB+JxnQox6K1U/N+6HFv3
         hR2MVY4cL8XUCWRoSApLOUSzY9y4Jhq7c5GG//H1AyVVwExjccObHESS1wFBzmPOQG/9
         Bpkd6WuHud3zIZQX09kYmbHlTlAdixuOcjI5MO/uyBOvSjQVloFqo0rCj62KCX1QzBMb
         kV2g==
X-Gm-Message-State: AOAM531e0ld62d3KZdmpcTnPv0ZaVZUjs4rnuGcHF3i/Iwan4EhsLUjS
        VL8ji82ATcq2WBLlIXPGSRKnnw==
X-Google-Smtp-Source: ABdhPJzr1tnc2PiNN73pB/HOg9I0gE61e29pPuXK9MBgVVIXrXWgxVMoUL6I65OwhBtFp1OWRk17MQ==
X-Received: by 2002:a17:903:185:b029:ec:b44d:7c3e with SMTP id z5-20020a1709030185b02900ecb44d7c3emr1038558plg.44.1619135203680;
        Thu, 22 Apr 2021 16:46:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:8893:ffc7:384b:2e13])
        by smtp.gmail.com with ESMTPSA id e1sm3230271pgl.25.2021.04.22.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:46:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YIARTVqnN8t/FA/P@smile.fi.intel.com>
References: <20210420215003.3510247-1-swboyd@chromium.org> <20210420215003.3510247-6-swboyd@chromium.org> <YIARTVqnN8t/FA/P@smile.fi.intel.com>
Subject: Re: [PATCH v5 05/13] module: Add printk formats to add module build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu, 22 Apr 2021 16:46:40 -0700
Message-ID: <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-04-21 04:49:33)
> On Tue, Apr 20, 2021 at 02:49:55PM -0700, Stephen Boyd wrote:
> > Let's make kernel stacktraces easier to identify by including the build
> > ID[1] of a module if the stacktrace is printing a symbol from a module.
> > This makes it simpler for developers to locate a kernel module's full
> > debuginfo for a particular stacktrace. Combined with
> > scripts/decode_stracktrace.sh, a developer can download the matching
> > debuginfo from a debuginfod[2] server and find the exact file and line
> > number for the functions plus offsets in a stacktrace that match the
> > module. This is especially useful for pstore crash debugging where the
> > kernel crashes are recorded in something like console-ramoops and the
> > recovery kernel/modules are different or the debuginfo doesn't exist on
> > the device due to space concerns (the debuginfo can be too large for
> > space limited devices).
> >=20
> > Originally, I put this on the %pS format, but that was quickly rejected
> > given that %pS is used in other places such as ftrace where build IDs
> > aren't meaningful. There was some discussions on the list to put every
> > module build ID into the "Modules linked in:" section of the stacktrace
> > message but that quickly becomes very hard to read once you have more
> > than three or four modules linked in. It also provides too much
> > information when we don't expect each module to be traversed in a
> > stacktrace. Having the build ID for modules that aren't important just
> > makes things messy. Splitting it to multiple lines for each module
> > quickly explodes the number of lines printed in an oops too, possibly
> > wrapping the warning off the console. And finally, trying to stash away
> > each module used in a callstack to provide the ID of each symbol printed
> > is cumbersome and would require changes to each architecture to stash
> > away modules and return their build IDs once unwinding has completed.
> >=20
> > Instead, we opt for the simpler approach of introducing new printk
> > formats '%pS[R]b' for "pointer symbolic backtrace with module build ID"
> > and '%pBb' for "pointer backtrace with module build ID" and then
> > updating the few places in the architecture layer where the stacktrace
> > is printed to use this new format.
> >=20
> > Example:
>=20
> Please, shrink the example to leave only meaningful lines.
>=20
> Why, e.g., do we need to see register dump, is it somehow different?

Can you format it how you would like to see it? Should it be a unified
diff? I agree it would help to see "what changed" but also don't know
what you want so opted to provide more information, not less. I was
worried about the questions like "do you change other parts of a splat?"
so I just put the whole thing there.

>=20
> ...
>=20
> > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > +     /* Module build ID */
> > +     unsigned char build_id[BUILD_ID_SIZE_MAX];
>=20
> Is it really string of characters? Perhaps u8 will be more explicit.

I'm just matching the build ID API that uses unsigned char. If you want
u8 then we should update more places. I could do that in a followup
patch, but this one is already sorta big.

>=20
> ...
>=20
> > +#include <linux/kernel.h>
>=20
> What do you need this header for?
>=20

For typeof_member().
