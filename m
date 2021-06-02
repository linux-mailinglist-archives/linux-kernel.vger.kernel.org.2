Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBD398406
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFBIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhFBIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:24:20 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB1C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:22:37 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id z206so658957vsz.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8yfjKGpbcry1gy+VbnjIMZhB7vFgB7ByKAj9f3nL3k=;
        b=gGCQTsNl1/mGvD+hdnwMUxBrkG4V9Z5n5U+vVeH6Iuy1vYOwiUw5R38SRw2xT/u72g
         x/PHvf0igbudRwskvrzfIf0YAlydQlzaIOaAEQeiguoB5RdFHxiLZDtMFgvw5jijVM67
         z7nwvsO99p6jtenEUqDAyeNPw1fw6LPuczfqoLCN5TP82DG7fAUxd2VsGy4YdRHUzxuo
         dICZBVi0Xwd6voNntZjHjbMAbpvho7BaKqctrD0muwIsctyyzmgtC77cqG31i7k0TvlK
         uE75rHrg+PPJmoPYYQU8k2z2MePOdGXsAEJxPVze4hvqzq1U8NymXQtlrAZ6XdXy9pDy
         KrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8yfjKGpbcry1gy+VbnjIMZhB7vFgB7ByKAj9f3nL3k=;
        b=C2ntTcrxUfrI7cF2Qp1Wi4CAcVAi7jxxAhfBt3VENZ0/+XkwxSDXVRiy7LLLS8wrTx
         c/2JgtiVnwIsVoUPA8eHLsoV/s3PSAJokRj2veOIvxv9jbTBuVXAbWDbudH42Y8IM7ld
         TVgVyGrXM9TjIBho/tFyv/yk5fEl8uOxQ0NeVVRCsx0A5m3ptXp2+vABaa6YjFuYch7y
         94J6YRKyuXRnepIr3fuMbiPwjuIs052F1LW7Tmr+uTNFA2GGBLA8UyMMpRi3CyeOYcnH
         sEHQ69+nOwdCYnbITx6UHVJ900tWxBnPGQSqGSTXxNDnbSwzKBlPZxsBtVzu9P/rM9aQ
         7Q2g==
X-Gm-Message-State: AOAM5331wg+lx4Jkh85wwdAsTi/mAoo87ZAYxXOF4L/57beJd1NMIBgx
        8b5DaeTitC6s1poab9zWVFyU0L4LllkrBM17aMz8l6N9E54=
X-Google-Smtp-Source: ABdhPJw1hdO4skd62IajXZeshiWckh7JR9LZvHRyBJlSdVBan8XXPTcJ9FE0IpkUIM7VhV2kGb+LjrellwajlBcbTqk=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr24087498vsl.9.1622622157119;
 Wed, 02 Jun 2021 01:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1619341721-5580-1-git-send-email-jrdr.linux@gmail.com> <24534cc6-e6dc-feda-1e2f-b9b3501845d9@infradead.org>
In-Reply-To: <24534cc6-e6dc-feda-1e2f-b9b3501845d9@infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 2 Jun 2021 13:52:25 +0530
Message-ID: <CAFqt6zbX0bOgqcp_575p4T+qTcycS2AhEmrAkZ7+hXrC-K4QfA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: marvell: Minor documentation correction
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     miquel.raynal@bootlin.com, Richard Weinberger <richard@nod.at>,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 9:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/25/21 2:08 AM, Souptick Joarder wrote:
> > Kernel test robot throws below warning ->
> > drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
> > with '/**', but isn't a kernel-doc comment. Refer
> > Documentation/doc-guide/kernel-doc.rst
> >
> > Minor documentation correction.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  drivers/mtd/nand/raw/marvell_nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> > index 79da6b0..e7b48d4 100644
> > --- a/drivers/mtd/nand/raw/marvell_nand.c
> > +++ b/drivers/mtd/nand/raw/marvell_nand.c
> > @@ -451,7 +451,7 @@ struct marvell_nfc_timings {
> >  };
> >
> >  /**
> > - * Derives a duration in numbers of clock cycles.
> > + * TO_CYCLES*() - Derives a duration in numbers of clock cycles.
>
> Hi--
>
> Did you test that?  I would be surprised if kernel-doc stays quiet
> with that change.

Sorry, I missed this thread. yes it's wrong.
Reason -> I posted the wrong patch.
I will correct it in v2.

>
> [testing]
>
> Yep, kernel-doc doesn't like to see that '*' there.
> That doesn't work.
>
> >   *
> >   * @ps: Duration in pico-seconds
> >   * @period_ns:  Clock period in nano-seconds
> >
>
>
> --
> ~Randy
>
