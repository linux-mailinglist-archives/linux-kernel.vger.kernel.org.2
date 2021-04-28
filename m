Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB67E36D366
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhD1Hrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbhD1Hrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:47:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9AC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:46:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr7so14177349pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DaD7iH9ovgaK3RlZ5gRXu2tNKhg+njbzvtd9ALNAT78=;
        b=Y+UEQBYQkugTJe6wIfvqfWSr9+oPBjwmY8420NKmxJHu+t4L1HEmOQmh6IpbTqly36
         GCHEhKcr2byntBFHpcpgSPmy/ebGv6QjeM3IfXeg1n5+uMdeoDGjz+rxcYvVvPlNRa52
         KUctU5cLAPxdPDi7W8lvfCzdZ5SqLD0sDaAG0CMuyxHdJiAD2GJUB5rmLHge/i3j18DF
         vIGA6Xnvro14PvQm4PhCXV4AmbEpOLDfKtVoXBmV8NZYSMO1DgCmHCNJYNHtE2qOs5Za
         PX/lWnu8KyBlZm8zeFGA4cr0xJIj/YYrwNpC/6TbzxWxfPWkXUKV/ZXElfuI+cyvDpu4
         NR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DaD7iH9ovgaK3RlZ5gRXu2tNKhg+njbzvtd9ALNAT78=;
        b=Uu590TGFEJYg4e2Fo2IYhxQczLg6bqTjVl1yBmn7ZHxYSIJ2ujnz6zqsKsneKnLYpq
         Fp+mT8SASQGYD11peGP2roNIo56+hx2Y0G2/8ZyWLa+xd97iqaS9rdMIlFLDKHXsf6SX
         Tl+S+OtvPEOylnOy+7YpWY14Qh5BBfFZbfOdxFEQyOwPDlPCYlbrHNzS/fZGD2ejPbkX
         tHTP1x3eGqzqzu2saLNBh8nEGJ8jHURi5XJ3475CsMvrDwlLn1ePJDUqjL0biiyZES1a
         o2Lkws0LhYdajo8fEFvyaphdGGFDV48YedZktAv2S+osBcGzL7boksP+ld26oyTjz/mW
         V70A==
X-Gm-Message-State: AOAM532oS3zCT1AbD7XEbAMc8Ool+ykSE6Gmr7UhHoxTfyeKJxdo/fKp
        656u0VClKAz+9YY0xGaOZJ6Ui6GoTDRKpLb7Rxc=
X-Google-Smtp-Source: ABdhPJxJT1UGET0eEvFbZtut7xrZ3cByfTDj0+YUu1ZOI/p+IsTFqPGJKXzsyK/sp1tVJ5pnC3+P75DswRbXJSCbdmM=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr28507367plc.0.1619596017485; Wed, 28 Apr
 2021 00:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210412113315.91700-1-gi-oh.kim@ionos.com> <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
 <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com> <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
In-Reply-To: <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Apr 2021 10:46:40 +0300
Message-ID: <CAHp75VevfrLHMVnRDxPNRHj3PHykvDUsBkTgXqbwKXJdbj4fmA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:32 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> On Wed, Apr 28, 2021 at 8:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wednesday, April 28, 2021, Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >> On Mon, Apr 12, 2021 at 1:33 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >> >
> >> > As the name shows, it checks the strings inputed from sysfs.
> >> > It should work for both case-sensitive filesystem and
> >> > case-insensitive filesystem. Therefore sysfs_streq should work
> >> > case-insensitively.

...

> > Are you sure it=E2=80=99s good change? Sysfs is used for an ABI and you=
 are opening a can of worms. From me NAK to this change without a very good=
 background description that tells why it is safe to do.
>
> https://www.spinics.net/lists/kernel/msg3898123.html
> My initial idea was making a new function: sysfs_streqcase.
> Andrew and Greg suggested making sysfs_streq to be case-insensitive.
> I would like to have a discussion about it.

This patch even doesn't have users, but suddenly changes behaviour of
hundreds of existing users without any good justification. What
discussion here is needed? No way this goes to the kernel.

> >> I changed sysfs_streq to be case-insensitive as you requested.
> >> Is there any progress?


--=20
With Best Regards,
Andy Shevchenko
