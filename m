Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0A377D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEJHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhEJHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:52:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EDEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:51:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lp4so9280586pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3lIDYRjEqzgIvcUCtBDnBQUErg1kgTxV/8Bkn6tm5Q=;
        b=SRshdANv1vpLG/kZ7Z7AyqI2G2nPqWVkHAXeJh+/bIaP5uIaYRbi13dpImBGjlEEYC
         jv+zJcrIVDqLbw8CISHFvOllHGbipDYPSKsOoKKKGihrp47Pzh7V1AphSLaq4DVmPNDG
         1/yWtIV9vcm8TZPMCwmEMm4c7FLJDA4ooMus0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3lIDYRjEqzgIvcUCtBDnBQUErg1kgTxV/8Bkn6tm5Q=;
        b=Jv9aQvP6ajCP+LADrNmmqH5E+h74QD1lGTDrYlfgcxGZtwiEZBkIfsW584Opefms+K
         tF54AV6vkWLsGpseAwnIJQKYEU3wtSxrr1HMHxY52WpbMwatenF0zB1cMRqadqImL2Ln
         NydA3tjnpuzNiU6qZtAubFD8ZvN5pdbXKJmgkvzGJ7k/IkvAU0j47G1JNI+wWhk8LGCt
         MV5wqb7KzNa6b+2rxFY3DDaseJ6SEd5OhpB9kbKgEtbDuw15M5QyBlXrKIYrENHe2Dnx
         OiqTflixy7uPUT/XXmXi3RcafqXpApWDqnuThbV2i91o9ZlKyTAhRr7JOpAUVS8OeRE6
         EZqQ==
X-Gm-Message-State: AOAM532EZO8XqQs7AovHeaUPcLlplEUsmdoD0yc9xdzd/7+k3uY7lsH0
        TtftgXM0L4x082Cda+IeqtjDKhqhfWb8RhDG78FY/Q==
X-Google-Smtp-Source: ABdhPJz9o7iMrQUyTT/OdYYa7W9Rr7zSPlQqxzJH4r5OhdoDQXjbWbWne2V241Wh9YZlXMy0ihMy1Zw/9gSYZ9YFAaI=
X-Received: by 2002:a17:90a:f0d2:: with SMTP id fa18mr39393884pjb.126.1620633106851;
 Mon, 10 May 2021 00:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210415032958.740233-1-ikjn@chromium.org> <20210415032958.740233-3-ikjn@chromium.org>
 <nycvar.YFH.7.76.2105051434520.28378@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2105051434520.28378@cbobk.fhfr.pm>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 10 May 2021 15:51:36 +0800
Message-ID: <CAATdQgA27o2wq0L-QrKwz1AywztnYZC7+rij=SjhWXdSJPC+dQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] HID: google: Add of_match table to Whiskers switch device.
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 8:35 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 15 Apr 2021, Ikjoon Jang wrote:
>
> > Add a device tree match table for "cros-cbas" switch device.
>
> Applied, sorry for the delay.

Thanks a lot!

Sorry for bothering you again but I can't find
a device tree binding patch [1] in your trees.

I think dt-binding should go first before the driver part.
Can it also be applied to hid tree (or am I missing something)?

[1] http://patchwork.kernel.org/patch/12204197
     [v5,1/2] mfd: google,cros-ec: add DT bindings for a baseboard's
switch device

>
> --
> Jiri Kosina
> SUSE Labs
>
