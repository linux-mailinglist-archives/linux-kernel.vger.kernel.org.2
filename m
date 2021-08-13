Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2173EB1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhHMHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhHMHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:52:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D3C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:51:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d11so16770128eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GK8wq/IOiIxJgDvCUYvsZ+KqziS3kB0R8RP8IZKkltI=;
        b=LdtOhIxb3CQdyFtsCx0t8s7ZbjdhMVfRroj6e9Bu0C5sIfiz3QfG18dDkFFOms71X7
         YzdoijNa4rlLVY35Q8Q9s4USIA8xIwu701vncDGBzNCTS9TmPv5S2gNXY3FjysdKL8Bm
         BfQexaZb9NyOxuE4q+vCMX88srriox7DrdTY68dNcshfDwzcBGveIfAOpXyjtMXwcwyD
         hrzt+SofXy3JYCi0qad59fBxLsVOiC0ebfeig7sY1mIc43y1VmxVWG6xdi8FyUOG4u2g
         yEzYIZ9AqqGAWVS7GcokAufeK3LczPFuW+EfClBOx+45MhjdS3xB+xxh0uIzfavVVzqQ
         JSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GK8wq/IOiIxJgDvCUYvsZ+KqziS3kB0R8RP8IZKkltI=;
        b=fIx1TtndKdvGzr+egr0nhQhuLbw8pmxEemohU/OaBYfKZovg2M9C8WoqFzkslYnJyo
         XacQFpBL9z+r4qMyDQ5HOFGH78Xrki5v5Uv4r4bJrQqCpJQVGJ7rMojHg1PyYdWcvLo5
         sEyUk86D1OQ7Ru8wBvRnzVqZi7ntsHDkz5dqJEfDscQZAz9tUSM0AHEfpz1uLcec3SX1
         c25iTpvIpNAmQlmGYxzcKYSlb5RHseRhXt7yc/yf0fNJpPr7HX4wugHXSINGhJ4dPZgO
         oIl0czRM/mUj8I1JpxT8xeCjpb4bMUxU2tpLr+PJP5DJTRu+KgF0ac0YTMbzjberY8t0
         RH6w==
X-Gm-Message-State: AOAM533DYRExjkhmnCuodoniGYOKeYskAXu0FNumgpgjntIXCAkt/U7Y
        2Mi4izpoEnWLJY7nj7FCkOa87FJP0Sd23Rx5mdc=
X-Google-Smtp-Source: ABdhPJwJ5SOLW9apRli3AOrXFL4cVQnh9RqbRN4V3vvm8P4Vzvjl97S95ccpuX4P4FSx16PZBSKVvs7RWqZ+8VFbLCU=
X-Received: by 2002:a17:907:2096:: with SMTP id pv22mr1220682ejb.443.1628841114413;
 Fri, 13 Aug 2021 00:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org> <20210811163731.186125-4-masahiroy@kernel.org>
 <CAMo8BfJtpUY-FC-cwU5HXSqOSwUwn15kTYWOhx-tsgybPe8mpw@mail.gmail.com> <CAK7LNATERCrQc1gDfJTqGNvFPpS3Xyzk9VErQyaj0kvc10oDeA@mail.gmail.com>
In-Reply-To: <CAK7LNATERCrQc1gDfJTqGNvFPpS3Xyzk9VErQyaj0kvc10oDeA@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 13 Aug 2021 00:51:43 -0700
Message-ID: <CAMo8Bf+0r7z=ueD571AFyHphcsb2hB3dLo5wMmLF_ELn8Dm_Qg@mail.gmail.com>
Subject: Re: [PATCH 4/4] xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:10 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Aug 13, 2021 at 2:32 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Use obj-y to clean up Makefile.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  arch/xtensa/Kbuild             | 1 +
> > >  arch/xtensa/Makefile           | 3 ---
> > >  arch/xtensa/platforms/Makefile | 4 ++++
> > >  3 files changed, 5 insertions(+), 3 deletions(-)
> > >  create mode 100644 arch/xtensa/platforms/Makefile
> > >
> > > diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
> > > index a4e40e534e6a..fd12f61745ba 100644
> > > --- a/arch/xtensa/Kbuild
> > > +++ b/arch/xtensa/Kbuild
> > > @@ -1 +1,2 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > +obj-y += kernel/ mm/ platforms/ boot/dts/
> > > diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> > > index 093e87b889be..96714ef7c89e 100644
> > > --- a/arch/xtensa/Makefile
> > > +++ b/arch/xtensa/Makefile
> > > @@ -58,9 +58,6 @@ KBUILD_DEFCONFIG := iss_defconfig
> > >  LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> > >
> > >  head-y         := arch/xtensa/kernel/head.o
> > > -core-y         += arch/xtensa/kernel/ arch/xtensa/mm/
> > > -core-y         += arch/xtensa/platforms/$(platform-y)/
> > > -core-y                 += arch/xtensa/boot/dts/
> > >
> > >  libs-y         += arch/xtensa/lib/ $(LIBGCC)
> > >
> > > diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
> > > new file mode 100644
> > > index 000000000000..e2e7e0726979
> > > --- /dev/null
> > > +++ b/arch/xtensa/platforms/Makefile
> > > @@ -0,0 +1,4 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +obj-$(CONFIG_XTENSA_PLATFORM_XT2000)   += xt2000/
> > > +obj-$(CONFIG_XTENSA_PLATFORM_ISS)      += iss/
> > > +obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)   += xtfpga/
> >
> > With this change platform directory names are duplicated in two
> > makefiles. Can we move them to Kconfig with something like the
> > following (on top of this change)?
>
> I do not like the idea much for the following reasons.

Ok, thanks for the explanation. Applied the original patch to my xtensa tree.

-- 
Thanks.
-- Max
