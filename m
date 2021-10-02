Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF00341FD97
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhJBSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhJBSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 14:13:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF9C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 11:11:27 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j15so14007615ila.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si6VK9l9Z2rrdXVWj/mhPTsIWAhKCn4rQ61qxbJLJfQ=;
        b=cXqzG+ZpbI4aAo6Vv2KTN3e1WMjT1U1la/DSZDSuehNgGcT+7vZbXv0y/MaiQShnLt
         JE9bWx6O9k0tqx7w94trvJGGFAzjbUYDvczu1E4zKs8z9kbMll2yKbeZO3gcZLQWxR0x
         tgTIPAeU4rj4P6Nuf7cJhWUVeAbRvQR/MjVdAdutoLq+FiKfPY7in9ddXQtkar1YFh09
         da6ACUZm2j4ddJZdezTkXGRlnGHoLwTDZWaEZF4uwESGKAbeeyB59d9bdR5VNprG4SZ5
         34+u8BN/8DD7x2wFhmtzFf+1IMMMIme9+fKzODpKJ2Nr/VlQtkaG6f2rFo1RFEO+jYhS
         vdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si6VK9l9Z2rrdXVWj/mhPTsIWAhKCn4rQ61qxbJLJfQ=;
        b=zqm21pNCv5MVgt+k0IPRKkVDTUp8vDGBjghuAudpeWZqicfAlGbwPhbReTyMdhsPQo
         Aj6Bsi39kL9lTqFoXihNCyaPDk+yG4wiS7uGXr9fkeQ9bON8VgyLtUy7E2lsc+znX9go
         ncsLLBqRE9gfa26IcnVMsCQDG/1Ci/+f6HmgbeUVOGqiYoPOZ6RKrrVSABwMw5So5Hms
         oXjLEMWaEJkkxY8KPyD1Ut8Pf2Kc/4VOAEAMVE5T2HcswmzCAHsaBE/WnFKcAGpYfIG2
         j78r1y0NhXzsB9dFkUmg8YBUXyGsowlvcSHXooCcHhyNWgSiyKofYkBzn4JEkVqHTj6w
         ugNQ==
X-Gm-Message-State: AOAM532vVkxzmfAhzvYY7Ezva1lzmrDB4Qi+DxAaRmhMZEuAPbuTF95n
        FYEy+F0Rncys8Hfafv/4U7n2KuhxrbLYvViIV3tPTA==
X-Google-Smtp-Source: ABdhPJzEE+SXuGKFWyPKhxC89xvtycrSV5p7SCnEBJ1bQ9gnudzpZopvPPTQRgKEsTNm/ZeCdK6eeIcGdysrPkPYPQ4=
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr3364224iln.293.1633198286914;
 Sat, 02 Oct 2021 11:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <YUZBkZhQsF5SlcLb@marsc.168.1.7> <CAGS_qxrtD7wJ8oTcyMdYjUZubiJwD7CO+YFDy8ohho5jLeNa8g@mail.gmail.com>
 <YU943oP0ERX1Xh3Q@marsc.168.1.7> <CAGS_qxooHU+7SW9_GbvV2w2QAr3daBJcybx0zMqVFp3f3azrGg@mail.gmail.com>
 <CAGS_qxpbH6c3OvoYZC6TXFQomLpwZg5q7=EZ9B9k=Rw1mOz=0w@mail.gmail.com>
In-Reply-To: <CAGS_qxpbH6c3OvoYZC6TXFQomLpwZg5q7=EZ9B9k=Rw1mOz=0w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 2 Oct 2021 11:11:15 -0700
Message-ID: <CAGS_qxp9fjKyw4z3sE2TDRrXB3=mMCcomcRq=CszOFLzsw6yNA@mail.gmail.com>
Subject: Re: [PATCH] kunit: mock: add support for function mocks with no parameters
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     brendanhiggins@google.com, andy.li@unisoc.com,
        andersonreisrosa@gmail.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Sep 27, 2021 at 9:44 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > [2]
> > On Sat, Sep 25, 2021 at 12:30 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > Thanks for your review.
> > >
> > > On 09/21, Daniel Latypov wrote:
> > > > On Sat, Sep 18, 2021 at 12:44 PM Marcelo Schmitt
> > > > <marcelo.schmitt1@gmail.com> wrote:
> > > > >
> > > > > Function mocks defined with DEFINE_FUNCTION_MOCK(...) do not support
> > > > > empty parameters list due to strict function prototypes enforcement
> > > > > (-Werror=strict-prototypes). Add support for function mocks with no
> > > > > parameters by adding checks to declare strict function prototypes when
> > > > > an empty param list is provided.
> > > > > Further, add an expectation to test that the generated code works.
> > > > >
> > > > > Co-developed-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > > > > Signed-off-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > >
> > > > Meta: kunit/alpha/master isn't really maintained anymore.
> > > > I think David and myself having some commits from this year might give
> > > > the wrong impression.
> > > > But all of my patches in 2021 were to make it easier to get people to
> > > > *move away* from kunit/alpha/master ;)
> > >
> > > We can't submit it upstream because the mock stuff isn't there yet.
> > > By the way, as nothing from mocking is upstream and kunit/alpha/master is
> > > being frozen somewhat, what tree/branch should we base our work on if we
> > > decide to develop more on the mocking framework?
> > > I recall the branch with the POC for mocking was at
> > > https://kunit-review.googlesource.com/c/linux/+/1114
> > > Should we use this branch to base future work on mocking?
> > > Or will the mocking framework be discontinued?
> >
> > All the mocking stuff is in limbo at the moment.
> > The v2 of the class mocking RFC was sent out Oct 2020,
> > https://lore.kernel.org/linux-kselftest/20201012222050.999431-1-dlatypov@google.com/
> >
> > Until we have user interest in mocking support, that RFC will likely
> > just sit there.
> > Or maybe we scrap it and just introduce the functionality piece by piece.
> >
> > There's https://kunit.dev/mocking.html which talks about how one can
> > implement mocking on their own, or (better yet) write fakes while
> > leveraging KUnit.
> > If we start seeing adoption of that, we can start factoring out
> > functionality into shared code as needed, e.g. support for saying a
> > mock should be called N times, then maybe gradually the parameter
> > matchers and return values, etc.
> >
> > I missed it, but I know David and Brendan talked a bit about this in
> > their recent LPC talk, https://youtu.be/Y_minEhZNm8?t=15905
> >
> > >
> > > Sorry for asking so many questions. We just want to help to enhance KUnit.
> >
> > No worries, and we really appreciate it.
> >
> > > We can work on something else besides mocking if it makes more sense to the
> > > project.
> >
> > Mocking doesn't feel like an area where we can expect to see progress right now.
> > In terms of other KUnit features we know would be useful now, I think
> > it's mostly just [1] and [2], which hopefully will land in 5.16.
>
> To be clear, if anyone thinks up a useful feature, that'd be great.
> I personally am just out of ideas at the moment, and I think so are
> Brendan and David.
>
> We'd want to prioritize features that can improve existing tests or
> unblock known new tests.
> Mocking in the alpha version of KUnit is a case where a feature
> sounded really good on paper and had a bunch of bells and whistles
> (e.g. strict/nice/naggy mocks support, etc.) but was perhaps
> overengineered and thus failed to find a home upstream.
>
> But I just thought of a few more things we could do in the kunit.py script.
> I think we have more room for improvement there than in the in-kernel
> part of KUnit right now, but I assume it's the more boring part for
> most people.
>
> One thing I'd really like to see is getting code coverage to work in
> kunit.py while using QEMU.
> We have a process for doing so under UML here:
> https://lore.kernel.org/linux-kselftest/20210901190623.315736-1-rmoar@google.com/

wrong copy-paste, meant
https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.html#generating-code-coverage-reports-under-uml

> UML actually uses a different coverage implementation than normal, so
> there's a few things that would need to change.
>
> We can build and run against "normal" coverage kernels pretty easily:
>
> $ cat >qemu_coverage_kunitconfig <<EOF
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_GCOV_KERNEL=y
> CONFIG_DEBUG_FS=y
> CONFIG_GCOV_PROFILE_ALL=y
> EOF
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> --kunitconfig=qemu_coverage_kunitconfig
>
> The problem is we'd need to copy the coverage data off the VM instead
> of just letting it shutdown when tests are done.
> If we had a userspace running, we'd basically do something like
> $ scp -r user@vm:/sys/kernel/debug/gcov .
> <some stuff to get these files in the right spot under .kunit/>
> <then we'd run lcov and genhtml, just like we do for UML>
>
> Normal KUnit tests definitely don't want to have to have the overhead
> of running a userspace, so the implementation might look like a
> "--qemu_coverage" flag, or maybe a set of generic flags that would
> give a user enough control over the VM to do this.
> Or maybe the right answer is to not involve kunit.py at all.
>
> Not sure if that sounds interesting to you or anyone.
>
> >
> > I think right now we probably need more tests written to have a better
> > idea of what else we could/should do.
> > Partly because of that, David is trying to get the ball rolling on
> > testing ext4. We're also hopeful that it'll be easier to add tests if
> > adjacent code is already tested (sharing fakes, conventions, ability
> > to copy-paste, etc.).
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33
> > [2] https://lore.kernel.org/linux-kselftest/20210909001037.2842954-1-dlatypov@google.com/
> >
> >
