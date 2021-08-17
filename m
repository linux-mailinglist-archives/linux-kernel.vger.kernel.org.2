Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A433EEBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhHQLsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbhHQLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:48:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE25C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:47:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa17so31617003pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IuRfHC8W7DGjH42w11/hQoI8c1gahqTINnCkt5cniCY=;
        b=HlX3N5iVsexM4cZik2nwQjmnXYhcP5lffXV+CS9+d5DYFWkyEGE1NSL1dqKIquD9SA
         bZpxWqH4X8nzkSwWiXznHXF0eyZMURkGp4Jgfqb98qShAPkRXIW3ebJH2MQnaN/Ykzn4
         xKm7+m/7kGHEy1msCpQauNxvK2W7XqZgJPcxEp6RJI2jxoP96P84BSaVewdAnjvgZmSp
         IYVqqKGw67jUyNsi9UnZTQlh53fze0ZZDb/Xq0jS25uNVq0uCjtZDFvX4C49gyiudtpK
         DokT6tyc4QR9N9uAzZjTxJv4ixQanILpV3C051bWz1wzHrkbyz8cYjHcXka9CT/shr1X
         x8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IuRfHC8W7DGjH42w11/hQoI8c1gahqTINnCkt5cniCY=;
        b=sLIj+1ih5Q25bjqFj7urI4QJk3gqcxbU2+IWJiD+tmjKnnzSRC/4O4pNyrDEyDHmWd
         tUu0eNKkt9wZlFejoGt4Pyb/cUrr5fynk/eiP62Q/T8yWkxvsxxAv2C5SSQBq7MhQvdK
         J4Sef/IB8NP4PHPKdrju2AwtVDEu/DD1tARGQteSrCsPcKzUKGOVN9MQsXFAr+MAdJHF
         KqEOgaXYhvrVLhiJYqpzvFfS8nL4wHID8Mi4dciZ1SIhKqFXZBHxDjGT5NC+sZd20kN6
         WBoHrclCcAiEozhOvnh+JYp6oEiPk56t4cWwgSB5ooFRK5khNB7rJchhITkM3i05y4Bd
         oDuA==
X-Gm-Message-State: AOAM532Hmz509Kyg6ceFsph7b6Pd96uIhJU53wwdMoSuMIAYitTTDdLh
        I1Ncnipfoc97TveS6X04bZNu4OpXuG394BE9mtU=
X-Google-Smtp-Source: ABdhPJz4TQlbJ1rgw0XhVk/2VKs8/gw+my29rfd4+32GLZ8aY4HxNCxMVtsnqxdX2cnCpVcW8A1UnNvBzfdEKzZ25KU=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr3262024pfi.7.1629200862497; Tue, 17 Aug
 2021 04:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210812113800.12466-1-novikov@ispras.ru> <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
 <4e582d89-0ef2-a94a-250a-30aa0f2eceb2@ispras.ru>
In-Reply-To: <4e582d89-0ef2-a94a-250a-30aa0f2eceb2@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Aug 2021 14:47:02 +0300
Message-ID: <CAHp75VcVX21mpWmA_g+tOdJDGgkN45nz85YXyh3p-m91GS_HeQ@mail.gmail.com>
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

On Tue, Aug 17, 2021 at 12:08 PM Evgeny Novikov <novikov@ispras.ru> wrote:
> On 12.08.2021 15:13, Andy Shevchenko wrote:
> > On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru
> > <mailto:novikov@ispras.ru>> wrote:
> >
> >     It seems that mxic_nfc_probe() missed invocation of
> >     mxic_nfc_clk_enable(). The patch fixed that. In addition, error
> >     handling
> >     was refined appropriately.
> >
> > NAK. Until you provide a deeper analysis, like how this works before
> > your change.
> >
> > Please, don=E2=80=99t blindly generate patches, this can even your bot =
do,
> > just think about each change and preferable test on the real hardware.
> >
> > The above is to all your lovely contributions.
>
> I completely agree with you that testing and debugging on the real
> hardware is indispensable since this can help to reason about both found
> bugs and patches suggested. Nevertheless, there are several cases when
> this does not work. The most obvious one is lack of appropriate devices
> on the spot that is not an obstacle for static analysis.
>
> My patches are based on results of static verification (software model
> checking). In a nutshell, this approach allows analyzing target programs
> more accurately in comparison with widely used static analysis tools.
> But this is not for free. Usually it needs much more computational
> resources to get something meaningful (in a general case the task is
> undecidable). Modern computer systems solve this issue partially. Worse
> is that thorough static analysis needs more or less complete and correct
> models of environments for target programs. For instance, for loadable
> kernel modules it is necessary to specify correct sequences of callback
> invocations, initialize their arguments at least to some extent and
> develop models of some vital functions like kzalloc(). Moreover, it is
> necessary to specify requirements if one wants to search for something
> special rather than NULL pointer dereferences. We were able to devote a
> relatively small part of our project to development of environment
> models and requirement specifications for verification of the Linux
> kernel. Also, we spent not so much time for application of our framework
> for open source device drivers. Nevertheless, this helped to find out
> quite a lot of bugs many of which are tricky enough. If you are
> interested in more details I can send you our last paper and presentation=
.

It is good and thanks for your contribution!

> Most our bug reports were accepted by developers. Rarely they preferred
> to fix bugs according to their needs and vision, that is especially the
> case for considerable changes that do need appropriate hardware and
> testing. Just a few our bug reports were ignored or rejected.

This ratio is not a point. I hope you learnt from the UMN case.

> In the
> latter case developers often pointed out us what is wrong with our
> current understanding and models of the device driver environment or
> requirement specifications. We always welcome this feedback as it allows
> us to refine the stuff and, thus, to avoid false alarms and invalid
> patches. Some developers requested scripts used for finding reported
> issues, but it is not easy to add or refer them in patches like, say,
> for Coccinelle since there is a bunch of external files developed in
> different domain-specific languages as well as a huge verification
> framework, that nobody will include into the source tree of the Linux
> kernel.
>
> Regarding your claim. We do not have an appropriate hardware. As usual
> this bug report was prepared on the base of static verification results
> purely. If you want to see on a particular artifact I based my decision
> on, I can share a link to a visualized violation witness provided by a
> verification tool. We have not any bots since used verification tools do
> not give any suggestions on the issue roots. Maybe in some cases it is
> possible to generate patches automatically on the base of these
> verification results like, say, Coccinelle does, but it is another big
> work. Of course, it is necessary to test the driver and confirm that
> there is an issue or reject the patch. As always the feedback is welcome.

My point is that the type of patches you are sending even a bot may
generate (for example, simple patches the LKP project generates along
with reports). The problem with all teams that are working with static
analysers against Linux kernel is that they so proud of their tools
and trying to flood the mailing lists with quick and nice fixes, from
which some are churn, some are simple bad, some are _bringing_
regressions, and only some are good enough. The ratio seems to me like
1 to 4 at most. So, 75% patches are not needed and only are a burden
on maintainers' shoulders.

Good patch should have a good commit message [1]. The message should
include an analysis to explain why the considered change is needed and
what the problem it tries to solve. Neither of this I have seen in
your patch. Also, you need to take into account the credits and tags
that Linux kernel is using (Fixes, Suggested-by, Reported-by, etc) it
will add a bit of unification. Also, while fixing problems these
patches often miss the big picture, and contributors should think
outside the box (this is a problem of 95% of such contributions, one
example is your patch where I recommended completely rewriting the
->probe() approach). That said, I don't want to see the flood of
patches with 75% miss ratio, I want to see maybe 5x, 10x less patches,
but each of them is carefully thought through and _ideally_ be tested
besides compilation.

And thank you for your work!

> If you are not gratified with my explanation it would be great if you
> and other developers will suggest any ideas how to enhance the process
> if you find this relevant.

[1]: https://chris.beams.io/posts/git-commit/

--=20
With Best Regards,
Andy Shevchenko
