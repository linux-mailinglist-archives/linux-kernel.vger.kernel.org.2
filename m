Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEDA3A42EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhFKNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKNTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D44D5613CF;
        Fri, 11 Jun 2021 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623417466;
        bh=jNzQ0TG0h6XTvMoCnRJucQt9h+fq2NEVGqRXeok5m9Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=grXs1Z3J7VJmXFkGze9KeySIlmphYvM4WTaWDGdtuR+PseTgG2TF5CgSP6353recZ
         3Y3OFE97Mc7aoYwV7/BIwz1FxJniLxjMDf5E0KBBssPU3GjQajQTEfKBCeJBmUGCX6
         UGZobUBPq80M53XQDwnIr/3V0LHJ32xTIb2Auyyjhk96AICq396TqtR7AGVYm7EFlK
         LHYH24VmzqYiGQQ3Sk0t9ufP0mBu0F+q43tZRNRdCQJup7JnmDDzpqubDHjXf9WxVa
         CL+6gPNgvS04pxDIk3VJSHGNim4nA3T1XyxWCBW/pDyTKwE+6HHbFGfKRhO13mdWHv
         Kthc3mRBNJ09Q==
From:   Felipe Balbi <balbi@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
In-Reply-To: <2cd8231e-c246-4255-a08e-c88ae9b62ed2@www.fastmail.com>
References: <20210607061751.89752-1-sven@svenpeter.dev>
 <871r9a2htf.fsf@kernel.org>
 <2cd8231e-c246-4255-a08e-c88ae9b62ed2@www.fastmail.com>
Date:   Fri, 11 Jun 2021 16:17:38 +0300
Message-ID: <87o8cczgjx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Sven Peter" <sven@svenpeter.dev> writes:
> On Thu, Jun 10, 2021, at 11:24, Felipe Balbi wrote:
>> Sven Peter <sven@svenpeter.dev> writes:
>> > Currently, the dwc3 platform driver does not explicitly ask for
>> > a DMA mask. This makes it fall back to the default 32-bit mask which
>> > breaks the driver on systems that only have RAM starting above the
>> > first 4G like the Apple M1 SoC.
>> >
>> > Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
>> >
>> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>=20
>> Acked-by: Felipe Balbi <balbi@kernel.org>
>
> Cheers!
>
>>=20
>> > ---
>> >
>> > Third time's a charm I hope - this time much simpler :)
>> >
>> > I still think this change should be fairly low risk.
>> >
>> > Unfortunately I only have the Apple M1 to test this on but here
>>=20
>> wait a minute. The M1 includes a dwc3? That's awesome. Mind sharing a
>> regdump? Should be in debugfs.
>
> Two of them, actually :-)

Sweet! Now we have a mobile platform that can test dwc3 role switch in
isolation :-p Just plug one dwc3 to the other lol

> One for each of the USB C ports together with an unknown PHY and some wei=
rd

I'll bet the PHY is a generic Synopsys PHY. There's no SW control for
it.

> quirks (neither the dwc3 gadget mode nor the xhci hardware seem to receive
> more than a single connect event).


> I've actually written a very basic dwc3 gadget driver for our bootloader
> m1n1 [1,2] loosely based on your Linux driver from before it was switched=
 to
> GPLv2-only to experiment with the hardware and load linux kernels over us=
b :-)

noice!

> I haven't found anything in debugfs, but I can share a simple dump of the=
 MMIO
> space. This is already after the controller has been initialized in gadge=
t mode.
> If you need something else just let me know.

there should be a directory with the device's name. Under which you
should find a file called regdump :-)

>>>> reghexdump32(0x502280000, 0xda00)
> 00000000  01100020 0200047f 1c0000f1 0200000a 0238ffcd 000004e0 00000440 =
0000003f
> 00000020  00000000 00000001 00000001 00000000 00000000 00000000 00000000 =
00000000
> 00000040  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 00000060  *
> 00000420  00000280 00000000 00000000 00000000 00000280 00000000 00000000 =
00000000
> 00000440  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 00000460  00000000 00000fa0 00000000 00000000 00000000 00000000 00000000 =
00000000
> 00000480  *
> 000004e0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 00000500  *
> 000008e0  00000401 00000000 00000000 00000000 02000402 20425355 00180101 =
00000000
> 00000900  03100002 20425355 20000102 00000000 00050134 000a4135 00000000 =
00000000
> 00000920  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 00000940  *
> 0000c100  00000001 00006f00 00f00000 01500000 30c12004 00000000 7e800020 =
00001908
> 0000c120  33313130 00000000 12345678 0a416802 00000000 00000000 00000000 =
00000000

This is the revision (0xc120). This confirms the IP as dwc3.1.

> 0000c140  4020800a 02092486 12345678 10420086 48422019 643d0410 18cc803f =
0f000e92
> 0000c160  00230000 9cc20006 00000000 00000000 257cf70a 00000000 00000000 =
00800000
> 0000c180  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c1a0  3139302a 736f3035 33313130 00000000 00000000 00000000 00000000 =
00000000

And this (0xc1a0) is the version number 1.90A

> 0000c1c0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c1e0  *
> 0000c200  00102400 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c220  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c240  *
> 0000c2c0  01021102 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c2e0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c300  00000023 002300c7 00ea00c7 01b180c7 027800c7 033f00c7 040600c7 =
04cd80c7
> 0000c320  059400c7 065b00c7 072200c7 07e900c7 08b000c7 097700c7 0a3e00c7 =
0b0500c7
> 0000c340  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c360  *
> 0000c380  000003e8 03e88809 0bf10000 0bf18000 0bf10000 0bf18000 00000000 =
00000000
> 0000c3a0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c3c0  *
> 0000c400  dead0000 00000000 00000100 00000000 00000000 00000000 00000000 =
00000000
> 0000c420  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c440  *
> 0000c600  00001744 00000000 18094246 0085560c 00000000 00000000 00000000 =
00000000
> 0000c620  00000000 0a0a0101 18181218 20201820 0a87f020 0001ffff 00000000 =
00000000
> 0000c640  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c660  *
> 0000c700  00080800 80f00000 00000007 008e0001 00000000 00000005 00000000 =
00000000
> 0000c720  00000003 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c740  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c760  *
> 0000c800  00000000 00000000 00000001 00010002 00000000 00000000 00000001 =
00020002
> 0000c820  00000000 00000000 00000000 00000000 00000000 00000000 00000001 =
00030002
> 0000c840  00000000 00000000 00000001 00050002 00000000 00000000 00000001 =
00040002
> 0000c860  00000000 00000000 00000000 00000000 00000000 00000000 00000001 =
00060002
> 0000c880  00000000 00000000 00000001 00080002 00000000 00000000 00000001 =
00070002
> 0000c8a0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000c8c0  *
> 0000cd20  00000000 00000000 00000886 00000886 00000000 00000000 00000000 =
00000000
> 0000cd40  3c20060c 0002000b 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000cd60  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000cd80  *
> 0000d000  30302626 00940076 26261f1f 00000052 9c067d05 3fff3b15 42843603 =
0023287d
> 0000d020  4e928162 008b8080 00000c00 0047e1f4 00753546 5dc2f07d 00000ea6 =
f0966b32
> 0000d040  00026cf5 1130c850 00000000 00000000 01090650 00000000 00000000 =
00000000
> 0000d060  000034c2 00000582 00003540 00000600 00000000 00000000 00051565 =
00000000
> 0000d080  00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
> 0000d0a0  *
>
>
> fyi, the Apple Device Tree defines the following register ranges, some of
> those are related the PHY and at least two are for the dwc3 itself. No id=
ea what
> the rest is used for yet.

could be some debugging thing. DWC3 has this EBC feature which allows an
external piece of HW to directly control the FIFOs. Usually used for
some processor tracing capability.

> <0x00000005 0x02280000 0x00000000 0x0000da00> <-- DWC3 + something else a=
t the end
> <0x00000005 0x02200000 0x00000000 0x00080000>
> <0x00000005 0x0228c000 0x00000000 0x00001800> <-- DWC3, just before GLOBA=
LS_REGS
> <0x00000005 0x02a84000 0x00000000 0x00004000> <-- possibly related to the=
 PHY
> <0x00000005 0x02800000 0x00000000 0x00004000>
> <0x00000005 0x02a80000 0x00000000 0x00004000>
> <0x00000005 0x02000000 0x00000000 0x00080000>
> <0x00000005 0x02080000 0x00000000 0x00080000>
> <0x00000005 0x0228d000 0x00000000 0x00000800> <-- just after DWC3

nice.

> [1] https://github.com/AsahiLinux/m1n1
> [2] https://github.com/AsahiLinux/m1n1/blob/main/src/usb_dwc3.c

pretty cool, this may just become the best ARM linux laptop :-p


PS: _do_ ping me if you have dwc3 issues, this is super interesting heh

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDDYnIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUh9BAf/df6LZQr9qVdCl7KmG5A8Lm8WM13kHUmk
P1BiU1IvqstYG5pQcuNUxjPk4g170STU4EmPPcOVGqhqEB5A2pERcH0UHlNNp92w
+JnqTt33JPL9ZutUGnfUCoUamWpsvshfDgbZt2xc98uTREXFPSrfHcDxAtxcf7Dc
VKHq+Q7VwHHOUmqNsMIXO9vDD+DOWc/VxpEScDQpAeqjCOuu/z7p9bFMXCKwCEiv
f+baYdoPV1eA4z47/Xrp14cKaSd71PDrlHK04QKiFYKh3e8ejmTk1yKgKahDra2O
cd9svcaMT1XHVrdhX+7i9yJ0lOI6XymBvLv2L05s/dG7KbthWaVk+Q==
=xVcP
-----END PGP SIGNATURE-----
--=-=-=--
