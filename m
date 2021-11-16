Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BE453ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhKPUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKPUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:25:46 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2585C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:22:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 14so188817ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O9VKvoceXwVaex9oUhrTDMbmORNpnJcPhpNAZgT+zc=;
        b=VoERw1nEsVGfo78krzq4syT9ErLsmGF1KC8F9uP520gHOLYkdoCzynrFOQyVrIRDCT
         D3SWW0MI4bGSgSxA80cVHcgj66c2pB55n8VHPDpamKVn/BSATzn3DDLnHqOnfWaCV7Hs
         vDUOvHfyEqv+SI/oyFDbUOLOj1aOyamfqebu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O9VKvoceXwVaex9oUhrTDMbmORNpnJcPhpNAZgT+zc=;
        b=HF5YhZPDRnSQ7OrRSUbrEGVwp8nKO6qb0wsZatcf9pzzNsCCc5Fn03CnHOtlAbDLP8
         TbA/CDNjAWkUqo5r/U9g5r3OujrkNzqpt0Gn0w9+zRuevXr2vi+SdvT9fHytbw2Zjo4y
         Xzn5zCYjYewMoFgjuAkY08xzQI4n2zUL/07byfiM4oQzRr9N8G4PlQYTDi1FQWpm7BpU
         BL7P+umrPzRlADMJImgd7+mxjUjcsH3DKLHP7SPmXFcq7kk5uyYAB0z8qVm0uRy1HouE
         jYhuHPeRwM+imX+XAr6lDtbNLKwsIbe9eA/hnBOPAZyyudvCx7UhCCS+4phJ2YNWq4e1
         v/zQ==
X-Gm-Message-State: AOAM5333oNCIcHSSgpGkCyocSD6drhfVW1YARHOCucplMvjjb3cpa2hk
        0++Ymbh/THAvdPvPTsPQHhzaZGdJzia/yw==
X-Google-Smtp-Source: ABdhPJwJexL0ZZ6TvuPvV48FLzFOf1MFeBWH4YlrU6W5frSxa9IIGGVQTTgYNtvAfMQ6AnF8tAZeXQ==
X-Received: by 2002:a5d:8785:: with SMTP id f5mr6932033ion.110.1637094168973;
        Tue, 16 Nov 2021 12:22:48 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id v1sm11491646iln.28.2021.11.16.12.22.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:22:48 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id i12so391318ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:22:48 -0800 (PST)
X-Received: by 2002:a92:6910:: with SMTP id e16mr6338204ilc.190.1637094167822;
 Tue, 16 Nov 2021 12:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com> <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 16 Nov 2021 12:22:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
Message-ID: <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 9:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Gentle bump.
> >
> >
> > On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > snapshot_write() is inappropriately limiting the amount of data that can
> > > be written in cases where a partial page has already been written. For
> > > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > > the snapshot device, and have both of those complete fully (since now
> > > we're aligned to a page again). But what ends up happening is we write 1
> > > byte, then 4094/4095 bytes complete successfully.
> > >
> > > The reason is that simple_write_to_buffer()'s second argument is the
> > > total size of the buffer, not the size of the buffer minus the offset.
> > > Since simple_write_to_buffer() accounts for the offset in its
> > > implementation, snapshot_write() can just pass the full page size
> > > directly down.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >
> > >  kernel/power/user.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > index 740723bb388524..ad241b4ff64c58 100644
> > > --- a/kernel/power/user.c
> > > +++ b/kernel/power/user.c
> > > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > >                 if (res <= 0)
> > >                         goto unlock;
> > >         } else {
> > > -               res = PAGE_SIZE - pg_offp;
> > > +               res = PAGE_SIZE;
> > >         }
> > >
> > >         if (!data_of(data->handle)) {
> > > --
>
> Do you actually see this problem in practice?

Yes. I may fire up another thread to explain why I'm stuck doing a
partial page write, and how I might be able to stop doing that in the
future with some kernel help. But either way, this is a bug.
-Evan
