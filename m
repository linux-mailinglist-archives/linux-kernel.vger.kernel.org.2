Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C685312CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBHJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhBHIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:55:26 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19604C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:54:46 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id q4so3259786ood.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+wQppqA+qPwRN7K+pykfRUc5QHoD33seMy1uTYc7ls=;
        b=rY6XJm+wPIKEGu+FIxW5ZV8p7BgQs1tjA1Zc9MtNXIcuWsEqJk0uD30cKoGxVWhzzN
         4f+6LeUCeV7Vnu4p9XPnUG8vaB0F/gfTW5wHJXV9tCT9TI2BIdbt2GwYBG3gVzHRIbUF
         3uNM1hGD140ptAtkUdeCMtKGjG5854P/W2GgWvn4MJMwk1kLWG7LCKBs94cYAt6nu88S
         3F0HYbBIVUDgekhJpZzMG20DaRXzAG+hMaTziQNbB9fh00Fvy5azR1iEO2LUP/tZqNhE
         zAPyR5OtuAJM5I279MCQOKgNTKhGAGHE5FQ2Ju59eZvr5knRwL1KtYzWjISGpFctIIXu
         1+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+wQppqA+qPwRN7K+pykfRUc5QHoD33seMy1uTYc7ls=;
        b=QnKVP8pfXY40c1DIeKR9A4gxOznkGBsKeeVwMhFMA63Miw2+kPgg6h1kstWI6ag/4g
         u46FVFcHRUB8jjay1voFwVxrx5uxLqpZO5eS41sUvyEZRYnSSWttPPSGadctrtrW0Vum
         /JvBFuo7vo2178R+QSl24C+FFyi1Ich/15Qd0zORSBr68liIYrIDKYVtcWVwE4Szr5W8
         tkdRoXs6h9ERyIUCgx5JeLmJCA6u4mllcRAXiQTXLpJfHac2bbZWGAH884OOPMPWA3qS
         q9LwPuqvsvUqsn3JFvH3D6UjgYRZcv4/K38PVum7d1QhdQZcBwHIBoOi2PO9QUmTDCDM
         8JyQ==
X-Gm-Message-State: AOAM533sR4pWjrmuZFTrfkV/W9v2cEjutHxdaxnDnos79vrO6pXOZ846
        6zhpZaX0mmVJ1YjB2nJQw7VZ5jUaxr5Z34BTw39yMTnYbJE=
X-Google-Smtp-Source: ABdhPJxY+MJvH/46wgSSt5Ws3HGvFmhNdYZa+7BATp0Fs7VJq6CN0IXuTinmUjGoOH/ljNGKQQU0PBDdemgJ6TfY7Xk=
X-Received: by 2002:a4a:a8cd:: with SMTP id r13mr11814804oom.6.1612774485525;
 Mon, 08 Feb 2021 00:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20210125113758.2430680-1-arnd@kernel.org> <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
 <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
 <20210208074631.GA27508@trex> <20210208083250.GB27508@trex>
In-Reply-To: <20210208083250.GB27508@trex>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 8 Feb 2021 09:54:34 +0100
Message-ID: <CAHUa44GUagcWJYyYw9EdaH0E2QjWVAR+iQN10dq_t0uPf+58uA@mail.gmail.com>
Subject: Re: [PATCH] optee: simplify i2c access
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 9:32 AM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 08/02/21, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 08/02/21, Jens Wiklander wrote:
> > > Hi Jorge,
> > >
> > > On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi Arnd,
> > > >
> > > > On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > >
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > > > causes a compile-time warning:
> > > > >
> > > > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > > > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > > > >
> > > > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > > > open-code the i2c_transfer() call, which makes it easier to read
> > > > > and avoids the warning.
> > > > >
> > > > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > ---
> > > > >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> > > > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > > >
> > > > Looks good to me.
> > > > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > >
> > > Would you mind testing this?
> >
> > sure, doing it this morning.
> >
> > btw what Arnd has done - removing the unnecessary level of indirection
> > - was pretty much my initial though but I thought it was easier to
> > read the way I wrote it (I guess I was wrong and I obviously missed
> > the stack size increase)
> >
> > but yes, will test
>
> Tested on imx6ull.
>
> Tested-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

Thank you.

Cheers,
Jens
