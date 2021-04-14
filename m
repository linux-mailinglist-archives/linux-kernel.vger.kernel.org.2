Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0235F92F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhDNQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:45:16 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:48972 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhDNQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:45:15 -0400
Date:   Wed, 14 Apr 2021 16:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1618418686;
        bh=7SuPu6tI+XPCR0O8XUCWVN2D8iwekEcROS+xCcAAL+Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=HyoBmm1nPGsJZbclGiz85wEAglAOUGh+A5+ENwcjeLhxvXp08/PFJxwTlfRe1fSLh
         Dj0NbH4Kys02HoqXnTs/Yzcd/rQBY0UkK8ciyAjTPQl3rcM5/XpwQ/iWtOjnZjF08J
         DvXTjxN+l9fcRssVvyqDuMOuJV6V9tps/Q2ED3Qc=
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   w4v3 <vv4v3@protonmail.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Reply-To: w4v3 <vv4v3@protonmail.com>
Subject: Re: "Reporting issues" document feedback
Message-ID: <3x-mW2Aa7Iz_sCWB1nxpPelpI18fDYosCWTq0_3mkcpnkNC6-HTsmIZ9eCEqcSKzXvt7-F25btwz38vkxAQBRLRVsgUqxUZlU9a-ZR_XhMY=@protonmail.com>
In-Reply-To: <CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com>
References: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com> <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info> <wqM80O49houE3ZJHpxjcrNxijZ_h9pMjxZU2OCL-ZpsdwMhIVFcGXZb9qe93r2AY0qd0dB-94ZVQaF-Xb-i-zqX5DIO5S4C6UTBpVkxvszA=@protonmail.com> <CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, thanks for clarifying!


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, April 14, 2021 3:42 PM, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:

> On Wed, Apr 14, 2021 at 3:22 PM w4v3 vv4v3@protonmail.com wrote:
>
> > Hi Thorsten,
> > Thanks for the quick and illuminating response :)
> >
> > > Links to your bug report and the thread on the mailing list would hav=
e
> > > helped here to understand better what's going on, but whatever, they =
are
> > > not that important.
> >
> > Here you go: https://bugzilla.kernel.org/show_bug.cgi?id=3D212643
> > https://marc.info/?l=3Dlinux-acpi&m=3D161824910030600&w=3D2
> >
> > > But it should, otherwise the subsystem should remove the line startin=
g
> > > with B: ("bugs:" in the webview).
> > > Rafael might be able to clarify things.
> >
> > > But afais it's appropriate there is a B: line: just a few weeks ago I
> > > took a quick look at bugzilla and ACPI bugs in particular, and back t=
hen
> > > most of the bug reports there got handled by the maintainers. That's =
why
> > > I assume you were just unlucky and your report fall through the crack=
s
> > > (but obviously I might be wrong here). And maybe your report even did
> > > help: the developer that fixed the issue might have seen both the bug
> > > entry and the mailed report, but simply forget to close the former.
> >
> > Good to know. It does seem like many recent ACPI bug reports on bugzill=
a
> > have been processed by maintainers. Maybe it is the ACPI-subcomponent I
> > chose for the bug: in Config-Tables, only two other bugs were submitted
> > and they did not attract comments. Anyways, I understand now that it's
> > not an issue with the document so thanks for forwarding it to Rafael.
>
> As a rule, ACPI bugs submitted through the BZ are processed by the
> ACPI team (not necessarily by me in person, though), but the response
> time may vary, so it's better to report urgent issues by sending
> e-mail to linux-acpi@vger.kernel.org.
>
> Definitely issues where table dumps or similar are requested are best
> handled in the BZ, so reporters can be asked to create a BZ entry for
> a bug reported by e-mail anyway.
>
> If you are interested in the history (ie. what issues were reported in
> the past), you need to look at both the BZ and the ml record.
>
> HTH


