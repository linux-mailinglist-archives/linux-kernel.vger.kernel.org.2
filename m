Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82832CCD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhCDG0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhCDG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:26:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5EC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 22:25:36 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o10so18253535pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=073Z4Ekpyix60DxdcQ0lkwFMZDm8uQOxmFSCevG2kWk=;
        b=cb1ec1aEuoM+7PjiNajI1/sLiAALO9yi9D5ViMZhYuQJxNEyoFW7sqMH290M3xSSZj
         n8lcaI5XWtLl5KS0s1BuhLdRL6O8LavDUYa6iWCCMfb1oNU6/xvkja8msl1mmLDyBXCw
         q9jlky749vTKv/aFc0Vy46iVsEX/myGzDKsLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=073Z4Ekpyix60DxdcQ0lkwFMZDm8uQOxmFSCevG2kWk=;
        b=C9EBNPB+qF2GY5h/wX3Rfc4rllIXsMEcAoIMsmdQ2g5nG/YZKxQCObxqKa+aoDt+op
         y+jm6UGzg6PhsyywdemjSabHTKGHQA9yAtwy15rxfGdOQ8ucoG3Xp2IBXEkXNvQI8XCg
         uTgisS8mULp+DbC5NlgmxJ8h8NzJJSVoMgZrq53tWkL2KLj2g/oco9z0DOgaRN9pNCrI
         ey8i/1qkNjpFRLb1E5I9h8KDwFQiXan7QqOGlRuqkAK0xrc1KZKSg1Vmw546gqQCIa8z
         BM2xmwQq51e3wbkwAmGt5ENrvyNXFZj2/oWgelekybbehpHi+9n9PTK71zpB70YPx0vE
         4I2w==
X-Gm-Message-State: AOAM531SceUKGPGCHUL+/u6zDBPfJcg1aTOCCb9zoPfDz61Tmf44ESFu
        V6hzWxpT8Khqoh03O85w6qgguA==
X-Google-Smtp-Source: ABdhPJyFv2llFJu54mc6Zpz1YiCVRlV5qW2dcbMGm7JCAnoHGYXULLL4+cFoWiJD3TEPTeSqGimQmg==
X-Received: by 2002:aa7:92c7:0:b029:1ee:75b2:2dab with SMTP id k7-20020aa792c70000b02901ee75b22dabmr2689365pfa.61.1614839136388;
        Wed, 03 Mar 2021 22:25:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id s27sm24917409pgk.77.2021.03.03.22.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 22:25:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210303201932.7ac93f12@oasis.local.home>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <YD9kNphaSRPk83KJ@alley> <20210303100012.0e6e4de3@gandalf.local.home> <YD+2fRo4J/ffQF8z@smile.fi.intel.com> <161481830876.1478170.4374239517736205573@swboyd.mtv.corp.google.com> <20210303201932.7ac93f12@oasis.local.home>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 03 Mar 2021 22:25:32 -0800
Message-ID: <161483913296.1478170.8327557921301152076@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2021-03-03 17:19:32)
> On Wed, 03 Mar 2021 16:38:28 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > I'm starting to feel like nobody read the commit text, or I messed up
> > somehow and the commit text was confusing? :(
> >=20
>=20
> I read it, I'm just unfamiliar with it. I don't use pstore, and I'm not
> sure what "crashdump" is. Do you mean the kexec/kdump? in which case
> you can retrieve data within the kernel quite easily.

Right, I meant kexec/kdump. Given that it is easy to retrieve it in
kdump (presumably with some scripting?) I can remove this motivation
from the commit text.

>=20
> I haven't used debuginfod (never heard of it before actually).

Got it. Hopefully the links I provided were good enough? I will provide
a link next time.

>=20
> > =E2=94=82 This is especially helpful for crash debugging with pstore or=
 crashdump                                                                 =
                                                                       =20
> > =E2=94=82 kernels. If we have the build ID for the module in the stackt=
race we can                                                                =
                                                                       =20
> > =E2=94=82 request the debug symbols for the module from a remote debugi=
nfod server                                                                =
                                                                       =20
> > =E2=94=82 or parse stacktraces at a later time with decode_stacktrace.s=
h by                                                                       =
                                                                       =20
> > =E2=94=82 downloading the correct symbols based on the build ID. This c=
uts down on                                                                =
                                                                       =20
> > =E2=94=82 the amount of time and effort needed to find the correct kern=
el modules                                                                 =
                                                                       =20
> > =E2=94=82 for a stacktrace by encoding that information into it. =20
>=20
> Are you saying it's common to have modules from different builds?

No.

>=20
> >=20
> > In some distro (read: non-kernel dev) workflows the vmlinux isn't
> > shipped on the device and crash handling is done offline or much later.
> > Using the build ID[1] is a common way to identify the binary that's
> > running on the device. In conjunction with a debuginfod[2] server you
> > can download the symbols for a crash automatically if you have the build
> > ID information.
> >=20
> > I can add a patch that updates decode_stacktrace.sh to show how it can
> > download the correct vmlinux/modules if it isn't provided on the
> > commandline.
>=20
> Are you just trying to match modules with the builds that they were
> created with?

Not exactly. I don't have a mapping of modules to the kernel they're
built/used with. I could create a mapping, but then that's something
else to maintain vs. what I have right now which is just a big database
of debuginfo mapped to build IDs (i.e. a debuginfod server).

>=20
> >=20
> > If the debug symbols are on some public server then in theory we could
> > have some robot sitting on the mailing list that looks for stacktraces
> > and automatically replies with information about the line number/file
> > and even provides the code snippet for the code that's crashing from
> > that binary, because it's all stored in the full debuginfo builds.
>=20
> Again, I have no idea how buildids are created or what they are used
> for. This is the first time I've even heard about them. I'm all for
> helping other people out to make their workflow easier, if it doesn't
> make a mess for everyone else.
>=20
>=20

Makes sense and sounds good. Thanks.
