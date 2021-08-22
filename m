Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA893F3E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhHVI2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:28:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 01:28:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4834429pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=euQfPbKD+/UUR11I9oO6KFzT1pHN3d1vzdydAMtYBpM=;
        b=OjM2d+ahX4cML9RzWB6O80KTjdDqtUIgZIMGGNpCUlbtG/cCqspBZOQNo8E5iD4xxO
         gZP8smr3PbYjVGiqeCoRMPhtYxZO0OAZhoclgNTadO84DE9CdV6rFyCp9rp0SDy0Qo4h
         xuy/LcRFUkpEie+3tSD6D3WFxQzqLeTZg//OhqBYW4854pYF4SZ6zeUWGeOXeYSS1K2J
         Ak+Bksdc+w/rIYrOLfq/pMVEK134hF91OMd+zq9P0z9goDtqJt3c7K86vFiO+iAwEyxW
         4rhmdl5Dni7xWET/aIL7F/I65JpwTQXDR7r7jlcNmjrEN8Xe/2kU7s8dzoYBYsyGIe0d
         Duog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=euQfPbKD+/UUR11I9oO6KFzT1pHN3d1vzdydAMtYBpM=;
        b=g6SYbrmk601/RkdH6Qip1DF+8Zjj+B6WBH+iyk1p2QLi0ec6Wlbzm4DKb9l8gsTlGQ
         vxTMIYh9u96kF7+BK5/fyzktSZk2cA8c0noVy4dL8VNbOQDlJKtI/6urrmE8NneF0kxW
         vQXRZlp1OjbCAKtkc87opw31gYztzv+jjN78Qxz6yYWo7hIk848in0a7CgBQJUP8R8f+
         tZhYm6Ao1nJB2ZBgKtpMOW+Q7rtKL7CalSpMZu+3ARrAV3B3HUGdmuP8lJoqWFM9oHL3
         j790t0Ud2WJ1S3V8BarGp4PVrVzQtkdxh1C3oDsLTpxk4iXaxCuWwZ5l4XXZ7zv1wkBC
         tGtQ==
X-Gm-Message-State: AOAM5330qQhy3CL9f1GaDHj8Fjwhe112gYiZHk4q/qEd/IDc4G6NbYW2
        vH96kySEefEVqovOui5YK3TqAxZdMkWGWJEbBY4=
X-Google-Smtp-Source: ABdhPJxqcNPegzB+kMy84aMlxwaNPuVtOgdhulaszyJmDZteTK0m95EaDCXqftbXkNqn7wcCHDQ9oAcmObYP7Z4Y0tI=
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr2300665pjz.181.1629620890443;
 Sun, 22 Aug 2021 01:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210812113800.12466-1-novikov@ispras.ru> <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
 <4e582d89-0ef2-a94a-250a-30aa0f2eceb2@ispras.ru> <CAHp75VcVX21mpWmA_g+tOdJDGgkN45nz85YXyh3p-m91GS_HeQ@mail.gmail.com>
 <9b0e4eb3-7d18-f3ed-be7d-5ff48e86292f@ispras.ru>
In-Reply-To: <9b0e4eb3-7d18-f3ed-be7d-5ff48e86292f@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 11:27:33 +0300
Message-ID: <CAHp75VeZRsG-L2g6_p5Zma2mMtnQDuJ1mqWV76jOJ=Gvnv5tdA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 8:26 PM Evgeny Novikov <novikov@ispras.ru> wrote:
> On 17.08.2021 14:47, Andy Shevchenko wrote:
> > On Tue, Aug 17, 2021 at 12:08 PM Evgeny Novikov <novikov@ispras.ru> wro=
te:
> >> On 12.08.2021 15:13, Andy Shevchenko wrote:
> >>> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru
> >>> <mailto:novikov@ispras.ru>> wrote:
> >>>
> >>>      It seems that mxic_nfc_probe() missed invocation of
> >>>      mxic_nfc_clk_enable(). The patch fixed that. In addition, error
> >>>      handling
> >>>      was refined appropriately.
> >>>
> >>> NAK. Until you provide a deeper analysis, like how this works before
> >>> your change.
> >>>
> >>> Please, don=E2=80=99t blindly generate patches, this can even your bo=
t do,
> >>> just think about each change and preferable test on the real hardware=
.
> >>>
> >>> The above is to all your lovely contributions.
> >> I completely agree with you that testing and debugging on the real
> >> hardware is indispensable since this can help to reason about both fou=
nd
> >> bugs and patches suggested. Nevertheless, there are several cases when
> >> this does not work. The most obvious one is lack of appropriate device=
s
> >> on the spot that is not an obstacle for static analysis.
> >>
> >> My patches are based on results of static verification (software model
> >> checking). In a nutshell, this approach allows analyzing target progra=
ms
> >> more accurately in comparison with widely used static analysis tools.
> >> But this is not for free. Usually it needs much more computational
> >> resources to get something meaningful (in a general case the task is
> >> undecidable). Modern computer systems solve this issue partially. Wors=
e
> >> is that thorough static analysis needs more or less complete and corre=
ct
> >> models of environments for target programs. For instance, for loadable
> >> kernel modules it is necessary to specify correct sequences of callbac=
k
> >> invocations, initialize their arguments at least to some extent and
> >> develop models of some vital functions like kzalloc(). Moreover, it is
> >> necessary to specify requirements if one wants to search for something
> >> special rather than NULL pointer dereferences. We were able to devote =
a
> >> relatively small part of our project to development of environment
> >> models and requirement specifications for verification of the Linux
> >> kernel. Also, we spent not so much time for application of our framewo=
rk
> >> for open source device drivers. Nevertheless, this helped to find out
> >> quite a lot of bugs many of which are tricky enough. If you are
> >> interested in more details I can send you our last paper and presentat=
ion.
> > It is good and thanks for your contribution!
> >
> >> Most our bug reports were accepted by developers. Rarely they preferre=
d
> >> to fix bugs according to their needs and vision, that is especially th=
e
> >> case for considerable changes that do need appropriate hardware and
> >> testing. Just a few our bug reports were ignored or rejected.
> > This ratio is not a point. I hope you learnt from the UMN case.
> >
> >> In the
> >> latter case developers often pointed out us what is wrong with our
> >> current understanding and models of the device driver environment or
> >> requirement specifications. We always welcome this feedback as it allo=
ws
> >> us to refine the stuff and, thus, to avoid false alarms and invalid
> >> patches. Some developers requested scripts used for finding reported
> >> issues, but it is not easy to add or refer them in patches like, say,
> >> for Coccinelle since there is a bunch of external files developed in
> >> different domain-specific languages as well as a huge verification
> >> framework, that nobody will include into the source tree of the Linux
> >> kernel.
> >>
> >> Regarding your claim. We do not have an appropriate hardware. As usual
> >> this bug report was prepared on the base of static verification result=
s
> >> purely. If you want to see on a particular artifact I based my decisio=
n
> >> on, I can share a link to a visualized violation witness provided by a
> >> verification tool. We have not any bots since used verification tools =
do
> >> not give any suggestions on the issue roots. Maybe in some cases it is
> >> possible to generate patches automatically on the base of these
> >> verification results like, say, Coccinelle does, but it is another big
> >> work. Of course, it is necessary to test the driver and confirm that
> >> there is an issue or reject the patch. As always the feedback is welco=
me.
> > My point is that the type of patches you are sending even a bot may
> > generate (for example, simple patches the LKP project generates along
> > with reports). The problem with all teams that are working with static
> > analysers against Linux kernel is that they so proud of their tools
> > and trying to flood the mailing lists with quick and nice fixes, from
> > which some are churn, some are simple bad, some are _bringing_
> > regressions, and only some are good enough. The ratio seems to me like
> > 1 to 4 at most. So, 75% patches are not needed and only are a burden
> > on maintainers' shoulders.
> Developers of static analysis tools need some acknowledgment.
> Application to the Linux kernel gives a great capability for that since
> it is a huge and vital open source project. Besides, it is unlikely that
> somebody will be able to develop any valuable QA tool without a numerous
> feedback from users (in case of this sort of tools users are developers
> of target projects). We always welcome any ideas and suggestions how to
> improve a quality of analysis.

Good luck with it!

> > Good patch should have a good commit message [1]. The message should
> > include an analysis to explain why the considered change is needed and
> > what the problem it tries to solve. Neither of this I have seen in
> > your patch. Also, you need to take into account the credits and tags
> > that Linux kernel is using (Fixes, Suggested-by, Reported-by, etc) it
> > will add a bit of unification. Also, while fixing problems these
> > patches often miss the big picture, and contributors should think
> > outside the box (this is a problem of 95% of such contributions, one
> > example is your patch where I recommended completely rewriting the
> > ->probe() approach). That said, I don't want to see the flood of
> > patches with 75% miss ratio, I want to see maybe 5x, 10x less patches,
> > but each of them is carefully thought through and _ideally_ be tested
> > besides compilation.
> We will try to follow your advices to a possible extent. I am not sure
> that this will be the case for thinking outside the box since often it
> requires a deep involvement into the development process.

Exactly my point. You need to dive into development better.

> Moreover, it
> may be dangerous to make such big changes without having an appropriate
> experience or/and an ability to test them.
> > And thank you for your work!
> Thank you for your patience!

> >> If you are not gratified with my explanation it would be great if you
> >> and other developers will suggest any ideas how to enhance the process
> >> if you find this relevant.
> > [1]: https://chris.beams.io/posts/git-commit/

--=20
With Best Regards,
Andy Shevchenko
