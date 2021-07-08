Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2233BF6E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGHIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:32:44 -0400
Received: from gimli.kloenk.dev ([195.39.247.182]:48982 "EHLO gimli.kloenk.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhGHIco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:32:44 -0400
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kloenk.dev; s=mail;
        t=1625733001; bh=nsLyPY9TFvdVAsKf24sz2i6+zJKmFfVuOlHVjrT1Wcg=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=F+X8j0IW1g0OcymY5PnahQp/ZFBdq5PH7IpJ3H89kKZKTzp3vnvaD4+r5cVV3wp0X
         d39Axsj4eCAk8ELeDN7np7WIOjZvd285pJokHrAOH+wkQWzlS4jrQrQNx+eEX7XL68
         26WFK/9pDmZyrX48D7J0oz0I9ml7kcGwkTMWdDYI=
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 00/17] Rust support, NVMe
From:   Finn Behrens <finn@kloenk.dev>
In-Reply-To: <20210708063941.xkpf6pr4for7y6gj@gpm.stappers.nl>
Date:   Thu, 8 Jul 2021 10:29:59 +0200
Cc:     Matthew Wilcox <willy@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E19BB1F6-8749-4EFA-AC6F-F77C0C5BF07C@kloenk.dev>
References: <20210704202756.29107-1-ojeda@kernel.org>
 <YOVNJuA0ojmeLvKa@infradead.org>
 <CANiq72mKPFtB4CtHcc94a_y1V4bEOXXN2CwttQFvyzwXJv62kw@mail.gmail.com>
 <YOWjLmg/Z7kr2+tx@kroah.com> <YOW1Nj8+a2Yth2++@google.com>
 <YOXB7FRqldZik2Xn@kroah.com>
 <BFD5298D-00CD-4FEF-AE77-61E69AF78604@kloenk.dev>
 <YOZNuEtNbsLxRM0R@casper.infradead.org>
 <20210708063941.xkpf6pr4for7y6gj@gpm.stappers.nl>
To:     Geert Stappers <stappers@stappers.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 8. Jul 2021, at 08:39, Geert Stappers <stappers@stappers.nl> wrote:
>=20
> On Thu, Jul 08, 2021 at 01:58:32AM +0100, Matthew Wilcox wrote:
>> On Wed, Jul 07, 2021 at 10:56:57PM +0200, Finn Behrens wrote:
>>> There is a more general use driver (network dummy) still in the
>>> making, It is fully operational, just the documentation of the rust
>>> bindings are not finished yet, so it is not merged into the rust
>>> tree yet, also I have to rebase it.
>>=20
>> Why are you so resistant to writing a real driver that deals with =
actual hardware?
>=20
> } Why are we so resistant to writing a real driver that deals with =
actual hardware?
>=20
> It is not dodging hardware, it is universal available.
>=20
>=20
>> A simple NVMe driver is less than a thousand lines of C.
>> I know the one in the kernel now is ridiculously complicated and has
>> been thoroughly messed up with abstractions to support NVMeoF instead
>> of having a separate driver, but it's really a simple interface at =
heart.
>=20
> Summary of https://qemu.readthedocs.io/en/latest/system/nvme.html
>=20
>  NVMe hardware is universal available.
>=20

I actually don=E2=80=99t have a clue how nvme works, that is my reason =
to not write a nvme driver. But, I=E2=80=99m currently writing a rust =
version of e1000. This is also available in qemu and is real hardware. =
This is sadly taking quite some time, as I don=E2=80=99t have a good =
linux kernel development setup currently.

>=20
>=20
>=20
> Groeten
> Geert Stappers
> --=20
> Silence is hard to parse

CU,
Finn

