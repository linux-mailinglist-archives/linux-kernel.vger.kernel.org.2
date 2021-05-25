Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0B390BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhEYWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhEYWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:05:01 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3717AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:03:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j30so29585593ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r5LQNRHZJ9OLYfdLSCyczxeiXiKMnpVrYtJQiiVJCs=;
        b=LduDF+layyUZoy+t/xHpySrPA946f8tlsvCUNBhHlKlFSZPRn3TZ68KJv2pD05poTW
         YqwlBohuEnym5uafG79D05Qa+rf4Q3G+L6lpVVUUG5HyABZOkfrjhcdli6Qf8NeWpv5i
         lYcf+NvDhT8VjO0qGfN7KK00Vq9W6qjIwxcX4j0LVR/SlslQQCOpS4wqSCf/dGPEDQL4
         UNMV0Gcnf85hXd3XyWrf9PcQKZs6+N3Z0oZnxu4aiOclZSWDimkIByASgUbL9lctwa9j
         IG4Cb2+O0x6DSV3DaSHPX624xDwA9mPkTr3ub95g9j3ovItAW3CEGlRlTd9s68GO6bJt
         1FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r5LQNRHZJ9OLYfdLSCyczxeiXiKMnpVrYtJQiiVJCs=;
        b=TAh4d+LUfvck8FlA9obm4w01qNYBzGAPzLqNJs+QWDzKepU/UXlDIv/Lt5apmFktes
         HM5Hb63xXln9Igv4wGCVaa/x5m8E/8ndR8FcDCOb/RhEVTVBHC+gED4upIYViozJv/J7
         UMEgsXOAvl4zLosCPj9+cVRtmGJ11Jp3Gxx1VPtIc0IOVayBWN05Y7Dj+MIUlh4WWOWF
         y/G1zzWNopr9bu8nku0u8dVmJGpryT1h74h07kv41kiBKOjwjHxpIdPuPZ/ocJgVV1XF
         Knf+xrk14zA0heM2g//hH6vp1/o/NIO3kztiF0Mvt7Mcj5zzGUgQCRDsyRgfpyiiQ9hA
         Ipyg==
X-Gm-Message-State: AOAM533U+BK667z4pzjGrLweBLIDgrBX179TCmKWnQkHAXxT1EIIGp1e
        UQDVOGsnVuTyeG2iKKIfBvv+PoPdqWlg6gr5RkFlfq/SK30=
X-Google-Smtp-Source: ABdhPJwZxBVE0tETy34dxFsN9+JVUpJRArYnM/yVYxxy3XNozeaY36M5lHs2mZ3IkcgsUqdd/c7zURqfmkzAu1jJH00=
X-Received: by 2002:a92:c70b:: with SMTP id a11mr26718580ilp.136.1621980209861;
 Tue, 25 May 2021 15:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210525144250.214670-1-tpiepho@gmail.com> <20210525144250.214670-2-tpiepho@gmail.com>
 <CAGS_qxqSo=s5=geB56QGKtgsHwjYfULYJfuaCTcghY3+c9yVBA@mail.gmail.com> <CA+7tXijdGYdEBT6PB7hWk0Ups3Y97iWPx=AWWsb0z=OPqVzA1g@mail.gmail.com>
In-Reply-To: <CA+7tXijdGYdEBT6PB7hWk0Ups3Y97iWPx=AWWsb0z=OPqVzA1g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 May 2021 15:03:17 -0700
Message-ID: <CAGS_qxr9RvjKLRyq3Pb1RqYdLAaNdhhRgSN_R2EiU_bj8fnjYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 2:09 PM Trent Piepho <tpiepho@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 10:34 AM Daniel Latypov <dlatypov@google.com> wrote:
> > On Tue, May 25, 2021 at 7:43 AM Trent Piepho <tpiepho@gmail.com> wrote:
> > > Adds a number of test cases that cover a range of possible code paths.
> > >
> > > Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> >
> > Looks really good to me, just two nits.
> >
> > Tangent:
> > I didn't check to see that this covers all the interesting cases, but
> > it seems like it does.
> > If you want, you can try generating a code coverage report to double check.
> > Instructions for doing so can be found in
> > https://lore.kernel.org/linux-kselftest/20210414222256.1280532-1-dlatypov@google.com/
> > I would have done that and included the #s in this email, but my
> > workplace decided to subtly break my workstation in some way and I
> > haven't gotten around to root causing...
>
> I installed a gcc 6.4 toolchain and changed the uml_abort() call to
> exit(), coverage was generated, but still truncated and incorrectly
> near 0%.  So what I did was crash after running all the test cases I
> cared about by dividing by zero and then coverage data was produced
> correctly.  It's 100% by lines.  But I think both possibilities when
> the largest semiconvergent is exactly half the previous convergent
> aren't tested.

Yeah, it's finicky.
Hopefully Brendan's change to cleanly shutdown the kernel at the end
of the tests might make it a bit more robust (still probably requires
gcc-6).

Thanks for running it!
It's nice to know we have 100% (line) coverage.

>
> > >  lib/math/rational-test.c | 56 ++++++++++++++++++++++++++++++++++++++++
> >
> > Ah, sorry, I forgot to mention this in the previous email.
> > If you look at kunit/style.rst docs, you'll see the documentation now
> > states a preference for the name of this file to be one of
> > {rational_test.c, rational_kunit.c}
>
> Before I chose a name, I checked every file with kunit tests cases,
> and *-test was the most common naming pattern, including the sample
> case.  I would be nice if changing the docs to say something is a
> standard also updated the code to make that reality.

Yeah, it's frustrating...
Andy sent out some changes renaming a lot of the files, but we've not
managed to get everything up to date.
