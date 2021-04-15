Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08663611D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhDOSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:14:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:45645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbhDOSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618510439;
        bh=TdTcHGYJ1c8RXGkpf0+s767H2Zkzsb60TtOHhEGg0OQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Te1Ium806lZyefPp+PmD7eu2uDuLWp8KbfVDRtnWGQDmWMYyC97dUqqtzudagx5Y6
         jly2gjwDnNt8HVvICJIGdaVweyPQ8fCwIsYdduiFtlNjsTs7trN5ndemcyBVB6aFlI
         QEhzvOCN9X/W6r9hiLTUEe167UukBSP1C+gMRtNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.95]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1luOgs1hXJ-00o03y; Thu, 15
 Apr 2021 20:13:59 +0200
Message-ID: <f2f54eccdbda3bd09eee8bf50264133faf84b80f.camel@gmx.de>
Subject: Re: Question on KASAN calltrace record in RT
From:   Mike Galbraith <efault@gmx.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Date:   Thu, 15 Apr 2021 20:13:58 +0200
In-Reply-To: <CACT4Y+bVkBscD+Ggp6oQm3LbyiMVmwaaX20fQJLHobg6_z4VzQ@mail.gmail.com>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
         <182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
         <CACT4Y+bVkBscD+Ggp6oQm3LbyiMVmwaaX20fQJLHobg6_z4VzQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJcUOFmUdF8mB3VJ5X9eU2m+Rl2Ob9KE5WzQ1EJoxEPmBschOWJ
 G0uUzYiIaxZhzPeEobnkLMfaC2Dyjb35GC+MF+ZIuCSlbmFyQEag6qChD0u2eMxfMtQz9Sm
 4ZH1WO3pB7TeCcbAOQrel7mENL1yYyyqrV4pQGNRZ2Fpzkd4LOSWQSoZ28rCIHzOw/jKKpI
 ROpl1fmnZNsZPaRE1Cprw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rKMJVeirOr8=:t/2IQteopQzsoMRImFcrCA
 axURKvimsAVhEWifQy0R59n1E/FeSERO91LhNZFzBNaQK6D0UMdpy31T25j95P3QyWAUfj0Qg
 bbueTBPleQAnX0I8608aeTAb3z41Gau+QgGNP8Pg2oVyHMT2LF2lU1rI6Xv/gxsNUJIYZoWob
 chPgbTI08blR5xmzrwHP5z5LKn5dgl2G7WXqu5dP19iBSe9RIx8uuUDNzV3pvyIv3DLq2qq6N
 wr1MoKgGooJWIvA7vNwPrvjRsXkh4udLHoijWqnm/ooXLGY7EZJAN7zyT9y0dAO9w45CrBjsT
 HfaBEyh0KtzZktsR1Fq7H3QA+bcN7KyOMjgg7HuXvWT9X+YG950mYQTf+MUfPFwuoRsrKmUaD
 XLtZ9nLp0C5AR9ZzdCVNB0nUBBEcGJiTKnPBrhrtAJlrdS6Cd3Tai1Y8BpxB9QRCXn1CsBTC1
 FVDaT/SqZmZyvpY7QLHn7YCacxd7cj/ft/zMfv+Ynq7Kpirzrj/s5lkl5W2a1abjjlrGmzomU
 qBD6KePakNsNQ+r2m2tRtdzPa/D9hUbzw1thVgzWQuCVXooPQ7kp3V2jqkOGRprUWcu8q/Rf1
 VHkQnuZ6VyxL/UV9pOluLWvtzD1FHBaYNdvwdj6foziTV2lc2Gq2xX034/0QRZKt1mXgyE987
 hibyAF6Y6LIdp8jHrsxRnVfFZ6hTsbZfnGRi2ztZpnyF4JG5eUKdsERKL5yOV9aqDNp9tKd1y
 dNmvVEQsHdOowMHpj2f819m3FZXhCQyQcwaEH0HZHkoUwPvwsfLKMzGtdFirg+qrNLmi3NWGm
 4kH79ZpZJNK4OvOoB4/HFTjGsUOTi8KkWsgrJ8HfhVSXlCErRdB03xXwtd9MePu/Anbw8v0t2
 k+VrBNzkQzL9/ncUATWTUjABbqXJZVftT2nLBwoANrluj4s4WFZxG29ARUjH3exYNPsiuiT0h
 pNtJjhOWA+NaCjMums2AZmi0bBMEvSiiltP5jdOaVkafDkIqosylf9THjNKliWuSdeDgSa5uW
 gsw3hiinK6Ns92hO6Up7s9nPq9qWUALQMPT3b+gSCQR+1mUMe1y6SzgvyFoqq6W8ALEUlA7u2
 m7DuDSSQGAOoAac7jEYZBEXxMbNsQhElD4NrfzHrJBGqi/FNuUVHd5Z4483vWTIW9RZGNqPAV
 2Rj76HAO7MXISUGihgteaU22mzcy57SfYZ28ELhN3OGJYY+6BQdCNUQSRQ6In4LI3KsfE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 07:26 +0200, Dmitry Vyukov wrote:
>
> > [   15.428008] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap=
_entries+0x17e/0x3a0
>
> This looks like a genuine kernel bug on first glance. I think it needs
> to be fixed rather than ignored.

I posted a fix, so KASAN earns another notch in its pistol grips.

	-Mike

