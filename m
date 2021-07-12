Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523BC3C57ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378095AbhGLIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352109AbhGLHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:52:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9356C0613DD;
        Mon, 12 Jul 2021 00:49:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v6so4375487lfp.6;
        Mon, 12 Jul 2021 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25uRGjyIuT2+pU4ci3d+O1+NHkNqvq8TVllUcppTGhA=;
        b=DXsSpZw/SVeET206aIqWEUuI5vrAknv9FNEY99wh8g9bv/2B8Zn4W1KE57CHRO+kff
         S7bbpZeJhQPdxd584nvjZh80a/gOzogMrFz/hMwcbpO5SJBxrr+qE3pPW2LrHM8e0Hlg
         5+ToQDrPoUsxWC0jHVOWLwN/FXMVUN2RsAsXoUn70fkQmum9gxL6JBnh/9p9/QQqhnCR
         Cx0ycZaT6fcjnaioOmiLHBb9rqoiEHWpu5Ody+qV96hRO9I1/uymT4j99mgiz5pKALnX
         u5opKVI87+2Ll7YF6NDUS91GfY9z13YAcVl6HcmrmLKNPo3+gMOsnHnnCqqp65w1fN2N
         bPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25uRGjyIuT2+pU4ci3d+O1+NHkNqvq8TVllUcppTGhA=;
        b=Y1yEXMGJk71aYiEOS+hKwMer+S4MCSsA/CB1JjbcLHfM/riyTMzH6W/BJJ7v4RvWq7
         OX7NKfh4GsTV5ZD0imVDjvLIg9W00205sQ68b1FYUoiJrXiJ4VmooSNdD0a0PK6YgbJ6
         jFYZiPWgdigFHwcb9m9GzFBS0KBuTPEGENV1VwSkVxFxgDLujnOVhDumNvLG25YLoY55
         pJcBnCTVSM/dOSJc39/c7SG/V4goxHQ6Cz6qU4cSY9sIaL0KV8yvJrCxQRkcTzDyOX5Z
         TFaqPIw4h1t+Rlwmv4APVVZm6/3lgZEJSzPvpEv5FFImxM9SfO0CXlqjbBvQh+MPAUOa
         vq+Q==
X-Gm-Message-State: AOAM530oaUYqEDm1rbJLMFLIau5oOka/limb8BrwJoWSiXT3bXKDSnFt
        Zdg2+E7ZJoHzn7JsV1FcvGooxW+2J2hmIXGFnCE=
X-Google-Smtp-Source: ABdhPJw26ORVIoyQPuX/1CUch9L7off2KGrMWpaVN/W8iilfojldbKr9j+qVGYlKQIp0iN9AhzMT+m17CTPdX8BYu5k=
X-Received: by 2002:a05:6512:2295:: with SMTP id f21mr29827234lfu.520.1626076179101;
 Mon, 12 Jul 2021 00:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141430.896595-1-sxwjean@me.com> <20210711141430.896595-3-sxwjean@me.com>
 <93ccb871-7f57-9109-9072-8fc26f3b811c@redhat.com>
In-Reply-To: <93ccb871-7f57-9109-9072-8fc26f3b811c@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 12 Jul 2021 15:49:12 +0800
Message-ID: <CAEVVKH-yQgFi2U4v2p4mN_aaUM7=A8UEpSK67wUpacpc-MtFAw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] locking/lockdep,doc: Correct the max number of
 lock classes
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 11:22 PM Waiman Long <llong@redhat.com> wrote:
>
> On 7/11/21 10:14 AM, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The max number of lock classes is 8192.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> >   Documentation/locking/lockdep-design.rst | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> > index 82f36cab61bd..5c2dcec684ff 100644
> > --- a/Documentation/locking/lockdep-design.rst
> > +++ b/Documentation/locking/lockdep-design.rst
> > @@ -341,7 +341,7 @@ Exceeding this number will trigger the following lockdep warning::
> >
> >       (DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
> >
> > -By default, MAX_LOCKDEP_KEYS is currently set to 8191, and typical
> > +By default, MAX_LOCKDEP_KEYS is currently set to 8192, and typical
> >   desktop systems have less than 1,000 lock classes, so this warning
> >   normally results from lock-class leakage or failure to properly
> >   initialize locks.  These two problems are illustrated below:
> > @@ -383,7 +383,7 @@ you the number of lock classes currently in use along with the maximum::
> >
> >   This command produces the following output on a modest system::
> >
> > -     lock-classes:                          748 [max: 8191]
> > +     lock-classes:                          748 [max: 8192]
> >
> >   If the number allocated (748 above) increases continually over time,
> >   then there is likely a leak.  The following command can be used to
>
> Acked-by: Waiman Long <longman@redhat.com>

Thanks.
