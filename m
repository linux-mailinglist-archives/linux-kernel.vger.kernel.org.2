Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9245C93F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbhKXP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbhKXP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:57:39 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:54:29 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u22so6401258lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSz945VXF1BFd/e4+mBTzOYUtSdM9vLxyacs/e/UXtA=;
        b=HMMh1lFnHVBYVLj5nSyQ7W5ZiPNE2LdReg7O0nYSHcxSI6dDIN3iskk/kch7WCCf6t
         pe8Q/5trZO43uytv3Duw1OTa3HHCyeYJ5MY10uNzsy1QsoG5/GQ5/P43q76Q3aDA9GMA
         J7KDHl8tWX67Zx4WFs2cVZ1CdnwGN4cV5sa1hZ01pb3NqLRylqImWhd8eVBD3JJVBqKO
         pX9AsyRzjae8GHs/wABmK5NDOUEzvWG2UibwE217xS6iJEPPOs+8BB4mdOQTfAchlE2d
         vP6kB30kaO48NrVvPnF5rogpwPryXg5ZwsFzSQb/LTw0t2g9xN0hn37arfZhZnDwSx7D
         kJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSz945VXF1BFd/e4+mBTzOYUtSdM9vLxyacs/e/UXtA=;
        b=ooxjazVOpbuvgHvzK+7scSN2XvimDy9w0pjcu2nRqUoWu2CmnRYE7ZxPHCHHoixojq
         8M5tbt7SfsWHECnjtLTUz0XHw/MEsC99P9ImiZHxvwiU1orWCbqk4UoWufEDahSmGfzd
         59orQodBNERdYk5/5DZ96dVqwxkm5a+Stf6hk9nWb+8WreF0qSGY4ps0t0M/eQnEut1P
         J72DFOTYTeA5jL2wNzRwJlguwhoRDAMvG0wXdsjwHUxb7wEPNp0nuPtRyPSawNkosmix
         ebuF4bqc2GF/0+Xprp+/lvpscCEEEyDZH8h0YjOXib750r1SxMNSnxVs/6UMqyETwX6a
         ydRw==
X-Gm-Message-State: AOAM5312ccQwuT2yFNlPOt2bnfIMaMdTyRwtN4msYQaIO+qFAk+TtsIr
        U3BDwowpRlnfKs22+nXDeho++gZ1OX1JmCgMNBrPpQ==
X-Google-Smtp-Source: ABdhPJxTZLNHOiJ4eL2gf7D6zLLVMvlKtcLTjtR8pcGzZtlPWJnSIWYCWTowlExoLRv9qU1zcJihPVr0e1wMYCu5GOE=
X-Received: by 2002:a2e:7616:: with SMTP id r22mr16689430ljc.391.1637769267387;
 Wed, 24 Nov 2021 07:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com> <YZ3y/aYUeC5HSXk0@kroah.com>
In-Reply-To: <YZ3y/aYUeC5HSXk0@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 24 Nov 2021 07:54:15 -0800
Message-ID: <CAHRSSEy527aTTHGeQxD2OiagxTtmyV2kZ5Rfh8JxWA84LxYT-Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] binder: Prevent untranslated sender data from being
 copied to target
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:08 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 23, 2021 at 11:17:34AM -0800, Todd Kjos wrote:
> > Binder copies transactions directly from the sender buffer
> > to the target buffer and then fixes up BINDER_TYPE_PTR and
> > BINDER_TYPE_FDA objects. This means there is a brief time
> > when sender pointers and fds are visible to the target
> > process.
> >
> > This series reworks the the sender to target copy to
> > avoid leaking any untranslated sender data from being
> > visible in the target.
> >
> > Todd Kjos (3):
> >   binder: defer copies of pre-patched txn data
> >   binder: read pre-translated fds from sender buffer
> >   binder: avoid potential data leakage when copying txn
> >
> >  drivers/android/binder.c | 442 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 387 insertions(+), 55 deletions(-)
>
> Are these changes needed now in 5.16-final and also in stable kernels?
>
> Or can they wait until 5.17-rc1?

They can wait until 5.17-rc1.

>
> thanks,
>
> greg k-h
