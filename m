Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD138E024
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 06:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhEXE0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhEXEZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 00:25:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBCFC061574;
        Sun, 23 May 2021 21:24:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i9so38730779lfe.13;
        Sun, 23 May 2021 21:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3ZOtOGlXp80QN3l22ADXZS6P4An6muJeQct/gjNKF0=;
        b=bp0aOnXp1/GvnK33syXjEwoyYYHXGCQXU7YAsIH0ylHWxMO4tUBMwmrz7oL2pt9spI
         xgIuQmGzbWa1IXgC1e5qXhnybLQu3aj5TQtHe6AIdT+ZdiCcvA0AoHwHspi5GY8j48ZX
         qi000XDogmMjkMC9pta6TykOnEE4YObS26k4/9TaUqQHxm2tW+ZEcCoSg2wdwIkfVnB0
         MIFuxQD4Q9/nazkm0FlEJWzZkpD6RWE4fuQPW74gCmf45XPuMMQ/pTaB4GjvFJSlHrY+
         rlxJjC/FT643BWvoiMA39LRHL/PICtIxnPiaBIFNSX7p+qcIowX1FE23ZftdTNvGKxeK
         iCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3ZOtOGlXp80QN3l22ADXZS6P4An6muJeQct/gjNKF0=;
        b=IPaLuJu1gYSy8nQtu0ZPJVxcXzXJw3pJ2lQRSL/tDUcJSNz8yR9osHsgVgOHAjynEU
         HQ2aZUVs0qgPOEYXJgy2LM4DUnK2tUGD0GTnQtD+UPXBMYcW+McVyvHmwWSyo6WXxNB3
         V/DWxftmaWvv/y35WpVfJS+Oxd4GUZkk/2wtAYc1RoEkITH/w8gCItcKdHJXzg6sVWjx
         aa8UW1B1QLGhdBh4djr86kNQFWSnTPMO1Kziqv4BlIJlR6mqUxyOrhzSseYV4AXUFVK9
         RTQOc0BrSh7VEs5O/SUlFJ3pF8binjj28+rWavakH/ZnKq+FoHh8MnJs3Oln9c0PSe0C
         5hlA==
X-Gm-Message-State: AOAM532J3aEjrElcR2VI7rK07bW8LhIMk1nP/UQ4+wOk7cmKF5Ggoa/d
        F0KhoULbmJkxJK7w5+UhzM1DweK3CTtYW+aeULY=
X-Google-Smtp-Source: ABdhPJyrfnOvTqQAsP/HhkDZdfAoLS0S4HrhTf3GosM4lguP/DyOUx5y29vcgR/sh0XnSYk68nIOx2Gzu/dMjSB6PBw=
X-Received: by 2002:a19:ccc:: with SMTP id 195mr9548751lfm.24.1621830267121;
 Sun, 23 May 2021 21:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <1621578594-13237-1-git-send-email-sxwjean@me.com> <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
In-Reply-To: <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 24 May 2021 12:24:00 +0800
Message-ID: <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:17 PM Waiman Long <llong@redhat.com> wrote:
>
> On 5/21/21 2:29 AM, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The block condition matrix is using 'E' as the writer noation here, so it
> > would be better to use 'E' as the reminder rather than 'W'.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   Documentation/locking/lockdep-design.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> > index 9f3cfca..c3b923a 100644
> > --- a/Documentation/locking/lockdep-design.rst
> > +++ b/Documentation/locking/lockdep-design.rst
> > @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
> >       | R | Y | Y | N |
> >       +---+---+---+---+
> >
> > -     (W: writers, r: non-recursive readers, R: recursive readers)
> > +     (E: writers, r: non-recursive readers, R: recursive readers)
> >
> >
> >   acquired recursively. Unlike non-recursive read locks, recursive read locks
>
> I would say it should be the other way around. Both W and E refer to the
> same type of lockers. W emphasizes writer aspect of it and E for
> exclusive. I think we should change the block condition matrix to use W
> instead of E.

The doc uses 'E'  to describe dependency egdes too. Should we change them
to 'W'? Personally,  both 'W' and 'E' are fine.

Thanks,
Xiongwei
>
> Cheers,
> Longman
>
