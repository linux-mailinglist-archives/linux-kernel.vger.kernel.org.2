Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE8390085
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhEYMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhEYMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:05:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FFEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:03:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 27so21255173pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtkT6fzzM2l9Wz2+8SKhQxenUy7hKwdaXKRCDufwqUI=;
        b=M1c3zsnI7cHO/iKrmWiJKCN3iKH4UNnnJZfUoAKiacTbzuz916EREgdEI0C3+9wjwF
         QbW417pEs73IdU67xz3IbQMgy5ehSyb9l8r00p2fN8a5DoxIrWYoo1G2hu+Q8k+dqPp3
         uIHVpsrX1WZ/hiqDzLYufQ6Sw8K5q9RaOlvZBD/woznIPeffZdwC0w8CSeY+M6Rj62Dp
         kjrfv0OL/vsG0Z/Bv5htRjkQCuVau03HE5wUW5R1jnfNOPmYlGobCDxrgmuJlxjnUJb7
         8DVEa/5msOGC4Ks1VmZY9Zn4BGquuog4I4y+w+W8Ukv+pT45oWCzvBsbGJ8RWNRuuerd
         gRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtkT6fzzM2l9Wz2+8SKhQxenUy7hKwdaXKRCDufwqUI=;
        b=Bdu/upc8n4E8MZqHVM4tOg0BIDx3bHfcjxAPOErgPrGgZy/wBIjinSwhvMhKqiOO1j
         lMVjdYcEK5ybsJiOpYQiZhC7KY5H7sxKJNZKbNE5lO5XdKFF9aIYXTelUk9oXk5vD+Py
         7uPiG3DwBV9IATxqGJRWDjFz7gyZrO80Etxl9BOmyy/ffa0trID68wcDv8fy5uhBxKMQ
         Zo5O1vrurpCJeoyQWZ82SJgR/QV8XwqgC98BJX4ny95SY9jDGToQJ7e1Ugt1SNKAPcXF
         mql/RgT8Rjk1bioVfbIT6aDV2OS4dJDzPzE02dxfv+NwrCT5DLcvqLLtFTzSblDl55jo
         tlyg==
X-Gm-Message-State: AOAM533vdbsyxrPwVX4f8DHf7fwld4+2vFNYhFxHKFOVnClY3bkGiFbT
        iTgjbpuuNwA1QSeRRKTXmp5vIn9D+WNQ+5DFwnw=
X-Google-Smtp-Source: ABdhPJw7SEVgsG9ZiBjbN+SO4u1FrgI/oUOp1x0FYKn5IT0gbdMsC+7UacIeeVr7Rdg9QeE7l9QMzZX1tKKbDr+xlSk=
X-Received: by 2002:a05:6a00:1591:b029:2d9:369a:b846 with SMTP id
 u17-20020a056a001591b02902d9369ab846mr30049950pfk.40.1621944211602; Tue, 25
 May 2021 05:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
 <YKy9PHIbuhsomsTq@smile.fi.intel.com> <CA+7tXihtuzw3+7boMFqmvHcpe-hr2qF0TnaduskbXUbfsFwb=A@mail.gmail.com>
In-Reply-To: <CA+7tXihtuzw3+7boMFqmvHcpe-hr2qF0TnaduskbXUbfsFwb=A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 May 2021 15:03:15 +0300
Message-ID: <CAHp75VeNvp2NHORiN-X+ohYdvLmADYBEOJ2_0+-eOZ+kznA_FQ@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 12:21 PM Trent Piepho <tpiepho@gmail.com> wrote:
> On Tue, May 25, 2021 at 2:02 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, May 24, 2021 at 01:17:48PM -0700, Trent Piepho wrote:
> > > On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
> > > >
> > > > This misses the test cases (*). Please, develop them with Daniel.
> > > >
> > > > *) We usually don't accept changes in the generic libraries without test cases.
> > > >
> > > > Fixes tag?
> > >
> > > Is there a bug report on a tracker?  I just got the email from Yigua.
> >
> > Fixes tag refers to the existing commit that brought the bug.
> > Also you may need to add Reported-by tag since Yigua reported it.
>
> I did add a Reported-by tag.

Oh, I haven't seen it in the context left, but yes, I see it in the
original mail, thanks!

>  Wasn't clear to me fixing a specific
> commit was entirely appropriate since not handling out of range values
> correctly has been there all along.

Daniel proposed one, wouldn't it be good enough?

-- 
With Best Regards,
Andy Shevchenko
