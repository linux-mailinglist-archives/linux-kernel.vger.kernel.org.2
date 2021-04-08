Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0057E357BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhDHFg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHFg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:36:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 22:36:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so576127pgj.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 22:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gOhPIYPxLTtIj6swyLzTqCfJIXn8QSZHEweUbL4PxTI=;
        b=ATB1Oiv7JHIb+CimHENN4Sk5QKrt/O79rOfl+rtjBjZBxe2SBI6QWLKRvvJL2+lj0q
         uTkPrGw7dtI6xLfhfcoQo/e6Dokx+4IJAQmR/9kUltN7pkc3T301xF2DqrbQ+A7rYSPE
         8oFw1862rmDVEgZbUI0yqfbcjbzolcdNvWnXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gOhPIYPxLTtIj6swyLzTqCfJIXn8QSZHEweUbL4PxTI=;
        b=gINewg1I4ff5bpg2iWb0/toWphQanbRRBwILgdTcihrv1aKBlA/jLmK7CSXDAA0DKn
         PQQ9llf/cTo9NKcOAzEfoqJfHvSBLaussb5X/ADjA7iLm6mYcfGVKYvldt/q9p9YnuKb
         UbHD0O7MBn9DRWNIENR4QfJm9Gx2UxtoZUWILX+UFIz9zyDgUu8dagFx1qG7CvnmcNgN
         eSxKCiayLAgI5z+wgo0pegau6MQ52DHlTIzvK0EUblXX+Wf4914t6rBxVUfIHrxVjCgq
         ifUQUMX7+HXMJmT16OWidBMkUcFx1wLlTHuM003LQlSq809jg5QEaEM2rnZ5TW6ZnEg3
         mF3A==
X-Gm-Message-State: AOAM532cU+swQhdnDeSmZCwkv+WhaNrf0MGH4wPderKGA/hHjeESplX5
        MUXU+EP4QuPLPUaqmrFkL9bVgw==
X-Google-Smtp-Source: ABdhPJxaszEeExtIJU2xlpUKoYJRBZPYeKxy0Xq+Pd3AHJPz+AFBXuQcTcW6hBRfosmJZ8ivnF5utQ==
X-Received: by 2002:aa7:87cf:0:b029:23f:6559:f189 with SMTP id i15-20020aa787cf0000b029023f6559f189mr5848090pfo.34.1617860207405;
        Wed, 07 Apr 2021 22:36:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e193:83c5:6e95:43de])
        by smtp.gmail.com with ESMTPSA id a65sm23959278pfb.116.2021.04.07.22.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 22:36:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-13-swboyd@chromium.org> <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
Subject: Re: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
To:     Petr Mladek <pmladek@suse.com>
Date:   Wed, 07 Apr 2021 22:36:45 -0700
Message-ID: <161786020531.3790633.14618419586085886962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-07 10:03:28)
> On Tue 2021-03-30 20:05:20, Stephen Boyd wrote:
> > We can use the vmlinux_build_id array here now instead of open coding
> > it. This mostly consolidates code.
> >=20
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: <kexec@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  include/linux/crash_core.h |  6 +-----
> >  kernel/crash_core.c        | 41 ++------------------------------------
> >  2 files changed, 3 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 206bde8308b2..fb8ab99bb2ee 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >  #define VMCOREINFO_OSRELEASE(value) \
> >       vmcoreinfo_append_str("OSRELEASE=3D%s\n", value)
> >  #define VMCOREINFO_BUILD_ID(value) \
> > -     vmcoreinfo_append_str("BUILD-ID=3D%s\n", value)
> > +     vmcoreinfo_append_str("BUILD-ID=3D%20phN\n", value)
>=20
> Please, add also build check that BUILD_ID_MAX =3D=3D 20.
>=20

I added a BUILD_BUG_ON() in kernel/crash_core.c. I tried static_assert()
here but got mixed ISO errors from gcc-10, although it feels like it
should work.

In file included from ./arch/arm64/include/asm/cmpxchg.h:10,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/mm_types_task.h:13,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from kernel/crash_core.c:7:
kernel/crash_core.c: In function 'crash_save_vmcoreinfo_init':
./include/linux/build_bug.h:78:41: warning: ISO C90 forbids mixed declarati=
ons and code [-Wdeclaration-after-statement]
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro '__static_as=
sert'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS_=
_, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/linux/crash_core.h:42:2: note: in expansion of macro 'static_asse=
rt'
   42 |  static_assert(ARRAY_SIZE(value) =3D=3D BUILD_ID_SIZE_MAX); \
      |  ^~~~~~~~~~~~~
kernel/crash_core.c:401:2: note: in expansion of macro 'VMCOREINFO_BUILD_ID'
  401 |  VMCOREINFO_BUILD_ID(vmlinux_build_id);

>=20
> The function add_build_id_vmcoreinfo() is used in
> crash_save_vmcoreinfo_init() in this context:
>=20
>=20
>         VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>         add_build_id_vmcoreinfo();
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
>=20
>         VMCOREINFO_SYMBOL(init_uts_ns);
>         VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
>=20
> The function is not longer need. VMCOREINFO_BUILD_ID()
> can be used directly:
>=20
>         VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>         VMCOREINFO_BUILD_ID(vmlinux_build_id);
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
>=20
>         VMCOREINFO_SYMBOL(init_uts_ns);
>         VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
>=20
>=20

Thanks. Makes sense. I've rolled that in.
