Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FBB37350F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhEEGtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhEEGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 02:49:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7DFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 23:48:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z13so1072349lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wcXiLyG9i0TKaDeWgs8Jk1abCiXdlslCAnNEtGY50s=;
        b=cCHvIscPTALLolDdhUgvV3n1avcO64cuTBtIogpwAFXg/NFEjs1+7jBDe+1EmOrM8d
         I2DJiFhaivi/FO1t6DLyVYzepwi5ffXta0P/bL4UXWkIYh0OznnsbFuICJV41qHdQQ6T
         PgQ+RN3EkW4lEILduTy/sfMsWIs5ISbbqQtTpU4H0qv7QhoaZEZ7/yEajFnfn0L7fEcW
         WOWBoGp9pidlxpit0WaUbA97kyERvLfwTWZczqtRmInlu9i0y6EPIjj7lIMOOuJOiHgw
         9aPwewGct5Q0gmjYONrq8D+RRewk3DgNrjFKu3mLZseIpjrFdALBl5JwU6X3KB6Sm9Yl
         0d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wcXiLyG9i0TKaDeWgs8Jk1abCiXdlslCAnNEtGY50s=;
        b=gTywIhQpdoMHLTEItO9oPcq23KTFrFJmQ1N7lZx53BvfGlNxkH+ToAhGWzWTqZlMtR
         2FkI7Og56X8gL3ki4UY8hVPfOfGrKmKgBHN0Lr4COoPDjEhsbXbSHy4+KYBI5cC6/U6t
         o6NC1MDl65XVVHNeS3v++OUFqE3AVW/72Uh7van+npadpm2fuHmWnzLIdb78Fd1lFnzN
         JpJV17P2ct8frNIIPhiYMWR5UixZNlXUUhaha17PomMVKnF/dpZakOTQDLMq2ZcZGJ6F
         NwURjg11mFvJDKgygE1AbTvsuzz9RSTU3tO/yJGyM7CSk6yPyVBkuuQ08JXnMN3wb+da
         UeKQ==
X-Gm-Message-State: AOAM5316YQrGbFvIM6+cHWRT6M65rUjuhOwMnPVHIK7pq58p+Or5tf9x
        8pTJ3ViO0Fe2woFCVnvtl555Xq0FNtecLfx7J6l5Vg==
X-Google-Smtp-Source: ABdhPJz4VhQlYL6Gho0QJGkSV/cn8S9cdL1OYhy0M6AjB5RfayDDrNKm8pU7YLMG/IHJUN7SFgNiJVQYTL4NoHX4AKs=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr19049087lfu.16.1620197332044;
 Tue, 04 May 2021 23:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210416065623.882364-1-davidgow@google.com> <YJGUFrc8PJ0LAKiF@google.com>
In-Reply-To: <YJGUFrc8PJ0LAKiF@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 May 2021 14:48:40 +0800
Message-ID: <CABVgOSnz2PhMeqXLz00U406Wn6cLiiHKmrUyB20A=zauwh2=1A@mail.gmail.com>
Subject: Re: [PATCH v8] fat: Add KUnit tests for checksums and timestamps
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 2:36 AM 'Brendan Higgins' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, Apr 15, 2021 at 11:56:23PM -0700, David Gow wrote:
> > Add some basic sanity-check tests for the fat_checksum() function and
> > the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
> > tests verify these functions return correct output for a number of test
> > inputs.
> >
> > These tests were inspored by -- and serve a similar purpose to -- the
>                    ^^^^^^^^
>         I am guessing this is supposed to be "inspired".
>

Oops -- yup. This is a typo. I can resend a version with this fixed if
you think that makes sense, otherwise I'll just hold it over in case I
need to send out a new version.

> > timestamp parsing KUnit tests in ext4[1].
> >
> > Note that, unlike fat_time_unix2fat, fat_time_fat2unix wasn't previously
> > exported, so this patch exports it as well. This is required for the
> > case where we're building the fat and fat_test as modules.
> >
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Aside from the nit above, and the *potential* nit and question below.
> Everything here looks good to me.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >
> > It's been a while, but this hopefully is a final version of the FAT KUnit
> > patchset. It has a number of changes to keep it up-to-date with current
> > KUnit standards, notably the use of parameterised tests and the addition
> > of a '.kunitconfig' file to allow for easy testing. It also fixes an
> > endianness tagging issue picked up by the kernel test robot under sparse
> > on pa-risc.
> >
> > Cheers,
> > -- David
>
> [...]
>
> > diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> > new file mode 100644
> > index 000000000000..febd25f57d4b
> > --- /dev/null
> > +++ b/fs/fat/fat_test.c
> > @@ -0,0 +1,197 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit tests for FAT filesystems.
> > + *
> > + * Copyright (C) 2020 Google LLC.
>
> Nit: I know you wrote this last year, but I have had other maintainers
> tell me the Copyright date should be set to when the final version of
> the patch is sent out.
>
> I personally don't care, and I don't think you should resend this patch
> just for that, but figured I would mention.
>

Hmm... I've definitely heard this both ways, but I can easily update
the year if I need to send a new version out.

> > + * Author: David Gow <davidgow@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +
> > +#include "fat.h"
> > +
> > +static void fat_checksum_test(struct kunit *test)
> > +{
> > +     /* With no extension. */
> > +     KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), (u8)44);
> > +     /* With 3-letter extension. */
> > +     KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), (u8)115);
> > +     /* With short (1-letter) extension. */
> > +     KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
>
> How do you get the magic values? Or is this just supposed to be a
> regression test?

This is mainly meant to be a regression test, and the values did
originally come from just running fat_checksum. I have, however,
checked that Windows 98 produces the same values (on a FAT12
filesystem).

> Not going to pretend I understand FAT, but everything else in this test
> makes sense from a logical/testing/readability point of view.
>
> Cheers!
>
> [...]
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YJGUFrc8PJ0LAKiF%40google.com.
