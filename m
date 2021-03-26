Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73534A636
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:14:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhCZLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:13:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616757223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=/iBlAmRlsswDw6I8DcYtCGRYshAzcVsfWLIL3yeFiTQ=;
        b=xbHD7PM7QtooJK54R8pGIo3Wg4RuxwU8a1fvKTZfxuAwBC4aTgW6LcYinaJGBt0k0F/1rS
        B7ANmLwgFvIoLLsvNnN4KziauGB/gn/3NAlJfcZEECvpz+i1WgGBFTRX23cWd4GkX/LJcC
        jVic2zauEmQrjIsVqPlu/7+J6KmzLYp275woUbJnE81pvZFckYlMX+iMbmgB0Vl4XhjcyT
        MtKaw2Z0oMnsVGmB1JH0I5sbWJDBiYjTnbGy4ANLuLvOKkmr4w/PIsa2U2cTzwYS/+PObY
        hajWYEuArnc7v227ajBsQORgJ5ztrYawZBqQy3wZkJ3mZp2XbejUPu01E/Lyyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616757223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=/iBlAmRlsswDw6I8DcYtCGRYshAzcVsfWLIL3yeFiTQ=;
        b=2+sbOAzlNhHENnXN+AdMJrAKUYXCTc+xSZ00Xv/iPWUhTqHtTL9EBMNEHW4wZaj4e3aTpo
        4mkIXJQBphv/BZAA==
To:     Daphne Preston-Kendall <dpk@nonceword.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an error when TAI has not been configured
In-Reply-To: 
Date:   Fri, 26 Mar 2021 12:13:43 +0100
Message-ID: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daphne,

On Sat, Mar 13 2021 at 17:44, bugzilla-daemon wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D212265

I'm leaving the text from the BZ entry untrimmed so everyone on Cc is on
the same page.

> In order for CLOCK_TAI to function properly, a program (usually ntpd)
> has to use the adjtimex family of system calls in order to tell the
> kernel what the difference is between TAI and UTC. ntpd will do this
> as long as it has been configured with a leap seconds file.
>
> Unfortunately, although the majority of distributions ship with a leap
> second file from the zoneinfo database, many or most of them (I have
> Arch here) do not configure ntpd to know about it, so ntpd does not
> set things up properly for CLOCK_TAI to work. Calling
> clock_gettime(CLOCK_TAI, ...) produces the same result as
> clock_gettime(CLOCK_REALTIME, ...), yielding UTC instead of the
> requested TAI.
>
> The result is that CLOCK_TAI, which one would usually wish to use to
> improve the correctness of a program=E2=80=99s date and time handling,
> produces utterly incorrect behaviours on the vast majority of boxes,
> unless the system administrator is conscientious enough to configure.

Yes, that's unfortunate, but pretty much historical behaviour and I fear
it's not really documented either.

> I would like to suggest that clock_gettime(CLOCK_TAI, ...) and friends
> should return an error (EINVAL? ENOTSUP?) when it would return the
> same as CLOCK_REALTIME, so that programs can detect when it=E2=80=99s not=
 been
> set up correctly and either tell users to go and set up their leap
> second data file properly,

That would be a user visible change and might hit existing user space by
surprise, so that's not a necessarily a good option.

Of course it could be argued that a given kernel can return -ENOTSUP or
whatever is appropriate for any CLOCK id, but that really needs some
deep thoughts and analysis vs. eventual disruption.

> or try to improvise TAI on top of UTC using (at the cost of not being
> able to be accurate during leap seconds themselves), or both.

The problem with TAI is that the number of leapseconds which need to be
accounted for at a given date/time, i.e. when the machine boots, looks
simple but leap seconds are not predictable due to the non-linear
behaviour of earth rotation.

So we'd need to have an up-to-date leap seconds table:

   https://www.ietf.org/timezones/data/leap-seconds.list

which is not rocket science, but there is this little spoilsport in that
file:

  File expires on:  28 December 2021

and the kernel on it's own has no way to check for and retrieve an
up-to-date version. That's why it is delegated to user space.

No idea though why this is not enabled by default in distros when NTP is
on. Of course I did not notice because I had that entry in my
ntpd/chrony configs forever since we started to hack on it.

> A workaround for programs which want to detect when CLOCK_TAI is wrong is=
 to
> try to detect when it hasn't been set up properly by getting both CLOCK_T=
AI and
> CLOCK_REALTIME and falling back to trying to emulate TAI on top of time_t=
 when
> the difference between the tv_sec value is =E2=89=A4 1 second (not =3D 0,=
 because it
> could happen that the first clock was checked at .00001 seconds before a =
whole
> second and the latter one at .00001 seconds after the whole second). But =
even
> that has edge cases=C2=A0=E2=80=94 putting similar logic in the kernel co=
uld make it work
> correctly all the time.

adjtimex()/ntp_timex() allows you to read out tai_offset race
free. Whether that's a good answer is a different question.

My initial takeaway is that at least the documentation sucks.

I hope the NTP/TAI wizards have some more insight/opinions on this.

Thanks,

        tglx
