Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92D3FEED1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbhIBNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbhIBNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:39:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A0C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:38:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i21so4472409ejd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hsT12q9l6TQD8145m1U6RLvhDKw5cK3afIq0kPWG8Y=;
        b=rm/K83xLimD8/Sar4CK6jKhvkSa3m9Jrf3cSQ7xtnLA7XNvmZ9FKMs8h6ATGhGAauY
         RfiQRcLCjv+jwK2X4TjUG1F6F3LKb/61hz/DAKL6B3ki1IHOEJQ/cLDpKQfbIxR+VZdq
         eXQPwDgVYP/f+A7UDsQx/5ryCVfpRLMMKn5EtWGwkBdaB0joxiKKFQir8PchzyvvetQ/
         I2GK5PTVSUi9hEverlXoJgY5J9kRQDER/YR4MLQdQJWKQHR43QdImTfobEjcrsxIYumE
         6m6rCJRg2oxS+4wDFbnYkB2Z1nExNRNE/YblBxy//cMseHkltHpyxw5gqAyXnMh62Q1z
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hsT12q9l6TQD8145m1U6RLvhDKw5cK3afIq0kPWG8Y=;
        b=miyHtA8VqKcwI1EuL4Jl/1knAXnWmLgkBmMAIJc7pdVMtxB/NV/leDrNb5nhy5a7TG
         5HdAYreT0rIUis8mOGZ6Uerwc/nhZjvqEfFl75Q9wlRD89Bb4UTaEm1JQC1zF3WdNWrc
         +KfI1nSq+fd7fUm7yID+67w2Er2qHeY+S4/dGS2lkHpW5MimF9YbJ6E0/OAItfvjwUc3
         wJeTimpcHQYYip6gLrzb1cv/LQIzyIqsienp5zj0Er5Bb9+Z/84uk7PWbnNhwPETwIUo
         aQizJst+JCtOsIz4j2+yzLrZueesDImugefdC0/Oqr0aqft4aRYy1uYMCFLEU67mABIx
         /1cw==
X-Gm-Message-State: AOAM532IqR7WhLJrAEioNEieFWGq0BNe1IvUwVrJfzXQLcjsNBsoXxpQ
        w99S4y7uAKcadMfCLNmevN7by2ynEiOs09AYwhMkrSDelO5srg==
X-Google-Smtp-Source: ABdhPJyJWl450Wi5qIiOaXpuOqVYxulEz/9ni1Ysxuz5mfzlO+VbWOJzlcVLLMFXeHcGj+1ecJ8Tb+IhyMO/kLKIT1M=
X-Received: by 2002:a17:906:802:: with SMTP id e2mr3810130ejd.133.1630589910058;
 Thu, 02 Sep 2021 06:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210824165607.709387-1-sashal@kernel.org> <20210824165607.709387-127-sashal@kernel.org>
 <CA+G9fYveOoHUydWRjRWtKcF3smTXt3F3ChxuZuDSoxCkDA1rPw@mail.gmail.com> <YTDSFr52yweeAkSa@kroah.com>
In-Reply-To: <YTDSFr52yweeAkSa@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Sep 2021 19:08:17 +0530
Message-ID: <CA+G9fYuhJzH28u16ht6MesRdgZs7tGi4wTo+FtbfH-uuU+ChAA@mail.gmail.com>
Subject: Re: [PATCH 5.13 126/127] fs: warn about impending deprecation of
 mandatory locks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sept 2021 at 19:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 02, 2021 at 06:50:48PM +0530, Naresh Kamboju wrote:
> > On Tue, 24 Aug 2021 at 22:35, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > From: Jeff Layton <jlayton@kernel.org>
> > >
> > > [ Upstream commit fdd92b64d15bc4aec973caa25899afd782402e68 ]
> > >
> > > We've had CONFIG_MANDATORY_FILE_LOCKING since 2015 and a lot of distros
> > > have disabled it. Warn the stragglers that still use "-o mand" that
> > > we'll be dropping support for that mount option.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  fs/namespace.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index caad091fb204..03770bae9dd5 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -1716,8 +1716,12 @@ static inline bool may_mount(void)
> > >  }
> > >
> > >  #ifdef CONFIG_MANDATORY_FILE_LOCKING
> > > -static inline bool may_mandlock(void)
> > > +static bool may_mandlock(void)
> > >  {
> > > +       pr_warn_once("======================================================\n"
> > > +                    "WARNING: the mand mount option is being deprecated and\n"
> > > +                    "         will be removed in v5.15!\n"
> > > +                    "======================================================\n");
> >
> > We are getting this error on all devices while running LTP syscalls
> > ftruncate test cases
> > on all the stable-rc branches.
>
> It's not an "error", it's a warning that the test should be fixed :)

You are right, it is a warning :)

 - Naresh
