Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6693330B05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCHKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhCHKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615198933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kdbU7D0Cs1nqJnhH9OV4K0Ddqhr5xVnkk7eSjOjWfo=;
        b=Yt5+ZokzS7FkYiK9SOFGQtP5JmXrg/l8PUvPLp43TysJSAR2AEPPhAoSacxLqmcN62L03f
        L6QbNHsechPNKbFL4kq6vNw3/kWIeoC+YmhxGbr8MuqvpQPYUJ3Y4pWqtvoiM7SIPJboWl
        g+47mLKQRZpFUXFQiAwz3sbpjLOVJu0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-ZxuRFkGmMIukY74HPX7abg-1; Mon, 08 Mar 2021 05:22:08 -0500
X-MC-Unique: ZxuRFkGmMIukY74HPX7abg-1
Received: by mail-pl1-f197.google.com with SMTP id f13so4323310plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+kdbU7D0Cs1nqJnhH9OV4K0Ddqhr5xVnkk7eSjOjWfo=;
        b=t+O4PEGcDfVp6IOlCCuIJuU4xQ2NF2v7Kk9TrtvpbWe4cmQBEYJEu0wKfTGPnvtkLX
         tlbc4gmGcl2GGcd1H3piaSg7ctgGqqbaLNb0dEjvj4jGAdNjbzvCE241LkSm6On8fc8F
         PKj3yR/9Lo4njYzYyOkQaFFUkIwfcsNHKdsMo3Di+KvyI0gR18qRuX5U4HhJIbAFIju9
         Yx1l6sOE+iIUUbQgrBbQ03CrNywt89hWgmdQ26FG0dwSDzjboJeSCo1mjkNZhYpIyee0
         f/MROtZl1tHvqSzJznyQoURdDOYyR9qKaoNcCt6jzSehbvxWz4erPqVimzXPYNxQRMoL
         7Bjg==
X-Gm-Message-State: AOAM5307pJlBVrKnuEDF1hjtiDttKQyCfXeQn/IK2CSQH2qGcFmLxaDN
        B9H195PTXQx6ZMGXY9tM99coqg1I/V2e5AMQyyL8hJn2mGni616lzTuB/w1nSSr0trucTFSPjqk
        sEJTAZpuoW/nL1wdjcVFP9WKvopAYFTZImfN2Y19f
X-Received: by 2002:a17:902:7006:b029:e3:dd4d:85ac with SMTP id y6-20020a1709027006b02900e3dd4d85acmr20267956plk.41.1615198927346;
        Mon, 08 Mar 2021 02:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzq49tQ7a54VntS9SC7qB4EcD5e9RLI11vUrjuafOhf+clmiNfTExsZvf5goIHxqniIWvr47LYYg8jQ0aa4Bn4=
X-Received: by 2002:a17:902:7006:b029:e3:dd4d:85ac with SMTP id
 y6-20020a1709027006b02900e3dd4d85acmr20267932plk.41.1615198927109; Mon, 08
 Mar 2021 02:22:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613582014.git.nabijaczleweli@nabijaczleweli.xyz> <nycvar.YFH.7.76.2103081114580.12405@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2103081114580.12405@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 8 Mar 2021 11:21:56 +0100
Message-ID: <CAO-hwJJj0KRCOYPmpNEmU1oVD+SNNYn9+BoGxnPbSthFuCxK9w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Stylus-on-touchscreen device support
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

Hi Jiri,

On Mon, Mar 8, 2021 at 11:15 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 17 Feb 2021, =D0=BD=D0=B0=D0=B1 wrote:
>
> > This patchset adds support for stylus-on-touchscreen devices as found o=
n
> > the OneMix 3 Pro and Dell Inspiron 15 7000 2-in-1 (7591), among others;
> > with it, they properly behave like a drawing tablet.
> >
> > Patches 2 and 4 funxionally depend on patch 1.
> > Patch 4 needs patch 3 to apply.
> >
> > The output of this patchset and the need for a kernel, rather than
> > userspace, patch was previously discussed here:
> >   https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/558=
#note_792834
> >
> > Ahelenia Ziemia=C5=84ska (4):
> >   HID: multitouch: require Finger field to mark Win8 reports as MT
> >   HID: multitouch: set Stylus suffix for Stylus-application devices, to=
o
> >   HID: input: replace outdated HID numbers+comments with macros
> >   HID: input: work around Win8 stylus-on-touchscreen reporting
> >
> >  drivers/hid/hid-input.c      | 47 +++++++++++++++++++++++++++++++++---
> >  drivers/hid/hid-multitouch.c | 18 ++++++++------
> >  2 files changed, 55 insertions(+), 10 deletions(-)
>
> Benjamin, this patchset looks good to me; do you have any objections on
> queuing it for 5.13?
>

Please hold on this one. I am pretty sure this should break the test
suite but couldn't have the chance to get to it. Will pop this one up
in TODO list.

Cheers,
Benjamin

