Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D934621E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhCWO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhCWO5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:57:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1646E619BA;
        Tue, 23 Mar 2021 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616511459;
        bh=rncsdl4i5TrEFMu6+Ym0vGycz7ZFKYV1YcXXIU8sWhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCqO7iaPbbwi6UadGRPL97vvD/O8257MtlKt25IRP4o4l1tRl4ZCH2Vwt8grwc6wa
         /2VEiACNqZdI6bLfzLjtD3USVIzSEnklfO1YimXVS0ivyNXArlGbqe46QcoP8uHcAm
         Ow8wMNzFcBwWzQTjgVmOPO8TDmdrmu4T9CPwblF/fdAld3SslIs+3rC9fc9Pl56aqj
         SrekgMGYx9UHqx3dW1toIj3DdsP8ZQaf3cMwnN5iNnaM4mLtOXNAnsJRjEcG31VEln
         vjGuH+ycXre1E4415u3IflinACL0xe0mV2NafQpn1ccMJCzrQIV5IT1VsWqOxNEw+5
         /8HuhaRPFurtA==
Received: by mail-qv1-f44.google.com with SMTP id j17so10541699qvo.13;
        Tue, 23 Mar 2021 07:57:39 -0700 (PDT)
X-Gm-Message-State: AOAM5306tMb4bU5HePMs+3m8j/C8zSh/5YgoJuD89p8HKn5bz3yUC55A
        WZBhtmJ9VHf3QMLGUp3xqRbidO8TM8dGHNYi2M4=
X-Google-Smtp-Source: ABdhPJy0Bf1GseHqyXVnbs94f5tPVaGsMsTG1p0um1fqkgNlm8U4SZfOvAeuLw2PRao3cfn+zNk3kze7QKfjivEMxdk=
X-Received: by 2002:a0c:f805:: with SMTP id r5mr5498083qvn.45.1616511458169;
 Tue, 23 Mar 2021 07:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com> <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
In-Reply-To: <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 23 Mar 2021 08:57:25 -0600
X-Gmail-Original-Message-ID: <CAB=NE6XpDuJdJs2aStPT3+2Z1JgBof3zokboSbqq=+4BKGs+Bw@mail.gmail.com>
Message-ID: <CAB=NE6XpDuJdJs2aStPT3+2Z1JgBof3zokboSbqq=+4BKGs+Bw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 1:25 PM Thorsten Leemhuis <linux@leemhuis.info> wro=
te:
>
>
>
> On 22.03.21 19:32, Linus Torvalds wrote:
> > On Mon, Mar 22, 2021 at 8:18 AM Thorsten Leemhuis <linux@leemhuis.info>=
 wrote:
> >>
> >>     I even requested a
> >> "linux-regressions@vger.kernel.org" a while later, but didn't hear
> >> anything back; and, sadly, about the same time I started having troubl=
e
> >> finding spare time for working on regression tracking. :-/
> >
> > Honestly, I'd much prefer the name 'linux-regressions' as being much
> > more targeted than 'linux-issues'.
>
> That only solves one of the two problem I'm trying to solve (albeit the
> one that is more important to me). That way users still have no easy way
> to query for reports about issues that are no regressions =E2=80=93 say
> something is broken and they have no idea if it once worked or never
> worked at all.

Without a known baseline of what works OK an issue cannot easily be
categorized as a regression. This "problem" I think deserves its own
considerations.

There are some kernel-ci solutions out there which report "issues"
which help develop such baselines, however what we need is a community
visible list of the sum, a list of *known issues upstream* represents
a baseline. The easiest way to develop such baselines are with
respective tests. We however obviously need to also accept new user
reported issues as possible issues which can be candidate baseline
issues, for which perhaps there are no known tests yet available to
reproduce.

Then there are the considerations also that some distribution issues,
which can be part of a distribution baseline, might fit into the
circle of upstream known issues, or baseline as well. But not all
issues part of a distribution baseline are part of the upstream
baseline, an example is a botched backport. Most distribution
baselines however tend to be private, however I'd like to see that
changed using OpenSUSE/SLE as an example in order to help with the
upstream baseline effort. I'd like to encourage other distributions to
follow suit.

Test frameworks help develop a baseline and so working on them helps
reduce the scope of this problem. We have many test frameworks. What I
have not seen is a public generic baseline "list" for each of these. I
have spent a bit of time on this problem and have come up with a
generic format for issues on test frameworks as part of kdevops [0] in
the hopes that it could be used to easily grep for known issues
against upstream kernels / distribution releases. The format is
simple:

mcgrof@bicho ~/kdevops (git::master)$ cat
workflows/blktests/expunges/5.12.0-rc1-next-20210304/failures.txt
block/009 # korg#212305 failure rate 1/669
block/011
block/012

The korg#212305 refers to bugzilla.kernel.org bug ID #212305 [0].

Distribution issues:

mcgrof@bicho ~/kdevops (git::master)$ cat
workflows/blktests/expunges/debian/testing/failures.txt
block/011
block/012
meta/005
meta/006
meta/009
nbd/002
nbd/003 # causes a hang after running a few times
scsi/004

I have support for blktests and fstests, will add selftests soon. I
tend to work on debian baseline as a public demo for work. The
OpenSUSE Leap 15.3 baseline will be reflective of the real SLE15.3
baseline.

The nice thing about having a public baseline is we can then really be
confident into labelling a new issue that comes up as a possible
regression. However, confidence is subjective, and so one must also
define confidence clearly. You associate confidence to a baseline by
the number of full tests you have run against a baseline for a
respective test framework. Borrowing IO stabilizing terms, I'm using a
test "steady state goal" for this, it means how many times have you
run all possible tests against a known baseline without failure. So a
steady state of 100 for blktests means your confidence in the baseline
you have developed is of 100 full tests. A higher steady state goal
however means more time is required to test, and so sometimes you
might be confined to only use a low steady state goal, but then use
side workers to run random tests with a higher test count. So for
instance, the failure rate of the issue reported on korg#212305 is
defined by the average number of times one must run a test in order
for it to fail. If your baseline steady state goal was just 100,
chances are low you may have run into that issue.

Are there other known collections of public baselines easily grep'able
for different test frameworks? Where can we contribute and collaborate
to such a thing?

PS. My current goal for steady state goal for upstream is 1000 for
blktests, 100 for fstests per filesystem.

[0] https://github.com/mcgrof/kdevops
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D212305

  Luis
