Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F579447F38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhKHMGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:06:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:60877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238065AbhKHMGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636373002;
        bh=7FNmA+y9LJTvWIvcEPrCOm7GfS4eaopz5GWAAGvl3gE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DrgGcOCLGYCvYGWUf1v+QJ6MLYAJCXu93n2uoz8Lm9A6RqHoid+rAyNrfOXE5qfwS
         Gven80ESHwnIsbUPGAIQ1SExFEmgIYv3CyeN1dpFkY8wOrhC2Y56Qc0X+tX8IdjzwW
         UAvH4d+X0+SH6FvixEakz9DO8R9dc3MfjMHDtby0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([46.146.146.157]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1mTUYW3dHZ-00sN3E; Mon, 08
 Nov 2021 13:03:22 +0100
Message-ID: <0b78b74e-5c72-1258-8373-5385d5709a6c@gmx.com>
Date:   Mon, 8 Nov 2021 12:03:20 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com> <87mtme98l6.fsf@intel.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <87mtme98l6.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+RCEZKEgwW2bGVsuzgNUPp1xkt7Eg0h3fkHCehIXwF62MIibs9O
 S79V2R+i7iJ1NeiAcyvGDkxhmAzOHGvWm8aXyA6sJMWsS+N3AgLndaoWKf2ZuTxvIvQO0Xu
 m9yr2xi+n9qI1JDlUE5WgfBHwGCQ5hXw4zfORbEpCYoYfb8X2lwMXYOrMbJ020y3EEOjdQu
 4FKJryBGBwi5xyeoZEvBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z3aOnR4jfg0=:FoJ55jH+nwy6CCV/1h4J1c
 QrTempK/b5jC5rxn1PUhPjd3JvATopnyyJUqOOIrXh42GBC2x2AGsy06jER7hdjaMksfwq5fy
 SX8wHrIQeFSNyJgpJNZogW/P2DK2izAeEuJTZPHrEUuqKbIJBDAUtdCjYkEAk2cRNCliO3sz1
 bziYTg0gK5fZbhWvmYn7wBHqFdzovJkfeyJ3tM7D4wV8nqfRAKpk0cTMWKTK4FBRyrqUwlyYJ
 +284HoKuyVeAv15IYiQDtMkAaM/qPGxyqmVPHJg1lKA3lQcDlSmzxCr/9+mZrkk/k6vpe4+nd
 BqV+tiw11OVxTuUfLhnDrWGcXTkQ1rkmPFNo5oxO38YDi/E/1YBUKpM74/S30FIklg+y3Omr4
 tJ8STigGsSrJGto13/UGsFtaEreN1jCWABGjnpGyOeSaBnzo+iqobfWKJ0RIojyUt3bBG/PMu
 zC1HvZDoRyB/mku3bfIwqq9evBfO0L0aAVGVa1d5PlrzvsUeYK6EyD63BUgg7oNkiDaQdIu4f
 YowzWtaxqokhhKz3pSxNT+pSDlNj9nNpfNY6DU6Cap/8yVr0lS1kCK4KuAtaqmtMu5e0eAVSG
 Jh7NOaUPPe6M+5S0GmkWqz2pkIei18ZLKCBM107iT5vW5jhDqoUAbhhJ/IbNaV9TRn92q81zg
 J72rsJbh7odOd7lF7rncCGfzOtgv3iRj3ewhhqpP8LpoxOf6D8O3n5CFw2qaRQZAExtfRT9EH
 oiLATm1oc6G0Xw+8O76rheR/QJJzfqxvdbAQ7LSwc/A3TnJuZkx9Qsls94cmuMDxFaGugJ0Uc
 tmOgjxMqqAbjWSmqYIUUX9U9UurvFuGNQhcUAwc+YrYMg90ayet/JPvB6+uMVivhu/LUSpi8N
 L98KwC6O/k3HmOguzSfqElVkNfwfCJfVVGpX4s7WfP1zXE7QUv270x0ohu0QK+JK/+u1QCCBQ
 D7fPUdhMCRkp0KK2Annnq6Y6hN531AI3wXZBuKWKdGtKcPX9CLhP4aUpUcq6CiCLbPo4fe8NE
 nTaYfA5eGyOMY4aUvKPr7Nc9/xcxK6HODpDUdI1wvH83O7yWreL/L7WP9FT4zUPfqg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/21 11:43, Jani Nikula wrote:
> On Fri, 05 Nov 2021, "Artem S. Tashkinov" <aros@gmx.com> wrote:
>> Let me continue.
>>
>> Here's something which is really bad for bugzilla.kernel.org:
>>
>> People _continue_ to file bug reports for graphics drivers in Linux and
>> we don't even have proper components for it, only
>>
>> Video (AGP) - What? AGP has been dead for a decade.
>> Video (DRI - Non Intel)  - what? Isn't it an X.org's feature, not kerne=
l's?
>> Video (Other)
>>
>> This is a complete and total clusterjoy.
>
> FWIW, for Intel graphics (i915) we don't want any bug reports at
> bugzilla.kernel.org. We've migrated away more than five years ago. The
> "Video (DRI - Intel)" component was closed for new bugs around that


 From my initial message:


=2D--
2.6 You're under the impression that users will read this wonderful
document (reporting-bugs.rst). They will *not*, they will google for
"report bug linux kernel" and find bugzilla.kernel.org

2) To integrate the first three with https://gitlab.freedesktop.org/drm/
and automatically crosspost over there.
=2D--


It does *not* help one bit that we have different bug trackers and
mailing lists for a *single* component which is the kernel. No other
software project under the sun makes the user rack their head trying to
understand how and where to post bug reports.

And then like I've mentioned earlier:


=2D--
2.1 Tons of messages in various kernel related mailing lists have zero
replies and are not acted upon in any way or shape

2.2 There's no sense of accountability, no way to see what are the
current issues, what's resolved or not

2.3 Users have an extremely hard time looking for bug reports which are
spread along God knows where

2.4 It's impossible to follow up on such messages except when you were
subscribed to the original mailing list, IOW just impossible

2.5 It's extremely difficult to collaborate since e-mail totally sucks
when it comes to long discussions.
=2D--


The Linux kernel bug reporting process is a complete clusterfuck and it
looks like no one cares at all. The consensus is "the harder it is, the
better" since unreported bugs means less work, accountability and
responsibility.

The fact that no one from FSF has replied to any of my messages is a
further confirmation. Budget ~$2 million in FY 2019. I guess two million
bucks are not enough to take proper care of the most important FSF project=
.

Can we shut down bugzilla.kernel.org completely? In its current form
it's nothing but disgrace.

> time, the description points at freedesktop.org as does MAINTAINERS:
>
> INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets=
)
> B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bug=
s
>
>
> BR,
> Jani.
>
>
