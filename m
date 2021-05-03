Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48F9371318
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhECJkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 05:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbhECJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 05:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620034787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ed4Fg0jmvz5izTHQmdOnBOoJKIPHVPN61DnFBqKQxak=;
        b=YA6cFzWKScK+zvX9Ydu7n3L5nVlmnj/L03fdw5I5akJWUffXN5ZbRK168+Wqkpd2+SEy8I
        OA/Kul5MA/mvkWSegy9u4Zz7aQweQxNL2Sp7zEHnmruPUCpHOJkBAoFBuDo0Xo6TyAKKrx
        rgdifwtIT47At+KsXfneMkZAj74JV3U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-wRNyXwzeM_CPH56PnALn2A-1; Mon, 03 May 2021 05:39:46 -0400
X-MC-Unique: wRNyXwzeM_CPH56PnALn2A-1
Received: by mail-pl1-f200.google.com with SMTP id x10-20020a1709029a4ab02900e71f0256beso1316461plv.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ed4Fg0jmvz5izTHQmdOnBOoJKIPHVPN61DnFBqKQxak=;
        b=S9fbE69PHnfyeiO8qjj5icV7P+wcCLAx5lAu0D/Ip0iOXOesj+YbZ2FlD958p678tS
         fEVpYbT4WrZJL50i0WDCagWz/1uSEcuTond6eLhup6UpFXWfSL+B/o7bgfT6lknqtUTr
         ynNVfkg1GAYw1dFd/3CdUXt+6uXN/P9jSshjhIoipsf9wVZijt7oCyw+QgwcarCoBTdT
         KzHmBXS2fgIKQUKa0C34JoYWqBfL9cvvqhe/OPhOwtu3xeIPvl1S4QzHweYNLCeb5rxd
         N1ZMKRk5nSzToWPfssKgGx/v0kDtW6Wkyw+JaaDBHaituVyZBPQ1F9QwE1589PalH4j/
         crYw==
X-Gm-Message-State: AOAM530boD4bKibu64iUryeogC3vEqpBBquBPjnWQ+KWBrgiJeSgq8I0
        eq9BzLS0Hm8Bp5SOSBAGQBbDQ6mB9w/+Aj0Ffabqlb7xkeeqgCzPQGyIsMnnX61thIIjS9BMLlr
        fFI5dHy6CMvlzkYBF0TSWPw53TbsLDA8JHMjx+ekX
X-Received: by 2002:a17:902:f686:b029:ee:d211:5a1b with SMTP id l6-20020a170902f686b02900eed2115a1bmr5621469plg.41.1620034785194;
        Mon, 03 May 2021 02:39:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVwcIIS+AzZDYRB2WFTm3qhlqHXnG6TXvo9ghWdIZfp2zf4V5g5e/VU5R60f6Ou/pYXvEqxrLZ+JvlRsSB070=
X-Received: by 2002:a17:902:f686:b029:ee:d211:5a1b with SMTP id
 l6-20020a170902f686b02900eed2115a1bmr5621447plg.41.1620034784949; Mon, 03 May
 2021 02:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615224800.git.nabijaczleweli@nabijaczleweli.xyz>
 <20210420131741.kdgxquhwqureih7c@tarta.nabijaczleweli.xyz> <nycvar.YFH.7.76.2105031110480.28378@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2105031110480.28378@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 May 2021 11:39:34 +0200
Message-ID: <CAO-hwJ+HhKU7EzPZGOtPePT_h7OUaJ=QfWi7eAcxsfRaDtQuvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stylus-on-touchscreen device support
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 11:11 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 20 Apr 2021, =D0=BD=D0=B0=D0=B1 wrote:
>
> > > This patchset adds support for stylus-on-touchscreen devices as found=
 on
> > > the OneMix 3 Pro and Dell Inspiron 15 7000 2-in-1 (7591), among other=
s;
> > > with it, they properly behave like a drawing tablet.
> > >
> > > Patches 2 and 4 funxionally depend on patch 1.
> > > Patch 4 needs patch 3 to apply.
> > >
> > > The output of this patchset and the need for a kernel, rather than
> > > userspace, patch was previously discussed here:
> > >   https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/5=
58#note_792834
> > >
> > > Changes in v2:
> > > Patch 4 now ANDs the secondary button with the tip switch,
> > > since it's otherwise borderline useless to the user.
> > >
> > > Ahelenia Ziemia=C5=84ska (4):
> > >   HID: multitouch: require Finger field to mark Win8 reports as MT
> > >   HID: multitouch: set Stylus suffix for Stylus-application devices, =
too
> > >   HID: input: replace outdated HID numbers+comments with macros
> > >   HID: input: work around Win8 stylus-on-touchscreen reporting
> > >
> > >  drivers/hid/hid-input.c      | 54 ++++++++++++++++++++++++++++++++++=
--
> > >  drivers/hid/hid-multitouch.c | 18 +++++++-----
> > >  2 files changed, 62 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.20.1
> >
> > Bumping this after a monthish =E2=80=92 is it missing something? Am I?
>
> Benjamin had concerns about regressions and wanted to run a full battery
> of testing on it.
>
> Benjamin, is there any outcome of that, please?
>

Sorry, no real outcome here.

I ran the test suite, and there were no errors, until I realized that
there are no tests regarding tablets, so it can't detect any
regressions here.
And then, the usual happens, no time to actually work on the test suite... =
:(

I'll do a "normal" review soon (i.e. today)

Cheers,
Benjamin

