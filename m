Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB11374BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 01:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhEEXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:33:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:46597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhEEXc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620257520;
        bh=ptpB4Mo5gjXW1QIf1DchDb8lby1fzDZYKg/z/S90zzI=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=ExnlOrykOkZpQIZ9taNzahxwBM3B3XNCfqnjzpzNg/Mt4BTq86IXRomhcQV9xU8t5
         WSBmPIYLKb5+mE68LdyKPMh7Fzs7m9FECw8kGFxDXx5EJZz1afZi13R0UIt+0t1WeE
         gZAfiN6UOYB3t3bm9ziwA3G22M4K04qAPVQsQL3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.189.19]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsHns-1lOgEU0dwY-00tnRr for
 <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 01:32:00 +0200
To:     linux-kernel@vger.kernel.org
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: An initiative to collect unusual kernel messages and automatically
 create bugzilla.kernel.org bugs based on them
Message-ID: <aaece64f-8c6d-29c8-2aa1-34e6dd9378ac@gmx.com>
Date:   Wed, 5 May 2021 23:31:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dtvZ3U1jo2JIDNEDiqwUQInfD9NLP5VytWXwdjbP3QGPBzOaijO
 g0xaMTlzu0ubEhzeOeNfskO3tNEQ8xkBztAEy0tD0L4kXNbChIpmfUmoTfCxQh9tnL5r3uP
 lgoCMmzG38uZvrgv+2Gw9kM1J6Qwio241EsTZS5mRNO8j4Z3j5ncv3NXUq2JScyPyn9Ws0r
 Qo19TcthYcascTeRXjrSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v+KqJh3q2AU=:1QHUfDV71hyg3NhVopyeo6
 CF4BK2FTL63YcdIGWPZx+kFBzzg02rPnxq9pI63miUjOMxAZZbUNbxEhxZuRvICIXSPbZZAL9
 ZegHno65R3y9gAdHnBp/XiEBwmKgjRnmgw0z+R8aoQ7N+DM3Azpn4KUx8l+LLpFlnBCtP0XF+
 sooryaeeAz207vQRdgAGYCdHPIVXnPpWtCWpVpv7RvXpmrzJH3vshFOj199D5DrG1475mJcmv
 i51cTaZXHWk3KZxCeRfIS/fIT2808+5DNitsJQWZyUHTJtiTzntS0ir1Uz39G0agywiv7dWA7
 anNM3D4h0cLglrJ+MAavdNZ7LWYgCGmJPlzTlzMisTLGmCfx51Ip5I7VK7xHtMoI8ZrclKnZy
 6asib6zCdBHN9C1J+5HfApxhQrevhB/6Qx5Hkwmp243t5DweixI6aEREdLdi+nhjjBc2HWlWC
 n7dPV1aA8IlpSeHxOM4ku81rVj7pGXmqZ8xdCU0ZZKeMw5qsqkbL1+2PvsTxHAcJ+2+TcaRPH
 riGWAUMoo4YPw2qiLkz28qYvHB0VA+QGLKK7GavPOx9M2gDMQLTR3fGBkCerqGssF0ogmZvyf
 8a9VgKAJ2wNAsNvAMnApaAphHXUi4zHz6rizCdCBZI1ttJf8A4rqFNyoXVIRvIXsefTBH+/LI
 rZ3d2e8SrPk/ZPovkv+PxyFPYaRXD86wNc84+FMnmz3HAtLzcJsvzPE65D18YPWmNqW7U0aou
 +oZG5c8CfneVXWl4GBNqsOncA5CYrbbpdYM5Waa1M0x9dCgX65AZiTROoE/x3wWv31weJMZaQ
 Pa1/+6i35ukUhHOubIrvFJKLlEBQlaaV47ivz/eKVCF2bwdeYxzozu309ExyiJJSWK++Ed7HE
 e1I0usAgGvMNbZAXhKTgaJNa4Iphd1qTE6qfIMvbBsxNQ+QJXixRsirdwDYw7AqGQVJlCQncc
 mmnzbeksqymTrMaHbNWuBG59FHG8TAJVvWmLLcwCrN5QMIahVdqWiyhLv3AfoxjJai/rLMASG
 sAKMjKNQbpGBLkh0G5UiJK4KWQgdRbntbtywn4glswGdivKLxVxwzN39Rr2htoeHxtktcyysO
 qDBXgy0uq33RrFvr1BvHqDE4EdxexjqGvLvgKzE5E2Svp6wzHwS8uReo09gzhb4doEgB55eY8
 Btf2mc9VgL18rGgyr6R4e6JQ0cTiSXTBVYi/W5XP7AypIiGxtjhfPihdoOTSkV+nV85d0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here's a proposal I've made in Redhat's bugzilla (it's been my distro
for more than two decades, so I think it's pertinent), PR1957520:

=2D-----------------------------------------------------------------

I've been thinking about this issue for a couple of years now and I
struggle to understand where and how it needs to be implemented.

We all know that the Linux kernel doesn't perfectly support all the
hardware around, and the second serious issue is that the Linux kernel
contains known workarounds for broken hardware but those are often not
properly organized and end users have no idea whether those workarounds
are mild and innocuous or they need to be taken care of.

I have a very unpopular idea to propose. Let's implement a strict opt-in
program and add it as an option in the Anaconda/Fedora/RHEL installer to
_anonymously_ collect unusual kernel messages and based on them
automatically create bugzilla.kernel.org bugs.

Why do I believe it's necessary?

If you run the following command on your Linux device right now you'll
see a ton of data which in a perfect world shouldn't be there, the
output of this command should be just empty but it's not:

dmesg -t --level=3Dalert,crit,err,warn

Of course some of the issues presented are known quirks which will never
be fixed, but users often have no way of knowing it and end up googling
each error message.

In a perfect world each of such messages should be followed by a good
explanation, e.g.

smpboot: 32 Processors exceeds NR_CPUS limit of 16 : this is a known bug
tracked as PR204813, it is safe to ignore it.

Or another message:

kernel: ACPI Warning: SystemIO range
0x0000000000000295-0x0000000000000296 conflicts with OpRegion
0x0000000000000290-0x0000000000000299 (\AMW0.SHWM)
(20201113/utaddress-204) : this is likely a problem with your EFI
firmware or a known bug: PR204807

In short, "bad" dmesg output should not be cryptic and Fedora may
actually start doing something about that.

Lastly, out of all active Linux users, I guess less than 0.1% actually
report bugs about their HW [support] and such an opt-in program could
actually resolve a ton of issues which are flying under the radar of
Linux developers.

Probably such a daemon for collecting anonymized kernel messages could
be implemented across all Linux distors right in the kernel itself but
that will require cooperation between Linux distros and the kernel which
I'm not sure will pan out.

I would love Fedora/Redhat/IBM to treat this proposal seriously and move
ahead with it regardless of what the Linux kernel community thinks about
it as it most likely will result in multiple bugs resolved or and kernel
messages made understandable for end users.

=2D-----------------------------------------------------------------

I would still be extremely glad and grateful if Linux kernel developers
chimed in and expressed their opinion about this program/initiative. I
believe it can have a great chance of resolving multiple not well known
issues in Linux hardware support and making `dmesg` messages a lot more
understandable and clear for Linux users without strong IT background.

Best regards,
Artem
