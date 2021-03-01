Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC978327864
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhCAHlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhCAHll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:41:41 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A517C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:42:27 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n195so15977120ybg.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BPplbjn/NdnRdY/ng25FE0iefOrG/B1EIvyw3V1siQ=;
        b=fSySkTiYersssragQgv5dnSXuq+Wt6h6ZJs9T5bfYJ4ceFFyq1UZouhUrDQB5J1mwR
         TBraNP3Ic12kqqHcHThEW9jMLGX47bNJcGiMH7KS9b1v1ITxnt8Y97hWpXbYv44c8r1T
         OELB/EX56l0GVjP/UYrkMfwRH+VEp59NcBhHaaSVlciFU0nSdiymHz67XMwhYgSz17Jo
         TLTC44xPVnxaLMQsh3aQy8St7RXOzffeCLrYXSo3bue/3heRsgLjZDJ9wwoJZmYW4WII
         jxaiY4vWftBnUqvT10+IZe/JqCAd43gf+sPlmtwp74qmN55HxDGniWn1lUUdnxsDZ2uh
         zATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BPplbjn/NdnRdY/ng25FE0iefOrG/B1EIvyw3V1siQ=;
        b=uTd3DgCO3WjDXcV69Fevv4Dr3o9XjrTxNcIpk0Z4uLO9CcRyXg/Oo0b4KXLhpC+hWB
         kCwRCOV05KOrgTsvcMKDeuhO6WBx+afkrVKR0e7vShGUdNkgWsdcua2T3SGtV7mpqoBz
         i7l6Gi6kpwPRko6RkghAjmV6mml3qKQPurv21TcW5vnei9JPbHWTCMYGe3jDsglEIKC5
         rFk/fN9z2te2xeM9h2tPbocqkLpch3RtE6rcEHwlpfFFgO/hISHXuHnXfGA/rSdkfPmw
         D2Lx8cj0b+D+Umw2gh+7OspoQNx79PpMnX8TbqMjoSHJ8FUr7o0z5pPAqZM7FmckAMeI
         CgDg==
X-Gm-Message-State: AOAM531eUCppYFGzRgej+FdzU6BWUnYtY7qfMwQ9u8NSX/soNScbfUQO
        Hg/z3X50fPc9nlvjUnV+O/yB/ufzKAeOzLgvQtx6TDY3nvY=
X-Google-Smtp-Source: ABdhPJyeWUaIOssNqnTrHXuTlVSj9mqQJSfClNrv5zOk4iRUe33lpKHtEDZdfIKZxN9O7iXVuxk0k77nsi+vJOat2VA=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr22473127ybi.32.1614584545238;
 Sun, 28 Feb 2021 23:42:25 -0800 (PST)
MIME-Version: 1.0
References: <YDZiQoP8h/QDSNkJ@kroah.com> <CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com>
 <YDpWsXwB6MJPjS7J@kroah.com>
In-Reply-To: <YDpWsXwB6MJPjS7J@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 28 Feb 2021 23:41:49 -0800
Message-ID: <CAGETcx8-g5DeajQa3fw6eeMdqsXG883b_2qxRXATQirvqL4yzw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core / debugfs changes for 5.12-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 6:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 24, 2021 at 10:20:44AM -0800, Linus Torvalds wrote:
> > On Wed, Feb 24, 2021 at 6:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > >  [..] I've reverted that change at
> > > the very end so we don't have to worry about regressions in 5.12.
> >
> > Side note: it would have been really nice to see links to the actual
> > problem reports in the revert commit.
>
> Odd, this showed up in my gmail spam folder, just saw this now :(

Yup, went to spam for me too!

> > Yes, there's a "Link:" line there, but that points to the
> > less-than-useful patch submission for the revert, not to the actual
> > _reasons_ for the revert.
> >
> > Now I'm looking at that revert, and I have absolutely no idea why it
> > happened. Only a very vague "there are still reported regressions
> > happening".
> >
> > I've pulled it, but wanted to just point out that when there's some
> > fairly fundamental revert like this, it really would be good to link
> > to the problems, so that when people try to re-enable it, they have
> > the history for why it didn't work the first time.
> >
> > Now all that history is basically lost (well, hopefully Saravana and
> > you actually remember, but you get my point).
>
> Sorry, the history is on the original commit Link that was reverted, and
> in lots of other emails on lkml over the past few weeks.  Next time I'll
> include links to those threads as well.

These are links of interest. All the fixes are at least linked to from
these two threads. And if they are not, they all mention "Fixes" and
list the commit that was reverted. So it's all trackable if we really
find the need to do so in the future.

The original series that set fw_devlink=on where most of the issues
were reported.
[1] - https://lore.kernel.org/lkml/20201218031703.3053753-1-saravanak@google.com/

This is the series that made fw_devlink=on more forgiving. And a few
issues were reported there.
[2] - https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/

To summarize, the issues fell into one of these types:
* Drivers would initialize the hardware without actually probing a
struct device that existed AND didn't use the existing mechanisms (Eg:
IRQCHIP_DECLARE) meant to allow this. So fw_devlink makes their
consumers wait forever. Bunch of driver fixes for this, but [2] also
workaround most of these by making fw_devlink/fwnode code a bit
smarter.
* Drivers would initialize the hardware without creating a struct
device at all despite the DT node having a compatible property. [2]
handles this by making fw_devlink a bit smarter.
* Some device link status not getting updated correctly when a driver
is force bound with a device (I know the fix, haven't gotten around to
submitting it).
* fw_devlink causing some probe reordering that should technically be
harmless (all suppliers probed before the consumer), but drivers still
don't like it. Bunch of fixes + reducing/removing unnecessary
reordering of probes by fw_devlink (latter is under review).
* Spinlock/corruption errors that fw_devlink exposed by reordering
some probes, but the actual issue was unrelated to fw_devlink.

So it was a mix of making fw_devlink smarter to deal with existing
code and fixing some drivers.

Thanks,
Saravana
