Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D7422A07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhJEOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbhJEOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:05:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF444C02B8C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:55:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dj4so79391392edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nQrZDe3L3lnevNgwmmPUj83yrkESGDrc+fmpfAhQFg=;
        b=5Z80PapGlg+CLKzYJ7C4/tcqEsBWzVrpWomx8ZPjQx33tVA89XTnNsMfMpNoGlEPFc
         Tv1ftiRthctlN0/AZ82d5WxOFvBqrAY1aPi2cvDs3OkwqfExUj04CDMxdO3i2i0tTXMg
         i/5P1V6lcfEq1kvXAW819vWS8f7ST75/6BhpJPvGexNA7o9J7+fmvAJr/fJqOTc962jV
         8FwKZTL5ttRXRnxqo4NBUjDHvTzE0QCoWcW1JgcBfKQ3xXwn/YNE7SulwFuZI7m5Q7FW
         La6Vqpkut1o7RbUic5xqYwBizsyJLbJvOV/nzyfmDVhGK3od5SwWE6OM045ZsIVosw8y
         yy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nQrZDe3L3lnevNgwmmPUj83yrkESGDrc+fmpfAhQFg=;
        b=ZuoZpF/3i8c4VLXVYv//Bpk1pLRDMHHwazxzC4oSv33NzWrPkWgBNIEWcn3yK1Sjk6
         ud9W6pgCGfG+tltRpsshQAWu1IZ3IuoM3lcdvlWvdzNOrbhm0/e8zUruwqn7KJ+ZAK16
         FyE0QJkdGh7zZbcrlb2O4ruCTzF0HTUf/iJsF3rvOcryqnBORwZ+NAk5dD5LUZVxizBZ
         rrY87xPshJ7wlTWtRS+rfnBYn2mPTPRGCtuj/J/kALro/cWOh36udyOCb4RiuuSQJ1C9
         MuhtconJMgH6Utgm9OzvCMTao5B+RkziFLQh691hl5gJDKeJytOHGDM4kuWvJ7r5+eLa
         E24A==
X-Gm-Message-State: AOAM532cHL0UqdxdYgRaGHuKv53lhEs9cwJPug8eovCvtj76jD8fynVp
        57wpyJtXQkyur6g9UTxK8rhdlT/AgmKM94fEvrEw
X-Google-Smtp-Source: ABdhPJxXFaPdoVeXTHWJ4N9Z9y35WGVg9/WQkoOpNDkwryi/oobLzFCbBmPQZs0ePNLDIgCowz+yAsCdg+1+ItUorQQ=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr25354271ejc.24.1633442022740;
 Tue, 05 Oct 2021 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001175521.3853257-1-tkjos@google.com> <YVxTlBMSWBkLgSi9@kroah.com>
In-Reply-To: <YVxTlBMSWBkLgSi9@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Oct 2021 09:53:31 -0400
Message-ID: <CAHC9VhTdyc6qagfFDLFteqTpayC4G=tNy1T7mueMKeZzU8QmwQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use cred instead of task for selinux checks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@google.com>, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 9:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Oct 01, 2021 at 10:55:21AM -0700, Todd Kjos wrote:
> > Save the struct cred associated with a binder process
> > at initial open to avoid potential race conditions
> > when converting to a security ID.
> >
> > Since binder was integrated with selinux, it has passed
> > 'struct task_struct' associated with the binder_proc
> > to represent the source and target of transactions.
> > The conversion of task to SID was then done in the hook
> > implementations. It turns out that there are race conditions
> > which can result in an incorrect security context being used.
> >
> > Fix by saving the 'struct cred' during binder_open and pass
> > it to the selinux subsystem.
> >
> > Fixes: 79af73079d75 ("Add security hooks to binder and implement the
> > hooks for SELinux.")
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Cc: stable@vger.kernel.org # 5.14+ (need backport for earlier stables)
> > ---
> > v2: updated comments as suggested by Paul Moore
> >
> >  drivers/android/binder.c          | 14 +++++----
> >  drivers/android/binder_internal.h |  4 +++
> >  include/linux/lsm_hook_defs.h     | 14 ++++-----
> >  include/linux/lsm_hooks.h         | 14 ++++-----
> >  include/linux/security.h          | 28 +++++++++---------
> >  security/security.c               | 14 ++++-----
> >  security/selinux/hooks.c          | 48 +++++++++----------------------
> >  7 files changed, 60 insertions(+), 76 deletions(-)
>
> Ideally I could get an ack from the security developers before taking
> this in my tree...

This should probably go in via one of the security trees, e.g. SELinux
or LSM, rather than the binder/driver tree.

-- 
paul moore
www.paul-moore.com
