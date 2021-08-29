Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0673FADC5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhH2S3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhH2S3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:29:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:28:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so10801912pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ag9D8N0fhBIrol0HNSilfA7AMgyYglE49DL9RoGRtsU=;
        b=svC4gFefGSS+cR/UbjmxUfdMp4uT7qfQz8vBEFSDJvv4yVkNw0lAR+cIyAtZtpP2JY
         YDR7PG68+OREMz6GdOh3hpGjHgSDOJ/f/UfvY69fPcQNFd/tKoDj3NeNxCktR3aTXslN
         zW4YMJQLpozi/SQEpm28Eg0O1bwgZd4ImCpgIj8sbIbLb2XR9ApTzHS7rn+UgrXyY11c
         Htn0XXrmIJeFwBNpHLQj3Umhj1xYQ5jJ9SSBNql24qUHoznRI59RCpX8m5i0ZZhfznBM
         vxrVz30o3NSlRUMd/a/OzVBURD31TFeMn2kSoIuy29KITTOOuhmXMemM8eDQuC71ImF/
         B5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ag9D8N0fhBIrol0HNSilfA7AMgyYglE49DL9RoGRtsU=;
        b=Vzw+90TKeRcGWbsF9F2+4noXv4Z6jLhWWm7FnqPJPDwA5zQkWXd7M9wQ2UMBkl/6o4
         vwTZRkbWu9VRw7I1R/7FiFlEN/1ocKAf8M5/daNepynT0FuhMwq3UxOt6m+4BKVgrHiF
         6DmjePcxpGGvWoAsoGYuyML9B25v97PGWyE7wdZBlZ6f7IoJxzsktYh+PwP/V2+4eGo5
         Q4wFxQe0fj/h2ARtvx7DqkRHahZqTj065jD6dD30yOWz6vtTHloWSJ4oFHMdUPldLbr5
         UJQAiU54P4v6RjDRSBOpEQDw/3xHIpCn63sSWQdBpJ3plc8FH0ET0u9fDhMzvrvYe9PB
         lUJQ==
X-Gm-Message-State: AOAM531lEBikuQOWsbr0FPkcJmKy3cAPoLRkhy1/1eXrrvtY9Pa0BGSg
        ztma2dT6ptycfk1IG/u7PP3kyIx7HvytnTKj5kM=
X-Google-Smtp-Source: ABdhPJxILhmsT/D4BB4XHvQ4sLJiXMQUnZttdEevpvWn2M3282wW2knpdWHPjJtqDm+pn4FTHFSDu2sVyR65npqsmIM=
X-Received: by 2002:a17:90a:ec0a:: with SMTP id l10mr373574pjy.26.1630261724681;
 Sun, 29 Aug 2021 11:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
 <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
In-Reply-To: <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Sun, 29 Aug 2021 20:28:33 +0200
Message-ID: <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically it says "you must have a prebuilt kernel available that
contains the configuration and header files used in the build." Since
for the staging kernel  "make oldconfig" asked me for  more
configurations apart from my old configuration file (as it reads the
existing .config file that was used for an old kernel and prompts the
user for options in the current kernel source that are not found in
the file) . So I *don't* currently have a prebuilt kernel that
contains all the configuration in my staging kernel's .config file. So
do I have to build the kernel once before I can just build the module
with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android" ?


Thanks again

On Sun, Aug 29, 2021 at 6:56 PM Krish Jain <krishjain02939@gmail.com> wrote=
:
>
> On Sun, Aug 29, 2021 at 6:49 PM Bryan Brattlof <hello@bryanbrattlof.com> =
wrote:
> >
> > On this day, August 29, 2021, thus sayeth Krish Jain:
> > > > >
> > > > > Hi, what option do you mean?  I already ran make allmodconfig and=
 sudo
> > > > > make modules_install install and then make   "CCFLAGS=3D-Werror W=
=3D1
> > > > > M=3Ddrivers/staging/android/" and now I do get output but one lin=
e
> > > > > "WARNING: Symbol version dump "Module.symvers" is missing. Module=
s may
> > > > > not have dependencies or modversions. You may get many unresolved
> > > > > symbol warnings." . Then I tried "make CCFLAGS=3D-Werror V=3D1
> > > > > M=3Ddrivers/staging/android/" and that outputted the following:
> > > > >
> > > >
> > > > Most of the answers you're asking for are going to get vague respon=
ses
> > > > (if any) on the mailing lists. The idea being (and I agree with) th=
at
> > > > giving out the answers will steal your opportunity to explore and l=
earn
> > > > the material yourself.
> > > >
> > > > Yes, it would be faster if we told you the answer, but ultimately, =
we
> > > > would be doing a disservice to you.
> > > >
> > > > Besides, more times than not we (me especially) don't have the answ=
er.
> > > >
> > > > With that said, I will give a (generous) hint. :)
> > > >
> > >
> > > Hi. Do I have to build the kernel once before this works? Or can I
> > > just build a module directly?
> > >
> >
> > Again, do not allow others to rob you of learning how to solve these
> > issues yourself. I *strongly* encourage you to familiarize yourself wit=
h
> > the Kernel Build System in the Documentation.
> >
> >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> >
> > Specifically the first paragraph of "2. How to Build External Modules"
> >
> > It may seem like a lot for such a simple issue but it *is* worth it.
> > ~Bryan
> >
>
>
>
> That section says
>
>
> "To build external modules, *you must have a prebuilt kernel
> available* that contains the configuration and header files used in
> the build. Also, the kernel must have been built with modules enabled.
> If you are using a distribution kernel, there will be a package for
> the kernel you are running provided by your distribution.
>
> An alternative is to use the =E2=80=9Cmake=E2=80=9D target =E2=80=9Cmodul=
es_prepare.=E2=80=9D This
> will make sure the kernel contains the information required. The
> target exists solely as a simple way to prepare a kernel source tree
> for building external modules.
>
> NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module.symvers eve=
n if
> CONFIG_MODVERSIONS is set; therefore, *a full kernel build needs to be
> executed to make module versioning work.*"
>
> So I am just trying to confirm with you whether I have to first build
> the kernel with like "make" or not? As you can imagine my hardware
> takes *very* long to build a kernel as I did in my last attempt so I
> am asking whether it is needed. Hope you understand.
>
> Best Regards
