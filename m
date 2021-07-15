Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A489D3C9989
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhGOHWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbhGOHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:22:11 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:19:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 23so4313609qke.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1cjQAto7nYn7JzkxmAiW/ruisinsa+AY3D9P3qup/Y=;
        b=Fbu4kxYTq2OFIl25YqIjP9vhUwC0wKe5r8AKpK1YnGdIx9QOy3Nk1X5o0BQN9QiehT
         LsbISaJBWTXydoRWxt+CRPtkUtukTo+Ih0kQF9L5xDYNVaKPPnqlib++wFZQZpBKcCJk
         8Q/SkuKCdDe2edjkxCVVOL4CpuUYw9222q8pkAK7OiJrgVaMgT7C5aaMwvfTlAvL9z5L
         28LDTEV8JO8KrQPtP7TC/hsvYZPQL7Ln33PG5tS9EyLQ4hOs5m4wT4SHP/7S3/3EylTQ
         w9ty7na7Sffy3hIieNLy0L+uzIIeYnj9Musub0EEYCQMmNkvis/m7Qzv5mqJYW/RnKx3
         jpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1cjQAto7nYn7JzkxmAiW/ruisinsa+AY3D9P3qup/Y=;
        b=pFhPKTM5/SjQWElU8eCS3/5bfccqw+5dEtXRG1nBpv395W85WB6ahkfDCIPr8ikQ1d
         MJxR7OD0pVhMMEr9brgb/23m04iCzORbngd2zJar3W3aJw3DxbjkNCBU85kiQIaRMRQR
         DjB3smynHJwFTQi53wmlaW2VM8Rgt0XEqPqHMH6YLzYVIy8z/US+r6/vqRzRXOvXhL+k
         9yc6eblV0kTIl8iSrogqhtf3+MyghwBghwMqKT6jUBcv5upomf4pAvar2h8wRgvurqz7
         kz7tqRYNWYhDszie33E3Nx6+U6wLjBZQ4diZh/NNrSWKcVnHiMxWPCpiT3aNNjJ0Koel
         iruw==
X-Gm-Message-State: AOAM530yncGHETEbQKwn1IcITE0PMMFzoCtATuzxOSo0jAuNW3Ki4CEf
        qA527Bawym4NOBUYteRz98cTZeFb1iAN7UQXZC5n8g==
X-Google-Smtp-Source: ABdhPJwlBlVy0JE6/3ZugPNKjbyhQoYkwp+BuCxehnChMqEvcNwhqYQ9PYzI15QDHRDbUaMXWaDxKWoyOgBP5h8SJHI=
X-Received: by 2002:a37:bbc7:: with SMTP id l190mr2606651qkf.424.1626333557862;
 Thu, 15 Jul 2021 00:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210711155345.GB293743@rowland.harvard.edu> <00000000000068b24405c6db3249@google.com>
 <20210712140004.GA316776@rowland.harvard.edu> <YOxf0OvoGOvWf14m@hovoldconsulting.com>
 <YOxk0URZrLYv8SNU@hovoldconsulting.com> <20210712161445.GA321728@rowland.harvard.edu>
 <CACT4Y+biD8AdKncmvqmaz3dytV-zoeo==rdkTSJvaZ9=RUs=UA@mail.gmail.com> <20210712184804.GA326369@rowland.harvard.edu>
In-Reply-To: <20210712184804.GA326369@rowland.harvard.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 15 Jul 2021 09:19:06 +0200
Message-ID: <CACT4Y+aWdeqfk3FEAWjNddc_tJUfVY34pqhzgiwEUPzPFaFtVQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Johan Hovold <johan@kernel.org>,
        syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 at 20:48, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Jul 12, 2021 at 06:24:43PM +0200, Dmitry Vyukov wrote:
> > On Mon, 12 Jul 2021 at 18:14, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > > > It looks like the second patch you submitted was hand-edited and still
> > > > quoted.
> > > >
> > > > And looking at the dashboard it seems like no patch was applied for your
> > > > second test attempt:
> > > >
> > > >       https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
> > >
> > > Yes, that explains it.  Funny how easy it is to miss those "> "
> > > markings -- you just get too used to them.
> > >
> > > > I've been bitten by something like this before when erroneously thinking
> > > > that a test command could be submitted as a reply to a patch.
> > > >
> > > > Perhaps the report mail could include the patch tested or something so
> > > > we don't spend time investigating syzbot interface failures.
> > >
> > > Good idea.
> >
> > The email always include the patch tested (as syzbot parsed it), see
> > e.g. earlier reply in this thread:
> > https://lore.kernel.org/lkml/00000000000074f06705c6ccd2a4@google.com/
>
> The email doesn't include the patch; it includes a _link_ to the patch.
>
> And the email does not contain any indication when no patch was parsed,
> other than the missing "patch:" link -- which is not particularly
> obvious if you aren't looking for it specifically:
>
>         https://marc.info/?l=linux-usb&m=162602190812912&w=2

I've filed https://github.com/google/syzkaller/issues/2668 for
explicitly saying that there was no patch.

Using links instead of attachments is intentional, initially syzbot
attached lots of things to emails and lots of users complained about
huge emails. So now all additional info goes via links.


> > > Anyway, here's the patch again, this time properly formatted.  Hopefully
> > > now it will work.
> >
> > syzbot parsed this patch successfully:
> > https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
>
> Yes, and it worked.  Time to submit it.
>
> Alan Stern
