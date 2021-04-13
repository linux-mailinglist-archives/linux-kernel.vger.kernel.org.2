Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3635E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhDMUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhDMUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:37:13 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:36:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l76so12788198pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=UwhGdc46iMWQqFEaIwmWAFlRSRD36hM0PT/2cl0x9I0=;
        b=MsspCibEeo+YX6jSqH6x4AskVUjuEN1wEcxXZ9XASs85zv1vx95OriB+hOOnu3qZNP
         IEyW3+fHT/gjNgMHPTjrZQtf/jmauMpZvL9TYQJ60Qh6mSjTcDSrPLKgkM3KThLxfWqq
         NCBOBzTZuTSkznk6GiYE+aHp+UfdH6d4u1ivs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=UwhGdc46iMWQqFEaIwmWAFlRSRD36hM0PT/2cl0x9I0=;
        b=YeKS8FRKzDFPa7j8FYTHgjDHmPMnYFhGZ0vgMic0QAYAvLYwqpWKtNnOFqwvNCBCk+
         UdU+8tSTBwFayl9DznIFY8FlfSf76D1UIldNmuXc9SKNzfyvOoqHk8csCh7svZmbR5mY
         VABFU/RMjqD2SVDZL4NFabcrF0Ahsa8MeWiPphnAk3qidM2LPZiNF4pxiP0tC7DGd4uc
         ICaGpbk2D+LmSH6zvZDd/QCcSfQJBLTx0hTMfQoNsPdARqj6GWkD9Y8e15CkXVlE9DeB
         gAV2O/xBeFMGqaNrxxWiG2HgcuODfpBYtSa6EpXxomoOgUQfyd8myADQyYDyRMbp/1dd
         P+vg==
X-Gm-Message-State: AOAM532twxX+dLEfNldJqkMzYpNWgcA8I9RwYStd59Yd7JsSK7eUNIAl
        HrigsRdzogkyYlUQuCbcSJ/fvQ==
X-Google-Smtp-Source: ABdhPJx0ib0QrQt6xiGcf5NEDVkDAUwVz7IEMYfzychHTAUMdib/BwPfl5VbHM4VkubtdtX1R/80mw==
X-Received: by 2002:a63:570e:: with SMTP id l14mr33789397pgb.159.1618346211250;
        Tue, 13 Apr 2021 13:36:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id f13sm363569pfc.195.2021.04.13.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:36:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YHWthzF+l0iacMuw@alley>
References: <20210410015300.3764485-1-swboyd@chromium.org> <20210410015300.3764485-5-swboyd@chromium.org> <YHWthzF+l0iacMuw@alley>
Subject: Re: [PATCH v4 04/13] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Tue, 13 Apr 2021 13:36:48 -0700
Message-ID: <161834620810.3764895.16783352875023260799@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-13 07:41:11)
> > diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> > index f5a33b6f773f..d685331b065f 100644
> > --- a/lib/dump_stack.c
> > +++ b/lib/dump_stack.c
> > @@ -5,6 +5,7 @@
> >   */
> > =20
> >  #include <linux/kernel.h>
> > +#include <linux/buildid.h>
> >  #include <linux/export.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/debug.h>
> > @@ -36,6 +37,14 @@ void __init dump_stack_set_arch_desc(const char *fmt=
, ...)
> >       va_end(args);
> >  }
> > =20
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > +#define BUILD_ID_FMT " %20phN"
> > +#define BUILD_ID_VAL vmlinux_build_id
> > +#else
> > +#define BUILD_ID_FMT "%s"
> > +#define BUILD_ID_VAL ""
> > +#endif
>=20
> 3rd patch always defines and initializes vmlinux_build_id. But it is
> used only when CONFIG_STACKTRACE_BUILD_ID is enabled.

It is also used for crash code.

> Is it intentional, please?

Yes, mostly for simplicity with the other user.

>=20
> It is not a big deal for vmlinux_build_id. But it is more questionable
> for the per-module id. I am going to open this question for 5th patch
> as well.
>=20

Right, for the vmlinux_build_id symbol it is not exported, and the whole
buildid.c file is part of lib-y, so if the symbol isn't used the linker
should drop it during link phase. I can drop the early init call if the
config is disabled and crash kernel code isn't enabled, and then rely on
the linker to drop the vmlinux_build_id symbol. Let me see if that can
work so that we don't have to parse it at boot if it is never used.
