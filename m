Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72C339A38
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhCMAAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhCMAAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:00:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:00:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p21so47928576lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmxyat8Pn6hyY6rb0+pkI0hzaawVQ4oGi5yLjm26k8Y=;
        b=UTj96buQ3XHBWUSJXpY2KO2W7ziKfVt5FGyxJSmGF7qNh5cO0Gs7fF301zupMIgh53
         oLsI5kHp9A81jOaitaEqd5DxC2VzGYLa46zZPy1rMZ8LxJLfCNMzQTJ4ajhFz4f++C/Z
         K+ZdoULYaPUvUCfHz661H18eFsR9zo93zJXhMzb6uYeaEAsfaVn+TwjlAfmX/AJL8h2U
         0IeCHBFStENhHzzDJUR+esKbWkPc1EO82x+jAbuVQ0T12sCdQO2f/bOp1gHDb9q/gdiW
         x+7S0q43wFWCB4MyG48CSc4Dk874O1j2/PH1R2vPhlq+VRiUm3AjARFSrfOQFTQTudse
         YY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmxyat8Pn6hyY6rb0+pkI0hzaawVQ4oGi5yLjm26k8Y=;
        b=cyCFf+TFStaNxjfG6HlMTkzHKAihtiKrWAAk0qInHqlv28Nu56k2TUbG6Fq2Me1N8i
         OYY+8tffEAmxtApWsXIOFsfE75t6cFAyjfzICcjvP0PWiUNCk9q1Wr8YUB02UdlYIjdb
         iBhipN5HYlZdUFvRuKbXPashkttEGMwmSdHwX8wnwg0hY0kIo8X6aoBiUfOSYvxzpYwI
         GUEjQrqa7Tcyq6/V085lYN3s4hKKtsBEkuOVN268Fx7U1+kypWaro1cb8MfPfLNKhmYv
         4vpvDm/GeR8kafH1AOAmqQCXg8Bklqn2jXpDNwKSyMJuSNs/IGrmyMxK/7YblT76BP9y
         5wPg==
X-Gm-Message-State: AOAM532+E1SzOfCbnmcaZwdDRaIe2scY9zGo6SoXUvs3MkVGecmq17HI
        4/lqQMV/08mSMBp/ZnAG34kY22RH0GDcGtMwMIoprhuW5yo=
X-Google-Smtp-Source: ABdhPJwc72IkCpqlUAkD2N6COr6Z9UoBbxNT+HyqgM6hgfK6BKb0VFBjmeorlwJoBv7YP/h3sg0gpQMOwlN/bnoRb4k=
X-Received: by 2002:ac2:5974:: with SMTP id h20mr1023017lfp.554.1615593623371;
 Fri, 12 Mar 2021 16:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20210312122531.2717093-1-daeho43@gmail.com> <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
 <YEt00vJ6oVfoRjSJ@kroah.com> <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
 <YEt+nAEOd+YUdln8@kroah.com>
In-Reply-To: <YEt+nAEOd+YUdln8@kroah.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Sat, 13 Mar 2021 09:00:12 +0900
Message-ID: <CACOAw_z9LUjx-5MRYnWOFnL9DzUkvKU1RVObRLwudZbpBxGywA@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:45, =
Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>

Thanks for letting me know this!

>
> On Fri, Mar 12, 2021 at 11:37:29PM +0900, Daeho Jeong wrote:
> > As you can see, if we're doing like the below.
> >
> > sbi->compr_written_block +=3D blocks;
> >
> > Let's assume the initial value as 0.
> >
> > <thread A>                                             <thread B>
> > sbi->compr_written_block =3D 0;
> >
> > sbi->compr_written_block =3D 0;
> > +blocks(3);
> >                                                                + blocks=
(2);
> > sbi->compr_written_block =3D 3;
> >
> > sbi->compr_written_block =3D 2;
> >
> > Finally, we end up with 2, not 5.
> >
> > As more threads are participating it, we might miss more counting.
>
> Are you sure?  Isn't adding a number something that should happen in a
> "safe" way?
>
> And if you miss 2 blocks, who cares?  What is so critical about these
> things that you take the cache flush of 2 atomic writes just for a
> debugging statistic?
>
> Why not just take 1 lock for everything if it's so important to get
> these "correct"?
>
> What is the performance throughput degradation of adding 2 atomic writes
> to each time you write a block?
>
> But really, will you ever notice missing a few, even if that could be
> possible on your cpu (and I strongly doubt most modern cpus will miss
> this...)
>
> But this isn't my code, I just hate seeing atomic variables used for
> silly things like debugging stats when they do not seem to be really
> needed.  So if you want to keep them, go ahead, but realize that the
> number you are reading has nothing to do with being "atomic" at all.
>
> thanks,
>

I agree that missing number would be extremely few and the overhead of
updating the numbers would be quite bad.

Thanks for your valuable comments. :)

> greg k-h
