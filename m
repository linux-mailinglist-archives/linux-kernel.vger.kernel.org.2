Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838639ABB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFCUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:20:12 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42867 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhFCUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:20:10 -0400
Received: by mail-ot1-f54.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so2556814oth.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7eJ9wL8gsfSWhYa3GsXO582wNM/wg9xrmWLnq5UnTuI=;
        b=mKA+uARhJWYQGbgrUlVezxhj35CVnfqnPuATv6WquPRjZOMvAr0y21FPfmADlpFGdn
         L9K1ZvMFWC5w4CQM+mq1ySJVf5e7Mn9N7GUX5ov06ILgT/yKla9XgmitTNyWWUvnMAXd
         e3g3g2cdYUuld5cyOJz0o2cM4cYSwTx/lEikI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7eJ9wL8gsfSWhYa3GsXO582wNM/wg9xrmWLnq5UnTuI=;
        b=tlHWvi6B/brWTmnUkzIy1ROyOzuDoNH0m1a8BMP6vR04jGnTbDIwEMSxjk9UTkVuHX
         X5LLxeSaMgDyiv4Xt3W5+SoBQeL+UGllGTQA9u5032IQYp90cZt4qUSxqFAxBiPnpVu5
         cG55xWFaCh3sLrsOu8fqQ0kkdoBN8RQ5W2W0W9FeGgYwZfSz3RjW9UTTtYBZ0BWHslVL
         ynk1i6AL3Lg94WsUuGGvDLxO6UU/AdocrODjLAUiJOQatdUnKE0YKFfXOhy4NoEG5rxS
         sZMhAOcOQU1CTsgENTCglJ71qKzo+DHEgfWFKYURAR71HCoMb2wnBk4Wx2WzZayogjEu
         UyfA==
X-Gm-Message-State: AOAM531vQC6410Ordw+CP/Arpv5DhdQHgfgAeNsudGpDzuF4k+N1b+Ax
        FtidC5xtX9i8mQd5eAl8ngMewCrwkoFtpWBX+8bBq3FmmBM=
X-Google-Smtp-Source: ABdhPJw2TLD+WqDr894w7WEVf8mwKpnx6jwYDLHpo3HRWV7W0sJHFh1ACWTxfaCaLZ1mNMwNbdZrgcYWY5EAfcfCUqA=
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr886757oth.25.1622751431771;
 Thu, 03 Jun 2021 13:17:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jun 2021 20:17:11 +0000
MIME-Version: 1.0
In-Reply-To: <CAGETcx8djbKQo2uxqE-2S_j0ek3+bO=2Ju8tfDSe1dCoSWWdXA@mail.gmail.com>
References: <20210603064849.1376107-1-swboyd@chromium.org> <CAGETcx8djbKQo2uxqE-2S_j0ek3+bO=2Ju8tfDSe1dCoSWWdXA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 3 Jun 2021 20:17:11 +0000
Message-ID: <CAE-0n50f7ttqWQrsv6MRW3i0z-6QJi0Se4CxfUn5Ai5RxSye4Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: Make dev_info() messages dev_dbg()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-06-03 09:18:33)
> On Wed, Jun 2, 2021 at 11:48 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > These seem to mostly print debug information about device link stuff at
> > boot. They don't seem very useful outside of debugging so move them to
> > dev_dbg().
> >
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/base/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 628e33939aca..066880a843bc 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -865,7 +865,7 @@ static void __device_link_del(struct kref *kref)
> >  {
> >         struct device_link *link = container_of(kref, struct device_link, kref);
> >
> > -       dev_info(link->consumer, "Dropping the link to %s\n",
> > +       dev_dbg(link->consumer, "Dropping the link to %s\n",
> >                  dev_name(link->supplier));
>
> I think this is already fixed in Tot.

Any commit? I looked at linux-next but didn't see it.

>
> >
> >         pm_runtime_drop_link(link);
> > @@ -1732,7 +1732,7 @@ static int fw_devlink_create_devlink(struct device *con,
> >                  */
> >                 if (!device_link_add(con, sup_dev, flags) &&
> >                     !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
> > -                       dev_info(con, "Fixing up cyclic dependency with %s\n",
> > +                       dev_dbg(con, "Fixing up cyclic dependency with %s\n",
> >                                  dev_name(sup_dev));
> >                         device_links_write_lock();
> >                         fw_devlink_relax_cycle(con, sup_dev);
> >
> > base-commit: 5fcd0bc17e451e8f140067131fd12be0f5f1204c
>
> Nak on this one. This doesn't happen for most systems and for the
> systems where this does happen, it's handy to figure out any boot
> issues that might be caused by this cyclic dependency.
>
> Maybe after a few kernel minor versions if no issues are reported with
> fw_devlink for a while, I'd consider making it dbg.
>

Ok, I see this is changed in rc4 so I'll resend.
