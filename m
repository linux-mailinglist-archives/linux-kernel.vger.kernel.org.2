Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95C32472B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhBXWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhBXWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:54:36 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:53:55 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id j14so1942410vsi.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtmcRer6hQJigU7MJiHWoawVGnAqfvAooXVPraxhhQ0=;
        b=gAqE4xzTxQYvXiIGJe5ngRwBo6wJZVfNwOdZjbKJx0i6Y7qkf4Ota2cfK8xMcAOXwt
         sUBOo40zSCLd2r6s+zBJRZlymgugeg7tMYbsS7SU2+2WnLk0KTg4sa2+/mR6eQRIn6kZ
         0EWNadiqsMWqXKDZom5rXgyrRk6GXpcGdpksbp4ktNiompA645Qw+9kuWnYnVcdfH9Nd
         X0kmBLPyIpmfCKDVA7g4bPslcHWYq1B+gStdhbLpElapeLaIMwruuLuyATVZYquvEOeu
         ILe7uNDqE/Jo3VcEvO/GXveOzpxPiiaczBQy92Y2RVpxMmJvCsnbyrxrwt2OiKq7La4C
         JPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtmcRer6hQJigU7MJiHWoawVGnAqfvAooXVPraxhhQ0=;
        b=mhL8/8lpBv0x/NXHaPSCVrP+y+lbuDxmIoRahsV1OFjGzIAXaiTWowchdmUSaN3Y11
         n3FjlfObzSGRZEEonDJEMk4jYkk5/SJLS2VD4hx5GtZoi3Pk/i86nImKLSwJ5fURnxhB
         8dr4ceDeM0gydRnLtMIwAIgb9m1LnEnd1i60bjwfI9SimdZMf98TftHETBexzwXCRo+Y
         Ovr+sOpS3PVT2UGiLJvsieXfISdRV8G4O9e0/z9L9KjZXMBLPhkbSOpWHVA7a2bz3qLp
         lvlTAOTUbO2AbKsAqmh833UwUuchZFzILgww2bhi0yzT7VG3VxkieItJjl5ykm2AnpxB
         WWNw==
X-Gm-Message-State: AOAM531YAD37PNhynuTiSnCPYWZuFlmPkWA6fKWCPXwaDf14XLy7R1PE
        QuTHjigEWHXcQ0QMB9HXaTHU4ATPqs3kWiOt0puXvQ==
X-Google-Smtp-Source: ABdhPJz9amPAf+Mcj7QcjJv+23lplTdEhk0bnuRNpc4wa+h3p96afBwfpClgfE2R2bLtMWCvDR1eh9xiXZAPseNNXTo=
X-Received: by 2002:a67:c82:: with SMTP id 124mr87583vsm.54.1614207234779;
 Wed, 24 Feb 2021 14:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20210224205938.4104543-1-samitolvanen@google.com>
 <202102241301.226812E88@keescook> <20210224224634.GC74404@roeck-us.net>
In-Reply-To: <20210224224634.GC74404@roeck-us.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Feb 2021 14:53:43 -0800
Message-ID: <CABCJKufAXX-jsfsdHgrOhvc7SCr3T4aT4TBuf1JpedLFu-VUcQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 2:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 24, 2021 at 01:02:27PM -0800, Kees Cook wrote:
> > On Wed, Feb 24, 2021 at 12:59:38PM -0800, Sami Tolvanen wrote:
> > > parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
> > > don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> > > to tell that to the build system.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Fixes: 3b15cdc15956 ("tracing: move function tracer options to Kconfig")
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > I've got parisc building now, and can confirm:
> >
> > Tested-by: Kees Cook <keescook@chromium.org>
> >
> > Guenter, does this fix it for you too?
> >
>
> I get this:
>
> WARNING: unmet direct dependencies detected for FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   Depends on [n]: TRACING_SUPPORT [=y] && FTRACE [=y] && FTRACE_MCOUNT_RECORD [=n]
>   Selected by [y]:
>   - PARISC [=y] && HAVE_DYNAMIC_FTRACE [=y]
>
> when trying to build parisc:defconfig.
>
> I think it should be
>
>         select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
>
> (no HAVE_)

Ah, it depends on FTRACE_MCOUNT_RECORD. Thanks for testing. I'll send v2.

Sami
