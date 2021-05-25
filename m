Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF9390B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEYVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhEYVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:11:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C8C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:09:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so30140806edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQempG3zPiZex9R3bfuXqpxoSATyeQ/cMhmIoIe744M=;
        b=EWFbONyxubWRiMtMDL8SRi/Gh6mggh42+mF4QvgnPSB8pxQV0ttRkmqRJsDhoebS8w
         fRDbcTl1uDQ46t69W+kQ40sffxU5OAvvuh2NdS8zwYMF1qoPrEvD+HtM1LOb4bQi0MRJ
         u0NPvNggdKJur61MhrH1ZEcjMkSO39HRIjBGS5zVvIDwBbENze/gJJD22x4OQXS5aBwB
         f6ClUjKEko1PWMCpZqrBMy1gQ7AS81K4YWhtMXRwsO9QoBpgyBS+AaWzH88IVlkpPWd5
         lYgcTCYLU5es5zPfYbrBOxSsekj+88IIT4X4aY0qsVEmOBynUsLMAAxRsXYYJb9L4FdU
         RKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQempG3zPiZex9R3bfuXqpxoSATyeQ/cMhmIoIe744M=;
        b=oVodDSPQmaDMyfocD3VAqziG9NX/6BzxNgDUhDlL5l5HT3zzDnOFsY+VB4RIsfIasx
         Qh3yPbPCMU7bR0spJP9nKWZGwTrjv1IVdQIwEWe13ZyMO2FdTtKXnY1Hvyq6nLOwCP/Z
         HpV2hHAw5F23wEzLayV5Nmz9GWQ2S5pkVKM5H8xgoJOdgxmOevCafOTI2gU3D8eM2FN2
         sFpnMM+CYfovm93xmxocF+0SbgL9P3X6WQFaxJMOsBTSsbqADesI4u7e6PbqribMHcYC
         s6ukRvzY91161KYL91u1FxEj30mxINg8YWgirNU1qCFjRlTvtoqDsj3j67d4oLjPF35D
         Kt9A==
X-Gm-Message-State: AOAM533G6DcsNiULGVwyk5RfpYPtbg9hM6pdTMgvs7YHzpzqprSnGt14
        nsZWCA/yTEvK/yLwFI0AG6NXcNQuhsCz4JDkQ4c=
X-Google-Smtp-Source: ABdhPJzV6T+hPhI4jleZ+CayZklDrliGuQhooo0PIuu1NKhgKeVBMFzUcRfRmBaqnhbMXH6zpmQopb/3DuQWBMfW/EM=
X-Received: by 2002:aa7:cc10:: with SMTP id q16mr34758122edt.53.1621976973943;
 Tue, 25 May 2021 14:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210525144250.214670-1-tpiepho@gmail.com> <20210525144250.214670-2-tpiepho@gmail.com>
 <CAGS_qxqSo=s5=geB56QGKtgsHwjYfULYJfuaCTcghY3+c9yVBA@mail.gmail.com>
In-Reply-To: <CAGS_qxqSo=s5=geB56QGKtgsHwjYfULYJfuaCTcghY3+c9yVBA@mail.gmail.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Tue, 25 May 2021 14:09:23 -0700
Message-ID: <CA+7tXijdGYdEBT6PB7hWk0Ups3Y97iWPx=AWWsb0z=OPqVzA1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:34 AM Daniel Latypov <dlatypov@google.com> wrote:
> On Tue, May 25, 2021 at 7:43 AM Trent Piepho <tpiepho@gmail.com> wrote:
> > Adds a number of test cases that cover a range of possible code paths.
> >
> > Signed-off-by: Trent Piepho <tpiepho@gmail.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Looks really good to me, just two nits.
>
> Tangent:
> I didn't check to see that this covers all the interesting cases, but
> it seems like it does.
> If you want, you can try generating a code coverage report to double check.
> Instructions for doing so can be found in
> https://lore.kernel.org/linux-kselftest/20210414222256.1280532-1-dlatypov@google.com/
> I would have done that and included the #s in this email, but my
> workplace decided to subtly break my workstation in some way and I
> haven't gotten around to root causing...

I installed a gcc 6.4 toolchain and changed the uml_abort() call to
exit(), coverage was generated, but still truncated and incorrectly
near 0%.  So what I did was crash after running all the test cases I
cared about by dividing by zero and then coverage data was produced
correctly.  It's 100% by lines.  But I think both possibilities when
the largest semiconvergent is exactly half the previous convergent
aren't tested.

> >  lib/math/rational-test.c | 56 ++++++++++++++++++++++++++++++++++++++++
>
> Ah, sorry, I forgot to mention this in the previous email.
> If you look at kunit/style.rst docs, you'll see the documentation now
> states a preference for the name of this file to be one of
> {rational_test.c, rational_kunit.c}

Before I chose a name, I checked every file with kunit tests cases,
and *-test was the most common naming pattern, including the sample
case.  I would be nice if changing the docs to say something is a
standard also updated the code to make that reality.
