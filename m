Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC844651E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhKEOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:39:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:46797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhKEOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636123012;
        bh=+5wbfOxHWvEieCA5vwLScoPcoUXpY44eR4AUn9qnXVE=;
        h=X-UI-Sender-Class:Date:To:References:Subject:From:In-Reply-To;
        b=U5SrIgi/IijNxcJnopT5XEN5qhFpDgDze0ppdnVUlu4tg8E1ii41K9mFuVRx+bjZR
         kumB5kqw9zZrasvjTHOTe4NviCoTW2DNL2xF1p+FDV+kr81B2b6aopU3ssV6/TuZHg
         upstDJxoRZzoj6pTC4RMvfs1vglEV1jIIchpMnlc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.175.137]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1mZDE00MEe-010sMv; Fri, 05
 Nov 2021 15:36:52 +0100
Message-ID: <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
Date:   Fri, 5 Nov 2021 14:36:51 +0000
MIME-Version: 1.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20210110121033.130504-1-linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XbteeJ6MAGtsY3wvzUORWmHJoaoPZmXPeRkP3z0kjwRkGJzS0yJ
 IHgAmI/SmuIPt45FNJkkvZkKxIEn1V+9/sJGt7A97jxCFGRxw5tC3HdpWL7YYFUMibv//iS
 uILzPzVzZrBdgqvpEOqoneLzc3kPzD26i5PK9J09OiQOyMcNnUdyogDEtIERPrRl8lUmuHX
 TpqP72WhJVmvBGmwTQIbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhzDEks+quY=:VOA54v/fp3jfNpryVZjN9T
 ETepWPJJIp2ORG9COf6zuYkXTEwTRMg4dlWU1g4DoRNAhoRDXpLQSn6kWDgIUSIUnJ+AIHkJL
 AnFJA66dvSsqrfK9m/JNT5xDh599jo+UaXDB8DLu7UBd1TZHUn7OLLvJK+BtC6lXh2cH9lELr
 7NcG43a5oDTku/2EheGLfHk/eETM+bEDEor+KIPFRNFwtsQ4ZsWiIwMeSCwwNJLI7pcVFQeqN
 h2NmpppooRRizN0TBUHeBDgiOZSUAfJbs0U1NSLbg6186eBSIYEFnGKFLFabuu0FGLP57Y/+5
 485ilCXCntuvce5jyaC9Id4tULlDQUfKg8rY93X7LBoiyvpRa/LNn1PCA1GW9JmjPQiEvTc6Q
 3xdSIp5RqHiH1kK/B9YjMNKUcwXStVpwqnkim2V+0a6+VMeBJlPOwFF1/L7Xh8ebFf+zsqDgA
 dqWDelgQsaVgIYzlyml2i7BSJIzyEWYxBkYN9gf3TNK04u5N/e6Ixos6/VKwFFygB4IL9+WVV
 DFtRrMIpivYBjwTaavbnnNAJwou6Rv6w5nLmes2Dco20So4Uoa7oSd2I55N70O80MgqZ5U5W8
 mKhBu0VxUs0vIBomXoUiYN8VYluZfBtbnU+zFuaQepQW2MDQt5AZ00iecSFp8UaarUL95xsZO
 XpVqHj6zLxaaihcveAqaA9aomD7/WspuNeYwIp16joFnm/YspF+kuly14eLNvj5v+iyO/nXjs
 nj2/kjCVXvdeIWnKP/on6SjZ5iZaRrLg0kvDByubqm5M20McnoV10T6Wg5oeeGwzIzLcd0m56
 vHS1f0y8SviAtygMz2sXwBJJN/hol6Rl/3fEmmc0cAui6yj/CGfEXNiD5HVNSzlrJjgbwEqVM
 Agyqamyb/3oxn4rMiKVO2wbrhF+D4jHRBOr8VnS2RzEcKQtw8ewfUpqWuF/2JGtuq6C5t1hsO
 qZe5kZqkQ9ByjCuAJ7vSUGJ9STyoR0egHyR29ZbZ+eRu2IJnJ7XJRWLsQU0IAQ5h0bDjID0DA
 rpw82SdMHtT5usC8M5jn22sP56GooEyq1cYSVhMWgIe6JUdLIvIKTlAZ1gJDlR3RHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Let me express an utter dissatisfaction and even contempt for this proposa=
l.

1. Absolute most open source projects are managed via bug trackers, I
see no reason the Linux kernel should be exempt

2. LKML has historically created/used for for posting patches and
discussing kernel features. Of course, major bugs have been discussed
and resolved as well but mostly among _core_ Linux hackers who are
_subscribed_ to it and _participate_ in it which is _not_ the case for
absolute most kernel developers nowadays.

2. Even though many kernel maintainers and subsystems express their
desire to manage bug reports via e-mail it's an utterly preposterous,
nonworking and broken idea for the following reasons:

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

Consider this bug report: https://bugzilla.kernel.org/show_bug.cgi?id=3D20=
4807

Over a hundreds of messages, multiple attachments, a flow of ideas and
patches - how on Earth this can possibly be replicated using email? Why
does pretty much no other project aside from maybe Debian has this
peculiar workflow?

2.6 You're under the impression that user will read this wonderful
document. They will not, they will google for "report bug linux kernel"
and find bugzilla.kernel.org

2.7 If you venture to work as a kernel hacker you're expected to be
_responsible_ for your code. If you submit a patch and disappear that's
going to be more a disservice to the community rather than actual help.

=2D--

Let me continue.

Here's something which is really bad for bugzilla.kernel.org:

People _continue_ to file bug reports for graphics drivers in Linux and
we don't even have proper components for it, only

Video (AGP) - What? AGP has been dead for a decade.
Video (DRI - Non Intel)  - what? Isn't it an X.org's feature, not kernel's=
?
Video (Other)

This is a complete and total clusterjoy.

I don't think it's too difficult:

1) At least update Video components, let's say, have Intel, AMD, Nouveau
and Other - there's a ton more but these will suffice. Most others are
for mobile/embedded and to be honest their users are unlikely to ever
touch this bugzilla.

2) To integrate the first three with https://gitlab.freedesktop.org/drm/
and automatically crosspost over there.

3) Someone has to actually read all the bug reports and check whether
they are relevant, filed properly, filed under the proper category and
whether they should be closed.

4) And what's with the front page which says to use Distros bugzillas? I
smell some BS in this statement because among all distros maybe RedHat
and Ubuntu have the people to deal with kernel issues, and all others
simply don't in any capacity. Bugs filed in distros bug trackers will
linger for ages, get zero attention (it's my experience with Fedora and
even RHEL) and be closed since _no one cares_ and no one is experienced
enough.

I really hate how this bugzilla is treated as an afterthought which no
one really cares about. If no one cares, why does it exist in the first
place? Let's shut it down then. Let's move to mailing lists and create a
total mayhem of lack of accountability. "Bugs? Sorry, I've had no time
to read emails".

If it exists and serves some purpose, why Products and Components are
stuck as if they were created in 1995, not in 2021?

AFAIK kernel.org is a The Linux Foundation project. The organization is
heavily sponsored by tons of companies. It would be great if we had a
person actually invested in bugzilla.kernel.org

=2D--


Best regards,
Artem
