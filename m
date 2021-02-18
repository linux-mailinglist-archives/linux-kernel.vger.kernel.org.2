Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB0231EF92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhBRTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhBRR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:59:37 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72336C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:58:52 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p193so3014408yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqlO7T1aKbV39Ityo1M+jjwnDIJxvPvVDTyYS8zw2v0=;
        b=qnQYXKdiKQ5FvOO3MyXT5JsAkK8ez6GEtDjfDcyF8JR5Rg6xfgyNRvJ3l+azbNq9t5
         cC/d8aiOZpBNav7rlbnyqPdyra89p3gk2Pn0tdl7E/f7K3uxvvea9SAq0dXkHYWaDaCo
         5Cz5Fv5NxEMo1r1azbBQG/7/XiQZ+Xzvs0KGdnDttvRYF77OyYYqISZMAE7sH/pSjTOw
         QFZ8cJEl54GP0ASAw0xX1pc1XlAa+8tnr472Q6utpdrpxqy8GlY37Jjby7x0yQHW/8mg
         +aWPGocoImDXKAwXc6XgvWa5N/+XXvIt/aVZK6EqN/3K3/Qwc5hrfWapojXik6edNNCU
         8j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqlO7T1aKbV39Ityo1M+jjwnDIJxvPvVDTyYS8zw2v0=;
        b=Y0yl06/L5GmNYzOj15DBmTifZ5SNnaaE7x/U3k0gpYvGv3smRnck0Lke9U2YEjD6Wv
         irwdlQJD1q1fqTvas38ARjI7erZlxbd0zI/gZ+tDdBVB9VgzDqrEDNGUO3ZHu67+WxsJ
         ZiKXHAO7IEBS/c+4lD02WOag3pzUxIySt7rgBemny0DFuwO6eyjgqMkpXUV0JdSEBTAy
         RdwMOgaSGGITpQr2QwfyzuC9h+ACBGKFmTZfL+d3Wpy+P0UeVmlYpUTD8vTEiWpUPmgH
         s+bm2Qgkaq8OdBd1Sl0uhyWBgTGmhP35THZddtZNBH7zANjKVU3y4kMtnQK/HTZzixth
         /H3w==
X-Gm-Message-State: AOAM533wnQEhMNcJ0UONlEDhV1t1rp/mZrHUyOt8zXg40QbFV3iXDjtW
        ybZ0QKQH/BZgnI6O/6Rw9S9u4c2vuyJipWuJHOpl9w==
X-Google-Smtp-Source: ABdhPJzAjk84jCvAO1GGNwAjQhjA5NVJMJvEMdoeXmwQYafmLhasQs8GjvNUFQwXo45Q/t3+YPCB+oVDMVYNP42Ehuw=
X-Received: by 2002:a25:3345:: with SMTP id z66mr8110740ybz.466.1613671131587;
 Thu, 18 Feb 2021 09:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com>
 <CAJZ5v0gdSbpjjD3=EC5i1Cw-t7fNzqv7oGm4rHzaOxUqC0c81A@mail.gmail.com> <CAGETcx-M51sy86QGXQpnevXb0AniNPatVJwcM9tRQttVXH5JEg@mail.gmail.com>
In-Reply-To: <CAGETcx-M51sy86QGXQpnevXb0AniNPatVJwcM9tRQttVXH5JEg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 18 Feb 2021 09:58:15 -0800
Message-ID: <CAGETcx_b3ytjN2G28vqDxiD5nmbXs7_kF70mm5a=0PABTdMgLg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Avoid pointless deferred probe attempts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 9:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 18, 2021 at 9:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > There's no point in adding a device to the deferred probe list if we
> > > know for sure that it doesn't have a matching driver. So, check if a
> > > device can match with a driver before adding it to the deferred probe
> > > list.
> >
> > What if a matching driver module loads in the meantime?
>
> Driver registration always triggers a match attempt and this flag will
> get set at that point. Yes, the user can disable autoprobe, but
> that'll block deferred probes too.
>

Btw, this can wait for 5.13. Doesn't need to go into 5.12-rcX.

> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 9179825ff646..f18963f42e21 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
> > >
> > >  void driver_deferred_probe_add(struct device *dev)
> > >  {
> > > +       if (!dev->can_match)
> > > +               return;
> > > +

Also, if you are worried about this check, for now, I can move it
inside device_links_driver_bound() which is the only place that
currently adds a device to the deferred probe list before the driver
is present. But it seemed like a good check in general to have in
driver_deferred_probe_add(), so I put it there.

-Saravana
