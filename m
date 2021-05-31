Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85888395956
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEaLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:01:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCEFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:59:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cb9so1101800edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP3WcUIToXbjBzYIVWAC3coIFADZFvRroLmM7ZEJD08=;
        b=OK30sQzcv7pOlKyf/wTJbiuM9Y3pJy8KSrHmIJveIlwbmMVAu+SEutZlB9W9OlNAii
         hxFVX1GQ5CFwKfYD+SpKm8jGiW51KypPo5ksWidt1m7oiQfrhJdtDTdZjJZl3eZ6Lire
         ghJsV6ODsZsCjUOxOBAQhGVxBEU2UDEg1xUVMZZIhUZOI/pVSFf4kxZkSfa1wAWFwkxj
         ZfvqtAjfuG4JDUq1USZYNcQGGdh6hbBuA/qrVUAXd9eqwwDUnRg0uLi0VHNzNLNsKb1Q
         24vBLGWOL5mGWH7D4/aSUA+WhgE5vJFHTtgLCEi7oEoO+1Odp+6m4euccHa4zsiwY8Lc
         svKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP3WcUIToXbjBzYIVWAC3coIFADZFvRroLmM7ZEJD08=;
        b=ElJiNPSOf8Z+XJcu3CBYF5fUTEuCxMZQi7+zLPSWmI/0RBGhUv9tbJgv+sf7FmX3Ul
         R8jmjH04QUUXcGad0q1OYcsOYdulXE2LMpner4+ETn/wns4OTPoZZU7V1uYptJGFZVO1
         /sficvJpLDDAPH+aGEl3Blz+BSXN7tv0kO7aZYG4pUNcmmCH9pxXjjTg5gZrLoexggxB
         amurmfOwUgdVXeC3PG4Kbs7cTEXExtoAhYcIBGZTfcBDdlswtDJO0Y4YGY++8Agd2Hxm
         AuQzxBgAlBw0cHa0kY+gyF3WyueZvNMgUhiwqkbFCQPj8IyWUl9MIPFH369Ou1nebRb+
         plAA==
X-Gm-Message-State: AOAM530bXrdJkcjmdHIP4EMaXI4a5P0tZGv6MS3ea2AZIbhOPkKP6iEY
        tL+QX2aT97n8joh4M8T+saSSYnuBf1N0xGzXn3w=
X-Google-Smtp-Source: ABdhPJw7wMDeOrH18o7Kh7wDlmDSk58NKBskCqUTNl8wB3HMaLUJjk1vxKZXE8eeAs/qvf8qnpr5V61G5gkN3DKW2Io=
X-Received: by 2002:a05:6402:22f9:: with SMTP id dn25mr176682edb.241.1622458785176;
 Mon, 31 May 2021 03:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam> <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam> <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
 <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com>
 <20210531084613.GX24442@kadam> <CAD-N9QVAdaitDcM6BGfwvNR=gMf7G6DK00n0Ev6ucXc6xNFFpw@mail.gmail.com>
 <20210531093817.GY24442@kadam> <CAD-N9QUTZ49CvrhW76pTUDOp8y=29JXxR45Z_W53qVz0PJHVLw@mail.gmail.com>
 <20210531104355.GZ24442@kadam>
In-Reply-To: <20210531104355.GZ24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 18:59:18 +0800
Message-ID: <CAD-N9QXAq73E5DrzkK6gULaBAQ4FrO5_OCndWZpOmSgPTAiqrw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 6:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, May 31, 2021 at 06:35:33PM +0800, Dongliang Mu wrote:
> > On Mon, May 31, 2021 at 5:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Mon, May 31, 2021 at 05:10:49PM +0800, Dongliang Mu wrote:
> > > > Hi Dan,
> > > >
> > > > I wonder if we shall split the current patch into two patches, one
> > > > patch for each memory leak. It is better to satisfy the rule - "one
> > > > patch only fixes one issue".
> > > >
> > > > We should absolutely fix all these memory leaks. But one patch for two
> > > > different bugs with different objects and different paths is not very
> > > > suitable.
> > > >
> > >
> > > I would just send one patch, because I only see it as one bug.  But you
> > > do what you think is best.
> >
> > If you think they are the same bug, that's great. Just send and apply
> > only one patch as it is. I will not send version v2.
>
> Sorry for the miscommunication.  That's not what I meant at all.
>
> Your patch only introduces one put_device().  We need all five to fix
> the bug, and we'll have to change the kfree(link_whatever).  Use
> device_unregister() instead put_device().  Include a Reported-by with
> the correct syzkaller information.
>
> >
> > BTW, could you please show me the syzbot link for the bug you tried to
> > resolve? If it is not from syzbot dashboard, can you please show the
> > bug report?
>
> What are you talking about?  I'm not trying to fix a syzkaller bug.  I'm
> just reviewing your patch.

It seems we truly have some miscommunication. Your message makes me
think you are fixing another bug report that shares the same root
cause with this bug.

Now let's sync and get on the same page.

You are trying to give me some suggestions to fix this bug. I need to
listen to your advice and send another version v2 to you developers.
Right?

>
> regards,
> dan carpenter
