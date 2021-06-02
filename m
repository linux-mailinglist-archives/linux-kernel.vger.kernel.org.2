Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09973398CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFBOfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:11 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:36564 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhFBOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:01 -0400
Received: by mail-ej1-f51.google.com with SMTP id a11so3479917ejf.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NEzqXEUZcOuaAjPBHdBD3YzSrWcsSUbM7pL6pp882Y=;
        b=HM2JLmp+cb2rdJXbwwCHeQpd+Dc/h/jgkm546CJQyOo/Cg+mQEP++Ynlso1n0rM02m
         pEMLMG67U3tbON5cmtQw8jB0X+Ur2Qc7EnKKvXkYxLC3uVTQCb6jBOy6+2c/jDavAh2e
         Ot5T7WWmE5G//I0VeNunVTc6qGFGMCB/dV3Shz94igkiZQNM1P3gTjKMKSCGDSyHUZHJ
         BrJVmsru/YODLzr2F+YBY5y7rOb6NCTjJUiajyYOzXIzm/XDLuEaP0/35G9Hy5e5Auah
         4SLAKXMJkyY+YGh3dY0EFxjiHdziTwKL9aQn4ehlj6msJTCbmWWi4EnHFQI5J6/YNObK
         iDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NEzqXEUZcOuaAjPBHdBD3YzSrWcsSUbM7pL6pp882Y=;
        b=jgVXMXVBWifI7fdojcoPRs4UY8weAxpFnypDEolG+0SW5zNLM43AKGVr9a1ZJyOMzU
         2sI2hAqT9DyClG6qs4/UhTd/IL5Ihc0xm+BP1wV8nPO2GF+F+aWj4O8e601mwesixhCa
         tyiWW6lhKUaqY+N/v0C6E5sPfRnk7jyJpEklKqF85oarOYXTywuqP+PVuJJ0l8XsOCY/
         x1h90poAkLujd9gYc8j+x5fZJRlAwnQX64WSIvslgw6cuX21PMUGdsoj3/2Ivx42NGOt
         CBxveziQy8YmA72X07bLKyNVgVF/a1NruXIOPH+4Wdyqil0OXvRWNR0w6H+d6Ab8ZSDE
         RaIQ==
X-Gm-Message-State: AOAM533rfLzN5Tu37VTdaz4Tcvuw2Rn7RcgbyoUMnUt4dRraBqzc3o0b
        z1CDYGr9EQXQwwUAJdqf+MKRRspqr7puAF0sWp3B
X-Google-Smtp-Source: ABdhPJzhO5ghggXAHF+13y+zCETq5Suqlx0WNmIIHDe7WqLHXUgME/QTDQF5pXr+zsiWnZeNHENS6Haw1zOJx/cqvjg=
X-Received: by 2002:a17:906:1113:: with SMTP id h19mr25232518eja.398.1622644337403;
 Wed, 02 Jun 2021 07:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210602054802.GA984@raspberrypi>
In-Reply-To: <20210602054802.GA984@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Jun 2021 10:32:06 -0400
Message-ID: <CAHC9VhQdAt2EQqP3pQM=5TifTYuXxnU1QOvOT-aFaDaGiLLJXQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated LABEL_INITIALIZED check routine
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 1:48 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> The 'isec->initialized == LABEL_INITIALIZED' is checked twice in a row,
> since selinux was mainlined from Linux-2.6.12-rc2.
>
> Since 'isec->initialized' is protected using spin_lock(&isec->lock)
> within various APIs, it had better remove first exceptional routine.
>
> With this commit, the code look simpler, easier to read and maintain.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/selinux/hooks.c | 3 ---
>  1 file changed, 3 deletions(-)

This is a common pattern when dealing with lock protected variables:
first check the variable before taking the lock (fast path) and if
necessary take the lock and re-check the variable when we know we have
exclusive access.

In the majority of cases the SELinux inode initialization value goes
from LABEL_INVALID to LABEL_INITIALIZED and stays there; while there
is an invalidation function/hook that is used by some
network/distributed filesystems, it isn't a common case to the best of
my knowledge.  With that understanding it makes perfect sense to do a
quick check to first see if the inode is initialized in
inode_doinit_with_dentry() and return quickly, without taking a lock,
if it is already initialized.  In the case where the inode has not
been previously initialized, or has been invalidated, we take the
spinlock to guarantee we are not racing with another task and re-check
the initialization value to ensure that another task hasn't
initialized the inode and act accordingly.

The existing code is correct.

-- 
paul moore
www.paul-moore.com
