Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A532E095
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCEEVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:21:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB6DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 20:21:21 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y67so1246764pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 20:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gz/AcE1P3Yr0Gm3eX8zMColErHy3vzo5LgxPPoJy2Jk=;
        b=kY8V/bf1GuiWwCdaTfawn1N3oYw5qHY4I3d+1frPAQk7kWAFrHlpIOvu6MWLvIOSNA
         cRFUjenXWECOJY5KwAZcVxl74V4+H1TeJ+oZ/gPnA9QdBWLwWOG058/9ebmvpNvYZ8Jw
         aq+eNacU3GkhdfVyygNl0JL2pZee3gPJIE6nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gz/AcE1P3Yr0Gm3eX8zMColErHy3vzo5LgxPPoJy2Jk=;
        b=oER3WEqw+GVEX1h7X2h1JVW58D5DdGPpeSksAHswaHoQNcIN8otM2kAadW23x7ddGK
         zmcAOct5l9cSEeUzixwaX9TsEP7TeotXx1M5YNEqSjOcchlNBxaUi+JO72MQPNgp/SEB
         SlEeGoRe/Ue+QKxucYlBDg3FmU6bUrMRsp58uOG2wZhDHDu4Zgzt/acukOetYM7Sdecz
         JDUjOhd4ZhYZyqVHUj94LW6bNWUHsfNvQY2yT7Caq9Sp2yJuccT7dG5mXNASTwsH/EuC
         /QtWn8rxrZ4LSUxLl2uSqxczkaM0y4oQvJrrl5Fuo1zb9PreBiruQXaZwZeC+0LCpGgP
         KJzw==
X-Gm-Message-State: AOAM531GxOOG2SFsxol22RcZSv5LTUqm8cPgWt5r0sYgDEyDsNUwC1BO
        OxQ+m9oU89GIQ9bdiNHc4zIUHg==
X-Google-Smtp-Source: ABdhPJws3fv+IybUhg0peK6oAerLhUCQfi4i3mhvn/s/0GmTUD9CWZaU7lNW4W47mB+Pa6UAr6NJvw==
X-Received: by 2002:aa7:95b5:0:b029:1ef:272f:920c with SMTP id a21-20020aa795b50000b02901ef272f920cmr4482082pfk.21.1614918080816;
        Thu, 04 Mar 2021 20:21:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b498:4a2d:bc34:b77e])
        by smtp.gmail.com with ESMTPSA id k10sm222492pfk.49.2021.03.04.20.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 20:21:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <95e58426-c7ab-6ba5-17ea-392754899959@rasmusvillemoes.dk>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210304170052.GK2723601@casper.infradead.org> <161488534185.1478170.10285681551102444519@swboyd.mtv.corp.google.com> <95e58426-c7ab-6ba5-17ea-392754899959@rasmusvillemoes.dk>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org
To:     Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Thu, 04 Mar 2021 20:21:18 -0800
Message-ID: <161491807864.1478170.14069558494579871831@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2021-03-04 15:11:47)
> On 04/03/2021 20.15, Stephen Boyd wrote:
> > Quoting Matthew Wilcox (2021-03-04 09:00:52)
> >> On Mon, Mar 01, 2021 at 09:47:47AM -0800, Stephen Boyd wrote:
> >>> Example:
> >>>
> >>>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARN=
ING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> >>
> >> Would the first 12 characters instead of all 40 make it more palatable
> >> without reducing its utility?
> >=20
> > I can't seem to request debuginfo from debuginfod without the full 40
> > characters. It's not a git sha1 hash.=20
> >=20
> >> And I feel it should be within the [], so maybe this:
> >>
> >> WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm ed5019fdf5e5]
> >>
> >=20
> > Sure I could put the hex numbers inside the brackets. I suspect changing
> > %pS or updating the "Modules linked in:" line isn't going to be
> > palatable. I've decided to introduce another printk format %pT to print
> > the stacktrace=20
>=20
> Can you avoid claiming a new "top-level" %p modifier? Isn't it better to
> add a new flag to '%pS', say '%pSb' to include build-id?
>=20

I see that %pSR is used in alpha for the stacktrace. I guess we can have
%pSb and %pSr then.
