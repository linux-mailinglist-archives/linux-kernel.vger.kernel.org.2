Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB43237A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhBXHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhBXHGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:06:33 -0500
Received: from filter03-ipv6-out05.totaalholding.nl (filter03-ipv6-out05.totaalholding.nl [IPv6:2a02:c207:2038:8169::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77768C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:05:53 -0800 (PST)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter03.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lEoEy-0003bz-WD
        for linux-kernel@vger.kernel.org; Wed, 24 Feb 2021 08:05:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Te9JM/fpGqSo9YQ/xYcYqfNig/F+aS/rb0mnnR2EUK4=; b=ALB1tPUsUcj7i5IRz2WxGV2nF
        1R1AWsPMrK4SOQHaKN6GD3uHBwd0j7q3rUojMjGbV/lHFisYXeOmzkaORTCy5u6u55Q9HJHCR72Fs
        U17frIkopdgMgkLlr8EF46ZUTkrJ5gt8L28e0xmBv1aNepyHmxNvVsOnBZ0C8wVK1SKMG8Gr/EF3o
        M01DXMs042vhee90a3mGjfLj/0gMCY+KMUiVqQgt4/vAEwHLb3KUCmfFmL02Pp54VL9SwpaIDB6o4
        Znoc7qbf1+eE3BnlG3MjSU488RKOnN7gpPjnl0tDVfOfb2J96hfzK5rCw3txSiZyWiDWOnL+XrtCA
        /ln23h65g==;
Received: from 82-94-23-232.ip.xs4all.nl ([82.94.23.232]:58070 helo=tp06.long4more.com)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lEoEw-0007dC-9d; Wed, 24 Feb 2021 08:05:42 +0100
Message-ID: <6d60d9b35012d970b7a2f60792ef45ec6b1bd4c7.camel@cyberfiber.eu>
Subject: Re: problems with memory allocation and the alignment check
From:   "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Feb 2021 08:05:42 +0100
In-Reply-To: <CA+=Sn1kR6jV2j2cOLhC-GBDS_NSxsw0m=K+VghBmqBSB4c2gqw@mail.gmail.com>
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
         <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
         <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
         <CA+=Sn1kR6jV2j2cOLhC-GBDS_NSxsw0m=K+VghBmqBSB4c2gqw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-gDqG88XF5HWMvyn7IRbU"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.gcc@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.gcc@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.15)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9t4BnnvdVdQTTgzyuGJel/PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bRF//qaUOSOwgO4hiECe1ZB15WCy5VkstzhnxgTXqsdmpzAZsc6MRuL9DcHa
 Zpd4we/piBIbZdykCKL9bqvChryU+RG6hze7zJVTSRhy6iTC2HkixtWJU3ux8TqCslrbPB+bgaCk
 W8nGm/sYr5TGcUrdU3OqTzTj50M7fvGTHKtUfUdqO0eWk7cK+7Mu0E3oiuU6t/uXZsD0kV3eTzZp
 3NyQLDnQGgRgHjioU8fpt7xeC7AK0L/uTNt3WCw41GzGb1Zq+pu9ho29CVyp3Dt9A9c5Q0rCcBHa
 hWKxj5ucSpYIqLmSWYrW9rfAlJyD3amD/+N02lc/+6URXoMhQMtzRh3qJOVgT5lyfynWs+kbrg/X
 Ljy6H8ZAD1knk8QPx5GWwsxL96o2cJJSAqZrdlwt8BT+rl/L3p68qpY0qoWMExIKqSSxWVdlbFqx
 F8WMzybyHsghJ1UrIDz/zIKkhjMfdql/vyG/94A9cXb+Do2HsRTe4ni1s7/TTDjHXHAsZ62HKw4p
 tYo2MrTW80hMkO4d8H0iXxOWtra7rYlLHkoU80Khk5A8y7HoHiH+Y0eTzU5RekWIsyGYd+uzOdN2
 eJmhyIEa0bRbmskEhysblbPkZqqEaqntKr6+crm+rffkaQ6ZgOjXyZ6Bm+DQUDWcrDt2FBVwpror
 HtoZkDFywymr1hVSgF+Pt/dv+dTYQMp4c1USnGTILQCjRBaGiTbUQo1GwQWRPAlbDjazCbhs7qBp
 ykynMl3rf892yVe/m3RwQsli2UKKwOziJLo5dRyS8OFBAmm5aH3mw3+yZR18ugGISthuh7VfaJU2
 SLyLNZm5BHGGPDRJyKr+mp1xY2Gq/n09lMSvx1b/scuxI0fRLiIN2Px3II2azxuHF97acinCSKJA
 yH805g8jPjKcxrullDiGL8caz4zTJyZm0O7lrW2SEdrkoxgOpYYn8rsC2Sd6QAaustQ=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gDqG88XF5HWMvyn7IRbU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-02-22 at 01:41 -0800, Andrew Pinski wrote:
> On Mon, Feb 22, 2021 at 1:37 AM Michael J. Baars
> <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > On Mon, 2021-02-22 at 01:29 -0800, Andrew Pinski wrote:
> > > On Mon, Feb 22, 2021 at 1:17 AM Michael J. Baars
> > > <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > > > Hi,
> > > > 
> > > > I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.
> > > > 
> > > > If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
> > > > If I allocate the same region from a function, three out of three optimization flags fail.
> > > > 
> > > > Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?
> > > 
> > > There is no flaw.  GCC (kernel, glibc) all assume unaligned accesses
> > > on x86 will not cause an exception.
> > 
> > Is this just an assumption or more like a fact? I agree with you that byte aligned is more or less the same as unaligned.
> 
> It is an assumption that is even made inside GCC.  You can modify GCC
> not to assume that but you need to recompile all libraries and even
> check the assembly code that is included with most programs.
> Why are you enabling the alignment access check anyways?  What are you
> trying to do?
> If you are looking into a performance issue with unaligned accesses,
> may I suggest you look into perf to see if you can see unaligned
> accesses?

Next to performance and correctness, I always try to keep in mind that every clock cycle will eventually end up on the energy bill, to avoid that computers cost
ten times more on the energy bill then they do in the store.

If you look at the power consumption of the Playstation 1 vs that of the Playstation 3 for example, you will see that the Playstation 1 uses (10 W / 240 V
= 0.041666667 A max, while the Playstation 3 consumes 240 V * 1.7 A = 408 W. More than 40 times as much energy!!!

Code and style always go hand in hand. Try to keep you code as sleek as possible and you will see that even an old computer can do a lot more than you ever
thought possible :)

Thanks,
Mischa.

> Thanks,
> Andrew
> 
> > > Thanks,
> > > Andrew
> > > 
> > > > Regards,
> > > > Mischa.

--=-gDqG88XF5HWMvyn7IRbU
Content-Disposition: attachment; filename="compression.c"
Content-Type: text/x-csrc; name="compression.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUJPHN0ZGludC5oPgoKI2luY2x1ZGUJImNvbXByZXNzaW9uLmgiCgp1aW50OF90CWRh
dGFfc1syNTZdICAgICA9CXsKCQkJCTB4MDAsIDB4MDEsIDB4MDIsIDB4MDMsIDB4MDQsIDB4MDUs
IDB4MDYsIDB4MDcsIDB4MDgsIDB4MDksIDB4MEEsIDB4MEIsIDB4MEMsIDB4MEQsIDB4MEUsIDB4
MEYsIDB4MTAsIDB4MTEsIDB4MTIsIDB4MTMsIDB4MTQsIDB4MTUsIDB4MTYsIDB4MTcsIDB4MTgs
IDB4MTksIDB4MUEsIDB4MUIsIDB4MUMsIDB4MUQsIDB4MUUsIDB4MUYsCgkJCQkweDIwLCAweDIx
LCAweDIyLCAweDIzLCAweDI0LCAweDI1LCAweDI2LCAweDI3LCAweDI4LCAweDI5LCAweDJBLCAw
eDJCLCAweDJDLCAweDJELCAweDJFLCAweDJGLCAweDMwLCAweDMxLCAweDMyLCAweDMzLCAweDM0
LCAweDM1LCAweDM2LCAweDM3LCAweDM4LCAweDM5LCAweDNBLCAweDNCLCAweDNDLCAweDNELCAw
eDNFLCAweDNGLAoJCQkJMHg0MCwgMHg0MSwgMHg0MiwgMHg0MywgMHg0NCwgMHg0NSwgMHg0Niwg
MHg0NywgMHg0OCwgMHg0OSwgMHg0QSwgMHg0QiwgMHg0QywgMHg0RCwgMHg0RSwgMHg0RiwgMHg1
MCwgMHg1MSwgMHg1MiwgMHg1MywgMHg1NCwgMHg1NSwgMHg1NiwgMHg1NywgMHg1OCwgMHg1OSwg
MHg1QSwgMHg1QiwgMHg1QywgMHg1RCwgMHg1RSwgMHg1RiwKCQkJCTB4NjAsIDB4NjEsIDB4NjIs
IDB4NjMsIDB4NjQsIDB4NjUsIDB4NjYsIDB4NjcsIDB4NjgsIDB4NjksIDB4NkEsIDB4NkIsIDB4
NkMsIDB4NkQsIDB4NkUsIDB4NkYsIDB4NzAsIDB4NzEsIDB4NzIsIDB4NzMsIDB4NzQsIDB4NzUs
IDB4NzYsIDB4NzcsIDB4NzgsIDB4NzksIDB4N0EsIDB4N0IsIDB4N0MsIDB4N0QsIDB4N0UsIDB4
N0YsCgkJCQkweDgwLCAweDgxLCAweDgyLCAweDgzLCAweDg0LCAweDg1LCAweDg2LCAweDg3LCAw
eDg4LCAweDg5LCAweDhBLCAweDhCLCAweDhDLCAweDhELCAweDhFLCAweDhGLCAweDkwLCAweDkx
LCAweDkyLCAweDkzLCAweDk0LCAweDk1LCAweDk2LCAweDk3LCAweDk4LCAweDk5LCAweDlBLCAw
eDlCLCAweDlDLCAweDlELCAweDlFLCAweDlGLAoJCQkJMHhBMCwgMHhBMSwgMHhBMiwgMHhBMywg
MHhBNCwgMHhBNSwgMHhBNiwgMHhBNywgMHhBOCwgMHhBOSwgMHhBQSwgMHhBQiwgMHhBQywgMHhB
RCwgMHhBRSwgMHhBRiwgMHhCMCwgMHhCMSwgMHhCMiwgMHhCMywgMHhCNCwgMHhCNSwgMHhCNiwg
MHhCNywgMHhCOCwgMHhCOSwgMHhCQSwgMHhCQiwgMHhCQywgMHhCRCwgMHhCRSwgMHhCRiwKCQkJ
CTB4QzAsIDB4QzEsIDB4QzIsIDB4QzMsIDB4QzQsIDB4QzUsIDB4QzYsIDB4QzcsIDB4QzgsIDB4
QzksIDB4Q0EsIDB4Q0IsIDB4Q0MsIDB4Q0QsIDB4Q0UsIDB4Q0YsIDB4RDAsIDB4RDEsIDB4RDIs
IDB4RDMsIDB4RDQsIDB4RDUsIDB4RDYsIDB4RDcsIDB4RDgsIDB4RDksIDB4REEsIDB4REIsIDB4
REMsIDB4REQsIDB4REUsIDB4REYsCgkJCQkweEUwLCAweEUxLCAweEUyLCAweEUzLCAweEU0LCAw
eEU1LCAweEU2LCAweEU3LCAweEU4LCAweEU5LCAweEVBLCAweEVCLCAweEVDLCAweEVELCAweEVF
LCAweEVGLCAweEYwLCAweEYxLCAweEYyLCAweEYzLCAweEY0LCAweEY1LCAweEY2LCAweEY3LCAw
eEY4LCAweEY5LCAweEZBLCAweEZCLCAweEZDLCAweEZELCAweEZFLCAweEZGCgkJCX07Ci8qCjAw
MDAwMDAwMDAwMDAwMDAgPGNvbXByZXNzaW9uX2VuY29kZV9wcmVwYXJlMT46CiAgIDA6CTQ4IDg5
IGY5ICAgICAgICAgICAgIAltb3YgICAgJXJkaSwlcmN4CiAgIDM6CTMxIGQyICAgICAgICAgICAg
ICAgIAl4b3IgICAgJWVkeCwlZWR4CiAgIDU6CWI4IDAwIDAwIDAwIDAxICAgICAgIAltb3YgICAg
JDB4MTAwMDAwMCwlZWF4CiAgIGE6CTY2IDBmIDFmIDQ0IDAwIDAwICAgIAlub3B3ICAgMHgwKCVy
YXgsJXJheCwxKQogIDEwOgk0OCA4MyBlOCAwMSAgICAgICAgICAJc3ViICAgICQweDEsJXJheAog
IDE0Ogk3NSBmYSAgICAgICAgICAgICAgICAJam5lICAgIDEwIDxjb21wcmVzc2lvbl9lbmNvZGVf
cHJlcGFyZTErMHgxMD4KICAxNjoJODggMTEgICAgICAgICAgICAgICAgCW1vdiAgICAlZGwsKCVy
Y3gpCiAgMTg6CTQ4IDgzIGMyIDAxICAgICAgICAgIAlhZGQgICAgJDB4MSwlcmR4CiAgMWM6CTQ4
IDgzIGMxIDAxICAgICAgICAgIAlhZGQgICAgJDB4MSwlcmN4CiAgMjA6CTQ4IDgxIGZhIDAwIDAx
IDAwIDAwIAljbXAgICAgJDB4MTAwLCVyZHgKICAyNzoJNzUgZGMgICAgICAgICAgICAgICAgCWpu
ZSAgICA1IDxjb21wcmVzc2lvbl9lbmNvZGVfcHJlcGFyZTErMHg1PgogIDI5OgljMyAgICAgICAg
ICAgICAgICAgICAJcmV0cSAgIAogIDJhOgk2NiAwZiAxZiA0NCAwMCAwMCAgICAJbm9wdyAgIDB4
MCglcmF4LCVyYXgsMSkKKi8KCnZvaWQJY29tcHJlc3Npb25fZW5jb2RlX3ByZXBhcmUxCShzdHJ1
Y3QgY29tcHJlc3Npb24qIGMpCnsKCWZvcgkodWludDY0X3QgaiA9IDA7IGogPCAoMSA8PCAyNCk7
IGorKykKCWZvcgkodWludDY0X3QgaSA9IDA7IGkgPCAyNTY7IGkrKykKCXsKCQljLT5kYXRhX3Rb
aV0gICAgPQlpOwoJfQp9Cgp2b2lkCWNvbXByZXNzaW9uX2VuY29kZV9wcmVwYXJlMgkoc3RydWN0
IGNvbXByZXNzaW9uKiBjKQp7Cglmb3IJKHVpbnQ2NF90IGogPSAwOyBqIDwgKDEgPDwgMjQpOyBq
KyspCglhc20Jdm9sYXRpbGUJCQkJCVwKCSgJCQkJCQlcCgkiCWxlYQkJJTAgICAsICUlcmRpCVxu
IglcCgkiCWxlYQkJJTEgICAsICUlcnNpCVxuIglcCgkiCW1vdgkJJDB4MjAsICUlcmN4CVxuIglc
CgkiCXJlcAkJbW92c3EJCVxuIglcCgkJOiAiPW0iCQkoYy0+ZGF0YV90KQkJXAoJCTogIm0iCQko
ICAgZGF0YV9zKQkJXAoJCTogIiVyY3giLCAiJXJzaSIsICIlcmRpIgkJCVwKCSk7Cn0KCg==


--=-gDqG88XF5HWMvyn7IRbU
Content-Disposition: attachment; filename="compression.h"
Content-Type: text/x-chdr; name="compression.h"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2lmbmRlZglfX0NPTVBSRVNTSU9OX0hfXwojZGVmaW5lCV9fQ09NUFJFU1NJT05fSF9fCgojaW5j
bHVkZQk8c3RkaW50Lmg+CgpzdHJ1Y3QJY29tcHJlc3Npb24KewoJdWludDhfdAlkYXRhX3RbMjU2
XTsJLy8gY29tcHJlc3Npb24gdHJlZSBpbmRpY2VzCn07CgpleHRlcm4Jdm9pZAljb21wcmVzc2lv
bl9lbmNvZGVfcHJlcGFyZTEJKHN0cnVjdCBjb21wcmVzc2lvbiogYyk7CmV4dGVybgl2b2lkCWNv
bXByZXNzaW9uX2VuY29kZV9wcmVwYXJlMgkoc3RydWN0IGNvbXByZXNzaW9uKiBjKTsKCiNlbmRp
ZgoK


--=-gDqG88XF5HWMvyn7IRbU
Content-Disposition: attachment; filename="main.c"
Content-Type: text/x-csrc; name="main.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUJPHN0ZGludC5oPgojaW5jbHVkZQk8c3RkaW8uaD4KI2luY2x1ZGUJPHRpbWUuaD4K
CiNpbmNsdWRlCSJjb21wcmVzc2lvbi5oIgoKaW50CW1haW4oKQp7CgljbG9ja190CXRpYywgdG9j
OwoJCglzdHJ1Y3QJY29tcHJlc3Npb24JYzsKCQoJdGljICAgID0JY2xvY2soKTsKCgkJCQljb21w
cmVzc2lvbl9lbmNvZGVfcHJlcGFyZTEJKCZjKTsKCQkJCQkKCXRvYyAgICA9CWNsb2NrKCk7CgkK
CWZvcgkodWludDY0X3QgaSA9IDA7IGkgPCAyNTY7IGkrKykgcHJpbnRmKCIlMDJoaFggIiwgYy5k
YXRhX3RbaV0pOyBwcmludGYoIlxuIik7CgkKCXByaW50ZigiZWxhcHNlZCBjb21wcmVzc2lvbiAm
IGVuY3J5cHRpb246ICVmc1xuIiwgKGRvdWJsZSkgKHRvYyAtIHRpYykgLyAoZG91YmxlKSBDTE9D
S1NfUEVSX1NFQyk7CQoJCgl0aWMgICAgPQljbG9jaygpOwoKCQkJCWNvbXByZXNzaW9uX2VuY29k
ZV9wcmVwYXJlMgkoJmMpOwoJCQkJCQoJdG9jICAgID0JY2xvY2soKTsKCQoJZm9yCSh1aW50NjRf
dCBpID0gMDsgaSA8IDI1NjsgaSsrKSBwcmludGYoIiUwMmhoWCAiLCBjLmRhdGFfdFtpXSk7IHBy
aW50ZigiXG4iKTsKCQoJcHJpbnRmKCJlbGFwc2VkIGNvbXByZXNzaW9uICYgZW5jcnlwdGlvbjog
JWZzXG4iLCAoZG91YmxlKSAodG9jIC0gdGljKSAvIChkb3VibGUpIENMT0NLU19QRVJfU0VDKTsJ
Cn0K


--=-gDqG88XF5HWMvyn7IRbU
Content-Disposition: attachment; filename="makefile"
Content-Type: text/x-makefile; name="makefile"; charset="UTF-8"
Content-Transfer-Encoding: base64

YWxsOgoKCWdjYyAtT2Zhc3QgLWMgLWcgLW8gY29tcHJlc3Npb24ubyBjb21wcmVzc2lvbi5jCgln
Y2MgLU9mYXN0IC1jIC1nIC1vIG1haW4ubyAgICAgICAgbWFpbi5jCglnY2MgLU9mYXN0ICAgIC1n
IC1vIG1haW4gICAgICAgICAgbWFpbi5vIGNvbXByZXNzaW9uLm8K


--=-gDqG88XF5HWMvyn7IRbU--

