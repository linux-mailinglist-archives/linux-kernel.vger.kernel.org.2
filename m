Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD836D336
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhD1Hd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbhD1HdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:33:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E4C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:32:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n25so868480edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THeq6+CcmMpvRzTjcbfJB+yNRiSjDY0H9orKZeXewXs=;
        b=ZvSsv0AjV3r1p9sf0++w73Na72guWLpSFgB9DRfp8JLdFEFgBr7XqoDLY4bNcmc6i6
         UVFr7INeSKtz19yVNXelETply/WpxQdfnhNNF2ZGem/BE3E3amtIoaWuouFkiAdnyeyg
         4hA5UXzBYrHaz3MldEywtbM1YP98VgK0BoFNYpFaSB2OlCv3igjF9ccr+zgSuc9q/eMS
         J238aT1a6w6MD/Z3GRuHcGarXMW3KY3pbBQLId2DYUhJFWts2YGq76bV7mj+6bjy20F2
         BCWFe0HzPIxZtJJjfw7HK/SMuAVdpikmk5UNgKpw6dj93M9suFCGjX0YEEwbvkrbuE68
         LwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THeq6+CcmMpvRzTjcbfJB+yNRiSjDY0H9orKZeXewXs=;
        b=SDBE7t0T0+qpHl1hai3hYvD1/3fGoMGYlZIkXnRmjI4j8OFZ2f7iEDIioFw0SfJuk1
         oy0MQ70aXRs8k7OYdvMSThgoCMAutl9iXQZkCX5ZVItCiqIDUrqhsOmvB9FZLnK4oCS2
         UcnsnpPBzkgJAKQpAcuEZogTUKM0ZmbHa/sZfz2F6TuTMZJ1rKXrQj8fAE8VXPqRKzkk
         y1TrIYJAMxUga71yLPdSUsrk7E8TfmJKoIl74+4q4z7e+W3EhAGmW8Ml9DLFYrovsPp6
         NWImPNd3CX91VzhDTxbGVLxcQGmnMNy5cQOVcZ+9El1FtyCJl/M6YSTagDmUC0okeKiO
         m/aQ==
X-Gm-Message-State: AOAM532q2vJjzPzQjZl+0UNz5xc8xr/OiWuuTkgRkWXzx1M9hOkAc8FM
        n0zrCfzqIoZ8rV9HbqpTbJsCchZ62s9/ZYbncmJBWA==
X-Google-Smtp-Source: ABdhPJzcYV3uVQTnYdm0xrMry0laeOxU9i9Er8DxZjpfEKvbKAmn542aUDbrjdRByJ5CZv40N38u8J0iAJtgvJNcRBE=
X-Received: by 2002:a05:6402:351:: with SMTP id r17mr9307314edw.186.1619595152587;
 Wed, 28 Apr 2021 00:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210412113315.91700-1-gi-oh.kim@ionos.com> <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
 <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com>
In-Reply-To: <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 28 Apr 2021 09:31:55 +0200
Message-ID: <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Wednesday, April 28, 2021, Gioh Kim <gi-oh.kim@ionos.com> wrote:
>>
>> On Mon, Apr 12, 2021 at 1:33 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>> >
>> > As the name shows, it checks the strings inputed from sysfs.
>> > It should work for both case-sensitive filesystem and
>> > case-insensitive filesystem. Therefore sysfs_streq should work
>> > case-insensitively.
>> >
>> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
>> > ---
>> >  lib/string.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/lib/string.c b/lib/string.c
>> > index 7548eb715ddb..d0914dffdaae 100644
>> > --- a/lib/string.c
>> > +++ b/lib/string.c
>> > @@ -688,7 +688,8 @@ EXPORT_SYMBOL(strsep);
>> >  #endif
>> >
>> >  /**
>> > - * sysfs_streq - return true if strings are equal, modulo trailing ne=
wline
>> > + * sysfs_streq - return true if strings are equal case-insentively,
>> > + *               modulo trailing newline
>> >   * @s1: one string
>> >   * @s2: another string
>> >   *
>> > @@ -696,10 +697,11 @@ EXPORT_SYMBOL(strsep);
>> >   * NUL and newline-then-NUL as equivalent string terminations.  It's
>> >   * geared for use with sysfs input strings, which generally terminate
>> >   * with newlines but are compared against values without newlines.
>> > + * And case does not matter for the sysfs input strings comparison.
>> >   */
>> >  bool sysfs_streq(const char *s1, const char *s2)
>> >  {
>> > -       while (*s1 && *s1 =3D=3D *s2) {
>> > +       while (*s1 && tolower(*s1) =3D=3D tolower(*s2)) {
>> >                 s1++;
>> >                 s2++;
>> >         }
>> > --
>> > 2.25.1
>> >
>>
>> Hi Andrew,
>>
>
> Are you sure it=E2=80=99s good change? Sysfs is used for an ABI and you a=
re opening a can of worms. From me NAK to this change without a very good b=
ackground description that tells why it is safe to do.

https://www.spinics.net/lists/kernel/msg3898123.html
My initial idea was making a new function: sysfs_streqcase.
Andrew and Greg suggested making sysfs_streq to be case-insensitive.
I would like to have a discussion about it.

>
>
>>
>> I changed sysfs_streq to be case-insensitive as you requested.
>> Is there any progress?
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
