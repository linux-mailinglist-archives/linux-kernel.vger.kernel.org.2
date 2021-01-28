Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC6306D16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhA1Fn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhA1FnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:43:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF584C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:42:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so6052388lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhPnjfxjWKosRLcoMYR5Wm2UmILCjhnOtStMVrHIlZo=;
        b=cOImc74CqHePwjtAxEuaLrpuwFBajqtxZPIHG1KEWSotICaG0xyVEKWsD9AwBsjnmE
         xrjhSzsAcLK3A5FgHbJ5JlPtvFR3WI1yg6o7rlwYd/RmsIxTIztBYZwQlKmr6NE0+0Vq
         4wcXJAf2Go+VJ/PpIXNq2hi0GAgV8PiMZKmRlYMwDMIWOE61qDFb+eL/MTCXECkuiBvv
         4dnQtChyl4H7GFhY0IO7ZBE5dP9uKZQ99EaKW2PtaZBkzOAhoH0pzme9d3v5UO3k/y9M
         9Jr5BJOrLAljApHI7rme1p9cP4F6H3J0W9do/37462V3e0NwWsc4Rrh4/JpNjrDzxisU
         M1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhPnjfxjWKosRLcoMYR5Wm2UmILCjhnOtStMVrHIlZo=;
        b=oKViTt33kKzEH5MrR8vDfCeayf4oOG3sgXUItyDDgJN6Kn42LIm6HbLx+nEgDXXRbM
         r7M/msy1HzDjMKFuY8R4gzYuWR5LtyBIcbf+0igB+PKbAYQxOIVxVW0jeZWsFHQCHI2e
         Lm8MKTRU+wHYcneF43GAVXbJ9RNj9uI6swkk/5Vf5nAVYl5klH0jBg4/zhSehPcRFrHE
         sxR3aCfWoTV4mobfhi7Fvk13aT5eXlYtuW2ZrNn1Az/pA7UFVPgqRJ/2iQFmjWFcREoH
         AUlgVZOI70YZ+Z++PYXE/mMsQhSJTnmZRvaT9qsCTclAOGwbA4tchi266I63sJ+G4WWt
         YNAg==
X-Gm-Message-State: AOAM531Hz/ZqXUtzgzSjPzEb/HPNQU+Po4xCby5bq6ya5SJhXqG5ppNt
        Dr42c18Gp/L2v0wysUbBFPiCaIYbo7DCYvQwKoes9Q==
X-Google-Smtp-Source: ABdhPJwasdvNPGsQKJf7SHDsVnj4Fk1Js6mJqifm7gRZYPMCbftGz/zNUXuHZB1a8Fctpp13j/ivahehvbMs2qG83eE=
X-Received: by 2002:a19:456:: with SMTP id 83mr6914736lfe.113.1611812559452;
 Wed, 27 Jan 2021 21:42:39 -0800 (PST)
MIME-Version: 1.0
References: <1611584985-12479-1-git-send-email-sumit.garg@linaro.org> <CAD=FV=VOGca=QVmGnUCgtTk5ednPnUXiLekqo77LQ3EknrVXjg@mail.gmail.com>
In-Reply-To: <CAD=FV=VOGca=QVmGnUCgtTk5ednPnUXiLekqo77LQ3EknrVXjg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 Jan 2021 11:12:28 +0530
Message-ID: <CAFA6WYOObMyR3gj3P+VGqpuTM0WQB=+Wh7BchmsXAfEpso4onQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Refactor env variables get/set code
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 22:44, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jan 25, 2021 at 6:30 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > diff --git a/kernel/debug/kdb/kdb_env.c b/kernel/debug/kdb/kdb_env.c
> > new file mode 100644
> > index 0000000..33ab5e6
> > --- /dev/null
> > +++ b/kernel/debug/kdb/kdb_env.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kernel Debugger Architecture Independent Environment Functions
> > + *
> > + * Copyright (c) 1999-2004 Silicon Graphics, Inc.  All Rights Reserved.
> > + * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
> > + * 03/02/13    added new 2.5 kallsyms <xavier.bru@bull.net>
>
> I'm not sure the policy for copying over copyright notices like this,
> but I would have expected them to get copied over from the file you
> got the code from?  These are slightly different.
>

Okay, I will match them exactly.

> > + */
> > +
> > +#include <linux/kdb.h>
> > +#include <linux/string.h>
> > +#include "kdb_private.h"
> > +
> > +/*
> > + * Initial environment.   This is all kept static and local to
> > + * this file.   We don't want to rely on the memory allocation
> > + * mechanisms in the kernel, so we use a very limited allocate-only
> > + * heap for new and altered environment variables.  The entire
> > + * environment is limited to a fixed number of entries (add more
> > + * to __env[] if required) and a fixed amount of heap (add more to
> > + * KDB_ENVBUFSIZE if required).
> > + */
> > +static char *__env[] = {
> > +#if defined(CONFIG_SMP)
> > +       "PROMPT=[%d]kdb> ",
> > +#else
> > +       "PROMPT=kdb> ",
> > +#endif
> > +       "MOREPROMPT=more> ",
> > +       "RADIX=16",
> > +       "MDCOUNT=8",            /* lines of md output */
> > +       KDB_PLATFORM_ENV,
> > +       "DTABCOUNT=30",
> > +       "NOSECT=1",
> > +       (char *)0,
>
> In a follow-up patch, I guess these could move from 0 to NULL and
> remove the cast?
>

Sure, I will remove the cast.

>
> > +/*
> > + * kdbgetenv - This function will return the character string value of
> > + *     an environment variable.
> > + * Parameters:
> > + *     match   A character string representing an environment variable.
> > + * Returns:
> > + *     NULL    No environment variable matches 'match'
> > + *     char*   Pointer to string value of environment variable.
> > + */
>
> In a follow-up patch, the above could be moved to kernel-doc format,
> which we're trying to move to for kgdb when we touch code.
>
> I will leave it up to you about whether the new functions introduced
> in this patch are introduced with the proper kernel doc format or move
> to the right format in the same follow-up patch.
>

Okay, I will move these to kernel-doc format.

>
> > +/*
> > + * kdb_prienv - Display the current environment variables.
> > + */
> > +void kdb_prienv(void)
>
> IMO saving the two characters in the function name isn't worth it,
> especially since this function is called in only one place.  Use
> kdb_printenv()

Sure, I will rename it as kdb_printenv().

-Sumit

>
> -Doug
