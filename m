Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992F135D113
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbhDLT31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhDLT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:29:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:29:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z22so1797021plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=c84g+o0c3EP7qqY5y8zkTye7ebMVv6LO6TcZMlT8scg=;
        b=MeWYUwQCJeqI+FE4nsXwN8sTAeHI2Bqa5FyQWBDZL3ZbmHLDgvG6fJGcBJyLdSDaX+
         a7KZww/47gwlUKO+UMrbw8CxOLHGGmTGda2zTXmjvdDMxi1yEvgqU8SfA6LePhbg4S/i
         M6FseQ3+8tGIzx/GAk+aeuIg76l7Pz2AwEk9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=c84g+o0c3EP7qqY5y8zkTye7ebMVv6LO6TcZMlT8scg=;
        b=FTFfwk6boU9eHS/FQR1CupfbTdjuO31GpIzYrCqhzKqQx11C36LGmVXtTa5rTU+2W2
         mClOW2pkMYAw9uQcSrt1vblEzN00kEWt8hXFkSF/OJAga8NG7qmb+BgRG4DEbnXB+RRS
         qseBL5OivIi1xvN6cl4k94Y6bbMjqKamGFDpO9Acpve4pHEBBYcIuU/XAVmX9GK0NRES
         qGhhgvwHt9k8eGJ2qLUIH4xstyExz4yI4NTP69mUNEajp8ffPsK8IdyMtw9gcV+Eegso
         Dy0HN6eLKh70PwzA42reehskL7/BBFJ+Zn0iGNnvkP9K5DpgF0rGQYefKlM9ccVvRhmJ
         vY6g==
X-Gm-Message-State: AOAM530ukA6JRr66/NM18X9JYRQEOYSBkojIwDJ8ETM5wac96HeZqk8n
        F2nol/29+ENnSUGkjv7ooxjvLA==
X-Google-Smtp-Source: ABdhPJx+kuUumalzsg7BgWOoYJotP9yFE6IfASB994orfa/PZgh98lAHvb4kQyvnpeflAxCV+/IndQ==
X-Received: by 2002:a17:90b:4a04:: with SMTP id kk4mr857303pjb.68.1618255747581;
        Mon, 12 Apr 2021 12:29:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id t18sm12277282pgg.33.2021.04.12.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:29:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YHQ1yqVkweZeN5+1@smile.fi.intel.com>
References: <20210410015300.3764485-1-swboyd@chromium.org> <20210410015300.3764485-6-swboyd@chromium.org> <YHQ1yqVkweZeN5+1@smile.fi.intel.com>
Subject: Re: [PATCH v4 05/13] module: Add printk formats to add module build ID to stacktraces
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
Date:   Mon, 12 Apr 2021 12:29:05 -0700
Message-ID: <161825574550.3764895.4387100574176584209@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-04-12 04:58:02)
> On Fri, Apr 09, 2021 at 06:52:52PM -0700, Stephen Boyd wrote:
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
> Can you trim a bit the example, so we will see only important lines.
> In such case you may provide "before" and "after" variants.
>=20
> ...
>=20
> > -     if (modname)
> > -             len +=3D sprintf(buffer + len, " [%s]", modname);
> > +     if (modname) {
> > +             len +=3D sprintf(buffer + len, " [%s", modname);
>=20
> > +             /* build ID should match length of sprintf below */
> > +             BUILD_BUG_ON(BUILD_ID_SIZE_MAX !=3D 20);
>=20
> First of all, why not static_assert() defined near to the actual macro?

Which macro? BUILD_ID_SIZE_MAX? I tried static_assert() and it didn't
work for me but maybe I missed something. Why is static_assert()
preferred?

>=20
> > +             if (IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && add_buildid=
 && buildid)
> > +                     len +=3D sprintf(buffer + len, " %20phN", buildid=
);
>=20
>                         len +=3D sprintf(buffer + len, " %*phN", BUILD_ID=
_SIZE_MAX, buildid);
>=20

Are you suggesting to use sprintf format here so that the size is part
of the printf? Sounds good to me. Thanks.
